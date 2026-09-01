# Make doctrine stop naming things that are not there

status: confirmed
revision: 1
context_refs: `AGENTS.md`, `.spec-agents/doctrine/skills/`, `templates/CONTEXT.md`, `.phrase/README.md`, `.spec-agents/doctrine/bin/spec-agents`, `docs/runbooks/installer-smoke.md`, `tests/doctrine-check.sh`, `docs/adr/0001`, `docs/adr/0007`

## Problem and goal

Four separate symptoms share one root: a document names a file, and the file is
not there.

**`CONTEXT.md`, twenty-two times.** Ten doctrine files reference it, including
the read list of every one of the six `SKILL.md` files. This repository has no
root `CONTEXT.md`, and that is deliberate: ADR 0001 moved the framework's
workflow model out of it into `docs/spec-agents/WORKFLOW.md` and gave the name
back to projects, after a field report in which root `CONTEXT.md` was claimed
three ways at once — the project's own glossary, another skill collection's
convention, and this framework's model. `AGENTS.md` already guards its own
reference with "when it exists". The six read lists do not, although they guard
`KERNEL.md` with 「若存在」 in the same sentence. The conditional-read pattern
exists; `CONTEXT.md` was left outside it.

**A first instruction that cannot run.** `AGENTS.md` directs the reader to five
`spec-agents` subcommands, and `AGENTS.md` is installed doctrine. `bin/` is
Instance and never installed (ADR 0001). A fresh install contains exactly one
executable, `docs/spec-agents/check-kernel.sh`. On any machine without a clone
of this repository, the first operational instruction in the installed doctrine
is `command not found`. The failure is invisible here because
`/usr/local/bin/spec-agents` is a symlink into this working copy, created seven
months before the subcommands existed.

**A template section that lost its job.** `templates/CONTEXT.md` has a
「权威边界」 section. ADR 0006 made the Kernel's `Architecture boundaries` the
authority map. Both files were introduced in the same commit; the collision was
created four days later by ADR 0006 and never reconciled.

**A legacy signpost written in the present tense.** `.phrase/README.md` is not
archived content — it was added by the v4.0.0 release as the framework's own
label for that directory, and its two main clauses are imperative: "Use the root
documents instead" and "New durable knowledge belongs in the root layout". An
imperative has no index to a past moment, so it cannot be read as history. Its
list omits `KERNEL.md`, `.specs/`, `docs/runbooks/` and `docs/lessons/`, and
names `CONTEXT.md`, which does not exist here. Unlike
`archive/roadmap-phases-10-20.md`, it carries no `status:`, `retired_on:`,
`reason:` or `source:` — nothing in the file states which class it belongs to.

**No check covers the class.** `tests/doctrine-check.sh`'s three assertions are
all reference-to-target in one direction — ADR pointers and CHANGELOG headings.
None asks whether a file a document names actually exists.

Goal: guard or fix every one of these references, ship the tool the doctrine
tells people to run, and add the missing check so the class cannot return
silently.

## Unchanged contracts

- The Doctrine/Instance split. `bin/` stays Instance and is still not installed.
- No root `CONTEXT.md` is created in this repository. ADR 0001 decided that and
  it has held.
- `CONTEXT.md` remains the managed project's own document, never written by the
  framework after the skeleton.
- The CLI does not print skill prose (ADR 0007).
- The installer writes `docs/` through an explicit allowlist, never by directory
  enumeration.
- The Kernel's `Architecture boundaries` remains the single authority map.

## Decision and boundaries

### The read lists guard `CONTEXT.md`

The six `SKILL.md` read lists reference `CONTEXT.md` conditionally, matching how
they already reference `KERNEL.md` and how `AGENTS.md` already reads. No file is
created.

### The CLI ships from `docs/spec-agents/`

`spec-agents` is installed beside `check-kernel.sh`, not from `bin/`. `bin/`
stays Instance, so ADR 0001's classification is untouched, and the payload
becomes Markdown plus two shell scripts — which is what ADR 0007 already
describes.

`docs/runbooks/installer-smoke.md` is updated for the new installed set. Its
"exactly this doctrine, and nothing else" list is also completed: it currently
omits `skills/*/agents/openai.yaml`, which the installer does emit. Correcting a
list while knowingly leaving a second omission in it would reproduce the defect
this SPEC exists to remove.

### The `CONTEXT.md` template drops its authority section

