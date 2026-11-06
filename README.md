# Double

Double is a project to create a personal digital twin that represents a
person's knowledge, skills, and ability to interact with the digital world.
It starts as a collection of skills and grows with the person who uses it.
With participants' consent, individual experience can also contribute to a
shared community agent.

The project's central aim is an open system for accumulating and exchanging
knowledge. Double's project knowledge is available free of charge; other
artifacts may have different access terms. Read the full [project idea](Double.md#grand-idea).

## Screencast

See the installer set up a test project and a Codex agent create an idea, a
goal, and a project rule. The English terminal replay uses real commands and
agent responses, is edited to shorten waiting time, and has no audio.

https://github.com/user-attachments/assets/2650d2a1-a533-405a-8ee0-b0b3e700ba66

[Download the screencast](_media/double-first-steps.mp4)

## Installation

Run the bootstrap from the project's `main` branch:
```bash
curl -fsSL https://raw.githubusercontent.com/densclub-rs/double/main/scripts/install.sh | bash
```
Then check that Double Installer is ready:
```bash
double-installer help
```
The default installation directory is `~/.local/bin`.

For system-wide installation in `/usr/local/bin`, use `--system` and run with the necessary permissions.

Download the bootstrap locally:
```bash
curl -fsSLo install.sh https://raw.githubusercontent.com/densclub-rs/double/main/scripts/install.sh
```
And run (_you can check the bootstrap script, of course_):
```bash
sudo bash install.sh --system
```
Use `--install-dir /absolute/path` to choose a different directory. If the selected directory is not in `PATH`, the bootstrap asks before updating shell configuration.

## Requirements

The bootstrap supports Linux and macOS with Bash 3.2 or newer, and Windows
through Git Bash. On Windows, run the commands in Git Bash; the user installation
is placed in `~/.local/bin`, and `--system` uses Git Bash's `/usr/local/bin`
and requires permission to write there. It does not configure PowerShell or
Windows system PATH.

The bootstrap needs `curl`, `jq`, standard shell utilities, and either
`sha256sum` or `shasum`.

## Ideas and Goals of the Double project

- [Double's grand idea](Double.md#grand-idea) — a personal digital twin and shared knowledge.
- [Machine of Ideas](ideas/machine-of-ideas/machine-of-ideas.md#machine-of-ideas) — develop raw thoughts into structured ideas, concepts, and principles.
- [Machine of Goals](ideas/machine-of-goals/machine-of-goals.md#machine-of-goals) — formulate verifiable goals, explore paths, plan, and validate results.
- [Machine of Knowledge](ideas/machine-of-knowledge/machine-of-knowledge.md#machine-of-knowledge) — extract and preserve knowledge for later use.
- [Ideas catalog](ideas/ideas.md) and [Goals catalog](goals/) — explore the project's work.
