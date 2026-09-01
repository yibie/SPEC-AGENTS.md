# 01 Require the confirmed cutover receipt

status: done
blocked_by:
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Upgrade Boundary
spec_ref: `.spec-agents/specs/upgrade-cutover-gate/SPEC.md`
context_ref: `.spec-agents/doctrine/UPGRADE.md`, `.spec-agents/doctrine/bin/spec-agents`, `docs/adr/0010-upgrade-rebootstrap.md`
evidence_ref: E-20260831-007

## Goal

Make user-confirmed, zero-unresolved Upgrade state a pre-write input to doctrine
replacement and report only doctrine completion until fresh START is accepted.

## Scope

- `UPGRADE.md`
- `docs/spec-agents/WORKFLOW.md`
- `bin/spec-agents` — replace-doctrine parsing, validation, and output only
- `README.md` — live replace-doctrine syntax and existing-project guidance

## Acceptance

- UPGRADE's overview and numbered steps use the same order: report, exact user
  confirmation, immutable confirmed-report snapshot plus CUTOVER v1, doctrine
  replacement, retired-state reset, fresh START, Completion result.
- CUTOVER has exactly the six confirmed fields declared in the SPEC and is
  written only after confirmation; the report remains the only
  pre-confirmation write.
- `replace-doctrine` requires `--cutover` and verifies its canonical location,
  exact field set, format, target, backup, report hash, zero unresolved count,
  and confirmed decision before creating the backup path.
- Any invalid receipt refuses without changing the target or backup parent.
- Valid copy/link replacement retains the existing doctrine-only allowlist,
  backup manifest, Instance invariants, guards, and recovery behaviour.
- Replacement success says doctrine replacement completed and the Upgrade must
  continue. It never says the project or Spec-AGENTS is ready. Ordinary install
  retains its ready message.
- Workflow's enacted Upgrade Boundary equals the SPEC Model delta after
  whitespace normalisation, without exceeding the mandatory-read ceiling.

## Verification

- Static assertions for UPGRADE order, receipt shape, command syntax, and the
  absence of replacement-ready language.
- Disposable missing/valid receipt plus target/backup/hash/unresolved/decision
  mismatch probes; require refusals before backup exists.
- Re-run existing copy/link, broad/source target, stale doctrine, Instance hash,
  forced failure, restore, syntax, doctrine, Kernel-delta, state, reference, and
  whitespace checks.

## Evidence

`do` implemented the confirmed-cutover boundary in `UPGRADE.md`,
`docs/spec-agents/WORKFLOW.md`, `bin/spec-agents`, and the live README guidance.
The CLI now parses exactly one `--cutover`, validates the six-row receipt and
current report before its backup phase, and separates doctrine completion from
ordinary install readiness.

Disposable probes at `spec-agents-cutover.fT8ExN` exercised missing receipt,
target/backup/hash/unresolved/decision mismatch, duplicate and unknown rows,
changed report, valid copy and link replacement, Instance preservation, and
ordinary install output. `spec-agents-cutover-failure.0BRxjQ` exercised a
post-backup failure plus source/root guards; it retained a replayable doctrine
backup and printed no success. `bash -n`, doctrine 400/400, Kernel-delta,
`check-state`, Model-delta equality, Upgrade-order, and whitespace checks pass.
The first same-context check returned one required output fix: replacement was
still printing ordinary-install advice to delete a `CONTEXT.md` skeleton even
though replacement never creates one. `do` isolated that advice to ordinary
install and added regular non-symlink checks for the receipt and report.
`spec-agents-cutover-symlink.93O2k3` verifies both link refusals happen before
backup and that successful replacement gives no CONTEXT deletion advice.
The second contract pass found that ordinary install would silently ignore a
`--cutover` option. The parser now rejects it outside `replace-doctrine`;
`spec-agents-cutover-option.5IToru` proves init/install refuse without creating
the target while an ordinary valid install retains its ready result.

The existing persistent upgrade fixture now reaches and correctly refuses its
first old no-receipt invocation. Its receipt-aware, full-lifecycle rewrite is
explicitly owned by blocked Slice 03; no test exception or compatibility bypass
was added here.
