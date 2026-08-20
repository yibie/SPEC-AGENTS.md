# 01 Move the work contracts and update the model

status: done
blocked_by:
spec_ref: `.specs/split-work-and-scratch/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-003`
## Goal

Give durable work contracts a home whose name matches their lifetime, and state
the distinction in the model.

## Scope

- the ten directories under `.scratch/` that hold a SPEC
- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- every `<feature>/` directory holding a `SPEC.md` is under `.specs/`;
- the move uses `git mv` so history follows;
- `.scratch/` holds no `SPEC.md` and no `issues/`;
- `WORKFLOW.md` states the durable/transient distinction and gives both paths
  in full;
- no new concept is introduced.

## Verification

`git log --follow` resolves across the move for a sample SPEC; `find .scratch
-name SPEC.md` is empty.
