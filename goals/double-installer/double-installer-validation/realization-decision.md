---
id: double-installer-validation-realization-decision
kind: realization-decision
template-id: realization-decision-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
goal-id: double-installer-validation
interaction-language: ru
artifact-language: en
plan-revision: 5
plan-revision-artifact: ./realizations/plan-revision-5.md
realization-record-id: interactive-ci
realization-artifact: ./realizations/interactive-ci.md
selected-paths:
  - path-shared-tests-ci
path-selection-confirmed-by: user
path-selection-confirmed-at: 2026-10-15T10:48:54Z
---
<a id="double-installer-validation-realization-decision"></a>
# Decision: Shared Tests and Interactive CI Implementation

User explicitly authorized proceeding to S06 and executing its subplan.
[Baseline](./realizations/plan-revision-2.md#double-installer-validation-plan),
[realization revision 1](./realizations/interactive-ci.md#interactive-ci-revision-1).
Enter CI01 with historical local evidence; implement sequentially and validate
stage results. Preserve unrelated work. Repository/disposable local tests allowed;
no release publication, real host cron/project mutation or broad host changes.
Hosted execution needs the exact checkout committed/pushed; review concrete
branch/diff before external mutation. Automatic realization is not registered.

## Continuation Decision — 2026-10-16

User approved the revised release-integrated plan and explicitly requested
CI04 execution. Selected path remains shared-tests-ci; realization revision 2
is aligned with plan revision 2. New run starts at CI04, carrying accepted
CI01–CI03 from baseline 1 without rebinding it. First publication remains a
separate concrete decision in CI05; no tag/push/publication authorized here.

2026-10-16: user explicitly authorized CI02R single-workflow refactor. Same
shared-tests path, realization revision 3, baseline 3; local changes/checks
only. No new tag, push, release or hosted execution is authorized by this step.

2026-10-17: user authorizes removal of all post-publication checks; same path,
baseline 4 and realization 4. Local implementation/validation only.

## Temporary Quick Release Validation — 2026-10-20

User explicitly authorizes temporarily excluding long tests and publishing the
installer with quick checks. Required: syntax and platform lifecycle smoke on
all six OS/architecture rows, fast repository regressions, live package and real
cron checks, then the strict gate and two-asset publication. CI invokes
run-installer-tests.sh --quick and bounds installer jobs at ten minutes.
The 175-case comprehensive fixture suite is preserved for explicit/manual runs;
it is not required for this temporary release policy. This reduced coverage must
not be reported as full regression coverage. User plans to refactor slow tests.
No branch duplicate, tag overwrite, manual gate bypass or post-publication tests.
Baseline 5 / realization 5 capture the changed acceptance contract before action.
