# 05 Record the borrowing and the payload change

status: done
blocked_by: 03
writer: learn
authority: n/a: records only
spec_ref: `.spec-agents/specs/checkable-authority/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260825-010`
## Scope
- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance
- Evidence records that nothing read `KERNEL.md` and that everything added in
  the two prior days was unenforced;
- it records what was borrowed from `gura105/operational-ontology` and what was
  not, with the reason;
- it records the payload composition change and why an executable was accepted;
- it records what the checker does not do — completeness and truth;
- it records that three `STATUS.md` items are now enforced rather than
  remembered, and which ones remain manual;
- the deferred "declared implementation choices" item is recorded in
  `STATUS.md`;
- no ADR.

## Verification
The Evidence entry names each borrowed and each rejected element.
