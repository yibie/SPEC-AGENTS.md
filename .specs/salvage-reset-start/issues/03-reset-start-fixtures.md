# 03 Prove the reset reaches a clean Start

status: done
blocked_by: 01, 02
authority: n/a — verification-only slice introduces no product rule
spec_ref: `.specs/salvage-reset-start/SPEC.md`
context_ref: `UPGRADE.md`, `START.md`, `bin/spec-agents`, `docs/runbooks/installer-smoke.md`
evidence_ref: E-20260831-005

## Goal

Prove end to end that confirmed salvage and reset keep selected knowledge
recoverable while the resulting active project starts clean and inherits no old
execution state.

## Scope

- `tests/upgrade-reset-smoke.sh`
- disposable directories created by the test under the system temporary root

## Acceptance

- A fixture with retired doctrine, old lifecycle records, a candidate rule,
  current intent, and unrelated application files first produces a report-only
  reconnaissance result.
- Before confirmation, every fixture path except the report is byte-identical.
- Confirmed cutover proves exact path/type/hash recovery for every archived
  item, zero unresolved entries, and byte-identical application and
  `keep-active` files.
- Doctrine replacement removes stale doctrine entries, installs the current
  allowlist, and leaves all Instance hashes unchanged.
- The resulting START input is `modern`; no old status is recreated, the
  archive is not scanned by default, candidate knowledge is not silently
  enacted, and current intent is directed to a new plan/capture pass.
- Refusal cases cannot print a success completion report.

## Verification

- `bash -n tests/upgrade-reset-smoke.sh`.
- Run `tests/upgrade-reset-smoke.sh` from the repository root and require every
  named fixture assertion to execute rather than infer success from no output.
- Run `tests/doctrine-check.sh`, `spec-agents check-state`, Kernel checks, the
  installer smoke Runbook, Markdown reference checks, and `git diff --check`.

## Evidence

`do` added `tests/upgrade-reset-smoke.sh`. Its disposable fixture verifies the
prompt order and four dispositions, a report-only reconnaissance pass, exact
doctrine and retired-state manifests, unchanged application and `keep-active`
paths, no inherited lifecycle state, all five retired-marker families, and
refusal/failure recovery boundaries. The test reports eight named groups so a
silent early exit cannot be mistaken for coverage.

Pending `check` and `learn`; this Slice intentionally remains `doing` until
`learn` assigns the stable Evidence ID.