「权威边界」 is removed and replaced by a pointer to the Kernel's
`Architecture boundaries`. The remaining three sections stay.

### `.phrase/README.md` declares its own class

It gains an `archive/`-style header — `status:`, `retired_on:`, `source:` — so
that which class it belongs to is answered by the file rather than by each
reader's judgement of its tone. Its list of current root documents is completed.

### `doctrine-check.sh` gains a fourth assertion

A document that names a root file as part of the current layout must name a file
that exists. The assertion must not fire on doctrine's `CONTEXT.md` references,
which are correct for managed projects and guarded here; the exact scoping rule
is a slice-level decision, and the constraint on it is that it distinguishes a
current-layout pointer from a conditional read.

## Model delta

No concept, identity, relation, lifecycle, or invariant changes. The payload
gains one file and the checker gains one assertion.

| | before | after |
| --- | --- | --- |
| installed payload | Markdown + 1 shell script | Markdown + 2 shell scripts |
| `CONTEXT.md` in read lists | 22 bare references | conditional, matching `KERNEL.md` |
| `templates/CONTEXT.md` | four sections, one colliding with ADR 0006 | three, pointing at the Kernel |
| `.phrase/README.md` | no class fields, incomplete list | self-declaring header, complete list |
| `doctrine-check.sh` | three assertions | four |

## Action Contracts

No action's contract changes. This SPEC edits doctrine text, one template, one
Instance signpost, the installer's allowlist, one Runbook, and one test.

## Seams and verification

- A fresh install contains `docs/spec-agents/spec-agents`, executable, and
  `--help` runs from inside the target directory.
- The installer smoke passes with the updated installed set and absent set;
  `bin/` is still absent from a fresh target.
- No installed file names this repository's Instance state (the existing leakage
  assertion still passes).
- All six `SKILL.md` files reference `CONTEXT.md` conditionally; no bare
  reference remains in a read list.
- `templates/CONTEXT.md` has no 「权威边界」 section and points at the Kernel.
- `.phrase/README.md` carries `status:`, `retired_on:` and `source:`, and its
  list resolves entry by entry against the repository root.
- `tests/doctrine-check.sh` has a fourth assertion; it fails on a fixture
  naming a missing root file, and passes on this repository.

## Compatibility and migration

**Compatible.** Everything is additive or a correction of a reference.

- Managed projects re-installing receive one new file. Nothing is removed from
  the payload.
- A project that already deleted or redirected its `CONTEXT.md` skeleton — which
  `AGENTS.md` explicitly permits — is unaffected, and is the case the guards
  make correct.
- A project whose `CONTEXT.md` still has a 「权威边界」 section keeps it; the
  template change affects new installs only, and no back-fill is required.
- The symlink at `/usr/local/bin/spec-agents` is a local development
  convenience, not part of the payload, and is out of scope here.

## Out of scope

- The CLI's lack of version identity, and what an Evidence record citing its
  output must record to stay reproducible — `.specs/evidence-reproducibility/SPEC.md`.
- Retiring `CONTEXT.md` altogether, or folding its vocabulary section into the
  Kernel. Raised in the same `plan` round and not chosen.
- Removing `link_to_system.sh`, or documenting it in doctrine.
- The `spec_ref` field's four degrees of freedom.
- Any change to `.phrase/`'s contents. Only its README, which is a current-voice
  label rather than archived material, is touched.

## Issue map

- `01-context-guards.md`: conditional `CONTEXT.md` in all six read lists.
- `02-ship-cli.md`: install `spec-agents` from `docs/spec-agents/`; update the
  installer allowlist.
- `03-installer-smoke.md`: updated installed and absent sets, plus the
  `skills/*/agents/openai.yaml` omission. `writer: do`.
- `04-context-template.md`: drop 「权威边界」, point at the Kernel.
- `05-phrase-readme.md`: class header and completed list.
- `06-doctrine-check-existence.md`: the fourth assertion and its fixture.
- `07-learn-record.md`: Evidence, `STATUS.md`, `CHANGELOG.md`. `writer: learn`.

## Revision notes

- **r1** — created from the `plan` round of 2026-08-27. Routed
  `compatible revise`. That round settled: no upstream `CONTEXT.md`; guards
  rather than a new file; the CLI ships from `docs/spec-agents/` so that ADR
  0001 is not disturbed; and the template loses only its authority section.
