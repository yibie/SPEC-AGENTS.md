# 05 Land the lifecycle rule lost from the previous SPEC

status: done
blocked_by: 03
writer: do
spec_ref: `.specs/kernel-maintenance/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- the Kernel lifecycle states that a revision re-anchoring only `source`, with
  enacted meaning unchanged, is still a revision and advances the file version;
- it states the consequence: every entry keeps its `since:`, which reads as
  "the file was revised, no meaning changed";
- the rule sits with the Kernel lifecycle, not in `start` or `learn` alone.

## Verification

`grep` for the rule finds it in the lifecycle section; the previous SPEC's
omission is recorded in Evidence by issue 06.
