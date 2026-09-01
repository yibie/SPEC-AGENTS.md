# Framework Namespace Split

status: verified
revision: 1
context_refs: `CONTEXT.md`, `AGENTS.md`, `ROADMAP.md`, `.spec-agents/state/STATUS.md`, `.spec-agents/doctrine/bin/spec-agents`

## Problem and goal

`bin/spec-agents` installs this repository's own live working state into every
managed project. A temporary-directory install reproduces it: the target
receives `STATUS.md` (Phase 19, `task031`, `bin/spec-agents`), `ROADMAP.md`
(481 lines of this repository's phase history), `EVIDENCE.md` (650 lines of this
repository's experiments), `docs/runbooks/installer-smoke.md` (a procedure for
`bin/spec-agents`, which the target does not have), and
`docs/lessons/dom-native-api-shadowing.md` (whose `E-20260817-004` and
`research/experiments/...` references are not installed).

In a real project these are false state pointers. A field report from a managed
project also shows the root name `CONTEXT.md` contested three ways: the
project's own business glossary, a second skill collection's convention, and
this framework's workflow model.

Goal: give framework doctrine its own namespace, stop shipping this
repository's instance state, and leave every project-owned name to the project.

## Unchanged contracts

- The installer never deletes a file in the target.
- Installing into the source repository is still refused.
- `--link` remains supported for doctrine files.
- The six action names, their contracts, and the `plan → capture → arrange →
  do → check → learn` order are unchanged.
- `KERNEL.md` is still absent from a fresh install and created by the first
  `START.md` scan.

## Decision and boundaries

Split the repository into two kinds of material and let the installer carry
only the first.

**Doctrine** — true for every managed project, installed:

```text
AGENTS.md  START.md  UPGRADE.md  skills/
docs/spec-agents/WORKFLOW.md              (was root CONTEXT.md)
docs/spec-agents/evidence-links.md        (was docs/protocols/)
docs/spec-agents/knowledge-promotion.md   (was docs/protocols/)
docs/spec-agents/jj-change-management.md  (was docs/protocols/)
docs/spec-agents/jj-project-setup.md      (was docs/runbooks/)
CONTEXT.md                                (from templates/CONTEXT.md, empty skeleton)
```

**Instance** — this repository's own state, never installed:

```text
STATUS.md  ROADMAP.md  EVIDENCE.md  archive/  research/  tests/  bin/
docs/adr/  docs/protocols/  docs/runbooks/  docs/lessons/
```

The four framework records move out of `docs/protocols/` and `docs/runbooks/`
so that in a managed project those directories belong entirely to the project.
`docs/spec-agents/` is the only path the installer writes under `docs/`.

Root `CONTEXT.md` becomes the managed project's own context and vocabulary
document. The installer emits an empty skeleton from `templates/`, never this
repository's copy.

`STATUS.md`, `ROADMAP.md`, and `EVIDENCE.md` are not installed at all. They are
per-project state; `learn` creates them on first write.

## Model delta

- `Workflow Model` moves from root `CONTEXT.md` to
  `docs/spec-agents/WORKFLOW.md`. Its content is unchanged.
- Root `CONTEXT.md` changes identity: framework workflow model → managed
  project's own context document. This is a rename of the concept's home, not a
  redefinition of the workflow model.
- New boundary concept: `Doctrine` vs `Instance`. Doctrine is installable and
  identical across projects; Instance is this repository's own state and is
  never installed.
- Document authority order in `AGENTS.md` replaces `CONTEXT.md` with
  `docs/spec-agents/WORKFLOW.md` at the workflow-semantics position, and keeps
  `CONTEXT.md` as project material below `KERNEL.md`.

## Action Contracts

`install` / `init`:

- precondition: target is not the source repository; target directory exists or
  can be created.
- allowed effect: create the doctrine files listed above plus a
  `templates/CONTEXT.md` skeleton; never overwrite an existing target file.
- invariant: no file whose content names this repository's phases, tasks,
  `bin/`, `research/`, or Evidence IDs reaches the target.
- invariant: `templates/`-sourced files are always copied, never symlinked,
  including under `--link`; a link would let the target write back into the
  source repository.
- verification: the installer smoke Runbook, extended with a leakage assertion.

## Compatibility

`breaking`. A project installed before this change has root `CONTEXT.md`
holding the workflow model and this repository's `STATUS.md`/`ROADMAP.md`/
`EVIDENCE.md` at its root.

Migration is user-confirmed, not automatic:

- `docs/adr/0001-framework-namespace-split.md` records the decision and the
  rejected alternatives.
- `UPGRADE.md` gains a section that tells the Agent how to recognise the old
  layout, which files are safe to remove, and which must be handed to the user.
- The installer deletes nothing during migration.

## Verification

- `bash -n bin/spec-agents`.
- Installer smoke Runbook: two copy installs, one `--link` install, source
  refusal.
- Leakage assertion: no installed file matches this repository's instance
  markers (`bin/spec-agents`, `Phase [0-9]`, `task[0-9]`, `research/`,
  `E-2026`).
- `--link` assertion: `CONTEXT.md` in the target is a regular file, not a
  symlink.
- Reference assertion: no live file outside `archive/`, `research/`, and
  `.scratch/` still points at root `CONTEXT.md` for workflow semantics.

## Out of scope

- Migrating or deleting anything in an already-installed target.
- Changing the six action names, their order, or their read/write contracts.
- Changing the workflow model's content while moving it.
- Formal ontology tooling, graph storage, or a seventh action.
- Touching the managed project that produced the field report.

## Issue map

- `01-doctrine-namespace.md`: create `docs/spec-agents/`, move the five
  doctrine records, add `templates/CONTEXT.md`.
- `02-installer-payload.md`: rewrite the installer payload and link rules.
- `03-reference-update.md`: update every live reference and the English
  documents.
- `04-adr-and-migration.md`: write ADR 0001 and the `UPGRADE.md` section.
- `05-smoke-and-evidence.md`: extend the smoke Runbook and record Evidence.
