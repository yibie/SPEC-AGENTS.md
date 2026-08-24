# 02 Make installed doctrine immutable in a managed project

status: done
blocked_by: 01
writer: do
spec_ref: `.specs/write-boundaries/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Close the gap that let a slice be arranged to edit `skills/` inside a managed
project.

## Scope

- `docs/spec-agents/WORKFLOW.md`, `AGENTS.md`, `AGENTS_en.md`
- `docs/spec-agents/README.md`, `skills/do/SKILL.md`

## Acceptance

- a new invariant states that no action writes installed doctrine in a managed
  project, and that changing it means changing it upstream;
- all five doctrine paths appear together wherever the boundary is stated —
  `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, `docs/spec-agents/`;
- the existing "not silently" phrasing no longer contradicts it;
- `docs/spec-agents/README.md` states that the rule covers doctrine outside its
  own directory too;
- the self-hosting exception from issue 01 is visible where the invariant is
  stated, so this repository is not caught by its own rule.

## Verification

No live file states the boundary as a partial list; `grep` for each of the five
paths finds them in the same statement.
