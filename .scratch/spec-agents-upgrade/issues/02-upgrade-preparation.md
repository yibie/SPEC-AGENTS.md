# 02 Upgrade preparation

status: done
blocked_by: 01-installer-boundary
spec_ref: ../SPEC.md
context_ref: /CONTEXT.md
evidence_ref: E-20260816-007

## Goal

Upgrade v2 and v3 projects by detecting their source layout, archiving the
complete `.phrase` tree, installing the modern shell, and writing a migration
handoff without semantic guesswork.

## Scope

- `bin/spec-agents`

## Acceptance

- v2, v3, and mixed source fixtures are classified correctly.
- Archive paths identify the legacy generation and a timestamp.
- Existing `.phrase` material is preserved under `archive/` and no active
  `.phrase` tree remains.
- `MIGRATION.md` records source type, archive path, direct mappings, and manual
  review items.
- Existing modern state documents cause a safe refusal without moving source.

## Verification

Run v2/v3/mixed/conflict temporary-project fixtures and inspect archive and
handoff contents.

## Evidence

Pending `learn`.

## Verification summary

Temporary fixtures classified and upgraded v2, v3, and mixed `.phrase` trees;
each source tree was preserved under a timestamped generation-specific archive,
the active `.phrase` path disappeared, and `MIGRATION.md` recorded the source
classification and review mappings. Unknown input and existing modern state
both refused without moving source files. Link-mode upgrade also passed.
