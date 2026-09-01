# 03 Sink WORKFLOW.md rationale

status: done
blocked_by: 01
writer: do
spec_ref: `.spec-agents/specs/shrink-default-context/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260822-007`
## Scope
- `docs/spec-agents/WORKFLOW.md`

## Acceptance
- the Invariants section keeps every invariant, with reasoning moved to ADRs;
- the `Code`, `Doctrine`, and `Instance` concepts keep their definitions, with
  their explanatory paragraphs moved or cut;
- the file is not split and stays in the default read;
- Core Concepts still defines every term the relations use.

## Verification
Count the invariants before and after: the number is unchanged.
