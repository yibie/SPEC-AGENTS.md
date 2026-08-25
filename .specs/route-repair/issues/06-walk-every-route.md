# 06 Walk all six outcomes

status: done
blocked_by: 03
writer: do
authority: n/a: verification only; introduces no rule
spec_ref: `.specs/route-repair/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- verification only; no file is edited by this slice

## Acceptance
- each of `no-change`, `plan-only`, `approve`, `compatible revise`, `breaking`,
  `reject`/`unresolved` is walked individually;
- for each, the next action is named and its preconditions are checked against
  what that outcome actually produces;
- a project with no authority map is walked through `do` on both paths;
- any outcome still lacking a satisfiable next step is reported, not assumed
  fixed.

## Verification
The walk names each outcome, its next action, and the precondition that admits
it.
