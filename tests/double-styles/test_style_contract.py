"""Cross-machine contract integration checks, not a simulated AI execution engine."""
from pathlib import Path
import re

import pytest
import yaml

ROOT = Path(__file__).resolve().parents[2]
MACHINES = ('double-agent', 'machine-of-ideas', 'machine-of-goals', 'machine-of-knowledge')


def workflow(machine):
    return ROOT / f'.double/workflows/{machine}/{machine}-workflow.md'


def protocol(machine):
    text = workflow(machine).read_text()
    return text.split('## Style Application Protocol\n', 1)[1].split('\n## ', 1)[0]


def operating_files(category, kind):
    for path in (ROOT / '.double' / category).rglob('*.md'):
        text = path.read_text()
        if text.startswith('---\n'):
            meta = yaml.safe_load(text.split('---', 2)[1])
            if isinstance(meta, dict) and meta.get('kind') == kind:
                yield path, text, meta


@pytest.mark.parametrize('machine', MACHINES)
def test_independent_machine_workflow_has_complete_identical_protocol(machine):
    """A separately installed machine must not depend on Double Agent for loading."""
    assert protocol(machine) == protocol('double-agent')
    text = protocol(machine)
    assert 'Selection and Loading' in text
    assert 'Ownership and Installation Boundary' in text
    assert 'workflows/double-agent/' not in text
    assert 'If `double.md` itself is unavailable' in text
    assert 'Do not load default recommendations' in text
    assert 'stage handoffs' in text


@pytest.mark.parametrize('machine', MACHINES)
def test_skill_entry_reaches_its_own_protocol(machine):
    path = ROOT / f'.double/skills/{machine}/SKILL.md'
    text = path.read_text()
    links = re.findall(r'\[Style Application Protocol\]\(([^)]+)\)', text)
    assert len(links) == 1
    target, anchor = links[0].split('#')
    assert (path.parent / target).resolve() == workflow(machine).resolve()
    assert f'<a id="{anchor}"></a>' in workflow(machine).read_text()


@pytest.mark.parametrize('category,kind', [('roles', 'role'), ('modes', 'mode'), ('agents', 'agent'), ('prompts', 'prompt')])
def test_producer_entries_reach_real_protocol_and_have_no_embedded_defaults(category, kind):
    files = list(operating_files(category, kind))
    assert files
    for path, text, meta in files:
        assert '## Role, Mode, and Style Boundary' in text, path
        assert meta.get('id'), path
        target, anchor = re.findall(r'\[Style Application Protocol\]\(([^)]+)\)', text)[0].split('#')
        destination = (path.parent / target).resolve()
        assert destination.is_file(), (path, destination)
        assert f'<a id="{anchor}"></a>' in destination.read_text(), path
        assert '## Basic Style' not in text, path
        assert '## Default Style' not in text, path


def test_default_preferences_have_one_source_and_are_removed_from_producers():
    style = (ROOT / 'styles/double.md').read_text()
    assert not style.startswith('---')  # Styles do not require operating metadata.
    assert 'Prefer a small set of strong concepts' in style
    assert 'Prefer a small set of strong principles' in style
    assert 'Prefer the minimum adequate structure' in style
    for category, kind in [('roles', 'role'), ('prompts', 'prompt')]:
        for path, text, _ in operating_files(category, kind):
            assert 'prefer concrete examples over abstractions' not in text.lower(), path
            assert 'prefer a small set of strong principles' not in text.lower(), path
            assert 'prefer the minimum adequate structure' not in text.lower(), path


def test_modes_preserve_mandatory_semantics_instead_of_becoming_preferences():
    modes = ROOT / '.double/modes'
    brainstorm = (modes / 'machine-of-ideas/brainstorm/brainstorm.md').read_text()
    research = (modes / 'machine-of-ideas/strict-research/strict-research.md').read_text()
    dry_run = (modes / 'machine-of-goals/dry-run/dry-run.md').read_text()
    assert 'without early criticism' in brainstorm
    assert 'do not suppress raw thoughts too early' in brainstorm
    assert 'do not invent sources' in research
    assert 'distinguish supported conclusions from assumptions' in research
    assert 'without causing real-world effects' in dry_run
    assert 'keep simulation separate from real execution' in dry_run
    for path, text, _ in operating_files('modes', 'mode'):
        assert '## Behavioral Intent' not in text, path


def test_custom_creation_and_rule_publication_are_separate_ownership_routes():
    agent = workflow('double-agent').read_text()
    knowledge = workflow('machine-of-knowledge').read_text()
    assert '## Style Development and Connection' in agent
    assert 'Route rule publication to Machine of Knowledge' in agent
    assert '## Style Selection as Project Knowledge' in knowledge
    assert 'existing knowledge template and index' in knowledge
    assert 'Do not copy style recommendations into the rule' in ' '.join(knowledge.split())


def test_rc_project_artifacts_are_linked_consistently():
    folder = ROOT / 'ideas/double-styles'
    idea = (folder / 'double-styles.md').read_text()
    for path in folder.glob('*.md'):
        text = path.read_text()
        meta = yaml.safe_load(text.split('---', 2)[1])
        assert meta['status'] == 'release-candidate'
        anchors = re.findall(r'<a id="([^"]+)"></a>', text)
        assert len(anchors) == len(set(anchors))
        if path.name != 'double-styles.md':
            for anchor in anchors:
                assert f'{path.name}#{anchor}' in idea
        for link in re.findall(r'\]\(([^)]+)\)', text):
            file, _, anchor = link.partition('#')
            destination = path.parent / file if file else path
            assert destination.is_file(), (path, link)
            if anchor:
                assert f'<a id="{anchor}"></a>' in destination.read_text(), (path, link)
