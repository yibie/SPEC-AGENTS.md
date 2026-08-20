# Retire Phase and ROADMAP

status: verified
revision: 1
context_refs: `docs/spec-agents/WORKFLOW.md`, `AGENTS.md`, `STATUS.md`, `ROADMAP.md`

## Problem and goal

`Phase` carries two jobs at once. It is the boundary of a bounded piece of work
— entry condition, scope, acceptance gate — and it is the spine of a history
ledger. The second job wins over time: `ROADMAP.md` holds eleven phases across
481 lines, `STATUS.md` holds three closed phase sections despite its own
contract saying it records only the active phase, and `EVIDENCE.md` already
records every phase result independently. Three ledgers, one set of facts.

Underneath that, `taskNNN` in `STATUS.md` and `Slice` in
`.scratch/<feature>/issues/` are two execution-unit systems for the same thing,
and `AGENTS.md` binds `taskNNN` to the active phase.

Goal: retire `Phase` and `ROADMAP.md`, collapse the two execution units into
`Slice`, and let `STATUS.md` answer only what is being worked on now.

## Unchanged contracts

- The six action names, their order, and their read/write contracts.
- The layering `KERNEL.md → SPEC → Slice → EVIDENCE.md`.
- The Doctrine/Instance boundary and the installer payload from the framework
  namespace split.
- `EVIDENCE.md` stays append-only and remains the record of what happened.
- `.scratch/<feature>/` paths are unchanged this revision. Renaming that
  directory is a separate `plan`.

## Decision and boundaries

**No replacement concept is introduced.** The unit of bounded work already
exists and is already a Core Concept:

```text
KERNEL.md   what exists in the project        long-lived, plan-gated
SPEC        what this work changes, and where it stops   bounded, becomes history
Slice       an independently verifiable execution unit
EVIDENCE.md what happened                     append-only
```

`Phase` is removed from the Core Concepts, from the `State` definition, and
from the `KnowledgeItem --applies_to-->` relation, where `Scope` already covers
what `Phase` contributed.

`ROADMAP.md` is retired outright. Future intent is not recorded in the
repository; it is decided in conversation and fixed in a SPEC when it becomes
work. Recording direction ahead of work is what let the phase ledger drift from
what was actually being done.

`taskNNN` is retired. `Slice` is the only execution unit. A Slice already
carries goal, scope, dependency, acceptance, verification, status, and
`evidence_ref` — strictly more than a one-line task.

`STATUS.md` lists the active SPECs, their blockers, and the next permitted
action. A completed SPEC is removed from it; the SPEC file stays where it is,
and its result is in `EVIDENCE.md`. `STATUS.md` never accumulates history.

Multiple SPECs may be active at once. Two constraints follow, and they are
different in kind:

- **Scope**: parallel SPECs must have non-overlapping scope. This is a `plan`
  and `arrange` responsibility. Isolation does not solve overlapping scope; it
  defers the conflict and makes it more expensive.
- **Execution**: when two pieces of work must occupy a working copy at the same
  time — concurrent builds or test runs, two agents, writing code while a
  regression runs — they must be isolated with `jj workspace add` in a project
  with `.jj/`, or `git worktree add` otherwise. Switching between SPECs
  serially does not require isolation; in JJ, `jj new` and `jj edit` are safe
  without a stash because there is no staging area and the working copy is
  snapshotted automatically.

## Model delta

- Core Concept `Phase`: removed.
- `State`: records active SPECs, slices, blockers, and the next permitted
  action. "Current phase" is gone.
- Relation: `KnowledgeItem --applies_to--> Scope | Action`.
- New invariant: parallel SPECs must have non-overlapping scope.
- New invariant: simultaneous execution requires an isolated working copy.
- `learn` loses its "phase boundary" trigger. Its triggers become verification,
  a failed assumption, a blocker, and a new fact that changes later judgement.
- `arrange` loses the "only within the current phase" bound; its bound is the
  confirmed SPEC.
- Document authority drops `ROADMAP.md` and renumbers.

## Action Contracts

`STATUS.md`:

- precondition: at least one SPEC is active, or the file says so plainly.
- allowed effect: `learn` adds, updates, and removes active SPEC entries.
- invariant: no closed SPEC section, no phase, no task list, no history.
- verification: the file names only SPECs that exist under `.scratch/`.

Parallel work:

- precondition: two or more SPECs are active.
- invariant: their scopes do not overlap; if they do, return to `plan`.
- invariant: simultaneous execution runs in separate workspaces or worktrees.
- verification: `jj workspace list` or `git worktree list` shows one working
  copy per concurrently executing SPEC.

## Compatibility

`breaking`. A project on the previous model has `ROADMAP.md`, a phase-shaped
`STATUS.md`, and `taskNNN` entries.

- `docs/adr/0002-retire-phase.md` records the decision and rejected
  alternatives.
- `UPGRADE.md` gains a section for converting a phase-shaped project, which
  stops for user confirmation and deletes nothing automatically.
- This repository's own `ROADMAP.md` and the closed phase sections of
  `STATUS.md` move to `archive/`. History is preserved, not deleted.

## Verification

- No live file outside `archive/`, `research/`, `.phrase/`, and `.scratch/`
  defines or requires `Phase` as a current concept. Descriptions of legacy
  v2/v3 material in `UPGRADE.md` are history and stay.
- `ROADMAP.md` is absent from the repository root and present under `archive/`.
- `STATUS.md` contains no closed section and no `taskNNN`.
- `docs/spec-agents/parallel-work.md` has the required Protocol metadata:
  `status`, `scope`, `applies_when`, source Evidence, verification.
- The installer smoke Runbook still passes, including the leakage assertion.

## Out of scope

- Renaming `.scratch/`. That is a separate `plan`.
- Migrating any managed project.
- Changing the six action names, their order, or their contracts.
- Adding tooling that creates or manages workspaces automatically.

## Issue map

- `01-retire-phase-concept.md`: WORKFLOW.md concept, State, relation, invariants.
- `02-entry-documents.md`: AGENTS.md, AGENTS_en.md, START.md, README.md.
- `03-skill-contracts.md`: `plan`, `arrange`, `learn`.
- `04-state-and-archive.md`: rebuild `STATUS.md`, archive `ROADMAP.md` and the
  closed phase sections.
- `05-parallel-work-protocol.md`: the new doctrine Protocol.
- `06-adr-migration-evidence.md`: ADR 0002, `UPGRADE.md` section, CHANGELOG,
  Evidence.
