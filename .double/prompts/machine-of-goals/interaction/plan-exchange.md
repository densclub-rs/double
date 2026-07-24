---
style: double
submodule: machine-of-goals
id: plan-exchange-interaction-prompt
kind: prompt
status: release-candidate
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
- existing implementation artifacts or packages to link as previous
  implementations
- mismatches and adaptation needs

For export, confirm:

- intended reuse or audience
- export format
- active plan artifact and relevant `results/` artifacts to include
- validation evidence
- context-specific assumptions
- what must remain linked to the original goal

Do not import or export in a way that breaks the connection between goal,
plan, criteria, context, and evidence.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
