# 05 Publish the single-authority Protocol

status: done
blocked_by: 01
writer: do
authority: `docs/spec-agents/single-authority.md` — new doctrine record
spec_ref: `.specs/single-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- new `docs/spec-agents/single-authority.md`; `docs/spec-agents/README.md`

## Acceptance
- full Protocol metadata: `status`, `scope`, `applies_when`, `owner`, source,
  `verification`;
- states that the rule is not "never duplicate" and names the legitimate case;
- requires a same-input equivalence test wherever a rule exists in two places,
  and states that divergence rather than duplication is the failure;
- records that tests written at the implementation's own layer cannot show the
  layer is wrong;
- prescribes no test framework or specific test shape;
- contains no marker that would fail the installer leakage assertion.

## Verification
Metadata check and installer smoke including the leakage assertion.
