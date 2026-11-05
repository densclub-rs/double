# Manual agent routing scenarios

Run each scenario independently in a project with the relevant machines installed,
for both Codex and Claude Code. Inspect the loaded skill and ensuing behavior;
these scenarios are behavioral evaluations, not guarantees provided by the files.

| Request and setup | Expected behavior |
| --- | --- |
| Ask to continue an existing idea without naming a machine; its artifact identifies `machine-of-ideas/idea-capture-agent`. | Identify provenance and current state, load the installed Machine of Ideas skill, and follow its workflow before proposing continuation or editing. |
| Ask to continue an existing goal whose artifact identifies Machine of Goals. | Identify provenance and state, load the installed Machine of Goals skill, and follow its workflow. |
| Ask a factual question about an existing idea artifact. | Answer from the artifact; do not advance its workflow merely because it was read. |
| Ask to edit an existing idea explicitly outside the machine workflow. | Respect the explicit request and do not force the workflow. |
