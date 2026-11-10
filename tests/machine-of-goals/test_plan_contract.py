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
    ('realization-template.md', 'plan-realization', 'realization-artifact', 'plan-realization-agent'),
    ('stage-realization-template.md', 'plan-realization', 'stage-realization', 'plan-realization-agent'),
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
    assert len(declared) == 1  # One model contract, independent of execution medium.
    for output in declared:
        assert '`plan-model`' in output
        assert not re.search(r'`(?:plan-artifact|plan-revision-snapshot|realization-artifact|plan-run)`', output)
    model = shapes('plan-model-template.md')[0]
    assert 'plan-version' not in model
    assert model['plan-revision'] == '<positive-integer>'
    assert model['id'] == '<id>'
    assert model['branch'] == '<branch-name>'
    template = (TEMPLATES / 'plan-model-template.md').read_text()
    assert '<goal-directory>/plan.md' in template
    assert '<a id="<id>"></a>' in template


def test_deferred_review_has_no_executor_output():
    step = section(WORKFLOW.read_text(), '### 04. Plan Review and Decision')
    declared = outputs(step)
    assert len(declared) == 1
    assert '`approved-model-selection`' in declared[0]
    assert 'no new execution file' in declared[0]
    presentation = section(WORKFLOW.read_text(), '### Plan Approval Presentation')
    approval_questions = re.findall(r'^> (.+)$', presentation, re.M)
    assert len(approval_questions) == 1
    assert '[Plan](<current-plan-link>)' in approval_questions[0]
    assert not re.search(r'sha.?256|digest|hash|checksum', approval_questions[0], re.I)
    assert 'internal' in presentation and 'before presenting' in presentation.lower()
    assert 'start deferred' in WORKFLOW.read_text()
    assert re.search(r'only when start is authorized', step)
    # Content review alone creates no execution material.
    assert all(name in step for name in ['realization', 'decision file'])


def test_start_links_approved_plan_without_local_copy():
    workflow = WORKFLOW.read_text()
    manual = section(section(workflow, '### 05. Plan Realization'), '#### Manual and Interactive Execution')
    assert '`realization-artifact`' in outputs(manual)[0]
    assert '`plan-artifact`' not in outputs(manual)[0]
    start = section(workflow, '### Start and Resume')
    assert 'recheck the exact approved source digest' in start
    assert 'do not create a' in start and 'local plan copy at start' in start
    assert 'Link the actual main plan' in start
    assert 'no Machine of Goals execution artifact is created' in section(section(workflow, '### 05. Plan Realization'), '#### Collapsed Automatic Execution')


def test_realization_records_approved_source_and_links_main_plan():
    realization = shapes('realization-template.md')[0]
    assert realization['plan-artifact'] == '../../plan.md'
    assert 'approved-source-file-digest' in realization['approved-model-content-hash']
    assert realization['plan-revision'] == '<approved-plan-revision>'
    assert 'plan-content-hash' not in realization
    assert 'plan-version' not in realization


def test_stage_contracts_reference_linked_main_plan_and_capture_conditions():
    stage = shapes('stage-realization-template.md')[0]
    assert stage['plan-artifact'] == '../../plan.md'
    text = (TEMPLATES / 'stage-realization-template.md').read_text()
    assert '](../../plan.md#stage-' in text
    assert 'Preserve each condition ID' in text and 'do not renumber' in text
    assert 'Capture effective conditions' in text
    assert 'Input State' in text and 'Output State' in text


def test_manual_realization_renders_emoji_states_and_legend():
    template = (TEMPLATES / 'realization-template.md').read_text()
    current_shape = template.split('## Realization Shape\n', 1)[1]
    states = {
        '⚪': 'pending', '🔄': 'in progress', '🟠': 'awaiting verification',
        '✅': 'completed', '🟡': 'partial', '⛔': 'blocked', '❌': 'failed',
        '🛠️': 'needs revision', '➖': 'not selected',
    }
    canonical = section(WORKFLOW.read_text(), '### Realization Progress Emojis')
    for emoji, state in states.items():
        assert f'{emoji} {state}' in current_shape
        assert f'| {state} | {emoji} |' in canonical
    initial_states = re.findall(r'^\| \[S0[12]:[^\n]+?\| [^|]+\| ([^|]+)\|', current_shape, re.M)
    assert len(initial_states) == 2
    assert all(value.strip() == '⚪' for value in initial_states)
    assert all(value.strip() in states for value in initial_states)
    assert current_shape.index('Legend:') < current_shape.index('| Stage | Type | State | Record | Result |')
    assert '| Progress |' not in current_shape
    validation = section(WORKFLOW.read_text(), '### Input, Action, and Output')
    assert 'showing `🟠` in the realization map' in validation
    assert 'Use `✅` only' in validation


