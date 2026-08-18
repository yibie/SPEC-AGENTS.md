# 02 Modern installation guidance

status: done
blocked_by: 01-modern-and-legacy-mode
spec_ref: ../SPEC.md
context_ref: /AGENTS.md
evidence_ref: E-20260816-005

## Goal

Make English agent guidance and README installation instructions describe the
modern default and the explicit legacy option.

## Scope

- `AGENTS_en.md`
- `README.md`

## Acceptance

- English guidance reads root documents and routes through six actions.
- README shows modern files and documents `--legacy`.
- Historical v3 benchmark notes are clearly historical, not default behavior.

## Verification

Search user-facing docs for contradictory default `.phrase` instructions.

## Verification summary

`AGENTS_en.md` now mirrors the root-document and six-action contracts. README
describes the modern installer and explicit `--legacy` escape hatch; the
historical v3 `.phrase` notes are labeled as historical. Guidance consistency
checks and `git diff --check` passed.

## Evidence

Pending `learn`.
