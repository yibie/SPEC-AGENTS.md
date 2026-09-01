# 07 Record the decision

status: done
blocked_by: 06
writer: learn
authority: n/a: records only
spec_ref: `.spec-agents/specs/workflow-cli/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- new `docs/adr/0007-workflow-cli.md`; `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance
- the ADR records the four independent sources and what each contributed;
- it records why the CLI does not print skill prose, and that doing so would be
  a single-authority violation;
- it records bash and the distribution argument, including the cost accepted;
- it records the rejected alternatives: path-encoded state, a compiled binary,
  prose-only checks;
- Evidence records the twelve drifts as the measured case for tooling, and what
  the repair could and could not establish;
- Evidence records what a gate cannot do — reasoning is not gateable.

## Verification
The ADR names each of the four sources and the specific mechanism taken from it.
