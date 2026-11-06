---
id: double-system-installer
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: ru
artifact-language: en
derived-from:
  - source conversation on 2026-10-13
  - ../double-installer/double-installer.md
---

<a id="double-system-installer"></a>

# Goal: Double System Installer

## 1. Summary

Provide a small shell bootstrap script that installs the appropriate Double
project installer or distribution entry point into the user's system. Double
System Installer adapts to the project's distribution method and supports
different kinds of project installers as Double evolves.

The first supported variant is the minimal Shell-based Double Installer.
A possible future variant is a TypeScript-based Double agent with its own
installers and installation functions. The bootstrap provides a simple entry
point in the style of shell-based installers commonly used by AI agent projects.

## 2. Subject of the Goal

### Subject

- Users setting up Double project installers or the Double agent on their computers.
- The Double System Installer bootstrap script.
- The supported Double distribution variants and their installed entry points.

## 3. Motivation

- Give users a simple starting point for adopting Double.
- Remove the need to retrieve and place project installers manually.
- Keep the bootstrap useful as Double's distribution method and implementation
  language evolve.
- Keep system bootstrap responsibilities separate from machine installation
  and management inside projects.

## 4. Current State

### Known facts

- The user requests a separate goal named Double System Installer.
- The requested implementation form is a shell script that downloads the
  required project artifacts; the initial variant is the Double Installer script.
- The existing Double Installer goal describes the component responsible for
  subsequent machine installation, release downloads, and project management.
- The current Double Installer is described by the user as Shell-based and
  performing the minimum necessary actions.
- The user anticipates a possible evolution toward TypeScript, with installers
  and other functions integrated into a general Double agent. This is a
  direction for future compatibility, not a committed TypeScript implementation.
- This formulation does not establish that a downloadable Double Installer
  script or a published bootstrap endpoint already exists.

### Relevant environment

Local user systems running Linux, macOS, or Windows with access to the
project's published artifacts. Windows uses Git Bash from Git for Windows,
matching the Double Installer goal. Both per-user and system-wide installation
are supported.

### Existing related goals or subgoals

- Double Installer — related goal in project `double`, artifact id
  `double-installer`. The previously referenced local goal artifact is not
  present in this checkout, so its current revision and location are unverified.
  It was identified as owning the downstream behavior of the initial Shell
  installer. Double System Installer supports this installer as its first
  variant and adapts to subsequent project distribution methods.

## 5. Target State

### Required result

- Users can run a shell bootstrap script to install the supported Double
  distribution entry point into their system.
- Double System Installer supports different kinds of project installers and
  adapts artifact retrieval, setup, and usage instructions to Double's
  distribution method. It is not permanently coupled to a standalone Shell
  installer.
- The initial supported variant is the minimal Shell-based Double Installer.
  The goal accommodates future variants, including a possible TypeScript-based
  Double agent with its own installers and installation functions. Concrete
  future variants are supported when their distribution contracts are defined.
- The first version supports Linux, macOS, and Windows through Git Bash from
  Git for Windows, matching Double Installer's platform coverage.
- Users can install the supported distribution either for the current user or
  system-wide for all users. The documented invocation works within the
  selected installation scope.
- The bootstrap downloads the artifacts required by the supported distribution
  method from the project's distribution source. Initially these include the
  Double Installer script.
- After successful bootstrap, the installed project installer or agent can be
  invoked to perform the remaining Double installation operations.
- After installation, the bootstrap displays instructions appropriate to the
  installed distribution. It does not launch the installed installer or agent
  automatically; the user starts it separately.
- Machine installation and management remain owned by the installed project
  installer or agent; the bootstrap does not duplicate those responsibilities.
- User instructions identify the bootstrap entry point, supported distribution
  variant, and how to invoke its installed entry point.

### Optional quality improvements

None specified at formulation time.

### Evidence

A demonstrated bootstrap invocation on each agreed supported environment,
with displayed invocation instructions and no automatic launch of Double
Installer, followed by a separate user-initiated invocation through the
documented entry point.

## 6. Success Criteria

- Minimal success: the shell bootstrap downloads and installs Double
  Installer, displays instructions without launching it, and the user can
  invoke it separately through the documented entry point.
- High-quality success: the documented first-install flow is repeatable
  across the agreed supported environments.
- Installation scope success: both per-user and system-wide installation
  produce a usable distribution entry point accessible within the selected scope.
- Adaptability success: the bootstrap's installation boundary describes how
  each supported distribution is retrieved, set up, and invoked. A new
  distribution variant can be supported without moving downstream project
  management responsibilities into the bootstrap. Verification for each added
  variant demonstrates installation and accurate usage instructions.
- Partial success: the script downloads Double Installer, but additional
  manual placement or setup is required before the documented invocation works.
- Failure / not achieved: bootstrap does not produce a usable Double
  Installer installation, or reports success after a failed download or setup.

## 7. Constraints

- Time: no deadline specified.
- Attention: keep the first-install experience simple.
- Cost: no budget specified.
- Technical constraints: a shell script downloads the required project
  artifacts appropriate to the supported distribution method; the installed
  project installer or agent owns downstream installation behavior.
  Support Linux, macOS, and Windows via Git Bash from Git for Windows.
  Support both per-user and system-wide installation; concrete locations and
  required permissions for each platform are to be established during planning.
- Social / legal / ethical constraints: none additionally specified.
- Other: concrete paths, dependencies, and distribution mechanics belong to
  research and planning.

## 8. Resources

- Available resources: the related Double Installer goal and the Double
  repository.
- Missing resources: a confirmed published Double Installer artifact and its
  download entry point; distribution contracts for future installer variants.
- Tools or systems: shell execution, artifact hosting, and local user systems.
- People or organizations: Double maintainers and users.

## 9. Open Questions

None. The goal is sufficiently clarified for path discovery. Concrete
installation locations, permissions, dependencies, and distribution mechanics
remain research and planning details.

## 10. Boundaries / Non-Goals

- Implementing the downstream Double Installer is owned by its separate goal.
- Implementing a future TypeScript-based Double agent or its installation
  functions is outside this bootstrap goal. Adapting bootstrap to their
  distribution method is within scope when that method is defined.
- Automatically launching an installed project installer or agent after
  bootstrap is outside this goal.
- Installing machines into projects, maintaining their installation registry,
  and managing machine updates belong to the downstream project installer or
  agent.
- Selecting concrete download URLs, installation directories, release
  selection rules, or bootstrap lifecycle commands is deferred to subsequent
  research and planning.
- This artifact formulates the goal; it does not implement or execute either
  installer.

## 11. Machine of Goals Artifacts

Possible paths: [Path options](./path-options.md#double-system-installer-path-options).

| Branch | Review revision | Plan |
| --- | --- | --- |
| main | 2 | [Double System Installer plan](./plan.md#doublebootstrap) |
