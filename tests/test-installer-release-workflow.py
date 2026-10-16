"""Check release safety dependencies without invoking GitHub."""
from pathlib import Path
import sys
root = Path(sys.argv[1])
release = (root / '.github/workflows/release.yml').read_text()
validation = (root / '.github/workflows/double-installer-tests.yml').read_text()
# Guard the reviewed YAML structure and critical expressions using only stdlib.
# Actual workflow execution is validated in CI05; this is a local contract check.
import re
def job(text, name):
    match = re.search(r'^  ' + re.escape(name) + r':\n(.*?)(?=^  [a-z][a-z-]*:|\Z)', text, re.M | re.S)
    assert match, name
    return match.group(1)
publish = job(release, 'release')
assert 'needs: [candidate, installer-validation]' in publish
assert not re.search(r'^    if:', publish, re.M)
assert 'ref: ${{ needs.candidate.outputs.commit }}' in publish
assert 'test "$actual" = "$EXPECTED_COMMIT"' in publish
assert 'test "$(git rev-parse HEAD)" = "$EXPECTED_COMMIT"' in publish
assert 'VALIDATED_COMMIT: ${{ needs.candidate.outputs.commit }}' in publish
adapter = job(release, 'installer-validation')
assert 'needs: candidate' in adapter
assert 'uses: ./.github/workflows/double-installer-tests.yml' in adapter
assert 'ref: ${{ needs.candidate.outputs.commit }}' in adapter
gate = job(validation, 'validation-gate')
assert 'needs: [installer, regressions, integrations]' in gate
for result in ('INSTALLER_RESULT', 'REGRESSIONS_RESULT', 'INTEGRATIONS_RESULT'):
    assert f'test "${result}" = success' in gate
assert job(validation, 'installer').count('- {os:') == 6
assert "- 'double-installer-*'" in release
assert 'continue-on-error: true' not in release + validation
print('PASS: publication gate and tagged-commit contract checks')

published = job(release, 'published-installer')
assert 'needs: [candidate, release]' in published
assert 'uses: ./.github/workflows/double-installer-published-tests.yml' in published
recheck = (root / '.github/workflows/double-installer-published-tests.yml').read_text()
assert job(recheck, 'verify').count('- {os:') == 6
assert 'tests/test-double-installer-published.sh' in recheck
assert 'commit: ${{ needs.candidate.outputs.commit }}' in published
print('PASS: downloaded installer verification follows publication on all six targets')
