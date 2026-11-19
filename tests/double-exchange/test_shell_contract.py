"""Check the shell format's documented contract, not an unimplemented runtime."""
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / '.double/workflows/double-agent/exchange-package-workflow.md'
TEMPLATE = ROOT / '.double/templates/double-agent/exchange-package-manifest-template.md'


def test_shell_informational_contract_keeps_runtime_acceptance_explicit():
    text = WORKFLOW.read_text().split('## Shell Package Informational Entry\n', 1)[1]
    text = text.split('\n## Installation and Registry', 1)[0]
    normalized = ' '.join(text.split())
    # Avoid a paper contract being mistaken for an implemented shell format.
    assert 'current experimental exchange implementation supports ZIP only' in normalized
    assert 'Contract consistency checks do not substitute for these runtime scenarios' in normalized
    # The acceptance matrix must cover passive entry and both metadata cases.
    for scenario in ['No arguments', '`--help`', '`--version`',
                     'Manifest with `public-url`', 'Manifest without `public-url`',
                     'Available operations differ', 'Redirected output and literal metadata']:
        assert f'| {scenario} |' in text
    assert '`--help` must display the same help' in normalized
    assert 'standard output and exit with status 0' in normalized
    for boundary in ['extract content', 'create files or temporary directories',
                     'install or register anything', 'check the environment',
                     'access the network', 'invoke a packaged realization']:
        assert boundary in normalized


def test_shell_help_metadata_matches_existing_manifest_fields():
    workflow = WORKFLOW.read_text()
    template = TEMPLATE.read_text()
    for field in ['package.title', 'package.id', 'package.version',
                  'package.summary', 'package.public-url']:
        assert f'`{field}`' in workflow
        assert f'`{field}`' in template
    assert 'Usage: <archive-name> [OPTION]...' in workflow
    assert 'Package home page: <URL>' in workflow
    assert 'no arguments and `--help` show the same GNU-style brief help' in template
    assert 'These existing fields require no schema change' in template
    assert '#shell-package-informational-entry' in template
