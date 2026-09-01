# 03 Prove the full confirmed Upgrade flow

status: done
blocked_by: 01, 02
authority: n/a — verification-only slice adds no product rule
spec_ref: `.specs/upgrade-cutover-gate/SPEC.md`
context_ref: `UPGRADE.md`, `START.md`, `bin/spec-agents`, `docs/runbooks/installer-smoke.md`
evidence_ref: E-20260831-009

## Goal

Turn the process-simulation findings into persistent end-to-end fixtures that
prove both the happy path and every newly executable refusal boundary.

## Scope

- `tests/upgrade-reset-smoke.sh`
- other narrowly named test files under `tests/` only if separating project-root
  discovery materially improves failure output
- disposable directories created by those tests under the system temporary root

## Acceptance

- The upgrade report uses every required section and manifest column, records
  one disposition per relevant path, and is byte/type/hash report-only before
  confirmation.
- User decision is filled before the confirmed snapshot and CUTOVER; snapshot,
  active report, and receipt hash agree at replacement time.
- Missing receipt and every malformed/mismatched receipt case in the SPEC refuse
  before backup; a deliberate direct-call bypass no longer reaches replacement.
- Valid replacement, exact retired-state reset, fresh START eligibility,
  candidate rejection/adoption, unchanged Instance/application paths, and
  recovery remain proved.
- Completion result is filled after fresh START, names actual paths/results and
  next route, and leaves no pending User decision or Completion result.
- The archived confirmed report stays equal to the receipt hash after the
  active report changes.
- Replacement output never claims project readiness; ordinary install still
  does. No failure prints either success claim.
- No-VCS modern and native-JJ workflow commands succeed from root and nested
  directories; partial/arbitrary roots refuse.

## Verification

- `bash -n` every changed test and installer script.
- Require every named assertion group to execute and the exact final count to
  match the implemented groups.
- Re-run installer Runbook, doctrine 400-line/pointer checks, Kernel-delta
  fixtures, `spec-agents check-state`, Kernel checks, installed Markdown
  references, and `git diff --check`.

## Evidence

`do` rewrote `tests/upgrade-reset-smoke.sh` as ten named assertion groups. The
main fixture now uses the complete preservation-table schema, proves REPORT is
the only pre-confirmation write, fills User decision before snapshot/CUTOVER,
tests every declared invalid-receipt seam against pre/post manifests, performs
the valid replacement and exact retired reset, simulates and accepts a modern
fresh START, then fills Completion result without changing the confirmed
snapshot. It proves one supported candidate enters the fresh K1, the legacy
candidate stays out, and current intent is handed to `plan` rather than
inherited as state.

The fixture also keeps the five retired-marker link replacements, broad/source/
existing-backup guards, post-backup failure recovery, ordinary-install
readiness, and the full workflow-root matrix. Replacement outputs never contain
project readiness; refusals/failures contain neither success claim. The final
line is exactly `upgrade reset smoke: 10/10`, and the count is asserted against
the groups actually executed.

Three initial failures corrected test boundaries rather than product code: the
Instance comparison first included the expected new doctrine-backup output,
then snapshotted CUTOVER before writing its final valid value; an absolute-path
`rg` search also failed to exclude the archive. The corrected fixture locks
only pre-existing Instance paths, snapshots after confirmed inputs are fixed,
and searches inherited state from the active project root. A retained passing
fixture is `spec-agents-upgrade-reset.tkV0sR`; subsequent clean runs also report
10/10.

`spec-agents-installer-smoke.QktGTE` passes repeated copy install, link install,
source/source-payload equality, absent Instance, executable Kernel checker,
leakage, relative Markdown links, and source-repository refusal. The Runbook's
link extractor needed the expected zero-match case isolated from `pipefail`;
the installed link result itself was empty and passing. Shell syntax, doctrine
400/400, Kernel-delta, workflow state, shipped Kernel, and whitespace checks
all pass.
