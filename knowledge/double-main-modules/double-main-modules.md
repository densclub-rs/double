---
id: double-main-modules
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: dynamic
access: free-of-charge
value-type: text
observed-at: 2026-10-29
ttl: one month
retrieval-method: local-command
derived-from:
  - .double/agents/
---

<a id="double-main-modules"></a>

# Main Double Modules

## Description

The main modules that make up the Double project, obtained from the first-level
directories in `.double/agents/`. Preserve their directory names as module ids
and list them in alphabetical order. Files and symbolic links are excluded.

## Value

```json
[
  "double-agent",
  "machine-of-goals",
  "machine-of-ideas",
  "machine-of-knowledge"
]
```

## Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "urn:double:knowledge:double-main-modules",
  "title": "Main Double Modules",
  "description": "Unique identifiers of the main modules discovered in the first-level agent directories.",
  "type": "array",
  "uniqueItems": true,
  "items": {
    "type": "string",
    "pattern": "^[a-z0-9]+(?:-[a-z0-9]+)*$"
  }
}
```

## Command

Run from the Double repository root to obtain the current value as JSON:

```sh
python3 - <<'PYCODE'
import json
from pathlib import Path

catalog = Path('.double/agents')
if not catalog.is_dir():
    raise SystemExit('Missing module catalog: .double/agents')
modules = sorted(
    path.name for path in catalog.iterdir()
    if path.is_dir() and not path.is_symlink()
)
print(json.dumps(modules, indent=2))
PYCODE
```

To refresh this knowledge, run the command, validate its output against
`Schema`, replace the JSON in `Value`, and set `observed-at` to the actual
retrieval date. Preserve `ttl: one month`. If retrieval or validation fails,
keep the last observed value and date; do not replace them with an assumed
value. The command prints the value and does not edit the artifact itself.
