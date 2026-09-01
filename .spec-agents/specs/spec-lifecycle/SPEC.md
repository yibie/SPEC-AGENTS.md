# Give SPEC a lifecycle and a terminal state

status: verified
revision: 5
context_refs: `.spec-agents/doctrine/docs/WORKFLOW.md`, `.spec-agents/doctrine/skills/capture/SKILL.md`, `.spec-agents/doctrine/skills/learn/SKILL.md`, `.spec-agents/doctrine/bin/spec-agents`, `docs/adr/0007`

## Problem and goal

`docs/spec-agents/WORKFLOW.md:147-155` lists a lifecycle for four entities —
`work`, `start`, `kernel`, `knowledge`. `SPEC` has no line. The Stable Relations
diagram at `:123` says the same thing a second way:

```text
Change --plan--> Plan --capture--> SPEC --arrange--> Slice* --do--> Code
```

SPEC has an in-edge and an out-edge and no terminal transition. Nothing in the
model says what a finished SPEC is.

Meanwhile `bin/spec-agents` refuses: when every slice of a SPEC is `done` and
its status is not `verified`, `check-state` reports a violation. `verified` is
not a SPEC status anywhere in doctrine — `grep -rn "verified" skills/*/SKILL.md`
returns zero hits, and `skills/capture/SKILL.md:35` enumerates
`draft | confirmed | in-progress | revised | superseded`. Its only source is the
`knowledge:` lifecycle line at `WORKFLOW.md:155`. The CLI borrowed a token from
a neighbouring state machine and made it mandatory.

Sixteen of this repository's nineteen SPECs carry `status: verified`.
`check-state` is green here only because an undocumented convention has been
applied consistently. It is verifying a habit, not a rule.

The gap is not cosmetic. It has already produced three incidents of one shape in
a single day — a gate went red because the rule behind it had a hole, and the
most natural next action was to edit the record being measured:

- a managed project's `learn` set a SPEC to `verified` to clear the gate, was
  ruled out of bounds, and reverted; the gate went red again, correctly;
- the same project added a `spec_section:` field to make the checker resolve
  `spec_ref`, was ruled out of bounds, and reverted;
- in this repository a published ADR's Consequences paragraph was rewritten in
  place to remove a stale claim; the replacement cited a script that first
  existed two days after the ADR's own `date:`, and was reverted.

Closing is also defined only half way. `skills/learn/SKILL.md:80` requires that
a finished SPEC be removed from `STATUS.md`, so `learn` is authorised to take
the SPEC off the status board while nothing is authorised to mark the SPEC
itself. The CLI supplies the missing half on its own, without `plan`.

Goal: give `SPEC` a lifecycle with a terminal state, and name the action that
writes it.

## Unchanged contracts

- The six action names and their division of labour.
- The Doctrine/Instance split (ADR 0001). `bin/` stays Instance.
- `plan` remains the only door through which the model changes.
- `check` stays read-only. `learn` stays the only action that promotes
  knowledge.
- `capture` continues to own `.specs/<feature>/SPEC.md` as a document.
- Slice states `ready | blocked | doing | done | stale` and their invariants.
- The CLI does not print skill prose (ADR 0007).
- No published record is edited in place. A correction to ADR 0006 or any other
  accepted record is made by a superseding record, written by `learn`.

## Decision and boundaries

### SPEC gains a lifecycle line

`WORKFLOW.md`'s Lifecycle block gains one line beside the existing four:

```text
spec: draft → confirmed → in-progress → revised → verified → superseded
```

`verified` is the terminal state of completed work. `superseded` keeps its
existing meaning — replaced by another SPEC — and is a different exit, not a
synonym.

### The word `verified` is kept deliberately

Sixteen SPECs already carry it, so adopting it costs no data migration, and the
CLI's existing assertion becomes correct rather than needing removal. Reusing a
state name across two entities' lifecycles is already established here:
`superseded` appears on both the `kernel:` and `knowledge:` lines.

### `learn` closes both levels

`learn` writes terminal state at close, at both levels of the same structure:

- **a Slice** — `evidence_ref` and `status: done`, in the same act, after
  `check` has verified it. `do` leaves the slice at `doing` with its
  verification summary and does not close it.
- **a SPEC** — `status: verified`, when every slice is `done`, the Evidence
  record is appended, and the SPEC is removed from `STATUS.md` in the same act.

Nothing else changes hands: `capture` owns the SPEC document, `arrange` creates
slices, `do` writes a slice's verification summary.

### A SPEC with no slices

The first precondition — every slice is `done` — says nothing about a SPEC
that never had a slice: it reads identically for one whose work was finished
before `arrange` existed and for one that was never started. For a SPEC with
no slices, that precondition is replaced: the Evidence record names each item
of the SPEC's issue map (or, absent one, each deliverable in its Verification
section) and states that it was verified. The third precondition — removed
from `STATUS.md` in the same act — is satisfied by a SPEC that is already
absent from it. The second is unchanged. Nothing is read as vacuously true.

