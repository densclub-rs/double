#!/usr/bin/env python3
"""Validate local links and contextual Machine of Goals navigation."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from urllib.parse import unquote

ANCHOR_RE = re.compile(r'<a\s+id=["\']([^"\']+)["\']\s*></a>')
LINK_RE = re.compile(r'(?<!!)\[[^\]]+\]\(([^)\s]+)(?:\s+["\'][^"\']*["\'])?\)')
FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n", re.DOTALL)
FIELD_RE = re.compile(r"^([A-Za-z0-9-]+):\s*(.*?)\s*$", re.MULTILINE)
STAGE_ID_RE = re.compile(r"^- Stage id: `([^`]+)`", re.MULTILINE)
PATH_ID_RE = re.compile(r"^- Path id: `([^`]+)`", re.MULTILINE)
RUN_FILE_RE = re.compile(r"(?:^|/)(?:run/)?[^/]+--\d{8}T\d{6}Z\.md(?:#.*)?$")


def metadata(text: str) -> dict[str, str]:
    match = FRONTMATTER_RE.match(text)
    return dict(FIELD_RE.findall(match.group(1))) if match else {}


def anchors(text: str) -> set[str]:
    return set(ANCHOR_RE.findall(text))


def links(text: str) -> list[str]:
    return LINK_RE.findall(text)


def has_link_to(targets: list[str], suffix: str) -> bool:
    return any(target.split("#", 1)[0].endswith(suffix) for target in targets)


def validate_file(path: Path) -> list[str]:
    errors: list[str] = []
    text = path.read_text(encoding="utf-8")
    meta = metadata(text)
    kind = meta.get("kind")
    artifact_id = meta.get("id")
    scan_text = re.sub(r"```.*?```", "", text, flags=re.DOTALL) if kind == "template" else text
    file_anchors = anchors(scan_text)
    file_links = links(scan_text)

    semantic_kinds = {"goal-artifact", "path-options", "plan-artifact", "realization-decision", "realization-artifact", "plan-run", "run-index", "exported-plan-package"}
    if kind in semantic_kinds and not meta.get("project-id"):
        errors.append(f"{path}: missing stable project-id")
    if kind in semantic_kinds and artifact_id and artifact_id not in file_anchors:
        errors.append(f"{path}: missing explicit artifact anchor #{artifact_id}")

    for target in file_links:
        if target.startswith(("http://", "https://", "mailto:", "app://")):
            continue
        if "<" in target or ">" in target:
            continue
        target_path, _, fragment = unquote(target).partition("#")
        resolved = path if not target_path else (path.parent / target_path).resolve()
        if not resolved.exists():
            errors.append(f"{path}: missing link target {target}")
            continue
        if resolved.is_dir():
            errors.append(f"{path}: Markdown navigation must target a file: {target}")
            continue
        if fragment and fragment not in anchors(resolved.read_text(encoding="utf-8")):
            errors.append(f"{path}: missing explicit fragment #{fragment} in {target}")

    if kind == "goal-artifact":
        for candidate in ("plan.md", "path-options.md", "realization-decision.md"):
            if (path.parent / candidate).exists() and not has_link_to(file_links, candidate):
                errors.append(f"{path}: existing {candidate} is not contextually linked")
        run_index = path.parent / "run" / "index.md"
        if run_index.exists() and not has_link_to(file_links, "run/index.md"):
            errors.append(f"{path}: existing run/index.md is not contextually linked")
        realization_artifacts = [
            candidate
            for candidate in (path.parent / "realizations").glob("*.md")
            if not candidate.name.startswith("plan-revision-")
        ] if (path.parent / "realizations").exists() else []
        if realization_artifacts and not any("realizations/" in target for target in file_links):
            errors.append(f"{path}: existing realization artifacts are not contextually linked")
        parent_id = meta.get("parent-goal-id")
        if meta.get("goal-scope") == "subgoal" and parent_id:
            if not any(parent_id in target for target in file_links):
                errors.append(f"{path}: subgoal does not link parent goal {parent_id}")

    elif kind == "path-options":
        goal_id = meta.get("goal-id")
        if goal_id and not any(f"{goal_id}.md" in target for target in file_links):
            errors.append(f"{path}: Source Goal is not linked")
        for path_id in PATH_ID_RE.findall(text):
            if path_id not in file_anchors:
                errors.append(f"{path}: path {path_id} has no explicit anchor")
        for target in file_links:
            if RUN_FILE_RE.search(target):
                errors.append(f"{path}: registry links an individual run: {target}")

    elif kind == "plan-artifact":
        goal_id = meta.get("goal-id")
        if goal_id and not any(f"{goal_id}.md" in target for target in file_links):
            errors.append(f"{path}: plan summary does not link its source goal")
        for stage_id in STAGE_ID_RE.findall(text):
            anchor = f"stage-{stage_id.lower()}"
            if anchor not in file_anchors:
                errors.append(f"{path}: stage {stage_id} has no explicit anchor #{anchor}")

    elif kind == "realization-decision":
        if not has_link_to(file_links, "plan.md"):
            errors.append(f"{path}: decision does not link its selected plan")
        if not has_link_to(file_links, "path-options.md"):
            errors.append(f"{path}: decision does not link its selected path registry")
        if meta.get("realization-artifact") and not any("realizations/" in target and "plan-revision-" not in target for target in file_links):
            errors.append(f"{path}: decision does not link its realization artifact")
        if "immutable" not in text.lower() and "vcs" not in text.lower():
            errors.append(f"{path}: decision has no immutable revision locator")

    elif kind == "realization-artifact":
        for label, suffix in (("plan", "plan.md"), ("decision", "realization-decision.md"), ("path catalog", "path-options.md"), ("run index", "run/index.md")):
            if not has_link_to(file_links, suffix):
                errors.append(f"{path}: realization artifact does not link its {label}")
        revision = meta.get("realization-revision")
        if not revision or not revision.isdigit() or int(revision) < 1:
            errors.append(f"{path}: realization artifact has no positive realization-revision")
        elif artifact_id and f"{artifact_id}-revision-{revision}" not in file_anchors:
            errors.append(f"{path}: missing current realization revision anchor #{artifact_id}-revision-{revision}")

    elif kind == "plan-run":
        for label, suffix in (("plan", "plan.md"), ("decision", "realization-decision.md"), ("path registry", "path-options.md")):
            if not has_link_to(file_links, suffix):
                errors.append(f"{path}: run does not link its {label}")
        if "immutable" not in text.lower() and "vcs" not in text.lower():
            errors.append(f"{path}: run has no immutable revision locator")
        if not any("realizations/" in target and "plan-revision-" not in target for target in file_links):
            errors.append(f"{path}: run does not link its realization artifact")

    elif kind == "run-index":
        if any(RUN_FILE_RE.search(target) for target in file_links):
            if not any("realizations/" in target and "plan-revision-" not in target for target in file_links):
                errors.append(f"{path}: retained runs do not link a realization artifact")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("paths", nargs="*", default=["goals"])
    args = parser.parse_args()
    files: list[Path] = []
    for raw in args.paths:
        path = Path(raw)
        files.extend(path.rglob("*.md") if path.is_dir() else [path])
    unique_files = sorted(set(files))
    errors = [error for path in unique_files for error in validate_file(path)]
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print(f"Machine of Goals navigation valid: {len(unique_files)} Markdown files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
