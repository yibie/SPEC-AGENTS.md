# 01 Define optional evidence link

status: done
blocked_by:
spec_ref: ../SPEC.md
context_ref: /CONTEXT.md
evidence_ref: E-20260816-002

## Goal

Define the optional Slice → Evidence relation and expose an empty
`evidence_ref` field in new issue templates.

## Scope

- `CONTEXT.md`
- `docs/protocols/evidence-links.md`
- `skills/arrange/SKILL.md`

## Acceptance

- The relation is explicitly optional and post-verification.
- Existing issue shapes remain valid without the field.
- Only `learn` is allowed to populate the field.

## Verification

Search the touched documents for the field and run all six skill validators.

## Evidence

Linked to `E-20260816-002` by `learn` after verification.
