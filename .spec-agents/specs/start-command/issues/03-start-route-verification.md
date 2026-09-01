# 03 Verify Start routes and record evidence

status: done
blocked_by:
spec_ref: `.spec-agents/specs/start-command/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260818-007`

## Goal

Verify the four project-state routes and the confirmation/handoff boundary in
disposable fixtures, then record bounded evidence.

## Scope

- temporary fixture directories under `/tmp`
- `EVIDENCE.md`
- `STATUS.md`
- `ROADMAP.md`

## Acceptance

- modern state routes to `plan` after confirmation;
- legacy and mixed state route to `UPGRADE.md`;
- missing entry points route to installation guidance;
- conflicting/unresolved findings stop at the report;
- no fixture changes the source project or application code.

## Verification

The modern, legacy, mixed, and missing-entry fixtures selected the expected
routes. Installer repeatability/source refusal and shell syntax also passed;
final link/content checks remain in `check`.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
