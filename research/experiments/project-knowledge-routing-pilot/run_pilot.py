#!/usr/bin/env python3
"""Bounded project-knowledge routing and runbook pilot."""

from __future__ import annotations

import re
import shutil
import subprocess
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
PROTOCOL = ROOT / "docs/protocols/shell-change-validation.md"
RUNBOOK = ROOT / "docs/runbooks/installer-smoke.md"
LESSON = ROOT / "docs/lessons/dom-native-api-shadowing.md"
DEFAULT_DOCS = [ROOT / name for name in ("AGENTS.md", "CONTEXT.md", "STATUS.md", "ROADMAP.md")]


def run(*args: str, cwd: Path | None = None, expect: int = 0) -> str:
    result = subprocess.run(args, cwd=cwd, text=True, capture_output=True)
    if result.returncode != expect:
        raise AssertionError(
            f"expected {expect} from {' '.join(args)}, got {result.returncode}\n"
            f"stdout={result.stdout}\nstderr={result.stderr}"
        )
    return result.stdout + result.stderr


def metadata(path: Path) -> dict[str, str]:
    fields: dict[str, str] = {}
    for line in path.read_text().splitlines():
        match = re.match(r"^([a-z_]+):\s*(.+)$", line)
        if match:
            fields[match.group(1)] = match.group(2)
    return fields


def bytes_for(paths: list[Path]) -> int:
    return sum(path.stat().st_size for path in paths)


def assert_knowledge_records() -> None:
    required = {"status", "scope", "applies_when", "source", "verification"}
    for path in (PROTOCOL, RUNBOOK, LESSON):
        fields = metadata(path)
        missing = required - fields.keys()
        assert not missing, f"{path} missing metadata: {sorted(missing)}"
        assert re.search(r"E-\d{8}-\d{3}", fields["source"]), path

    protocol = metadata(PROTOCOL)
    runbook = metadata(RUNBOOK)
    lesson = metadata(LESSON)
    assert ".sh" in protocol["applies_when"]
    assert "installer" in runbook["applies_when"]
    assert "browser" in lesson["scope"]
    assert "form" in lesson["applies_when"]


def temp_shell_change(root: Path) -> Path:
    repo = root / "shell-change"
    (repo / "bin").mkdir(parents=True)
    shutil.copy(ROOT / "bin/spec-agents", repo / "bin/spec-agents")
    run("git", "init", "-q", str(repo))
    run("git", "-C", str(repo), "add", "bin/spec-agents")
    run(
        "git",
        "-C",
        str(repo),
        "-c",
        "user.name=SPEC-AGENTS pilot",
        "-c",
        "user.email=pilot@example.invalid",
        "commit",
        "-qm",
        "baseline",
    )
    path = repo / "bin/spec-agents"
    path.write_text(path.read_text() + "\n# pilot: harmless comment-only change\n")
    return repo


def run_installer_smoke() -> None:
    with tempfile.TemporaryDirectory(prefix="spec-agents-installer-smoke-") as directory:
        target_root = Path(directory)
        target = target_root / "project"
        for _ in range(2):
            run(str(ROOT / "bin/spec-agents"), "install", str(target), "en")

        expected = (
            "AGENTS.md",
            "CONTEXT.md",
            "ROADMAP.md",
            "STATUS.md",
            "EVIDENCE.md",
            "UPGRADE.md",
            "docs/protocols/knowledge-promotion.md",
            "docs/runbooks/README.md",
            "docs/lessons/README.md",
            "skills/plan/SKILL.md",
            "skills/capture/SKILL.md",
            "skills/arrange/SKILL.md",
            "skills/do/SKILL.md",
            "skills/check/SKILL.md",
            "skills/learn/SKILL.md",
        )
        for relative in expected:
            assert (target / relative).is_file(), relative
        assert not (target / "research").exists()
        run(str(ROOT / "bin/spec-agents"), "install", str(ROOT), "en", expect=1)


def main() -> None:
    assert_knowledge_records()
    default_bytes = bytes_for(DEFAULT_DOCS)
    routed_bytes = bytes_for(DEFAULT_DOCS + [PROTOCOL, RUNBOOK])
    unrelated_bytes = bytes_for(DEFAULT_DOCS + [LESSON])

    with tempfile.TemporaryDirectory(prefix="spec-agents-knowledge-pilot-") as directory:
        control_repo = temp_shell_change(Path(directory) / "control")
        treatment_repo = temp_shell_change(Path(directory) / "treatment")

        # Control: default context, minimal syntax proof.
        run("bash", "-n", str(control_repo / "bin/spec-agents"))

        # Treatment: the selected Protocol adds whitespace and installer checks.
        run("bash", "-n", str(treatment_repo / "bin/spec-agents"))
        run("git", "diff", "--check", cwd=treatment_repo)
        run_installer_smoke()

    print("# Project Knowledge Routing Pilot")
    print("metadata: pass")
    print("control: bash -n pass")
    print("treatment: bash -n + git diff --check + installer smoke x2 + source refusal pass")
    print("routing: shell -> Protocol + Runbook; browser form -> DOM Lesson only")
    print(f"default_context_bytes: {default_bytes}")
    print(f"routed_context_bytes: {routed_bytes}")
    print(f"routed_context_overhead_bytes: {routed_bytes - default_bytes}")
    print(f"unrelated_lesson_context_bytes: {unrelated_bytes - default_bytes}")
    print("fixtures: temporary-only; repository files unchanged by runner")


if __name__ == "__main__":
    main()