def test_emoji_rendering_preserves_metadata_and_plan_immutability():
    realization = shapes('realization-template.md')[0]
    assert realization['status'] == '<in-progress|completed|blocked|cancelled|model-changed>'
    assert realization['current-stage'] == '<stage-id-or-null>'
    for name in ['plan-model-template.md']:
        generated = re.search(r'^````md\n(.*?)^````$', (TEMPLATES / name).read_text(), re.M | re.S).group(1)
        assert not any(emoji in generated for emoji in ['⚪', '🔄', '🟠', '✅', '🟡', '⛔', '❌', '🛠️', '➖'])


def test_compatible_evolution_and_incompatible_preservation():
    workflow = WORKFLOW.read_text()
    review = section(workflow, '### Model and Selection')
    assert 'Any model edit invalidates that approval' in review
    change = section(workflow, '### Model Change and Succession')
    for text in ['assess compatibility', 'Continue the same realization', 'ask explicitly',
                 'before editing the main plan', 'separate explicit consent',
                 'do not delete or apply the incompatible change', 'compatible edit needs no local plan copy',
                 'conditions captured when that stage was performed', 'newly started']:
        assert text in ' '.join(change.split()), text
    assert change.index('preserve the actual old plan') < change.index('After preservation or')


def test_agent_registry_assigns_execution_to_executor_only():
    registry = (ROOT / '.double/registries' / MACHINE / 'agents-registry.md').read_text()
    synth = section(registry, '## Plan Synthesis Agent')
    synth_outputs = re.search(r'^- output: (.*)$', synth, re.M).group(1)
    assert '`plan-model`' in synth_outputs
    assert '`plan-artifact`' not in synth_outputs
    assert '`realization-artifact' not in synth_outputs
    executor = section(registry, '## Plan Realization Agent')
    exec_outputs = re.search(r'^- output: (.*)$', executor, re.M).group(1)
    assert '`plan-artifact`' not in exec_outputs
    assert '`realization-artifact`' in exec_outputs


def test_template_registry_and_catalog_include_both_contracts():
    registry = (ROOT / '.double/registries' / MACHINE / 'templates-registry.md').read_text()
    catalog = (TEMPLATES / 'machine-of-goals.md').read_text()
    for name, kind in [('plan-model-template', 'plan-model'), ('plan-template', 'plan-artifact')]:
        assert f'| `{kind}` | `{name}` |' in registry
        assert f'](./{name}.md)' in catalog
    for name in ['goal-template.md', 'path-options-template.md']:
        text = (TEMPLATES / name).read_text()
        assert './plan.md#' in text
        assert 'plan-<branch>-v<major>.md' not in text
    goal = (TEMPLATES / 'goal-template.md').read_text()
    assert './plan.md#<plan-id>' in goal
    assert '| Branch | Review revision | Plan |' in goal
    assert '| <default-branch> |' in goal
    assert '`plan-<id>.md`' in goal
    assert '`plan<owner_id>.md`' in goal
    assert 'include it only when that file exists' in ' '.join(goal.split())


def test_plan_filename_policy_covers_three_cases_and_one_identity():
    policy = section(WORKFLOW.read_text(), '### Logical Branches and Plan Filenames')
    rows = re.findall(r'^\| ([^|]+) \| `([^`]+)` \| (.+) \|$', policy, re.M)
    identities = {filename: identity for _, filename, identity in rows}
    assert set(identities) == {'plan.md', 'plan-<id>.md', 'plan<owner_id>.md'}
    assert all('`id: <id>`' in identity for identity in identities.values())
    assert all('root anchor `<id>`' in identity for identity in identities.values())
    assert all('plan-id:' not in identity for identity in identities.values())
    assert 'owner-id: <owner_id>' in identities['plan<owner_id>.md']
    normalized = ' '.join(policy.split())
    for rule in ['unique within the goal', 'choose another ID on collision',
                 'generate a new `id`', 'actual author', 'not the goal owner',
                 'no hyphen between', 'Do not invent a combined',
                 'not silently migrated']:
        assert rule in normalized


