"""Check release safety dependencies without invoking GitHub."""
from pathlib import Path
import re
import sys
root = Path(sys.argv[1])
release = (root / '.github/workflows/release.yml').read_text()
validation = (root / '.github/workflows/double-installer.yml').read_text()
def job(text, name):
    match = re.search(r'^  ' + re.escape(name) + r':\n(.*?)(?=^  [a-z][a-z-]*:|\Z)', text, re.M | re.S)
    assert match, name
    return match.group(1)
publish = job(validation, 'publish')
assert 'needs: [candidate, validation-gate]' in publish
assert "if: needs.candidate.outputs.mode == 'publish'" in publish
assert 'ref: ${{ needs.candidate.outputs.commit }}' in publish
assert 'test "$actual" = "$EXPECTED_COMMIT"' in publish
assert 'test "$(git rev-parse HEAD)" = "$EXPECTED_COMMIT"' in publish
assert 'VALIDATED_COMMIT: ${{ needs.candidate.outputs.commit }}' in publish
assert validation.count('contents: write') == 1
assert 'contents: write' in publish
gate = job(validation, 'validation-gate')
assert 'needs: [candidate, installer, regressions, integrations]' in gate
for result in ('INSTALLER_RESULT', 'REGRESSIONS_RESULT', 'INTEGRATIONS_RESULT'):
    assert f'test "${result}" = success' in gate
assert job(validation, 'installer').count('- {os:') == 6
assert "tags: ['double-installer-*']" in validation
assert 'continue-on-error: true' not in release + validation
assert 'published-installer:' not in validation
assert 'release_tag:' not in validation
assert 'release_commit:' not in validation
for old in ('double-installer-tests.yml', 'double-installer-published-tests.yml'):
    assert not (root / '.github/workflows' / old).exists()
    assert old not in release + validation
machine = job(release, 'release')
assert 'needs: candidate' in machine
assert 'tests/test-double-release.sh --tag "$RELEASE_TAG"' in machine
assert "- 'double-installer-*'" not in release
assert 'Use double-installer.yml' in release
print('PASS: independent machine releases and unified six-platform installer publication gate')
