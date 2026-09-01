# 03 Give plan-only and breaking a next step

status: done
blocked_by: 02
writer: do
authority: `.spec-agents/doctrine/skills/plan/SKILL.md` — plan defines the outcomes; do and capture consume them
spec_ref: `.spec-agents/specs/route-repair/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- `skills/plan/SKILL.md`, `skills/do/SKILL.md`, `skills/capture/SKILL.md`

## Acceptance
- `do`'s short path accepts `approve`, or `plan-only` with explicit user
  authorization; both still require single-context completion;
- `plan`'s `breaking` outcome requires a migration plan recorded in the SPEC by
  `capture`, and states that the ADR is written by `learn` at the close;
- `capture` lists `breaking` among its accepted preconditions;
- no outcome asks for an ADR before verification;
- ADR 0004's single writer is untouched.

## Verification
Each of the six outcomes names an action that will accept it.
