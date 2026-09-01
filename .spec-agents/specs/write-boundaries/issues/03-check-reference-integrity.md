# 03 Add reference integrity as a check axis

status: done
blocked_by: 01
writer: do
spec_ref: `.spec-agents/specs/write-boundaries/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Make a broken reference fail a verification instead of surviving into a commit.

## Scope

- `skills/check/SKILL.md`
- `AGENTS.md`, `AGENTS_en.md` (the `check` description)

## Acceptance

- `check` names three axes, the third being reference integrity;
- the axis covers `source`, `spec_ref`, `context_ref`, `evidence_ref`, relative
  links, and paths quoted in prose;
- it is scoped to references the change touches, not the whole repository;
- a reference that is deliberately historical is recorded as such rather than
  repaired — a record of what was true then is not a defect;
- `check` stays read-only and returns repairs to `do`.

## Verification

Apply the axis to this change itself: every reference touched by issues 01–06
resolves, or is recorded as historical.