def test_all_plan_shapes_have_one_contextual_id_matching_the_root_anchor():
    for template in ['plan-model-template.md', 'plan-template.md']:
        text = (TEMPLATES / template).read_text()
        for shape in shapes(template):
            assert shape['id'] == '<id>'
            assert 'plan-id' not in shape and 'plan_id' not in shape
            assert f'<a id="{shape["id"]}"></a>' in text
    contract = section((TEMPLATES / 'plan-model-template.md').read_text(), '## Model Contract')
    assert 'for every new plan' in contract
    assert 'always write it as `id: <id>` in frontmatter' in contract
    assert 'regenerate on collision' in contract
    assert 'across all plan filenames' in contract
    policy = section(WORKFLOW.read_text(), '### Logical Branches and Plan Filenames')
    assert 'Only a parallel variant includes it in' in policy


def test_generated_plan_id_combines_subject_meaning_and_goal_in_one_word():
    texts = [
        section(WORKFLOW.read_text(), '### Logical Branches and Plan Filenames'),
        section((TEMPLATES / 'plan-model-template.md').read_text(), '## Model Contract'),
    ]
    for text in texts:
        normalized = ' '.join(text.split())
        for rule in ['one short human-readable word', 'lowercase English letters only',
                     'no digits, hashes or opaque codes', 'another word',
                     'never adding digits', "derived from the plan's context",
                     "must jointly express the plan's subject, core meaning and goal",
                     'single meaningful word', 'no spaces or hyphens',
                     'A readable coined word is allowed',
                     'A word reflecting only one of the three is insufficient',
                     'distinguishes this plan from other variants',
                     'Do not choose a random word or an unrelated dictionary word']:
            assert rule in normalized
        assert '`^[a-z]+$`' in text
        assert "another word derived from the plan's context" in normalized
        assert 'still combines all three concepts' in normalized
    for relative in [
        'agents/machine-of-goals/plan-synthesis/plan-synthesis.md',
        'roles/machine-of-goals/plan-synthesis-role.md',
        'prompts/machine-of-goals/system/plan-synthesis.md',
        'prompts/machine-of-goals/interaction/plan-synthesis.md',
        'registries/machine-of-goals/templates-registry.md',
        'skills/machine-of-goals/SKILL.md',
        'templates/machine-of-goals/machine-of-goals.md',
        'templates/machine-of-goals/goal-template.md',
        'templates/machine-of-goals/path-options-template.md',
    ]:
        text = (ROOT / '.double' / relative).read_text()
        assert '`id`' in text, relative
        normalized = ' '.join(text.split())
        assert "derived from the plan's context" in normalized, relative
        assert 'subject, core meaning and goal' in normalized, relative
        assert 'single word' in normalized, relative


def test_preserved_copies_keep_source_identity_and_realizations_reference_it():
    model = shapes('plan-model-template.md')[0]
    realization = shapes('realization-template.md')[0]
    assert model['id'] == '<id>' and realization['plan-id'] == '<plan-id>'
    assert realization['id'] != model['id']
    contract = (TEMPLATES / 'plan-template.md').read_text()
    assert 'Preserve its original id, metadata' in contract
    assert 'stage and condition identifiers and anchors' in contract
    assert 'rebase' in contract.lower() and 'without\noverwriting existing files' in contract
    for name in ['goal-template.md', 'realization-template.md']:
        assert 'plan.md#<plan-id>' in (TEMPLATES / name).read_text()


