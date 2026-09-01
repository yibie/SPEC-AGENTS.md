# 01 Give SPEC a lifecycle line and a terminal edge

status: done
blocked_by:
writer: do
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — the workflow model owns entity lifecycles
spec_ref: `.spec-agents/specs/spec-lifecycle/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260828-012`

## Goal

SPEC becomes the fifth entity with a stated lifecycle, and the relations
diagram shows how a SPEC ends.

## Scope

- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- the Lifecycle block carries
  `spec: draft → confirmed → in-progress → revised → verified → superseded`;
- `verified` is stated as the terminal state of completed work and `superseded`
  as replacement by another SPEC; the two are not presented as synonyms;
- the Stable Relations block shows a transition out of SPEC at close, so SPEC no
  longer carries only an in-edge and an out-edge;
- no other entity's lifecycle line changes;
- the mandatory read stays at or under 400 lines, removing something first if
  the addition would exceed it.

## Verification

`tests/doctrine-check.sh` passes. The Lifecycle block lists five entities. A
reader can answer "what is a finished SPEC" from `WORKFLOW.md` alone, without
opening a skill or the CLI.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `docs/spec-agents/WORKFLOW.md` — Lifecycle block gained
  `spec: draft → confirmed → in-progress → revised → verified → superseded`;
  it now lists five entities.
- Stable Relations gained `SPEC --learn when every Slice is done--> SPEC(verified)`,
  using the `X(state)` notation already used by `Project Kernel(K1)`.
- Prose added distinguishing the two exits: `verified` is completion under
  `learn`'s three preconditions, `superseded` is replacement by another SPEC.
- No other entity's lifecycle line changed.
- `tests/doctrine-check.sh` passes; mandatory read 373 → 379 of 400, so nothing
  had to be removed first.

Open finding for `plan` (`semantic`, per `skills/do/SKILL.md:46-53`): this
repository has no `KERNEL.md`, so there is no `Architecture boundaries` map to
compare the write site against. The intended site was recorded as
`docs/spec-agents/WORKFLOW.md` and work continued, as the skill directs. The
absence is a gap in the Kernel, not a defect in this slice.

Second finding for `plan` (`semantic`, blocking): the work of this slice is
complete and its acceptance is met, but the slice cannot reach `done`.
`bin/spec-agents` refuses the transition because `done` requires `evidence_ref`,
and its own refusal text says `learn` writes that back. `skills/do/SKILL.md:64`
tells `do` to update the slice's status while keeping `evidence_ref` empty;
`skills/arrange/SKILL.md:62` keeps it empty until `learn`; `skills/learn/SKILL.md:68`
authorises `learn` to write `evidence_ref` and says nothing about slice status.
`grep -rn "done" skills/*/SKILL.md` returns one hit, the status enum in
`arrange`'s template. No contract names the action that ends a slice.

This is the defect this SPEC is repairing, one level down: the tool enforces a
field-and-status combination that no single action is authorised to produce. It
blocks slices 02 through 05 of this SPEC as well. Left at `doing`, which is the
most accurate state the tool permits.

Resolution of the second finding: routed to `plan` on 2026-08-28 and folded into
SPEC r3 — `learn` closes both a Slice and a SPEC, one decision at two levels.
This slice stays at `doing`, which r3 makes the correct resting state for a
slice `do` has finished; it is closed by `learn` once slice 02 grants that
power.

That ordering first looked like a deadlock: 01 needs `learn` to close it, the
close is granted by 02, and 02 was `blocked_by: 01`. The tempting repair was a
bootstrap clause exempting this SPEC from the rule it establishes, which is the
same reflex the three recorded incidents share. The actual defect was in the
dependency: none of 02's acceptance criteria require this slice's output to
exist, so the edge was conceptual order rather than a precondition, and
`arrange` removed it. No exception was written.

Post-check revision: `check` found the three `SPEC.verified` preconditions
stated in two places — `skills/learn/SKILL.md` and this slice's own prose in
`WORKFLOW.md` — with none of `single-authority.md`'s three conditions for a
legitimate second site holding. Routed to `plan` as `semantic`; `plan` returned
`compatible revise`. The enumeration was removed from `WORKFLOW.md`, which now
carries the model-layer fact and a pointer, matching the shape of the other five
pointers. The rule itself did not change, only where it is stated.

Derivation used: `AGENTS.md` ranks first in the current authority order and
already delegates each action's write boundary to `skills/<action>/SKILL.md`.
The three preconditions are `learn`'s write conditions, so the enacted order
settles this without depending on the `skills/`-ranking decision captured in
`.specs/authority-order/SPEC.md`, which is confirmed but not yet enacted.

