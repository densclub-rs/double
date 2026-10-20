---
id: interactive-ci
kind: realization-artifact
template-id: realization-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
goal-id: double-installer-validation
interaction-language: ru
artifact-language: en
plan-revision: 5
plan-revision-artifact: ./plan-revision-5.md
realization-record-id: interactive-ci
realization-id: interactive-ci-procedure
realization-kind: manual
realization-revision: 5
implementation-revision: null
realization-mode: interactive
selected-paths:
  - path-shared-tests-ci
status: ready
alignment: aligned
---
<a id="interactive-ci"></a>
# Realization: Interactive Validation Implementation

[Registry](../plan.md#interactive-ci), [decision](../realization-decision.md#double-installer-validation-realization-decision),
[baseline](./plan-revision-1.md#double-installer-validation-plan).

<a id="interactive-ci-revision-1"></a>
## Revision 1

Prepare shared scenarios at CI01, implement CI02 workflow/gate, execute CI03
matrix and CI04 integrations, then consolidate CI05. Preserve imported local
evidence, refresh applicable tests when implementation changes. Capture each
stage contract before action and exact useful successful commands after result.
Stop for stage validation, unavailable evidence or unauthorized external scope.
No publishing, unrelated changes, global host scheduling or project mutations.

## Runs

[First application](../run/interactive-ci--20261015T104854Z.md#double-installer-validation-run-interactive-ci--20261015T104854Z),
started 2026-10-15T10:48:54Z, running. [Index](../run/index.md#double-installer-validation-run-index).

## Revision-2 Plan Alignment Required — 2026-10-16

The approved plan now owns release preparation, publication and downloaded
installer validation in CI04–CI06. Revision 1 above remains historical and
its no-publication procedure cannot execute the new contract. Align a new
realization revision and decision before opening a revision-2 execution run.

<a id="interactive-ci-revision-2"></a>
## Revision 2 — Approved 2026-10-16

User authorized executing the next stage of approved plan revision 2. Carry
accepted CI01–CI03 by reference; execute CI04 release preparation with local
package and gate checks, then stop for stage acceptance. CI05 requires an
explicit first tag/version/publication decision before remote mutation; run
mandatory exact-commit CI, publish and test downloaded assets. CI06 performs
final consolidation/knowledge/user acceptance. Capture each effective contract
and successful useful commands in the new baseline-2 run. No host cron or
unrelated changes. Revision 1 and its run remain historical.

[Revision-2 run](../run/interactive-ci--20261016T094955Z.md#double-installer-validation-run-interactive-ci--20261016T094955Z).

Parent S05A expanded product scope; baseline-2 run is now closed partial.
Review new global-agent coverage before a new validation continuation.

<a id="interactive-ci-revision-3"></a>
## Revision 3 — Approved Single Workflow Refactor

Start CI02R after explicit user instruction. Consolidate tests, candidate
resolution, gated installer publication and published-asset checks in one
workflow. Preserve separate machine release behavior, existing release assets
and old runs. Run local resolver/gate/YAML checks; fresh hosted matrix and a
new version require later concrete execution/publication decisions.

[Refactor run](../run/interactive-ci--20261016T162619Z.md#double-installer-validation-run-interactive-ci--20261016T162619Z).

<a id="interactive-ci-revision-4"></a>
## Revision 4 — Tests Then Publication

User explicitly removed post-publication checks on 2026-10-17. Baseline 4
retains full prepublication tests and the strict gate; publication ends the
automated chain. No new release authorized.
[Run](../run/interactive-ci--20261017T173000Z.md).

<a id="interactive-ci-revision-5"></a>
## Revision 5 — Temporary Quick Release


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

[Run](../run/interactive-ci--20261020T094950Z.md#double-installer-validation-run-interactive-ci-20261020T094950Z).
