---
style: double
submodule: double-agent
id: exchange-package-workflow
kind: workflow
status: release-candidate
---

# Double Exchange Package Workflow

## Scope

Provide a common packaging contract for machine-owned ideas and goals. The
owning machine selects and prepares content; Double Agent selects a supported
container with the user and packages and verifies the prepared content. This is
distinct from machine release packaging and does not publish by itself.

## Content and Formats

The package includes `manifest.yaml`, selected material and its dependencies.
Create the manifest using the [exchange package manifest template](../../templates/double-agent/exchange-package-manifest-template.md).
The proposed manifest has `schema-version`, package identity, version, type,
title, summary and language, and content-specific paths. Goal content identifies
its goal, plans and selected manual or automatic sharing realizations, including
their plan, location, entry point, optional documentation and requirements.
Idea content identifies the idea and selected related artifacts. Paths are
relative to the package root; reject absolute paths, traversal and missing
referenced files. A realization may identify a directory containing its files.
Do not duplicate the archive inventory as a `files` list in the manifest.
The [version 1 manifest schema](../../templates/double-agent/exchange-package-manifest.schema.json)
defines the current structural fields; package validation must also check
referenced files and relationships. An executable packaging implementation
remains to be built and validated.

## Repository Metadata

The manifest and discovery registry templates embed the fixed top-level
`double-repository: https://github.com/densclub-rs/double`. Include the optional
top-level `project-repository` only when the active project's address is
confirmed. These fields identify Double and the user's project independently;
neither replaces `package.public-url`, registry publication links or source
artifact provenance. Follow the Double Agent workflow's Project Repository Metadata
rule for project-address clarification and document maturity transitions.
Preserve source artifacts and their metadata when packaging sharing copies.

The version 1 manifest schema accepts these attributes when present and checks
the canonical Double URL and a nonempty project address. It continues to accept
legacy manifests without the attributes. The embedded template value does not
introduce a runtime presence check or trigger an implicit migration. Import and checksum
verification do not probe either repository or execute its contents.

## Explain, Check and Dry Run

Explain describes the goal, realizations, requirements and intended installation
actions without checking the environment, and displays the actual available
command for checking current requirements. When known, show the public goal
page or catalog URL from the manifest. During manual export the user may supply
this URL; a Git remote is only a candidate and is not by itself proof of a
public page. Do not invent a URL or claim publication. Future registry upload
may supply a publication URL when that workflow is implemented.

Check displays its check commands and, when explicitly invoked, evaluates only
the selected realization's local requirements. Report met, unmet or unknown
separately; never infer success from an unparseable version. Check does not
search registries. Separately, Double Agent may use unmet capability IDs to find
matching goals and present candidates without executing them. An unavailable
registry is not an empty one. Dry run shows intended installation commands
without executing them or changing the system. These operations are design
requirements, not claims of complete implementation.

Checks are argument arrays invoked directly without a shell. In schema version
1, version constraints are `>=` followed by dot-separated integers; extract
the version with the declared pattern's first capture and compare components
numerically, padding missing components with zero. Unsupported constraints,
unparseable output and failed checks are unknown; a missing executable is unmet.

## Integrity Checks

Every export creates `SHA256SUMS` at the package root, containing a SHA-256
digest and package-relative path for every regular content file, including
`manifest.yaml` and excluding `SHA256SUMS` itself. Reject duplicate entries,
unsafe paths and ambiguous filenames that cannot be represented reliably in the
chosen checksum format. Create the checksum file after assembling the content,
then build the container and verify the extracted files against it. At import or
installation, check before placing files: missing, mismatched or unlisted files
block the operation. Checksums establish integrity, not authorship or trust;
the shell container itself must be trusted before executing it for extraction.

Supported formats are intended to be `.double.zip` (a ZIP archive) and
`.double.sh` (a self-extracting shell package). Both carry equivalent content.
Show the format and execution requirements before selection. Inspecting or
extracting a ZIP must not execute a packaged realization. Running a shell package
executes code; disclose this before running it. Package creation never runs a
realization. Do not claim support for a format until its implementation exists
and is verified.

## Shell Package Informational Entry

This contract applies to both goal and idea `.double.sh` packages when a shell
container is implemented and verified. It does not declare shell packaging
available; the current experimental exchange implementation supports ZIP only.

