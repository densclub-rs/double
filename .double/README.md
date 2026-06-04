# Double Working Catalog

The `.double/` directory is the working catalog of Double.

It contains process material for Double submodules: workflows, agent cards, roles, modes, prompts, templates, registries, skills, and drafts. These files describe how Double should operate. They are not user idea artifacts.

When a user refers to the "working catalog", "the catalog", "your side", "inside yourself", or "у себя", an agent should usually interpret that as `.double/` if the user is asking to change the behavior of Double, a submodule, a workflow, a mode, a prompt, a template, a skill, or an agent role.

User idea artifacts usually live outside `.double/`, especially under `ideas/`.

## Submodules

Working files that belong to a specific Double submodule should declare that ownership in frontmatter:

```yaml
submodule: <submodule-id>
```

For example, current Machine of Ideas working files use:

```yaml
submodule: machine-of-ideas
```

Submodule-specific behavior rules belong in the relevant workflow, agent, role, prompt, mode, template, registry, or skill files for that submodule.
