# 01 Turn Six actions into a router

status: done
blocked_by:
writer: do
spec_ref: `.specs/shrink-default-context/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260822-007`
## Scope
- `AGENTS.md`, `AGENTS_en.md`

## Acceptance
- the section keeps the pipeline, the three routes with the `approve` two-part
  test, and one line per action saying when to reach for it;
- each action's read list, write boundary, and completion condition are deleted
  here and remain in `skills/<action>/SKILL.md`;
- the section drops from 111 lines to 20 or fewer;
- an agent that has not yet chosen an action can still choose from this section
  alone;
- both languages are structurally identical.

## Verification
For each of the six actions, the deleted text is present in its `SKILL.md`.