This case surfaced while executing slice 04 (r4): the write was made on the
vacuous reading, withdrawn on an independent `check`'s `semantic` finding, and
routed here.

`capture` is not given a second trigger. Its preconditions
(`skills/capture/SKILL.md:10-18`) are a confirmed `plan` outcome plus
multi-context work, and neither holds at close; making one action both the entry
and the exit is a wider change than naming a writer.

The slice level was not in this SPEC's first revision. It surfaced while
executing slice 01: the work was complete, and `spec-agents transition ... done`
refused because `done` requires `evidence_ref` while no contract said who writes
the pair. `bin/spec-agents:250-252` demands both; `skills/do/SKILL.md:64` keeps
`evidence_ref` empty; `skills/arrange/SKILL.md:62` keeps it empty until `learn`;
`skills/learn/SKILL.md:68` writes `evidence_ref` and says nothing about slice
status. `grep -rn "done" skills/*/SKILL.md` returns one hit — a status enum in
`arrange`'s template. The repository's seventy-five closed slices were all set
by hand, which is the practice ADR 0007 built the CLI to end. It is the same
defect as the SPEC terminal state, one level down, so it is repaired by the same
decision rather than a second one.

### Two ownership sentences are amended

`skills/arrange/SKILL.md:31` and `skills/do/SKILL.md:90` state flatly that
`capture` owns the SPEC. Both are amended to say that `capture` owns the SPEC
document and `learn` writes its terminal status. No behaviour of `arrange` or
`do` changes.

### `check-state` keeps its assertion

The refusal text gains the citation it currently cannot make, naming the
lifecycle line and `skills/learn/SKILL.md`. The check itself is unchanged.

## Model delta

| | before | after |
| --- | --- | --- |
| `WORKFLOW.md` Lifecycle | four entities | five; `spec:` added |
| `WORKFLOW.md:123` relations | SPEC has no terminal edge | SPEC reaches `verified` at close |
| `capture/SKILL.md:35` status set | five values | six; `verified` added |
| SPEC status writer | `capture` only, no terminal trigger | `capture` owns the document; `learn` writes `status` at close |
| Slice close | required by the CLI, authorised by no contract | `learn` writes `evidence_ref` and `done` together; `do` leaves `doing` |
| `verified` provenance | `knowledge:` lifecycle, borrowed by the CLI | a SPEC state defined in the model |

## Action Contracts

- **`learn`** — new, two writes. `Slice.status = done` together with
  `evidence_ref`, after `check` has verified that slice. And
  `SPEC.status = verified`, with three preconditions: every slice of that SPEC
  is `done`; the Evidence record is appended; the SPEC is being removed from
  `STATUS.md` in the same act. For a SPEC with no slices the first is replaced
  by the Evidence record naming each deliverable as verified, and the third is
  satisfied by an entry already absent (r4). Any precondition unmet: stop,
  write nothing, report which one failed. `learn` writes no other field of a
  SPEC or a slice.
- **`do`** — leaves a finished slice at `doing` with its verification summary,
  and keeps `evidence_ref` empty. It no longer implies a close.
- **`capture`** — unchanged ownership and triggers. Its status set gains
  `verified`; `capture` does not write that value.
- **`arrange`**, **`do`** — wording of one sentence each; no behavioural change.
- **`check-state`** — unchanged assertion; refusal text cites the new rule.

## Seams and verification

- `grep -rn "verified" skills/*/SKILL.md` returns at least one hit. It returns
  zero before this SPEC, and that is the sharpest form of the defect.
- `grep -rn "done" skills/*/SKILL.md` returns a hit outside `arrange`'s status
  enum, naming the action that closes a slice. It returns only the enum today.
- A slice whose work is complete reaches `done` through `spec-agents transition`
  without any field being hand-edited.
- `WORKFLOW.md`'s Lifecycle block contains a `spec:` line, and `:123` shows a
  terminal transition for SPEC.
- `spec-agents check-state` exits 0 across all nineteen SPECs.
- A fixture SPEC with every slice `done` and status `confirmed` still produces
  the violation, and its message names a document that resolves.
- A fixture close with an unmet precondition (slices not all `done`) leaves
  `status` unwritten.
- `tests/doctrine-check.sh` passes; the mandatory read stays at or under 400
  lines.
- The three SPECs that are `confirmed` with zero slices are each classified.

## Compatibility and migration

**Breaking.** `learn` gains a write it did not have, and a status value becomes
reachable that the vocabulary did not contain.

- **Sixteen SPECs already `verified`** — no data change. This is the reason the
  word is kept.
