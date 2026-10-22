"""Check the installer publication and notification dependency boundaries."""
from pathlib import Path
import re
import sys
root = Path(sys.argv[1])
text = (root / '.github/workflows/double-installer.yml').read_text()
def job(name):
    return re.search(r'^  ' + name + r':\n(.*?)(?=^  [a-z][a-z-]*:|\Z)', text, re.M | re.S).group(1)
assert 'needs: [candidate, validation-gate]' in job('publish')
assert "if: needs.candidate.outputs.mode == 'publish'" in job('publish')
assert 'needs: [candidate, installer, regressions, integrations]' in job('validation-gate')
assert job('installer').count('- {os:') == 6
assert '--quick' in job('installer')
assert text.count('contents: write') == 1
assert 'needs: publish' in job('telegram')
assert "needs.publish.result == 'success'" in job('telegram')
assert "needs.publish.outputs.eligible == 'true'" in job('telegram')
for path in re.findall(r'\btests/[\w/.-]+\.(?:sh|py|txt|ini)', text):
    assert (root / path).is_file(), path
print('PASS: six-platform quick validation, publication gate and post-publication announcement')
