# 05 Extend the smoke Runbook and record Evidence

status: done
blocked_by: 02
spec_ref: `.scratch/framework-namespace-split/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-001`
## Goal

Turn the reproduction into a standing check so instance state cannot re-enter
the installer payload.

## Scope

- `docs/runbooks/installer-smoke.md`
- `EVIDENCE.md`, `STATUS.md`

## Acceptance

- the Runbook asserts the exact installed set and the absent set;
- a leakage assertion greps the target for `bin/spec-agents`, `Phase [0-9]`,
  `task[0-9]`, `research/`, and `E-2026` and fails on any hit;
- a `--link` assertion proves `CONTEXT.md` in the target is a regular file;
- Evidence records the original reproduction, the fix, and the residual risk.

## Verification

The Runbook fails against the pre-fix installer and passes against the fixed
one.
