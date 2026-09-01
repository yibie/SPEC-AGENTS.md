# 06 AGENTS.md points at the tool

status: done
blocked_by: 03
writer: do
authority: `AGENTS.md` — the mandatory read
spec_ref: `.spec-agents/specs/workflow-cli/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- `AGENTS.md`, `AGENTS_en.md`

## Acceptance
- the six-action router points at `spec-agents --help` and the skills;
- what stays is what must be true before any tool runs: ownership, document
  authority order, safety boundary;
- the degraded mode is stated: without `spec-agents`, read the skills and check
  the gates by hand — the workflow degrades, it does not disappear;
- the mandatory read is under 374 lines;
- both languages match.

## Verification
`tests/doctrine-check.sh` passes and reports a lower line count than before.
