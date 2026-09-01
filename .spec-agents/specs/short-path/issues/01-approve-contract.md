# 01 Give approve a satisfiable contract

status: done
blocked_by:
writer: do
spec_ref: `.spec-agents/specs/short-path/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260821-005`
## Goal

Make `approve` state its test and hand something to `do`.

## Scope

- `skills/plan/SKILL.md`

## Acceptance

- `approve` requires both conditions: semantics unchanged, and completable
  within the current context;
- routing `approve` states the contract that stays unchanged and one verifiable
  acceptance sentence;
- neither is a file, and `approve` never creates a SPEC or a slice;
- `plan` records one `STATUS.md` entry only when the work may outlive the
  current context, and the rule says why the condition exists;
- a semantically neutral change that cannot finish in one context routes to
  `capture`, not `approve`.

## Verification

Read the routing section against `skills/do`'s short-path preconditions: every
input `do` requires is produced by `approve`.
