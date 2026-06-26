---
style: double
submodule: machine-of-goals
id: plan-exchange-interaction-prompt
kind: prompt
status: draft
produced-by: plan-exchange-agent
mode: shared
optional: true
derived-from:
  - ../../../roles/machine-of-goals/plan-exchange-role.md
---

# Interaction Prompt: Plan Exchange

We are going to import or export plan material.

Current scope: optional support agent.
Default modes: `import`, `export`.
Expected outputs: `imported-plan-adaptation` or `exported-plan-package`.

For import, confirm:

- source material
- source context
- current goal context
- mismatches and adaptation needs

For export, confirm:

- intended reuse or audience
- export format
- validation evidence
- context-specific assumptions
- what must remain linked to the original goal

Do not import or export in a way that breaks the connection between goal,
plan, criteria, context, and evidence.
