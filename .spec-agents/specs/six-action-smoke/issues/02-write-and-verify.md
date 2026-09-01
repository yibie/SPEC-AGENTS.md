# 02 Wire evidence link writer

status: done
blocked_by: 01-model-and-template
spec_ref: ../SPEC.md
context_ref: /AGENTS.md
evidence_ref: E-20260816-003

## Goal

Make `learn` the only writer of `evidence_ref`, document the do/check handoff,
and prove the full compatible path remains discoverable and valid.

## Scope

- `AGENTS.md`
- `skills/check/SKILL.md`
- `skills/do/SKILL.md`
- `skills/learn/SKILL.md`

## Acceptance

- `do` leaves the field empty while work is in progress.
- `learn` appends the Evidence ID before writing it back to the issue.
- No other skill claims write ownership.

## Verification

Run all six validators, `npx skills list --json`, and a stale-writer search.

## Evidence

Linked to `E-20260816-003` by `learn` after verification.
