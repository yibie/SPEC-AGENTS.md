# 03 Ship the checker

status: done
blocked_by: 02
writer: do
authority: `bin/spec-agents` — the installer owns the payload
spec_ref: `.specs/checkable-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260825-010`
## Scope
- `bin/spec-agents`, `docs/runbooks/installer-smoke.md`,
  `docs/spec-agents/README.md`, `README.md`

## Acceptance
- the checker reaches an installed project with its executable bit intact;
- the smoke Runbook's installed set includes it and asserts it is executable;
- `docs/spec-agents/README.md` lists it and says it is the only executable in
  the directory;
- the installer's completion message does not grow — the payload list already
  names `docs/spec-agents/`;
- the leakage assertion still passes with an executable in the payload.

## Verification
Install to a temporary directory and run the shipped checker there.
