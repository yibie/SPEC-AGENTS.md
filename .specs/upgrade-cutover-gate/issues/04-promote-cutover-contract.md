# 04 Record and close the executable cutover boundary

status: done
blocked_by: 03
writer: learn
authority: `docs/spec-agents/WORKFLOW.md` — Upgrade Boundary
spec_ref: `.specs/upgrade-cutover-gate/SPEC.md`
context_ref: `EVIDENCE.md`, `docs/adr/0010-upgrade-rebootstrap.md`, `docs/runbooks/installer-smoke.md`, `CHANGELOG.md`, `STATUS.md`
evidence_ref: E-20260831-010

## Goal

Promote the verified receipt-gated Upgrade contract, record its breaking CLI
migration and simulation limits, and close the SPEC without overstating what
disposable projects prove.

## Scope

- `EVIDENCE.md` — one append-only result
- `docs/adr/0012-upgrade-cutover-gate.md`
- `docs/runbooks/installer-smoke.md`
- `CHANGELOG.md` — Upgrade cutover-gate section
- `STATUS.md` — this feature's active section and count only
- `.specs/upgrade-cutover-gate/SPEC.md` — terminal status only
- `.specs/upgrade-cutover-gate/issues/01-enforce-cutover-receipt.md` — terminal fields only
- `.specs/upgrade-cutover-gate/issues/02-recognize-modern-project-roots.md` — terminal fields only
- `.specs/upgrade-cutover-gate/issues/03-prove-complete-upgrade-flow.md` — terminal fields only
- `.specs/upgrade-cutover-gate/issues/04-promote-cutover-contract.md` — terminal fields only

## Acceptance

- Evidence separates observations, interpretation, recommended next action,
  verification, simulation limits, and the fact that a receipt cannot prove
  human identity.
- ADR 0012 records the breaking receipt requirement and supersedes only the
  unguarded replace-doctrine invocation in ADR 0010; accepted historical
  records remain byte-identical.
- The installer Runbook contains receipt creation/validation, confirmed-report
  snapshot, replacement-only completion language, recovery/retry, no-VCS/JJ
  discovery, and final-report assertions.
- CHANGELOG gives the old-call migration and ordinary-install compatibility.
- The promoted Workflow entry equals the SPEC Model delta and cites this SPEC
  through Evidence/ADR.
- All four Slices are done with evidence references, the SPEC is verified, and
  this active section is removed from STATUS without disturbing
  `authority-order` or its reserved ADR 0011 scope.

## Verification

- Re-run every Slice verification from the final tree.
- Run `spec-agents check-state`, `spec-agents status`, doctrine/Kernel-delta
  checks, Kernel checks, fresh installed-reference checks, and
  `git diff --check`.
- Confirm ADR 0010 and every older accepted ADR mentioned by the new record are
  byte-identical to their pre-work hashes.

## Evidence

Pending `check` and `learn`.
