# 06 Record the incident and the decision

status: done
blocked_by: 05
writer: learn
authority: n/a: records only; introduces no rule of its own
spec_ref: `.specs/single-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- new `docs/adr/0006-single-authority.md`
- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance
- Evidence records that six gates passed and the result was wrong, with the
  violation classes named;
- it records that the ontology-impact question added two days earlier answers
  "no" for a duplicate implementation, and that the contract axis is
  structurally blind to duplication;
- it records the co-located-test finding, which the reporting project observed
  but did not include in its own proposals;
- it records that this is the first external evidence in this sequence of
  changes — everything prior was self-consistency checking;
- the ADR records the decision, the rejected alternatives including mandated
  independent `check` and a fourth axis, and the consequences;
- Evidence states what remains unverified: the reporting project's trial is
  still in progress and its result has not been received.

## Verification
The Evidence entry names the incident's violation classes rather than
summarising them.
