# ADR 0003: Separate durable work contracts from scratch

status: accepted
date: 2026-08-20
scope: where a confirmed SPEC and its slices live
applies_when: creating a SPEC or slice, or reading a project's confirmed work contracts
owner: project maintainer
source: E-20260820-003
verification: no live file points a SPEC or slice at `.scratch/`; `git log --follow` resolves across the move

## Context

`.scratch/` held three kinds of content with different lifetimes under a name
that described only one of them.

At the time of this decision it contained ten `<feature>/` directories with 34
git-tracked, committed files — every confirmed decision the project had made —
alongside the paths for `start/REPORT.md` and `upgrade-review/REPORT.md`, which
are one-shot reports awaiting user confirmation.

Only the reports are scratch. `docs/adr/0002-retire-phase.md`, decided the same
day, had just made the mismatch worse by stating that a SPEC's contract stays
in place after its work closes: the durable record of the project's decisions
was living in a directory whose name tells the next context it can be deleted.

## Decision

Durable work contracts move to `.specs/<feature>/`:

```text
.specs/<feature>/SPEC.md
.specs/<feature>/issues/NN-<slug>.md
```

`.scratch/` keeps only the one-shot reports. Documentation recommends that a
project ignore `.scratch/` in version control; the framework does not write a
project's `.gitignore`, because writing project files is the boundary that
`docs/adr/0001-framework-namespace-split.md` exists to hold.

`<feature>` stays an informal directory label. `Feature` is deliberately not a
concept.

## Alternatives rejected

- **Rename the whole directory without splitting it.** One name would have to
  fit both a durable contract and a disposable report. It cannot.
- **`.spec-agents/`, for symmetry with `docs/spec-agents/`.** Chosen first,
  then withdrawn. The symmetry is misleading: the two would share a name
  segment while having opposite ownership — `docs/spec-agents/` is written by
  the installer and never by project work, `.spec-agents/` the reverse. A rule
  phrased as "do not edit spec-agents" reads as ambiguous even where the paths
  are distinct, which weakens the Doctrine/Instance boundary established the
  same day.
- **`work/` or `specs/`, visible at the project root.** A generic visible name
  in the project root is exactly the collision that
  `docs/adr/0001-framework-namespace-split.md` was written to stop. `.specs/`
  is hidden and claims no visible name.
- **Nesting the reports under the new directory, e.g. `.specs/.reports/`.**
  One fewer root entry, but it re-mixes the two lifetimes that this decision
  separates.

## Consequences

Breaking for any project whose SPECs are under `.scratch/<feature>/`.
`UPGRADE.md` gains a section that recognises the old layout, proposes the move,
and stops for user confirmation. Nothing is deleted or moved automatically.

This repository's ten directories moved with `git mv`, so `git log --follow`
resolves across the rename.

`.specs/` is a hidden directory holding content that should be committed. That
is unusual and worth watching: if contributors overlook it because it is
hidden, the answer is better pointers from `AGENTS.md` and `README.md`, not a
visible root name.
