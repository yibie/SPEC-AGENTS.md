# ADR 0008: Give SPEC a lifecycle, and let `learn` close both levels

status: accepted
date: 2026-08-29
scope: what a finished SPEC is, and which action writes the terminal state of a SPEC and of a Slice
applies_when: closing a slice after `check`, closing a SPEC, or reading a `verified` status
owner: project maintainer
source: E-20260828-012, E-20260829-013, E-20260829-014, E-20260829-015
verification: `grep -rn "verified" skills/*/SKILL.md` and `grep -rn "done" skills/*/SKILL.md` each return a hit naming the writer; both CLI refusals cite a document that resolves; `check-state` clean on this repository

## Context

`docs/spec-agents/WORKFLOW.md` gave a lifecycle to four entities — `work`,
`start`, `kernel`, `knowledge` — and none to `SPEC`. The Stable Relations block
said the same thing a second way: SPEC had an in-edge and an out-edge and no
terminal transition. Nothing in the model said what a finished SPEC is.

`bin/spec-agents` nevertheless refused when every slice of a SPEC was `done`
and its status was not `verified`. `verified` appeared in no skill;
`skills/capture/SKILL.md`'s status set did not contain it. Its only source was
the `knowledge:` lifecycle line. Sixteen SPECs carried the value anyway, so
`check-state` was green because an undocumented convention had been applied
consistently. The CLI had supplied a terminal state on its own, without `plan`.

The same defect sat one level down. `transition ... done` required
`evidence_ref`; `skills/do/SKILL.md` told `do` to keep `evidence_ref` empty;
`skills/learn/SKILL.md` let `learn` write `evidence_ref` and said nothing about
slice status. No contract named the action that ends a slice. Seventy-five
closed slices had all been set by hand — the practice ADR 0007 built the CLI
to end.

Three incidents on 2026-08-27 shared one shape and made the gap visible: a gate
went red because the rule behind it had a hole, and the next action taken was
to edit the record being measured. Each was reverted. They are recorded in
E-20260828-012 and E-20260829-013.

## Decision

`WORKFLOW.md`'s Lifecycle block gains a fifth line:

```text
spec: draft → confirmed → in-progress → revised → verified → superseded
```

`verified` is the terminal state of completed work. `superseded` keeps its
meaning — replaced by another SPEC — and is a different exit, not a synonym.

**`learn` writes terminal state at both levels**, and it is the only action
that does:

- a Slice — `evidence_ref` and `status: done` together, after `check` has
  verified it. `do` leaves a finished slice at `doing` with its verification
  summary.
- a SPEC — `status: verified`, when every slice is `done`, the Evidence record
  is appended, and the SPEC is removed from `STATUS.md` in the same act.

Any precondition unmet: stop, write nothing, report which one. `learn` writes
no other field of a SPEC or a slice. `capture` keeps ownership of the SPEC
document; `arrange` keeps creating slices.

The CLI's two assertions are unchanged; their refusal text now cites the
Lifecycle line and `skills/learn/SKILL.md` instead of a rule that did not
exist.

## Why this shape

**`verified` was kept, not renamed.** Sixteen SPECs already carried it, so the
vocabulary change costs no migration, and reusing a state name across entities
was already established: `superseded` appears on both the `kernel:` and
`knowledge:` lines.

**`learn`, not `capture`, writes the terminal states.** `capture` is the entry
action. Its preconditions are a confirmed `plan` outcome plus multi-context
work, and neither holds at close. Making one action both the entry and the exit
is a wider change than naming a writer.

**One decision, two levels.** The slice-level gap surfaced while executing the
first slice of the repair. It is the same defect one step down — the tool
requires a field-and-status pair that no contract authorised anyone to write —
so it was folded into the same decision rather than given a second one.

## Alternatives rejected

- **Remove the CLI's assertions.** Restores consistency by deleting the only
  check that noticed the drift.
- **Relax `done` so it no longer requires `evidence_ref`.** Reintroduces
  "finished, but no one can say on what evidence", which the pair exists to
  prevent.
- **Give `capture` a second trigger at close.** See above; one action at both
  ends.
- **Reading "every slice `done`" as vacuously true for a SPEC with no
  slices.** Cannot distinguish a finished SPEC from an unstarted one;
  `authority-order` is `confirmed` with zero slices and nothing done, and the
  reading accepts it.
- **A bootstrap clause exempting this SPEC from the rule it establishes.** The
  apparent deadlock — slice 01 needed `learn` to close it, the close was
  granted by slice 02, and 02 was `blocked_by: 01` — was a modelling error in
  the dependency, not a case for an exception. None of 02's acceptance
  criteria required 01's output; `arrange` removed the edge.

## Consequences

Breaking for anyone reading `done` as "`do` finished": a slice `do` completes
now rests at `doing` until `learn` closes it. Nothing that was `done` becomes
not-`done`, and the seventy-five hand-closed slices are not revisited.

Three SPECs that were `confirmed` with zero slices — `jsonl-evidence-pilot`,
`ontology-graph-pilot`, `upgrade-prompt` — were invisible to `check-state` and
had each been finished for eleven days. Classifying them exposed that the
three preconditions said nothing about a SPEC with no slices: "every slice
`done`" reads identically for a SPEC finished before `arrange` existed and for
one never started. A first write took it as vacuously true; an independent
`check` raised it as `semantic`, the write was withdrawn, and `plan` decided
the rule (r4): for a SPEC with no slices, the first precondition is replaced
by the Evidence record naming each deliverable as verified, and an entry
already absent from `STATUS.md` satisfies the third. Nothing is read as
vacuously true. Only then were the three set to `verified`. `check-state`'s
assertion still fires only when a SPEC has at least one slice, so a
zero-slice SPEC remains a state the tool does not see.

`gate arrange` still accepts only `confirmed|revised`, a copy of the status
vocabulary that has now drifted from `capture`'s. Same defect class, not
confirmed in this `plan` round; it needs its own.

The rule cost six files to state — one authority and five pointers. That is
the price of a doctrine readable from several entry points, and it is also the
surface on which this repository's recurring drift appears.
