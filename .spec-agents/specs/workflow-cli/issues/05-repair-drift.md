# 05 Repair the twelve drifts

status: done
blocked_by: 02
writer: do
authority: `.spec-agents/specs/` — the affected slice and SPEC files
spec_ref: `.spec-agents/specs/workflow-cli/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- the five SPECs whose slices are all `done` but whose status is not `verified`

## Acceptance
- each of the five moves to `verified` only if every slice is `done`;
- no slice content changes;
- `check-state` is clean afterwards;
- the earlier claim of seven missing `evidence_ref` values is recorded as a
  false positive, not silently dropped;
- the mixed `spec_ref` convention is reported, not repaired.

## Verification
`bin/spec-agents check-state` exits 0.
