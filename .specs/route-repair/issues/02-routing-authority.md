# 02 Make skills/plan the single routing authority

status: done
blocked_by: 01
writer: do
authority: `skills/plan/SKILL.md` — plan owns its own outcomes
spec_ref: `.specs/route-repair/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- `AGENTS.md`, `AGENTS_en.md`, `skills/plan/SKILL.md`

## Acceptance
- `AGENTS.md` contains no route diagram and no `approve` definition;
- it states that every route begins at `plan` and names
  `skills/plan/SKILL.md` as where the outcomes are defined;
- the one-line `do` entry still says "a ready slice, or an `approve` route with
  no slice";
- `skills/plan/SKILL.md` carries the full `approve` two-part test that
  `AGENTS.md` gives up;
- both languages match.

## Verification
`grep` finds the `approve` two-part test in exactly one file.
