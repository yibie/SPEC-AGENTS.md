# 01 Define Start concept and Prompt routing

status: done
blocked_by:
spec_ref: `.scratch/start-command/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260818-007`

## Goal

Make `Start`, `ProjectState`, and `StartReport` explicit without adding a
seventh action or duplicating legacy migration.

## Scope

- `CONTEXT.md`
- `AGENTS.md`
- `AGENTS_en.md`
- `START.md`

## Acceptance

- `start` routes modern, legacy/mixed, and missing-entry projects distinctly.
- The report is written before confirmation; root documents and code are not.
- Confirmed modern projects hand off to `plan`, not `do`.
- Existing `UPGRADE.md` remains the only legacy cutover prompt.

## Verification

The Start concept, lifecycle, route matrix, and confirmation boundary are now
defined in the stable model and Prompt; final static checks remain in `check`.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
