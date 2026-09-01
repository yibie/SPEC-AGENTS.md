# 02 Sink AGENTS.md rationale into the ADRs

status: done
blocked_by: 01
writer: do
spec_ref: `.spec-agents/specs/shrink-default-context/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260822-007`
## Scope
- `AGENTS.md`, `AGENTS_en.md`; `docs/adr/0001`–`0005` if a reason has no home

## Acceptance
- reasoning moves to the ADR that records the decision; the rule keeps a short
  pointer;
- a reason with no ADR is either written into the ADR that should have had it,
  or deleted as keyboard justification — no rationale file is created;
- the two counter-intuitive rules keep their inline reason: the recorded "no" on
  the ontology-impact question, and templates copied under `--link`;
- no rule is removed or weakened.

## Verification
Every pointer resolves to an ADR whose text contains the reasoning it replaced.
