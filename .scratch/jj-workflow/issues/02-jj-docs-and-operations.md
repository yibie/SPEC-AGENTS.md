# 02 Publish JJ Protocol, Runbook, and guide updates

status: done
blocked_by:
spec_ref: `.scratch/jj-workflow/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260817-006`

## Goal

Give humans and agents a recognizable Protocol and an explicit setup/recovery
Runbook, and update both language entry points and README/upgrade guidance.

## Scope

- `docs/protocols/jj-change-management.md`
- `docs/runbooks/jj-project-setup.md`
- `docs/protocols/shell-change-validation.md`
- `docs/runbooks/installer-smoke.md`
- `README.md`
- `UPGRADE.md`

## Acceptance

- Protocol metadata includes status, scope, applicability, source, and
  verification.
- Runbook does not initialize a project without an explicit user choice.
- README explains the JJ/Git boundary without requiring a JJ server.
- Existing shell and installer guidance remains runnable in Git-only projects.

## Verification

The Protocol, Runbook, README, upgrade, shell, and installer guidance are
written; final reference and temporary-directory checks remain in `check`.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
