# 04 Verify by rule diff and real-task comparison

status: done
blocked_by: 03
writer: do
spec_ref: `.specs/shrink-default-context/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260822-007`
## Scope
- verification only; no doctrine file is edited by this slice

## Acceptance
- `AGENTS.md` + `docs/spec-agents/WORKFLOW.md` total ≤ 400 lines;
- a rule-by-rule comparison against the pre-compression files shows no rule
  missing;
- every rationale pointer resolves;
- the 12-smell task is re-derived from the compressed documents alone, and its
  routing and outputs are compared against the recorded pre-compression run;
- any decision that differs is reported, not silently accepted.

## Verification
The comparison names each decision point and states same or different.