@pytest.mark.parametrize('relative', [
    'agents/machine-of-goals/plan-synthesis/plan-synthesis.md',
    'roles/machine-of-goals/plan-synthesis-role.md',
    'prompts/machine-of-goals/system/plan-synthesis.md',
    'prompts/machine-of-goals/interaction/plan-synthesis.md',
    'templates/machine-of-goals/plan-model-template.md',
    'templates/machine-of-goals/goal-template.md',
    'templates/machine-of-goals/path-options-template.md',
    'templates/machine-of-goals/machine-of-goals.md',
    'registries/machine-of-goals/templates-registry.md',
    'skills/machine-of-goals/SKILL.md',
])
def test_filename_policy_reaches_planning_and_navigation_surfaces(relative):
    text = (ROOT / '.double' / relative).read_text()
    code = re.findall(r'`([^`\n]+)`', text)
    for name in ['plan.md', 'plan-<id>.md', 'plan<owner_id>.md']:
        assert any(value == name or value.endswith('/' + name) for value in code)


def test_discovery_can_identify_parallel_variants_without_creating_plans():
    discovery = section(WORKFLOW.read_text(), '### 02. Path Discovery')
    assert 'parallel plan variants' in discovery
    assert 'without creating plan or execution files during discovery' in discovery
    assert '`plan-model`' not in '\n'.join(outputs(discovery))
    synthesis = section(WORKFLOW.read_text(), '### 03. Plan Synthesis')
    assert 'no prior default plan is required' in synthesis
    policy = section(WORKFLOW.read_text(), '### Logical Branches and Plan Filenames')
    normalized = ' '.join(policy.split())
    assert 'Parallel stages and different realization media alone' in normalized
    for relative in [
        'agents/machine-of-goals/path-discovery/path-discovery.md',
        'roles/machine-of-goals/path-discovery-role.md',
        'prompts/machine-of-goals/system/path-discovery.md',
        'prompts/machine-of-goals/interaction/path-discovery.md',
    ]:
        text = (ROOT / '.double' / relative).read_text()
        assert '`plan-<id>.md`' in text
        assert '`plan<owner_id>.md`' in text
        assert 'step-03' in text or 'synthesis' in text


def test_named_variant_uses_actual_source_and_historical_copy_name():
    text = (TEMPLATES / 'realization-template.md').read_text()
    assert '`plan-<id>.md`' in text and '`plan<owner_id>.md`' in text
    assert 'never\nfall back to `plan.md` for a named variant' in text
    start = section(WORKFLOW.read_text(), '### Start and Resume')
    assert 'Named plan variants keep their actual paths' in start
    change = section(WORKFLOW.read_text(), '### Model Change and Succession')
    normalized = ' '.join(change.split())
    assert 'old plan as `plan.md`' in normalized and 'Never overwrite an existing' in normalized


def operating_files():
    for area in ['agents', 'roles', 'prompts', 'modes', 'registries', 'skills', 'templates', 'workflows']:
        yield from (ROOT / '.double' / area / MACHINE).rglob('*.md')


