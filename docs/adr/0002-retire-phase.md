# ADR 0002: Retire Phase and ROADMAP

status: accepted
date: 2026-08-20
scope: the workflow's unit of bounded work and the documents that record it
applies_when: deciding where a piece of work is bounded, or where current state and future intent are recorded
owner: project maintainer
source: E-20260820-002
verification: reference scan for `Phase` over live files; `STATUS.md` contains no closed section or task list; installer smoke still passes

## Context

`Phase` carried two jobs at once. It was the boundary of a bounded piece of
work — entry condition, scope, acceptance gate — and it was the spine of a
history ledger. The second job won.

At the time of this decision, this repository held eleven phases across 481
lines of `ROADMAP.md`, three closed phase sections inside `STATUS.md` despite
that file's own contract saying it records only the active phase, and a
complete record of every phase result in `EVIDENCE.md`. Three ledgers, one set
of facts.

Underneath that sat two execution-unit systems for the same thing: 26 `taskNNN`
entries in `STATUS.md`, and `Slice` records under `.scratch/<feature>/issues/`.
`AGENTS.md` bound `taskNNN` to the active phase, so neither could be removed
without addressing `Phase` itself.

The same shape appeared in the field. A managed project's handoff note
explicitly refused to reintroduce "phase/task/change" as three parallel
indexes — which is what installing the framework had just done to it.

Recording future intent was the other half of the problem. `ROADMAP.md` fixed a
direction before the work existed, and the direction then drifted from what was
actually being done, because nothing forced the two to reconcile.

## Decision

Retire `Phase` as a concept and `ROADMAP.md` as a document. Introduce no
replacement concept.

The unit of bounded work already existed: `SPEC`. A SPEC records the confirmed
goal, unchanged baseline, scope, decisions, Action Contracts, and verification
entry, and it is already gated by `plan`. The layering becomes:

```text
KERNEL.md   what exists in the project      long-lived, plan-gated
SPEC        what this work changes, and where it stops
Slice       an independently verifiable execution unit
EVIDENCE.md what happened                   append-only
```

`Slice` becomes the only execution unit; `taskNNN` is retired. A Slice already
carries goal, scope, dependency, acceptance, verification, status, and
`evidence_ref` — strictly more than a one-line task.

`STATUS.md` lists only the active SPECs, their blockers, and the next permitted
action. A finished SPEC is removed from it. It never accumulates closed
sections.

The repository records no future intent. Direction is decided in conversation
and becomes durable only when it becomes a confirmed SPEC.

Several SPECs may be active at once, under two separate constraints: their
scopes must not intersect, which is a `plan` responsibility; and work that runs
at the same time gets its own working copy, which is a version-control
convenience. The second does not license the first. Recorded in
`docs/spec-agents/parallel-work.md`.

## Alternatives rejected

- **Keep `Phase`, forbid history accumulation by rule.** The previous contract
  already said `STATUS.md` records only the active phase, and it accumulated
  three closed sections anyway. A rule that was already being broken is not a
  fix.
- **Promote `Feature` to a Core Concept as the new unit.** This was the first
  proposal in the `plan` round and was withdrawn: it reads as a second ontology
  unit competing with `KERNEL.md`, when the distinction that matters is
  semantic model versus work boundary — and `SPEC` already occupies the second.
- **Keep `ROADMAP.md` for direction only, without phases.** Direction recorded
  ahead of work is what drifted. Removing the phase numbering would not have
  changed that.
- **Rename `ROADMAP.md` to a non-phased `DIRECTION.md`.** Same failure with a
  new filename, plus another root document to maintain.

## Consequences

Breaking for any project on the previous model. `UPGRADE.md` gains a conversion
section for a phase-shaped project: open tasks become Slices, `STATUS.md` is
rewritten, `ROADMAP.md` moves to `archive/`, and future-intent entries are
shown to the user rather than migrated. Nothing is deleted automatically.

This repository's own `ROADMAP.md` and the closed phase sections of `STATUS.md`
are preserved at `archive/roadmap-phases-10-20.md`.

`STATUS.md` becomes short and often nearly empty. That is the intended result:
an empty state pointer means no work is in flight, which is information, not a
gap to fill.

Renaming `.scratch/` was raised during this decision and deliberately deferred
to its own `plan`. The directory is git-tracked and holds nine features'
contracts, so the name is misleading, but changing it is an independent
semantic change.
