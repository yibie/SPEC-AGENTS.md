# ADR 0001: Separate framework doctrine from repository instance state

status: accepted
date: 2026-08-20
scope: `bin/spec-agents` installation payload and the root document layout
applies_when: changing what the installer emits, or where framework semantics live
owner: project maintainer
source: E-20260820-001
verification: the installer smoke Runbook, including the leakage and `--link` assertions

## Context

`bin/spec-agents` installed six root documents by copying this repository's own
files, and installed `docs/` by enumerating its directory contents. Four of
those files are this repository's live working state: `STATUS.md` named
Phase 19, `task031`, and `bin/spec-agents`; `ROADMAP.md` carried 481 lines of
this repository's phase history; `EVIDENCE.md` carried 650 lines of this
repository's experiments; directory enumeration additionally shipped
`docs/runbooks/installer-smoke.md`, a procedure for a `bin/` the target does not
have, and `docs/lessons/dom-native-api-shadowing.md`, whose Evidence ID and
`research/` references were not installed alongside it.

In a managed project these are false state pointers. An agent reading the
installed `STATUS.md` believes the project's active phase is this repository's
active phase.

A field report from a managed project surfaced a second failure. Root
`CONTEXT.md` was claimed three ways at once: by the project's own business
glossary, by another skill collection's convention, and by this framework's
workflow model. The framework had taken a name that projects already use.

`--link` made the first problem worse in a way that had not yet fired: a linked
`STATUS.md` in a managed project points at this repository's `STATUS.md`, so the
managed project's first status write would corrupt the framework source.

## Decision

Split the repository into Doctrine and Instance.

Doctrine is identical in every managed project and is the only thing the
installer emits: `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, and
`docs/spec-agents/`. The framework's workflow semantic model moves from root
`CONTEXT.md` to `docs/spec-agents/WORKFLOW.md`, and the four framework
protocol/runbook records move from `docs/protocols/` and `docs/runbooks/` into
`docs/spec-agents/`, so that in a managed project those directories belong
entirely to the project.

Instance is this repository's own state and is never installed: `STATUS.md`,
`ROADMAP.md`, `EVIDENCE.md`, `archive/`, `research/`, `bin/`, `tests/`,
`docs/adr/`, `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/`.

Root `CONTEXT.md` becomes the managed project's own context and vocabulary
document. The installer emits an empty skeleton from `templates/` and never
writes it again.

`STATUS.md`, `ROADMAP.md`, and `EVIDENCE.md` are not installed at all. `learn`
creates them on the first real write.

The installer writes `docs/` through an explicit allowlist. Directory
enumeration is what leaked instance material, and it will leak again the moment
a new file is added to a scanned directory.

Files sourced from `templates/` are always copied, never symlinked, including
under `--link`.

## Alternatives rejected

- **Keep the current file set and ship empty templates for the four state
  documents.** This fixes the false pointers but leaves a new project carrying
  ten framework-owned files on day one, and leaves root `CONTEXT.md` contested.
- **Backward-compatible fallback: read `docs/spec-agents/WORKFLOW.md` when it
  exists, otherwise fall back to root `CONTEXT.md`.** This is exactly the
  "compatibility runtime mode" that the Legacy Upgrade Boundary rejects. Two
  read paths would coexist indefinitely and neither would be authoritative.
- **Merge the workflow model into `AGENTS.md`.** One fewer name in the project
  root, but the default context grows from 211 to over 400 lines for every task.

## Consequences

Breaking for any project installed before this change. Such a project has the
workflow model at root `CONTEXT.md` and this repository's `STATUS.md`,
`ROADMAP.md`, and `EVIDENCE.md` at its root. `UPGRADE.md` gains a section that
lets an agent recognise the pre-split layout and hand the decision to the user.
Nothing is deleted automatically, and no root document is classified as
framework material on the basis of its name alone.
