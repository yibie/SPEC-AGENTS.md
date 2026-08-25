# Make the routes executable

status: verified
revision: 1
context_refs: `AGENTS.md`, `skills/{plan,do,arrange,check}`, `docs/adr/0004`, `docs/adr/0006`

## Problem and goal

An independent review (`codex exec`, read-only) of the doctrine found seven
defects. Four were verified against the files and are load-bearing; three of
those were introduced within the previous day, by the same author who then
verified the work.

**`do` cannot start in a valid project.** `skills/do/SKILL.md` requires the
slice's `authority:` to match the Kernel's authority map and stops when the
target is not on it. `START.md` states that an existing Kernel is not required
to back-fill that map. Both halves were written in the same SPEC hours apart. A
conforming project with a thin Kernel can enter neither execution path.

**The router and `plan` disagree about the routes.** `AGENTS.md` draws three
routes out of `plan`. `skills/plan/SKILL.md` emits six outcomes: `no-change`,
`plan-only`, `approve`, `compatible revise`, `breaking`, and
`reject`/`unresolved`. The three-route diagram was written during the
context-compression round by collapsing six into three. This is a
single-authority violation in the doctrine, in the same week the
single-authority Protocol was written.

**`plan-only` has no next action.** `do`'s short path accepts only `approve`.
`capture` accepts an authorized `plan-only` but also requires the design to span
multiple contexts. A single-context `plan-only` that the user authorizes can
enter neither.

**`breaking` is circular.** `plan` says a breaking change must first record a
migration plan and an ADR. `capture` does not list `breaking` among its accepted
preconditions. ADR authorship belongs to `learn` (ADR 0004), and `learn` fires
after verification — but nothing has been verified yet. The author hit this
personally twice in one session: ADRs were written during `do`, corrected by
ADR 0004 to belong to `learn`, and `plan`'s wording was never revisited.

The review's own conclusion names the pattern:

> making a rule visible everywhere is not the same as making it executable;
> several gates now pass on document shape while the route underneath has no
> satisfiable next step.

Three of seven findings are routes with no satisfiable next step. The preceding
days added required fields, required questions, and named checks — all
visibility. `do`'s map requirement is the sharpest case: a gate demanding a
document that the same doctrine says need not exist.

Goal: make every documented route executable, and stop the router from being a
second source of routing truth.

## Unchanged contracts

- The six action names and their order.
- `learn` remains the only writer of ADRs and durable knowledge (ADR 0004).
- The authority map, `authority:`, and the placement check (ADR 0006) — this
  SPEC repairs how they gate, not whether they exist.
- The three `check` axes, four finding types, and the ontology-impact question.
- The 400-line ceiling on the mandatory read.
- Existing Kernels are still not required to back-fill the authority map.

## Decision and boundaries

### `do`'s map comparison becomes conditional

When the Kernel has an authority map, `do` compares the target site against it
and stops if the site is absent. When the Kernel has no map, or the map has no
entry covering this rule, `do` records the intended site and emits a `semantic`
finding to `plan` — it does not stop.

A missing map is a gap in the Kernel, not a defect in the work. Turning it into
a hard stop makes conforming projects unable to move and guarantees the rule is
routed around. Turning it into a `semantic` finding makes the gap an occasion to
build the map, through the gate that owns Kernel change.

### `skills/plan` is the routing authority

`AGENTS.md` stops drawing the route diagram. It states that every route begins
at `plan` and that the outcomes are defined in `skills/plan/SKILL.md`.

The routes out of `plan` are needed *after* choosing `plan`, which by the router
principle places them in the skill. Keeping a second copy in the mandatory read
is what let the two drift, and the drift was invisible because both looked
authoritative.

The `approve` two-part test moves with them. `AGENTS.md` keeps one line: `do` is
used for a ready slice or for an `approve` route with no slice.

### `do` accepts an authorized `plan-only`

The short path's precondition becomes: `plan` returned `approve`, or returned
`plan-only` and the user has explicitly authorized execution. Both still require
the work to complete in the current context.

A small change that needs authorization before it starts is a legitimate case.
The previous contract documented it and left it nowhere to go.

### `breaking` states the migration, `learn` writes the ADR

`plan`'s `breaking` outcome requires a migration plan, recorded in the SPEC by
`capture`. The ADR is written by `learn` at the close, like every other durable
record. `capture` lists `breaking` among its accepted preconditions.

This matches what the author actually did across six ADRs and contradicts only
the wording. ADR 0004's single writer is preserved.

### `authority:` states what it can and cannot guarantee

The stated purpose is corrected: a required field guarantees an answer, not a
correct one. `n/a: <reason>` still returns the classification to the slice
author, and the gate detects presence rather than truth.

`check`'s placement item gains one question: was `n/a` accurate — does this
change really touch no rule that has an owner? This is where the classification
can be caught, because `check` reads the diff and `arrange` only reads intent.

### Three sections sink out of the mandatory read

`Start entry`, `Version-control layer`, and `SPEC and slice discipline` contain
procedure needed after an action is chosen, not before. They sink to `START.md`,
`docs/spec-agents/jj-change-management.md`, and the relevant skills, leaving a
pointer each. Same principle that removed the 111-line action summary.

## Model delta

None. No concept, relation, lifecycle, invariant, or Action Contract changes
meaning. Preconditions are relaxed where they were unsatisfiable, and one
duplicated statement is removed in favour of its authority.

## Compatibility

`compatible`. Every change either removes an impossible requirement, relaxes a
precondition, or deletes a duplicate. No project needs migration, no existing
slice or Kernel becomes invalid, and no rule is repealed.

No ADR. This repairs contracts to match decisions already recorded in ADR 0004
and ADR 0006 rather than deciding anything new; the reasoning is recorded in
`EVIDENCE.md`.

## Verification

- `skills/do/SKILL.md` states both branches of the map comparison, and the
  no-map branch does not stop execution.
- `AGENTS.md` contains no route diagram and names `skills/plan/SKILL.md` as the
  authority; `AGENTS_en.md` matches.
- `skills/plan/SKILL.md` still lists all six outcomes, and each names its next
  action.
- Every one of the six outcomes has a satisfiable next step — walked
  individually, not asserted.
- `skills/capture/SKILL.md` accepts `breaking`; `plan` no longer asks for an ADR
  before verification.
- `skills/arrange/SKILL.md` states what `authority:` guarantees; `check` asks
  whether `n/a` was accurate.
- The mandatory read is at or under 400 lines and lower than before.
- Installer smoke, three axes, ontology-impact question all pass.

## Out of scope

- Removing `authority:`, the authority map, or the placement check.
- Changing who writes ADRs.
- Re-examining findings #6 and #7 beyond the three named sections.
- Mandating independent review.

## Issue map

- `01-do-map-conditional.md`: the blocking defect.
- `02-routing-authority.md`: `AGENTS.md` stops duplicating the routes.
- `03-plan-only-and-breaking.md`: both dead-end routes.
- `04-authority-honesty.md`: what `authority:` guarantees, and the `n/a` check.
- `05-sink-three-sections.md`: mandatory-read reduction.
- `06-walk-every-route.md`: verification — walk all six outcomes.
- `07-learn-record.md`: Evidence, `STATUS.md`, `CHANGELOG.md`. `writer: learn`.
