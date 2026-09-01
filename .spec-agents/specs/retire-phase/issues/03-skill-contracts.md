# 03 Update the affected skill contracts

status: done
blocked_by: 01
spec_ref: `.spec-agents/specs/retire-phase/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

Remove Phase from the three skills that read or write it, and record the
parallel-scope constraint where it is enforced.

## Scope

- `skills/plan/SKILL.md`, `skills/arrange/SKILL.md`, `skills/learn/SKILL.md`

## Acceptance

- `plan` no longer reads `ROADMAP.md`, and it checks that a new SPEC's scope
  does not overlap an active one;
- `arrange` is bounded by the confirmed SPEC rather than "the current phase",
  and its description drops "future phase tasks";
- `learn` writes `STATUS.md` only, never `ROADMAP.md`, and removes a completed
  SPEC from it;
- `learn`'s description and completion condition drop the phase-boundary
  trigger;
- `learn`'s write boundary restates "unless a new phase is opened" without
  `Phase`.

## Verification

`grep -n "phase\|阶段\|ROADMAP"` over `skills/` returns nothing.
