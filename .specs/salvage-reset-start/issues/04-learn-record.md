# 04 Record and close the new upgrade boundary

status: done
blocked_by: 03
writer: learn
authority: `docs/spec-agents/WORKFLOW.md` — Upgrade and ProjectState
spec_ref: `.specs/salvage-reset-start/SPEC.md`
context_ref: `EVIDENCE.md`, `docs/adr/0001-framework-namespace-split.md`, `STATUS.md`, `CHANGELOG.md`
evidence_ref: E-20260831-006

## Goal

Record verified evidence, supersede the old upgrade decision, and close the
SPEC only after the implementation and destructive-boundary fixtures pass.

## Scope

- `EVIDENCE.md`
- `docs/adr/0010-upgrade-rebootstrap.md`
- `docs/runbooks/installer-smoke.md`
- `STATUS.md`
- `CHANGELOG.md`
- `.specs/salvage-reset-start/SPEC.md`
- `.specs/salvage-reset-start/issues/01-upgrade-model-and-entry.md`
- `.specs/salvage-reset-start/issues/02-replace-doctrine.md`
- `.specs/salvage-reset-start/issues/03-reset-start-fixtures.md`
- `.specs/salvage-reset-start/issues/04-learn-record.md`

## Acceptance

- STATUS reserves `docs/adr/0010-upgrade-rebootstrap.md` for this SPEC and
  `docs/adr/0011-authority-order.md` for `authority-order`; no active write
  scope intersects this Slice.
- Evidence separates observed command results, interpretation, and recommended
  next action, including recovery and failure fixtures.
- A new ADR supersedes the old mechanical and prompt-driven conversion
  decisions without editing their historical records in place.
- The installer smoke Runbook records replacement success, refusal,
  unchanged-Instance, stale-doctrine-removal, backup, and recovery assertions.
- The promoted Workflow entries equal the SPEC's declared Model delta and cite
  this SPEC through the Evidence/ADR record.
- All four Slices are `done` with evidence references, the SPEC is `verified`,
  and `salvage-reset-start` is removed from STATUS.
- No claim says a real-project cutover is generally safe on the strength of
  disposable fixtures alone.

## Verification

- Re-run every Slice verification from the final tree.
- Run `spec-agents check-state`, `spec-agents status`,
  `tests/doctrine-check.sh`, Kernel checks, reference checks, and
  `git diff --check`.
- Confirm the accepted ADRs that are superseded remain byte-identical.

## Evidence

Pending `check` and `learn`.
