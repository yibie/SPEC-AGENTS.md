# 03 Cut an old root layout over to the namespace

status: done
blocked_by: 01
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Upgrade Boundary
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `.spec-agents/doctrine/UPGRADE.md`, `.spec-agents/doctrine/bin/spec-agents`, `tests/upgrade-reset-smoke.sh`, `docs/adr/0010-upgrade-rebootstrap.md`, `docs/adr/0012-upgrade-cutover-gate.md`
evidence_ref: E-20260831-011

## Goal

Make the confirmed salvage/reset/fresh-Start flow replace an old root layout
with the namespaced layout without treating either layout as a compatibility
runtime.

## Scope

- `UPGRADE.md`
- `START.md` — old-layout classification and post-cutover handoff only
- `bin/spec-agents` — `replace-doctrine`, cutover receipt, explicit old/new
  Doctrine manifests, failure recovery, and replacement messages
- `tests/upgrade-reset-smoke.sh`
- `docs/runbooks/installer-smoke.md` replacement and recovery sections
- `README.md` existing-project Upgrade instructions

## Acceptance

- Current root Doctrine and root/legacy Instance markers classify as
  `upgrade-needed`; they are never read as current after cutover.
- The existing six-row CUTOVER receipt remains a pre-write gate bound to the
  canonical target, backup, report hash, zero unresolved rows, and confirmed
  decision.
- Replacement backs up exact old/new Doctrine paths and only an exact generated
  root adapter; it never deletes `.spec-agents/` as a unit or edits a
  project-owned root `AGENTS.md`.
- Approved retired root state is recoverable under
  `.spec-agents/archive/`; no legacy execution status, Kernel, Evidence, SPEC,
  or Slice is inherited as current.
- Forced failure preserves a replayable Doctrine backup and leaves all Instance
  paths byte-identical.
- Successful replacement reports Doctrine completion, then a fresh namespaced
  Start creates the only current K1 and waits for user acceptance.

## Verification

- Rewrite the persistent Upgrade fixture for exact old-root → namespaced
  lifecycle coverage while retaining all current invalid-receipt, recovery,
  manifest, no-VCS, native-JJ, and completion assertions.
- Require numbered assertion count, syntax checks, pre/post Instance manifests,
  archive hash replay, no-dual-layout scan, and `git diff --check`.

## Evidence

Stale before execution. Parent regression after revision 2 proved that active
Start/archive paths and doctrine replacement already fail directly from Slice
01's canonical cutover. Its complete Goal, Scope, Acceptance, and Verification
were absorbed into Slice 01 by SPEC revision 3; no separate implementation or
Evidence belongs to this record.
