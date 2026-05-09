# LESSONS.md — SPEC-AGENTS Lessons

This file records durable lessons for SPEC-AGENTS itself. Keep entries short and
decision-relevant; do not use this as a session diary.

## lesson001 — Commands Are Installable Workflow Surfaces

**Observation**: Commands such as `/done` and `/start-phase` need to travel with
the installed protocol, not stay only in repository documentation.

**Decision**: Keep command instructions under `.phrase/commands/` and install
them into `.claude/commands/` when available.

**Verification**: `spec-agents init` installs command files into the target
project.

## lesson002 — Static Phase Bundles Became Too Heavy

**Observation**: The old `.phrase/phases/phase-*` bundle of `spec_*`, `plan_*`,
`task_*`, `change_*`, and `issue_*` improved traceability but increased token
load and made stale plans look authoritative.

**Decision**: SPEC-AGENTS vNext uses EDPP: `.phrase/decision.md`,
`.phrase/roadmap.md`, `.phrase/current.md`, `.phrase/evidence.md`, and
`.phrase/archive/`.

**Verification**: The installer now creates the vNext minimal context files, and
`/start-phase` updates roadmap/current/evidence instead of creating static
phase bundles.
