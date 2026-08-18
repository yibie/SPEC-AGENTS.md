# 01 Modern and legacy installer modes

status: done
blocked_by:
spec_ref: ../SPEC.md
context_ref: /CONTEXT.md
evidence_ref: E-20260816-004

## Goal

Make modern root documents and six skills the default installer output, with an
explicit `--legacy` path for the old `.phrase` layout.

## Scope

- `bin/spec-agents`

## Acceptance

- Modern mode copies or links root docs, `docs/`, `archive/`, and `skills/`.
- Legacy mode keeps the existing `.phrase` and Claude command behavior.
- `--link` and source-repository refusal remain functional.

## Verification

Run `bash -n` and install both modes into disposable temporary directories.

## Verification summary

`bash -n bin/spec-agents` passed. Temporary assertions passed for modern copy,
legacy copy, modern link, legacy link, and source-repository refusal. The
modern install contains no `.phrase` tree; the legacy install retains the
`.phrase` files and Claude command shims.

## Evidence

Pending `learn`.
