# 01 Define Code and state the self-hosting case

status: done
blocked_by:
writer: do
spec_ref: `.specs/write-boundaries/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Give `Code` a definition so that "writing the product" and "promoting
knowledge" are distinguishable in a project whose product is documents.

## Scope

- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- `Code` is a Core Concept: the artifact constrained by SPEC, Kernel, and
  Action Contracts;
- the definition states the self-hosting case — in SPEC-AGENTS the doctrine
  documents and `bin/` are `Code`;
- it states what `Code` is not: knowledge about the product stays Instance
  knowledge and belongs to `learn`, in every project including this one;
- the four relations naming `Code` are unchanged;
- no other concept is added or redefined.

## Verification

Every relation naming `Code` resolves to the new definition; `grep` finds no
remaining use of `Code` that the definition does not cover.
