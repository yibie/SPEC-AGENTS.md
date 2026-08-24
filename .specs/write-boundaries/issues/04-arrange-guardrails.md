# 04 Add writer and reachability guardrails to arrange

status: done
blocked_by: 01
writer: do
spec_ref: `.specs/write-boundaries/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Make an unsatisfiable slice detectable when it is written, not when it is
executed.

## Scope

- `skills/arrange/SKILL.md`, `skills/plan/SKILL.md`
- `AGENTS.md`, `AGENTS_en.md` (the slice shape)

## Acceptance

- the slice template carries a conditional `writer:` field, required when the
  Scope contains a file `do` does not own;
- `arrange` gains a completion condition: each slice's verification is
  reachable within that slice's own Scope;
- the rule names the failure it prevents — a verification requiring a write
  outside the Scope is a split error, returned to `plan`;
- existing slices touching only code stay valid without `writer:`;
- the documented slice shape lists the field in both languages.

## Verification

The six slices of this SPEC each carry `writer:` and pass the reachability
check against their own Scope.
