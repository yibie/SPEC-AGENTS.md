# Make a cited verification reproducible, and name the reflex that corrupts one

status: confirmed
revision: 1
context_refs: `EVIDENCE.md`, `docs/protocols/`, `docs/lessons/`, `skills/check/SKILL.md`, `skills/learn/SKILL.md`, `link_to_system.sh`

## Problem and goal

Two facts were established on 2026-08-27, each with a reproduction, and neither
has a home.

**A verification that cannot be re-run.** `/usr/local/bin/spec-agents` is a
symlink created by `link_to_system.sh` pointing at this repository's *working
copy*, not at any commit. The five workflow subcommands it exposes have never
been committed: `git log -S'check-state' -- bin/spec-agents` and
`git log -S'cmd_gate' -- bin/spec-agents` are both empty. The symlink predates
those subcommands by seven months, so they went live the moment they were saved
— no install step, no version, no commit.

The consequence is not that the tool is unversioned. It is that **any Evidence
record citing `spec-agents <cmd>` output has no reproducible referent**: there
is no commit to check out and re-run, because that code never entered history. A
`verification:` field naming only a command is already unverifiable at the
moment it is written. A managed project reported a run of nine violations,
then zero, then five during the same afternoon, all against this uncommitted
working copy.

**A reflex that damages the record.** Three incidents in one day shared a shape:
a gate went red because the rule behind it had a hole, and the most natural next
action was to edit the record being measured.

- A managed project's `learn` set a SPEC's status to `verified` to clear the
  gate; ruled out of bounds and reverted, and the gate correctly went red again.
- The same project added a `spec_section:` field so the checker would resolve
  `spec_ref`; ruled out of bounds and reverted.
- In this repository, an accepted ADR's Consequences paragraph was rewritten in
  place to remove a claim that had gone stale. The replacement cited a script
  first committed two days after that ADR's own `date:`. Reverted.

The rule that forbids this already exists — `skills/check/SKILL.md:126-131`
routes a `semantic` finding to `plan` and states that `check` does not
adjudicate, because deciding there bypasses the gate that ontology evolution
must pass through. But it is written only inside `check`, and **none of the
three incidents happened in `check`**: two were in `learn`, and one was in a
short-path `do` correction. The third was not inside any of the six actions at
all — it was the CLI inventing a terminal state while being written.

What made the third incident detectable is worth recording separately: the ADR
carried a `date:` field and `git log` is a second ledger, so two timestamps
produced by independent tools could be set against each other. A record that
attests only to itself cannot be contradicted that way.

Goal: promote both, each with a scope that matches where it actually applies.

## Unchanged contracts

- `learn` remains the only action that promotes knowledge, and promotion to
  `docs/protocols/` or `docs/lessons/` still requires `plan` confirmation —
  given for both records in the round that produced this SPEC.
- `check` stays read-only and continues not to adjudicate.
- Every promoted record carries `status | scope | applies_when | source | verification`.
- A scoped Lesson is not applied outside its `applies_when`.
- No existing record is edited in place.

## Decision and boundaries

### Protocol: a cited verification names what can be re-run

Evidence that cites the output of a tool which is not committed must record the
working-tree identity it was run against — the hash from `git stash create`, or
an equivalent that resolves later — alongside the command. A `verification:`
field naming only a command name does not satisfy this.

The Protocol also records the corollary that made today's backdating visible: a
durable record must carry a timestamp an independent tool can contradict. Its
own prose is not enough; the contradiction comes from a second ledger.

### Lesson: a red gate is a finding, not an invitation to edit

When a gate or check fails and the rule it enforces has a hole, the result is a
`semantic` finding routed to `plan` — whichever action is running, and whether
or not the person is building the gate rather than following the workflow.

`applies_when` is written as "a check **or gate** fails and the rule it enforces
has a hole". The second half of that phrase is load-bearing: one of the three
incidents was not inside any action, and a scope limited to running a check
would have excluded it.

This does not restate `check`'s rule in a second place. `check`'s statement
keeps its scope; the Lesson records that the same reflex fires everywhere and
names the three failures that demonstrated it.

## Model delta

None. No concept, identity, relation, lifecycle, or invariant changes. Two
records are added to existing knowledge classes.

## Action Contracts

No action's contract changes. `learn` performs both promotions under the `plan`
confirmation already given.

## Seams and verification

- Both records exist under `docs/protocols/` and `docs/lessons/` with the five
  required fields, and each `source:` names a resolvable Evidence ID.
- The Lesson's `applies_when` names gates as well as checks.
- The Protocol's `verification:` states how a reader confirms a cited run is
  reproducible, and does so without citing an uncommitted command itself.
- `tests/doctrine-check.sh` passes; every `ADR NNNN` pointer still resolves.
- The three incidents are recorded in `EVIDENCE.md` with enough detail that each
  reverted edit can be located in version control.

## Compatibility and migration

**Compatible.** Two additive records.

- Existing Evidence entries are not back-filled. The Protocol applies to records
  written after it; entries citing CLI output before it stay as they are, and
  the Protocol notes that they are not reproducible rather than rewriting them.
- No existing Lesson or Protocol is superseded or contradicted.

## Out of scope

- Giving the CLI a version identity, publishing it, or changing
  `link_to_system.sh`. The Protocol records what a citation must carry; it does
  not decide how the tool should be distributed.
- Shipping the CLI in the payload — `.specs/reference-existence/SPEC.md`.
- Any change to `skills/check/SKILL.md:126-131`. Its scope is correct for
  `check`; the Lesson covers the rest without editing it.
- Re-running or re-validating the managed project's reported figures.

## Issue map

This SPEC is small enough to close in a single `learn` pass and may not need
`arrange`. If it is sliced:

- `01-evidence-protocol.md`: the Protocol, with the timestamp corollary.
  `writer: learn`.
- `02-gate-reflex-lesson.md`: the Lesson and its `applies_when`. `writer: learn`.
- `03-incident-evidence.md`: the three incidents in `EVIDENCE.md`.
  `writer: learn`.

## Revision notes

- **r1** — created from the `plan` round of 2026-08-27. Routed `plan-only` with
  execution authorised. Captured rather than executed immediately so the two
  confirmed promotions survive to a later context; the round that confirmed them
  produced four Changes and only one became a SPEC at first, which is the loss
  mode `STATUS.md` already records.