- **Three SPECs `confirmed` with zero slices** (`jsonl-evidence-pilot`,
  `ontology-graph-pilot`, `upgrade-prompt`) — `check-state`'s assertion fires
  only when a SPEC has at least one slice, so they are unaffected mechanically.
  Each still needs a one-line classification: genuinely open, or terminal and
  mis-stated. That classification is a slice of this SPEC, not a side effect.
- **Managed projects** — additive. A SPEC that never reaches `verified` keeps
  working; no slice format changes; no existing status value is invalidated.
  A project that installed doctrine before this change is not required to
  back-fill.
- **No back-fill of closed work.** The seventy-five slices already `done` are not
  revisited, and their missing provenance is not reconstructed.
- **`do`'s output changes shape.** A slice that `do` finishes is left `doing`
  rather than `done`. Any project reading `done` as "`do` finished" reads one
  state later than before; nothing that was `done` becomes not-`done`.

## Out of scope

- `gate arrange` accepting `in-progress` and `verified` alongside
  `confirmed|revised`. It is the same defect class — a copy of the state
  vocabulary inside the CLI that drifted from `capture` — but this `plan` round
  did not confirm it, and a SPEC is not the place to introduce a decision. It
  needs its own `plan`.
- The `spec_ref` field's four degrees of freedom.
- The three authority conflicts: `skills/` absent from the authority order,
  `learn` writing `docs/spec-agents/WORKFLOW.md`, and `single-authority.md`
  contradicting `skills/do/SKILL.md:46-53`. Confirmed in the same `plan` round
  but sequenced after this SPEC; their scope intersects `skills/`.
- `CONTEXT.md` reference guards, the `CONTEXT.md` template's authority section,
  and shipping the CLI from `docs/spec-agents/`. Sequenced third.
- Editing ADR 0006, ADR 0007, or any accepted record in place.

## Issue map

- `01-workflow-lifecycle.md`: add the `spec:` line to the Lifecycle block and a
  terminal transition to the Stable Relations block.
- `02-terminal-state-and-writer.md`: add `verified` to
  `skills/capture/SKILL.md`'s status set, give `learn` the `SPEC.status` write
  and its three preconditions, and amend `arrange/SKILL.md:31` and
  `do/SKILL.md:90`.
- `03-check-state-citation.md`: `check-state`'s refusal cites the lifecycle line
  and `skills/learn/SKILL.md`.
- `04-classify-open-specs.md`: classify the three zero-slice `confirmed` SPECs.
  `writer: learn`.
- `05-learn-record.md`: Evidence, ADR, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.
- `06-zero-slice-rule.md`: state the zero-slice preconditions in
  `skills/learn/SKILL.md` 收尾. Added at r4; slice 04 waits on it.

## Revision notes

Line anchors in the prose above record where things stood at the revision that
wrote them. Slices 01 and 02 have since moved several of those lines; the
anchors are not repointed, because an instruction that has been carried out is
a record of where the change was decided, not a pointer to current text. A
reader who needs the current position has the files and the diff.


- **r3** — the slice-level close was folded in after `do` on slice 01 hit it.
- **r4** — compatible revision, decided in `plan` on 2026-08-29 after an
  independent `check` of slice 04 found the three preconditions undefined for
  a SPEC with no slices. One alternative was chosen: replace the first
  precondition with a named-deliverables check and treat an absent `STATUS.md`
  entry as satisfying the third. Rejected: reading "every slice done" as
  vacuously true (cannot tell a finished SPEC from an unstarted one), and
  leaving the three SPECs unclassified for a later `plan`. Adds slice 06;
  slice 04 becomes `blocked_by: 02, 06`.
- **r5** — compatible revision, decided in `plan` on 2026-08-29 after an
  independent `check` of slice 05. Its acceptance required each of the three
  2026-08-27 reverted edits to be locatable in version control; two happened
  in a managed project outside this repository and the third was made and
  reverted in this working tree before any commit, so no revision holds them.
  The bullet now reads: locate the reverted edit in version control, or state
  why it cannot be located. Rejected: leaving slice 05 open on an
  unsatisfiable criterion. `.specs/evidence-reproducibility/SPEC.md` already
  carries the general form of this gap.
  `learn` now closes both a Slice and a SPEC, which is one decision applied at
  two levels rather than two decisions. Confirmed in a `plan` round on
  2026-08-28; it widens `learn`'s write boundary and changes what `do` leaves
  behind, so it did not qualify as a direct revision.
- **r2** — `arrange` merged the vocabulary and writer issues into one slice.
  Adding a value that no action may write reproduces the defect in a new form,
  so the two are not independently verifiable. Issue map updated to match the
  five slices that exist. Clarification only; no goal, boundary, contract or
  acceptance criterion changed, so no new `plan` round.
- **r1** — created from the `plan` round of 2026-08-27. Routed `breaking`.
  The terminal state's name, `learn` as its writer, and the sequencing against
  the two other confirmed Changes were all decided in that round.
