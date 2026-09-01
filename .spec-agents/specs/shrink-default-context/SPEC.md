# Shrink the default context

status: verified
revision: 1
context_refs: `AGENTS.md`, `.spec-agents/doctrine/docs/WORKFLOW.md`, `docs/adr/0001`–`0005`

## Problem and goal

In two days the mandatory read grew from 299 lines to 586 — `AGENTS.md` from
175 to 290, and the workflow model from 124 to 296. Every increment closed a
defect with evidence behind it, and every one was applied the same way: by
adding prose to the file every task must read.

An external methodology (`mattpocock/skills`) argues that heavy specification
makes a strong model perform worse, not better — that a prior framework stopped
working "because the model got stronger, and the old rules were so verbose they
constrained it". Its own structure supports the claim differently than it
states it: that repository has 24 skills, likely more total text than this one,
but **none of them is mandatory reading**. One router skill dispatches, the rest
load on demand.

So the lever is layering, not brevity. Measured against that, two problems:

**Redundancy.** `AGENTS.md`'s `## Six actions` section is 111 lines — 38% of
the file — restating what the six `SKILL.md` files contain. Those files are read
in full when the action runs. Every task pays for a summary of documents it will
otherwise read completely.

**Rationale in the wrong file.** Rules written over the past two days carry
their reasoning inline, because rules without reasons were observed to be broken
silently five times in this repository. The reasoning is correct and it belongs
somewhere — but a strong model does not need to be told why installed doctrine
must not be edited; it needs the rule once. `docs/adr/` already exists for
reasoning, `EVIDENCE.md` already holds the evidence, and `AGENTS.md` already
instructs the agent to read an ADR when the intent points at one. The machinery
is in place; the text is in the wrong place.

Goal: cut the mandatory read to 400 lines or fewer without removing a single
rule.

## Unchanged contracts

- Every rule survives. This is a relocation, not a repeal.
- The six action names, their order, the three routes, and the two execution
  paths.
- The Doctrine/Instance boundary, the write boundaries, the three `check` axes
  and four finding types, the ontology-impact question, the Kernel's eight
  sections and per-entry provenance.
- `docs/spec-agents/WORKFLOW.md` is not split. It stays one file and stays in
  the default read.
- The installed payload and the installer allowlist.

## Decision and boundaries

### Target

`AGENTS.md` + `docs/spec-agents/WORKFLOW.md` ≤ 400 lines, from 586.

The target is a hard number because the growth that motivated this SPEC was
gradual and invisible — no single addition looked unreasonable. A number is
checkable; "keep it lean" is not.

400 rather than 300: the workflow model stays whole, which alone is roughly 250
lines after its own rationale sinks. Reaching 300 would require splitting it,
which was considered and declined — a semantic model that lives in two files
invites the two halves to drift.

### Redundancy: `## Six actions` becomes a router

The section keeps the pipeline, the three routes with the `approve` two-part
test, and a one-line-per-action statement of when to reach for it. Everything
else — each action's read list, write boundary, and completion condition —
already lives in `skills/<action>/SKILL.md` and is deleted here.

The test for what stays: an agent that has not yet decided which action to use
must be able to decide from `AGENTS.md` alone. Anything only needed *after* that
decision belongs in the skill.

### Rationale sinks into existing ADRs

Reasoning moves to the ADR that already records the decision. The rule keeps a
pointer: `（理由见 ADR 0004）`.

A rule whose reasoning has no ADR is a signal, not an exception. Either the
decision deserved an ADR and did not get one, or the reasoning was
justification written at the keyboard. In the first case write the ADR; in the
second delete the reasoning. Do not create a rationale file — a file whose only
job is to hold reasons detached from decisions becomes the next accumulation
site, which is the failure this SPEC is correcting.

### What does not move

Reasoning stays inline where the rule is counter-intuitive enough that an agent
would plausibly do the opposite. Two known cases: a recorded "no" is required on
the ontology-impact question, and `templates/`-sourced files are copied even
under `--link`. Both were violated in practice, by this session's own author,
while the rule was in front of them.

## Model delta

None. No concept, relation, lifecycle, invariant, or Action Contract changes
meaning. This SPEC moves text and deletes duplication.

## Action Contracts

Unchanged. If any Action Contract reads differently after this change, that is a
defect in the compression, not an intended effect.

## Compatibility

`compatible`. No rule is removed, no contract changes, no file is renamed, and
the installed payload's file list is identical. A managed project sees shorter
doctrine saying the same things.

## Verification

- `wc -l AGENTS.md docs/spec-agents/WORKFLOW.md` totals ≤ 400.
- Every rule present before is present after: a rule-by-rule diff, not a
  reading.
- Every relocated rationale is retrievable — each pointer resolves to an ADR
  that contains the reasoning.
- `AGENTS_en.md` matches `AGENTS.md` in content and structure.
- The real-task comparison: the 12-smell addition to `check`'s engineering axis
  was executed under the 586-line doctrine via the `approve` short path, with
  its routing and output recorded. After compression, the same task is
  re-derived from the compressed documents alone. Any decision that comes out
  differently means the compression cut something load-bearing.
- Installer smoke passes; the three `check` axes and the ontology-impact
  question run on this change.

## Out of scope

- Removing or weakening any rule.
- Splitting `docs/spec-agents/WORKFLOW.md`.
- Compressing the six `SKILL.md` files — they are not mandatory reading, so
  their length costs nothing per task.
- Borrowing `implement`'s continuation loop, `to-tickets`' external tracker, or
  the parallel sub-agent architecture. Each is a separate `plan`.
- Changing `README.md`, which is for humans and not read by default.

## Issue map

- `01-router.md`: `## Six actions` becomes a router in both languages.
- `02-agents-rationale.md`: sink `AGENTS.md`'s remaining rationale.
- `03-workflow-rationale.md`: sink `WORKFLOW.md`'s rationale from Invariants
  and Core Concepts.
- `04-verify-and-compare.md`: rule-by-rule diff, pointer resolution, and the
  real-task comparison.
- `05-learn-record.md`: Evidence and `STATUS.md`. `writer: learn`.
