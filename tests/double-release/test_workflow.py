"""Inspect the actual adapter and execute only its local configuration check."""
import os
from pathlib import Path
import re
import subprocess
import sys

import pytest
import yaml

ROOT = Path(__file__).resolve().parents[2]


def workflow():
    return yaml.safe_load((ROOT/'.github/workflows/release.yml').read_text())


def test_workflow_is_gated_and_uses_current_tooling():
    jobs=workflow()['jobs']; release=jobs['release']; telegram=jobs['telegram']
    assert release['needs'] == 'candidate'
    assert release['permissions'] == {'contents':'write','pull-requests':'read'}
    steps=release['steps']
    candidate_checkout=next(s for s in steps if s.get('name') == 'Checkout repository')
    tooling=next(s for s in steps if s.get('name') == 'Checkout workflow tooling')
    assert candidate_checkout['with']['ref'] == '${{ needs.candidate.outputs.commit }}'
    assert tooling['with']['ref'] == '${{ github.workflow_sha }}'
    gate=next(s for s in steps if s.get('name') == 'Test release possibility')
    assert 'python3 -m pytest' in gate['run']
    assert '.release-tools/tests/double-release' in gate['run']
    assert '--release-tag "$RELEASE_TAG"' in gate['run']
    publish=next(s for s in steps if s.get('id') == 'publish')
    assert 'python3 .release-tools/scripts/double-release/double-release.py publish --tag "$RELEASE_TAG"' == publish['run']
    assert publish['if'] == '${{ inputs.validation_only != true }}'
    assert not publish.get('continue-on-error', False)
    assert not gate.get('continue-on-error', False)
    notes=next(s for s in steps if s.get('id') == 'notes')
    assert notes['if'] == '${{ inputs.validation_only != true }}'
    assert not notes.get('continue-on-error', False)
    evidence=next(s for s in steps if s.get('uses','').startswith('actions/upload-artifact@'))
    assert evidence['with']['retention-days'] == 14
    assert '--junitxml=test-results/release.xml' in gate['run']
    assert steps.index(gate) < steps.index(publish)
    identity=next(s for s in steps if s.get('name') == 'Verify validated tag identity')
    assert 'test "$actual" = "$EXPECTED_COMMIT"' in identity['run']
    assert 'test "$(git rev-parse HEAD)" = "$EXPECTED_COMMIT"' in identity['run']
    assert steps.index(identity) < steps.index(gate)
    assert any(s.get('uses','').startswith('actions/setup-python@') and s['with']['python-version']=='3.11' for s in steps)
    assert any('requirements.txt' in s.get('run','') for s in steps)
    assert telegram['permissions'] == {}
    assert telegram['needs'] == 'release'
    assert "outputs.published == 'true'" in telegram['if']
    assert "outputs.eligible == 'true'" in telegram['if']
    assert not any('checkout' in s.get('uses','') for s in telegram['steps'])
    send=next(s for s in telegram['steps'] if s.get('id')=='send')
    assert re.fullmatch(r'appleboy/telegram-action@[a-f0-9]{40}',send['uses'])
    assert send['continue-on-error']
    assert send['with']['format']=='html'
    assert send['with']['message_thread_id']=='${{ vars.TELEGRAM_THREAD_ID }}'
    for job in jobs.values():
        for step in job['steps']:
            env=step.get('env',{})
            if 'TELEGRAM_TOKEN' in env:
                assert job is telegram


@pytest.mark.parametrize('token,destination,topic,ready', [
    ('x','-1002983024983','8',True),
    ('','-1002983024983','8',False),
    ('x','-100999','8',False),
    ('x','-1002983024983','',False),
    ('x','-1002983024983','9',False),
])
def test_notification_destination_check(tmp_path, token, destination, topic, ready):
    check=next(s for s in workflow()['jobs']['telegram']['steps'] if s.get('id')=='config')
    assert check['shell']=='python'
    output=tmp_path/'outputs';output.write_text('')
    env=dict(os.environ,TELEGRAM_TOKEN=token,TELEGRAM_TO=destination,
             TELEGRAM_THREAD_ID=topic,GITHUB_OUTPUT=str(output))
    result=subprocess.run([sys.executable,'-c',check['run']],env=env,capture_output=True,text=True,check=True)
    assert ('ready=true' in output.read_text()) == ready
    if not ready:
        assert '::warning::' in result.stdout


def test_old_machine_shell_entry_points_are_retired():
    for name in ('scripts/double-release.sh', 'scripts/test-double-release.sh',
                 'tests/test-double-release.sh', 'tests/test-double-release-notes.py'):
        assert not (ROOT/name).exists(), name
    for path in (ROOT/'.github/workflows').glob('*.yml'):
        assert 'scripts/double-release.sh' not in path.read_text(), path
