# Split durable work contracts from scratch

status: verified
revision: 1
context_refs: `.spec-agents/doctrine/docs/WORKFLOW.md`, `AGENTS.md`, `docs/adr/0002-retire-phase.md`

## Problem and goal

`.scratch/` holds three kinds of content with different lifetimes under one
name that describes only one of them.

- `<feature>/SPEC.md` and `<feature>/issues/` — durable work contracts. All 34
  files are git-tracked and committed, and `docs/adr/0002-retire-phase.md`
  states that a SPEC's contract stays in place after the work closes.
- `start/REPORT.md` — a one-shot report awaiting user confirmation.
- `upgrade-review/REPORT.md` — the same, for the upgrade path.

Only the last two are scratch. Calling the first "scratch" tells the next
context it may be deleted, when it is the record of every confirmed decision
the project has made.

Goal: give durable work contracts a name that matches their lifetime, and leave
`.scratch/` holding only what the word describes.

## Unchanged contracts

- `SPEC` and `Slice` concepts, their fields, and the six action contracts.
- The Doctrine/Instance boundary and the installer payload.
- `.scratch/start/REPORT.md` and `.scratch/upgrade-review/REPORT.md` keep their
  paths.
- The installer does not write either directory, and does not write a project's
  `.gitignore`.

## Decision and boundaries

Durable work contracts move to `.specs/<feature>/`:

```text
.specs/<feature>/SPEC.md
.specs/<feature>/issues/NN-<slug>.md
```

`.scratch/` keeps the one-shot reports and nothing else. Documentation
recommends that a project ignore `.scratch/` in version control, and the
framework never writes a project's `.gitignore` — recommending is doctrine,
writing would be the same boundary violation the namespace split fixed.

`<feature>` stays an informal directory label. `Feature` is deliberately not a
concept; `docs/adr/0002-retire-phase.md` records why.

### Rejected: `.spec-agents/`

`.spec-agents/` was chosen first, for symmetry with `docs/spec-agents/`. It was
withdrawn because the symmetry is misleading: the two would share a name
segment while having opposite ownership — `docs/spec-agents/` is written by the
installer and never by project work, `.spec-agents/` would be written by
project work and never by the installer. A rule phrased as "do not edit
spec-agents" reads as ambiguous even where the paths are distinct, which
weakens the Doctrine/Instance boundary established the same day.

`.specs/` is hidden, so it claims no visible project root name, and it names
what it holds without borrowing the framework's name.

## Model delta

- `SPEC`'s durable home is `.specs/<feature>/SPEC.md`.
- `Slice`'s durable home is `.specs/<feature>/issues/NN-<slug>.md`.
- New distinction in `WORKFLOW.md`: durable work contracts versus transient
  reports, with `.scratch/` defined as the second only.
- No new concept. This is a home change for two existing concepts.

## Action Contracts

`capture` / `arrange`:

- allowed effect: write under `.specs/<feature>/`.
- invariant: never write a project's `.gitignore`; never delete `.scratch/`.
- verification: the created path matches the documented shape.

`start` / upgrade review:

- allowed effect: write `.scratch/start/REPORT.md` or
  `.scratch/upgrade-review/REPORT.md`.
- invariant: a report is never treated as a confirmed contract.

## Compatibility

`breaking`. A project installed earlier has its SPECs and issues under
`.scratch/<feature>/`.

- `docs/adr/0003-split-work-and-scratch.md` records the decision.
- `UPGRADE.md` gains a section: recognise `.scratch/<feature>/SPEC.md`, propose
  the move, stop for user confirmation, delete nothing.
- This repository's ten directories move with `git mv` so history follows.

## Verification

- No live file outside `archive/`, `research/`, and `.phrase/` points a SPEC or
  a Slice at `.scratch/`.
- `.scratch/` in this repository contains no `SPEC.md` and no `issues/`.
- `git log --follow` resolves across the move for a sample SPEC.
- No document says "spec-agents" without `docs/` or the leading dot.
- Installer smoke still passes; neither directory is in the payload.

## Out of scope

- Migrating any managed project.
- Writing a project's `.gitignore`.
- Renaming `SPEC.md` or the `NN-<slug>.md` issue shape.
- Reopening whether `Feature` is a concept.

## Issue map

- `01-move-and-model.md`: move the ten directories; update `WORKFLOW.md`.
- `02-doctrine-references.md`: the 25 doctrine references and `README.md`.
- `03-adr-migration-evidence.md`: ADR 0003, `UPGRADE.md`, `CHANGELOG.md`,
  `EVIDENCE.md`, `.gitignore`.
