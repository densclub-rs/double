---
id: machine-version-and-changelog-locations
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-29
ttl: one month
derived-from:
  - .double/agents/double-agent/double-agent.md
  - user instruction to preserve separate machine changelogs on 2026-10-28
  - user-requested version, date and concise changelog format on 2026-10-28
  - user approval of the format and request to refactor machine changelogs on 2026-10-28
  - user-approved project version source precedence and unchanged version values on 2026-10-28
  - user-approved schema-based storage and grouping artifacts by machine on 2026-10-28
  - user-required version and changelog components in the schema on 2026-10-29
---

<a id="machine-version-and-changelog-locations"></a>

# Machine Version and Changelog Locations and Format

## Description

Where the Double project preserves machine versions and change history, and
how each version's changelog entry is formatted.

## Value

Applied for every module identifier `<machine>`.

### Version

Resolve the current machine's version source from applicable project knowledge
in `.double-rules/` first. Use a directly indexed `<machine>-version` artifact
or a link to that artifact in an indexed knowledge item's `Value`. Read the
`Common Rules`, `double-agent` and selected machine's index headings.

When no project source is established, use
`knowledge/<machine>-version/<machine>-version.md` as the default. A broken,
conflicting or invalid project source blocks dependent work instead of
triggering fallback. Local reads and updates use the resolved source; tagged
packaging resolves the index and source from the exact tagged tree.

### Storage Layout

`Schema` uses JSON Schema Draft 2020-12. It was authored from the user-agreed
knowledge composition and storage rules. Its identifier refers to this public
knowledge artifact; it validates the JSON descriptor below. File contents and
cross-field machine-prefix agreement are checked separately after expansion.

The machine version-and-change knowledge consists of exactly two required
components: `version` preserves the current machine version, and `changelog`
preserves the changes by release. Store the components as two independent
knowledge artifact files in one directory per machine. The named properties
below are required roles, not interchangeable slots for arbitrary files.
The following JSON is the storage descriptor; `Schema` validates this structured
part of the value. Replace `<machine>` with the confirmed machine identifier.
Resolve `directory` within the selected catalog root, rather than relative to
this public document.

```json
{
  "directory": "<machine>",
  "artifacts": {
    "version": {
      "id": "<machine>-version",
      "file": "<machine>-version.md"
    },
    "changelog": {
      "id": "<machine>-changelog",
      "file": "<machine>-changelog.md"
    }
  }
}
```

For this project's machine knowledge, the catalog root is `.double-rules/`.
For example:

```text
.double-rules/machine-of-knowledge/
  machine-of-knowledge-version.md
  machine-of-knowledge-changelog.md
```

The same descriptor can be applied inside `knowledge/` when ordinary public
knowledge is the selected destination. The directory groups artifacts by their
subject; each file remains a complete knowledge artifact with its own stable
id and matching root anchor. For each role, the id is `<machine>-<role>` and
the file is `<machine>-<role>.md`; the machine prefix matches the resolved
directory. Verify that relationship after placeholder expansion. A directory index
or wrapper knowledge artifact is not required.

Register actual paths under Double Agent and the owning machine in the project
index. The index may reference this public layout as the project's selected
schema without relocating the layout artifact. When no schema or project
source applies, the historical per-artifact directory paths remain defaults.

### Changelog Entry Format

Use a version heading with a date, followed by a concise list of changes:

```markdown
### X.Y.Z — YYYY-MM-DD

- Briefly describe one significant change.
- Briefly describe another significant change.
```

- The heading identifies the exact machine version and its release date in
  `YYYY-MM-DD` format. Preserve a release suffix such as `-rc` when applicable.
- Order entries newest first. Each release has one entry.
- Write the changes in English. Use short, concrete statements describing
  user-visible behavior, significant fixes or compatibility changes.
- Use as many bullets as needed to describe the significant changes without
  repeating implementation details, workflow instructions or development history.
- Do not invent historical release dates or version assignments. Preserve
  unresolved attribution or dates in the artifact's optional `Notes` until
  verified; do not present them as confirmed release entries.
- During release preparation, propose the release date and entry text for
  review. A dated draft does not establish that publication has occurred.
- Show the complete entry, including its version and date, for user approval.
  Apply requested edits and obtain approval of the resulting text before
  proceeding with the release. Any later text or date change requires renewed
  approval.
- Use the complete approved entry as the annotated tag message and GitHub
  release text. Telegram may shorten the message and link to the full release.

## Notes

The format was approved on 2026-10-28 and applied to the four machine
changelog artifacts. Draft entry dates and incomplete historical attribution
are identified in each changelog; entry approval is still required before a
new release.

## Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "urn:double:knowledge:machine-version-and-changelog-locations",
  "title": "Machine Version and Changelog Knowledge Composition and Storage",
  "description": "The storage descriptor for this knowledge requires both a current-version artifact and a changelog artifact for one machine.",
  "type": "object",
  "required": [
    "directory",
    "artifacts"
  ],
  "additionalProperties": false,
  "properties": {
    "directory": {
      "type": "string",
      "pattern": "^(?:<machine>|[a-z0-9]+(?:-[a-z0-9]+)*)$",
      "description": "Machine directory relative to the selected catalog root."
    },
    "artifacts": {
      "type": "object",
      "required": [
        "version",
        "changelog"
      ],
      "additionalProperties": false,
      "properties": {
        "version": {
          "type": "object",
          "description": "Knowledge artifact preserving the current machine version.",
          "required": [
            "id",
            "file"
          ],
          "additionalProperties": false,
          "properties": {
            "id": {
              "type": "string",
              "pattern": "^(?:<machine>|[a-z0-9]+(?:-[a-z0-9]+)*)-version$"
            },
            "file": {
              "type": "string",
              "pattern": "^(?:<machine>|[a-z0-9]+(?:-[a-z0-9]+)*)-version\\.md$"
            }
          }
        },
        "changelog": {
          "type": "object",
          "description": "Knowledge artifact preserving versioned machine change history.",
          "required": [
            "id",
            "file"
          ],
          "additionalProperties": false,
          "properties": {
            "id": {
              "type": "string",
              "pattern": "^(?:<machine>|[a-z0-9]+(?:-[a-z0-9]+)*)-changelog$"
            },
            "file": {
              "type": "string",
              "pattern": "^(?:<machine>|[a-z0-9]+(?:-[a-z0-9]+)*)-changelog\\.md$"
            }
          }
        }
      }
    }
  }
}
```
