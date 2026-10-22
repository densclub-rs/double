"""Structural regression checks for the document-driven planning contract.

These inspect actual workflow outputs, template metadata and producer contracts;
they do not simulate an execution engine that this repository does not contain.
"""
from pathlib import Path
import re

import pytest
import yaml

ROOT = Path(__file__).resolve().parents[2]
MACHINE = 'machine-of-goals'
TEMPLATES = ROOT / '.double/templates' / MACHINE
WORKFLOW = ROOT / '.double/workflows' / MACHINE / 'machine-of-goals-workflow.md'


def frontmatter(text):
    assert text.startswith('---\n')
    return yaml.safe_load(text[4:].split('\n---\n', 1)[0])


def shapes(name):
    text = (TEMPLATES / name).read_text()
    return [yaml.safe_load(block) for block in re.findall(
        r'^`{3,4}md\n---\n(.*?)\n---\n', text, re.M | re.S)]


def section(text, heading):
    start = text.index(heading) + len(heading)
    following = re.search(r'^#{1,%d} ' % len(heading.split(' ', 1)[0]), text[start:], re.M)
    return text[start:start + following.start()] if following else text[start:]


def outputs(step):
    """Read only positive output declarations, excluding prohibitions/prose."""
    return re.findall(
        r'^- produced-outputs:(.*?)(?=^- [a-z][a-z-]*:|^### |\Z)',
        step, re.M | re.S)


@pytest.mark.parametrize(('template', 'stage', 'artifact_kind', 'producer'), [
    ('plan-model-template.md', 'plan-synthesis', 'plan-model', 'plan-synthesis-agent'),
    ('plan-template.md', 'plan-realization', 'plan-artifact', 'plan-realization-agent'),
    ('realization-template.md', 'plan-realization', 'realization-artifact', 'plan-realization-agent'),
    ('stage-realization-template.md', 'plan-realization', 'stage-realization', 'plan-realization-agent'),
    ('realization-decision-template.md', 'plan-realization', 'realization-decision', 'plan-realization-agent'),
])
def test_template_producers_and_lifecycle(template, stage, artifact_kind, producer):
    meta = frontmatter((TEMPLATES / template).read_text())
    assert meta['workflow-stage'] == stage
    assert meta['status'] == 'release-candidate'
    assert shapes(template)
    if template in {'plan-model-template.md', 'plan-template.md'}:
        document_titles = re.findall(
            r'^# (?!Template:)([^:\n]+):', (TEMPLATES / template).read_text(), re.M)
        assert document_titles and set(document_titles) == {'Plan'}
    for artifact in shapes(template):
        assert artifact['kind'] == artifact_kind
        assert artifact['template-id'] == meta['id']
        assert artifact['produced-by'] == f'{MACHINE}/{producer}'


def test_synthesis_produces_models_only():
    step = section(WORKFLOW.read_text(), '### 03. Plan Synthesis')
    declared = outputs(step)
    assert len(declared) == 2  # Manual/interactive and retained other-mode shape.
    for output in declared:
        assert '`plan-model`' in output
        assert not re.search(r'`(?:plan-artifact|plan-revision-snapshot|realization-artifact|plan-run)`', output)
    model = shapes('plan-model-template.md')[0]
    assert 'plan-version' not in model
    assert 'model-revision' in model


def test_deferred_review_has_no_executor_output():
    step = section(WORKFLOW.read_text(), '### 04. Plan Review and Decision')
    declared = outputs(step)
    assert len(declared) == 1
    assert '`approved-model-selection`' in declared[0]
    assert 'no new execution file' in declared[0]
    assert 'start deferred' in WORKFLOW.read_text()
    assert re.search(r'only when start is authorized', step)
    # The prohibition covers both naming families, not just manual plan-v1.md.
    assert all(name in step for name in ['`plan-v1.md`', 'snapshot', 'realization', 'decision file', 'run', 'index'])


def test_start_produces_frozen_plan_and_realization_before_action():
    workflow = WORKFLOW.read_text()
    step = section(workflow, '### 05. Plan Realization')
    for output in outputs(step):
        assert '`plan-artifact`' in output
        assert '`realization-artifact`' in output
    start = section(workflow, '### Start and Resume')
    assert start.index('freeze the approved model content') < start.index('then create `realization.md`')
    assert start.index('recheck the current model') < start.index('Create a new `realizations/')
    assert 'mismatch returns to\n  review without creating execution artifacts' in start
    frozen = shapes('plan-template.md')[0]
    assert frozen['plan-version'] == 1
    assert frozen['plan-model-artifact'] == '../../plan-model-<branch>.md'
    assert 'approved-model-content-hash' in frozen


