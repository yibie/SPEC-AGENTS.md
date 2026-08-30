# 02 status, check-state, ready

status: done
blocked_by: 01
writer: do
authority: `bin/spec-agents` — the CLI owns invariant checking
spec_ref: `.specs/workflow-cli/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- `bin/spec-agents`

## Acceptance
- `status` prints active SPECs, slice counts by state, and any drift;
- `check-state --all` checks every invariant listed in the SPEC and exits 1 on
  any violation, naming file and reason;
- `ready` lists slices whose `blocked_by` are all `done`;
- each invariant names the doctrine rule it enforces, so a failure is traceable;
- exit 0 when `.specs/` is absent — a project with no SPECs is not in violation.

## Verification
`check-state --all` reports exactly the twelve known drifts before repair.