def test_no_stale_model_filename_or_revision_shortcut():
    prohibited = ['plan-<plan_id>.md', '<goal-id>-plan', '<realization-id>-plan-v1',
                  'short lowercase alphanumeric', 'a7c3e2', 'such as `cedar` or `orbit`',
                  'approach, key action or intended result',
                  '`repair` for repairing an existing system',
                  'model-revision', 'plan-<branch>.md', 'plan-<branch>-v<major>.md',
                  'Only an explicit major divergence', 'only an explicit major divergence',
                  'plan-model-<branch>.md',
                  '<goal-id>-plan-model-<branch>', 'using the first `plan-template`',
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


def test_retired_execution_artifacts_have_no_current_producer_or_reference():
    retired = {'plan-run-template.md', 'run-index-template.md',
               'realization-decision-template.md'}
    assert all(not (TEMPLATES / name).exists() for name in retired)
    # Include modes and the shared catalog: neither may bypass the workflow.
    for path in [*operating_files(), ROOT / '.double/templates/templates.md']:
        text = path.read_text()
        assert not re.search(
            r'plan-run|run-index|realization-decision-template|/run/|'
            r'Other[ -](?:Execution[ -])?Modes|single-pass|multi-pass|'
            r'plan-execution-style|section 10|plan-revision-<N>', text, re.I), path


def test_every_plan_shape_has_no_runtime_state_or_progress():
    forbidden_fields = {'current-stage', 'realization-id', 'status', 'runs',
                        'last-run', 'last-result', 'plan-execution-style',
                        'plan-revision-artifact', 'readiness', 'alignment'}
    # Frozen provenance names its realization; this is identity, not progress.
    for name in ['plan-model-template.md']:
        generated = re.findall(r'^(`{3,4})md\n(.*?)^\1$',
                               (TEMPLATES / name).read_text(), re.M | re.S)
        assert len(generated) == 1
        _, text = generated[0]
        meta = frontmatter(text)
        allowed = {'realization-id'} if name == 'plan-template.md' else set()
        assert not ((forbidden_fields - allowed) & meta.keys())
        assert not re.search(r'^\|[^\n]*(?:Progress|State \| Record|Last Run|Last Result)',
                             text, re.M)
        assert not any(e in text for e in ['⚪', '🔄', '🟠', '✅', '🟡', '⛔', '❌', '🛠️', '➖'])
    boundary = section(WORKFLOW.read_text(), '## Plan Model and Execution Plan Boundary')
    assert 'The plan is a model in every mode' in boundary
    assert 'validating a stage never modifies the plan' in boundary


def test_manual_progress_has_one_home_and_a_goal_navigation_path():
    realization = shapes('realization-template.md')
    assert len(realization) == 1
    assert realization[0]['current-stage'] == '<stage-id-or-null>'
    assert realization[0]['started-at'] == '<actual-ISO8601-time-with-offset>'
    text = (TEMPLATES / 'realization-template.md').read_text()
    assert '_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md' in text
    assert '| Stage | Type | State | Record | Result |' in text
    goal = (TEMPLATES / 'goal-template.md').read_text()
    assert './_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md#<realization-id>' in goal
    assert 'not merely the latest timestamp' in goal
    assert 'no active\nrealization or multiple candidates explicitly' in goal
    assert 'not a dangling link' in text


def test_collapsed_invocation_has_checks_but_no_machine_execution_record():
    automatic = section(WORKFLOW.read_text(), '## Automatic Realization Rule')
    normalized = ' '.join(automatic.split())
    assert 'skill' in automatic and 'automated action' in automatic
    assert 'invocation creates no Machine of Goals' in normalized
    assert 'initial, required intermediate and final state' in normalized
    assert 'authorization and stop points' in normalized
    assert 'Repeatability does not require automation' in normalized
    for relative in ['modes/machine-of-goals/execution/execution.md',
                     'modes/machine-of-goals/validation/validation.md',
                     'agents/machine-of-goals/plan-realization/plan-realization.md',
                     'agents/machine-of-goals/plan-validation/plan-validation.md',
                     'skills/machine-of-goals/SKILL.md']:
        text = ' '.join((ROOT / '.double' / relative).read_text().split())
        assert re.search(r'[Cc]reate[s]? no Machine of Goals', text), relative
    validation = section(WORKFLOW.read_text(), '#### Collapsed Automatic Validation')
    assert 'no Machine of Goals realization document or journal is created' in validation
    assert '`realization-artifact`' not in '\n'.join(outputs(validation))


def test_exchange_preserves_selected_walkthroughs_without_execution_bookkeeping():
    text = (TEMPLATES / 'exported-plan-package-template.md').read_text()
    meta = shapes('exported-plan-package-template.md')[0]
    assert 'documented-realizations' in meta
    assert 'registered-realizations' not in meta
    assert 'importing experience does not establish' in text
    assert '<realization-result-or-stage-record>' in text
    for name in ['import', 'export']:
        mode = (ROOT / '.double/modes' / MACHINE / name / f'{name}.md').read_text()
        assert 'goal and model alone or selected/all documented realizations' in mode
        assert 'Imported experience remains source history' in mode
        assert 'never executes a packaged mechanism as a side effect' in mode


def test_evolution_dependency_and_sharing_contracts():
    workflow = ' '.join(WORKFLOW.read_text().split())
    for requirement in (
        'without a plan copy or successor',
        'do not ask to reconfirm them',
        'direct and transitive dependent stages',
        'independent stages keep their status',
        'Continuing a partial passage',
        'remove, retain or mask',
        'before committing',
    ):
        assert requirement in workflow
    stage = (TEMPLATES / 'stage-realization-template.md').read_text()
    assert 'unique record id and anchor' in stage
    assert 'Continue a partial passage in its existing record' in stage
