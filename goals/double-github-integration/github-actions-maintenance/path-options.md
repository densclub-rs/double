---
id: github-actions-maintenance-path-options
kind: path-options
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: en
artifact-language: en
goal-id: github-actions-maintenance
goal-artifact: ./github-actions-maintenance.md
goal-scope: subgoal
parent-goal-id: double-github-integration
derived-from:
  - ./github-actions-maintenance.md
  - ../../../.github/workflows/release.yml
---

<a id="github-actions-maintenance-path-options"></a>

# Path Options: GitHub Actions Maintenance

## 1. Source Goal

- Goal: [GitHub Actions Maintenance](./github-actions-maintenance.md#github-actions-maintenance)
- Scope: subgoal
- Parent goal: [Double GitHub Integration](../double-github-integration.md#double-github-integration)
- Current state: `release.yml` contains the release parsing, package-selection,
  archive, checksum, and GitHub Release logic in one GitHub Actions workflow.
- Target state: a maintainable release implementation supports the accepted
  module tag and status-filtering contract, is callable on a local laptop for
  package testing, and is invoked autonomously by GitHub Actions for releases.
- Success criteria: the selected path enforces the goal's tag, status, version,
  warning, package, prerelease, permission, and retention requirements.
- Constraints: use a shell-based implementation; permit local package testing;
  do not require repository secrets beyond the automatic GitHub token; preserve
  GitHub Actions as the autonomous release executor.

## 2. Discovery Scope

- Mode: `research`
- Sources inspected:
  - `./github-actions-maintenance.md`
  - `.github/workflows/release.yml`
  - Machine of Goals path-discovery materials
- Existing analogs checked: the current `release.yml` is the local analog; no
  reusable local release script exists.
- Known limitations of discovery: the exact shell-script interface, directory,
  and test cases remain planning decisions; no implementation or GitHub run was
  performed.

## 3. Path Options

<a id="direct-workflow-rules"></a>

### Path: Direct Workflow Rules

- Path id: `direct-workflow-rules`
- Path type: direct
- Description: extend the Bash blocks embedded in `release.yml` to parse the
  accepted tags, select the matching `.double` machine files, package them, and
  publish the result.
- Why it is plausible: the current workflow already implements these concerns
  directly in GitHub Actions.
- Required resources: `release.yml`, GitHub Actions, GitHub Releases, and
  workflow-only validation.
- Main risks: release logic remains difficult to run locally; long embedded
  Bash blocks are harder to test, reuse, and maintain.
- Expected cost: low
- Expected value: medium
- Unknowns: local testing would require reproducing workflow behavior outside
  the workflow or accepting GitHub-only execution.
- Reuse / import opportunity: reuse the current workflow's logic in place.
- Plan element: none; retained as an unselected alternative.
- Recommendation: keep-as-alternative

<a id="shell-script-workflow-adapter"></a>

### Path: Shell Script with Thin Workflow Adapter

- Path id: `shell-script-workflow-adapter`
- Path type: hybrid
- Description: move reusable release logic into a repository shell script. The
  workflow becomes a thin adapter that passes the release tag and invokes the
  script. The accepted interface is `scripts/double-release.sh package --tag <tag>`
  for safe local packaging and `scripts/double-release.sh publish --tag <tag>` for
  publication, using the same tag parsing and selection rules.
- Why it is plausible: it preserves GitHub Actions for autonomous releases and
  lets the package logic run on a laptop against a selected tag before a
  release is published.
- Required resources: one shell release script, a small `release.yml` adapter,
  Git and standard shell utilities locally, and GitHub CLI or the GitHub token
  only for the publish operation.
- Main risks: the script contract must separate safe local packaging from
  GitHub publication; Bash compatibility and deterministic archive behavior
  must be tested.
- Required local tests:
  - stable, `rc`, and `dev` tags select only files with their matching status
  - each package contains only the selected machine's Markdown working files
  - a tag/machine-version-knowledge mismatch fails
  - exported working-file copies receive the verified tag version without
    changing their source frontmatter
  - nonmatching or missing statuses emit warnings and are excluded
  - no matching files emits the final warning and creates no package
  - the archive checksum matches and `package` never publishes a GitHub Release
  - GitHub Actions logs and temporary workflow artifacts use 14-day retention;
    published GitHub Release assets are not subject to that retention rule
- Expected cost: medium
- Expected value: high
- Unknowns: local test fixture strategy.
- Reuse / import opportunity: extract and adapt the current workflow's tag,
  package, checksum, and publication logic.
- Plan element: [S01: Specify the Release Contract](./plan.md#stage-s01).
- Recommendation: candidate

<a id="reusable-composite-action"></a>

### Path: Reusable Composite Action

- Path id: `reusable-composite-action`
- Path type: reusable-plan
- Description: extract the release steps into a composite GitHub Action or a
  reusable workflow, then invoke it from `release.yml`.
- Why it is plausible: GitHub-native reuse can reduce YAML duplication if more
  repository workflows later need release behavior.
- Required resources: a composite action or reusable workflow and GitHub
  Actions validation.
- Main risks: it remains primarily GitHub-bound and does not provide the
  desired native laptop testing experience without an emulator or a separate
  local implementation.
- Expected cost: medium
- Expected value: low
- Unknowns: whether future workflows need the same reusable GitHub interface.
- Reuse / import opportunity: reuse the current workflow steps in a
  GitHub-native component.
- Plan element: none; rejected before plan synthesis.
- Recommendation: reject

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| `direct-workflow-rules` | medium | low | medium | low | medium | keep-as-alternative |
| `shell-script-workflow-adapter` | high | medium | medium | medium | high | candidate |
| `reusable-composite-action` | low | medium | medium | medium | low | reject |

## 5. Rejected or Deferred Paths

- `reusable-composite-action`: rejected for the first release implementation
  because it does not satisfy native local package testing.

## 6. Computed Plan Style

- Computed style: `multi-pass`
- Computed from: registered automatic realization
  [`double-release-shell-workflow`](#double-release-shell-workflow)
- Rule: registration, rather than file creation or first successful execution,
  is the style transition point.

<a id="registered-realizations"></a>

## 7. Registered Realizations

<a id="double-release-shell-workflow"></a>

### Realization: Double Release Shell and Workflow

- Realization id: `double-release-shell-workflow`
- Kind: workflow
- Definition and implementation:
  [release program](../../../scripts/double-release.sh) and
  [GitHub Actions adapter](../../../.github/workflows/release.yml)
- Exact implementation references:
  [release program at `3a86411`](https://github.com/densclub-rs/double/blob/3a86411a7b86d677174a36593d1820444412015d/scripts/double-release.sh)
  and
  [workflow at `1354130`](https://github.com/densclub-rs/double/blob/135413068f8d0f77e99bbd2680bbbc7efe187e04/.github/workflows/release.yml)
- Supported path: [Shell Script with Thin Workflow Adapter](#shell-script-workflow-adapter)
- Registration: registered
- Readiness: ready
- Alignment: review-required after the navigation-contract revision
- Runs: `0` Machine of Goals run artifacts
- Retained runs: [Run index](./run/index.md#github-actions-maintenance-run-index)

## 8. Run Retention

- Retained runs: [Run index](./run/index.md#github-actions-maintenance-run-index)
- Maximum terminal runs per realization: `5`
- Individual run files are not linked from this registry.

## 9. Open Questions

None currently.