Running a shell package with no arguments must display brief help on standard
output and exit with status 0. `--help` must display the same help and exit
successfully. These informational paths must not extract content, create files
or temporary directories, install or register anything, check the environment,
access the network, or invoke a packaged realization. Prepare the informational
metadata at package creation so displaying it needs no extraction or dependency
bootstrap. Treat metadata as literal text, never as shell commands.

Use the existing manifest fields for the informational content:
- Identify the package using `package.title`, `package.id` and `package.version`.
- Give its brief description from `package.summary`.
- Show a short, actionable guide to the next supported operations and their
  actual invocation syntax. List only operations implemented by this container;
  do not advertise design-only actions as available commands.
- When `package.public-url` is present, display it as the package home page near
  the end. Otherwise omit that line. Do not invent a URL, use a Git remote as
  proof of a public page, or probe a website while displaying help.

Format the help in the style of GNU command-line tools: start with
`Usage: <archive-name> [OPTION]...`, followed by a short description, a blank
line, and an aligned list of available options with concise descriptions.
Include `--help` and `--version`, brief next-action instructions, and the
optional `Package home page: <URL>` line near the end. Use plain text without
mandatory color, decorative banners, emoji or terminal control sequences; keep
it readable both in a terminal and when redirected. The GNU-style presentation
neither asserts GNU project membership nor supplies invented GNU/support links.

`--version` must print the package name/identity and `package.version` on
standard output and exit with status 0, under the same no-side-effects boundary.
The version belongs to the exported package, not to the packaging tool or a
plan revision. The no-arguments behavior is an explicit Double requirement in
addition to the GNU-style `--help` and `--version` interface.

Before claiming a shell container is supported, run these acceptance scenarios
against a real generated package for both content types:

| Invocation or setup | Required result |
| --- | --- |
| No arguments | Brief help, stdout, status 0; no extraction, writes, installation, registration, checks, network or realization invocation |
| `--help` | Same informational content as no arguments, stdout, status 0 and the same absence of side effects |
| `--version` | Actual package identity/version, stdout, status 0 and the same absence of side effects |
| Manifest with `public-url` | Show the supplied URL near the end without requesting it |
| Manifest without `public-url` | Omit the home-page line, without substituting another URL |
| Available operations differ | Show only the container's supported options and actionable next steps |
| Redirected output and literal metadata | Readable plain text; metadata is never executed as shell code |

Contract consistency checks do not substitute for these runtime scenarios.
Do not simulate a shell implementation in tests or report shell runtime support
until an implementation exists and these scenarios have actually passed.

## Installation and Registry

Use the [discovery registry template](../../templates/double-agent/exchange-registry-template.md)
for available ideas and goals. Discovery registries may be local or remote and
are separate from records of installed packages. Match capability IDs exactly;
the candidate's version and platform still require evaluation.

Installation and registration are distinct from export. On explicit request,
install selected content into the selected scope and register only after success.
An update replaces the prior installed version; preserve the working source. A
failed update must report actual file and registry state and must not claim
success. The Double state root is `DOUBLE_STATE_DIR` when set, otherwise
`~/.local/state/double`; package registry storage is separate from the existing
installer-owned `installer/registry.json`. Registry layout, scope handling and
transaction semantics require implementation and validation.

The experimental ZIP installer stores cached archives under `goals/packages/`,
installed goal contents under `goals/installed/<goal-id>/`, and installation
records in `goals/registry.json` below the Double state root. The record includes
the selected realization and declared capabilities. This initial implementation
supports `goal search --capability <id>` against this local registry,
returning candidate goals without executing them. Missing or invalid registry
data is an error rather than an empty match. It does not expose commands on PATH,
implement system/project scope, or search remote registries. It must not modify
the Installer machine registry.

The exchange CLI is distributed at `.double/tools/double-agent/exchange/double-exchange`
with its Python modules and manifest schema. It currently requires Python 3.9+
with PyYAML and jsonschema installed; installation of these dependencies is not
automated. If they are missing, report the dependency rather than claiming the
tool is available.

## Validation and Handoff

Check manifest completeness, selected files, relative links, dependencies and
archive extraction; check shell operations when implemented. Report missing
components and unsupported formats explicitly. Supply the resulting package
only after validation. A contract document alone is not a packaging tool.
