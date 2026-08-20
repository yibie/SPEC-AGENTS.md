# 02 Install and document START.md

status: done
blocked_by:
spec_ref: `.specs/start-command/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260818-007`

## Goal

Make the Start entry discoverable in both language guides and ensure the
installer copies it without overwriting an existing project prompt.

## Scope

- `bin/spec-agents`
- `README.md`
- `UPGRADE.md`
- installer/runbook references as needed

## Acceptance

- Fresh init/install includes `START.md`.
- Repeat installation preserves an existing `START.md`.
- README and installer output explain `Read START.md and execute the start
  review.`
- No CLI path performs semantic migration.

## Verification

`START.md` is included in the installer and both language guides; final shell,
installer, and reference checks remain in `check`.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
