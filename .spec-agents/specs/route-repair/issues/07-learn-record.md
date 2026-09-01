# 07 Record the review and the repair

status: done
blocked_by: 06
writer: learn
authority: n/a: records only
spec_ref: `.spec-agents/specs/route-repair/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance
- Evidence records that an independent review found in one pass four verified
  defects that three days of self-review missed, three of them introduced the
  previous day;
- it records the review's own conclusion — visibility is not executability —
  and that three of seven findings were routes with no satisfiable next step;
- it records the two findings not acted on and why;
- it records that this is empirical support for ADR 0006's claim about
  self-review, obtained on the author rather than on a managed project;
- it records the codex version defect that cost two hours, and the working
  invocation;
- no ADR: this repairs contracts to match ADR 0004 and ADR 0006.

## Verification
The Evidence entry names each of the four verified defects with its file.