def test_source_identity_and_frozen_identity_are_separate():
    realization = shapes('realization-template.md')[0]
    assert realization['plan-artifact'] == './plan-v1.md'
    assert realization['plan-model-artifact'] == '../../plan-model-<branch>.md'
    assert realization['plan-content-hash'] != realization['approved-model-content-hash']
    assert 'frozen-plan-file-digest' in realization['plan-content-hash']
    assert 'approved-source-file-digest' in realization['approved-model-content-hash']


def test_stage_contracts_reference_fixed_plan_in_both_modes():
    manual = shapes('stage-realization-template.md')[0]
    assert manual['plan-artifact'] == './plan-v1.md'
    assert manual['plan-version'] == 1
    stage = (TEMPLATES / 'stage-realization-template.md').read_text()
    assert '](./plan-v1.md#stage-' in stage
    legacy = (TEMPLATES / 'plan-run-template.md').read_text()
    links = re.findall(r'\]\(([^)]+#stage-[^)]+)\)', legacy)
    assert links
    assert all('/realizations/plan-revision-<N>.md#stage-' in link for link in links)
    assert 'adopt current\nplan changes' not in legacy


def test_edited_model_requires_review_and_preserves_historical_plan():
    workflow = WORKFLOW.read_text()
    review = section(workflow, '### Model and Selection')
    assert 'Any model edit invalidates that approval' in review
    assert 'same filename/revision' in review
    change = section(workflow, '### Model Change and Succession')
    assert 'already frozen plan remains unchanged' in change
    assert 'Validate observed outputs against that plan' in change
    assert 'approval of the exact new model content' in change
    validation_outputs = '\n'.join(outputs(section(workflow, '### 06. Plan Validation')))
    assert '`plan-revision-snapshot`' not in validation_outputs
    assert '`plan-artifact`' not in validation_outputs


def test_agent_registry_assigns_execution_to_executor_only():
    registry = (ROOT / '.double/registries' / MACHINE / 'agents-registry.md').read_text()
    synth = section(registry, '## Plan Synthesis Agent')
    synth_outputs = re.search(r'^- output: (.*)$', synth, re.M).group(1)
    assert '`plan-model`' in synth_outputs
    assert '`plan-artifact`' not in synth_outputs
    assert '`realization-artifact' not in synth_outputs
    executor = section(registry, '## Plan Realization Agent')
    exec_outputs = re.search(r'^- output: (.*)$', executor, re.M).group(1)
    assert '`plan-artifact`' in exec_outputs
    assert '`realization-artifact`' in exec_outputs


def test_template_registry_and_catalog_include_both_contracts():
    registry = (ROOT / '.double/registries' / MACHINE / 'templates-registry.md').read_text()
    catalog = (TEMPLATES / 'machine-of-goals.md').read_text()
    for name, kind in [('plan-model-template', 'plan-model'), ('plan-template', 'plan-artifact')]:
        assert f'| `{kind}` | `{name}` |' in registry
        assert f'](./{name}.md)' in catalog
    for name in ['goal-template.md', 'path-options-template.md']:
        text = (TEMPLATES / name).read_text()
        assert './plan-model-<branch>.md' in text
        assert 'plan-<branch>-v<major>.md' not in text


def operating_files():
    for area in ['agents', 'roles', 'prompts', 'registries', 'skills', 'templates', 'workflows']:
        yield from (ROOT / '.double' / area / MACHINE).rglob('*.md')


def test_no_stale_model_filename_or_revision_shortcut():
    prohibited = ['plan-<branch>-v<major>.md', 'using the first `plan-template`',
                  'reuse the historical baseline for compatible future-only changes',
                  'Log compatible future-only edits without a new revision',
                  'updated-plan-artifact']
    for path in operating_files():
        text = path.read_text()
        for old in prohibited:
            assert old not in text, (path, old)


def test_operating_frontmatter_and_static_links():
    for path in operating_files():
        text = path.read_text()
        meta = frontmatter(text)
        assert meta['status'] == 'release-candidate', path
        assert not ({'version', 'machine-version', 'workflow-version'} & meta.keys()), path
        # Generated examples contain destination-context links and placeholders;
        # only literal links outside fenced examples are repository navigation.
        prose = re.sub(r'^(`{3,})[^\n]*\n.*?^\1\s*$', '', text, flags=re.M | re.S)
        prose = re.sub(r'`[^`\n]+`', '', prose)
        for target in re.findall(r'\]\(([^)]+)\)', prose):
            if '<' in target or re.match(r'[a-z]+:', target):
                continue
            target_path, _, anchor = target.partition('#')
            dest = (path.parent / target_path).resolve() if target_path else path
            assert dest.exists(), (path, target)
            if anchor and dest.is_file():
                destination = dest.read_text()
                explicit = re.findall(r'<a id="([^"]+)"', destination)
                headings = [re.sub(r'[^\w -]', '', h.lower()).replace(' ', '-')
                            for h in re.findall(r'^#+ (.+)$', destination, re.M)]
                assert anchor in explicit + headings, (path, target)
