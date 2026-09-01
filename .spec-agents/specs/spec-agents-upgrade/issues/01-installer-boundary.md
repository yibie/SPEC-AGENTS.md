# 01 Installer boundary

status: done
blocked_by:
spec_ref: ../SPEC.md
context_ref: /CONTEXT.md
evidence_ref: E-20260816-006

## Goal

Make fresh installation modern-only and route old projects to the explicit
`upgrade` command.

## Scope

- `bin/spec-agents`

## Acceptance

- `init` and `install` accept `--link` but reject `--legacy`.
- `upgrade` is a recognized command with its own help entry.
- Fresh installs do not create `.phrase`.
- Source-repository refusal remains functional.

## Verification

Run `bash -n`, help assertions, modern install assertions, and explicit
`--legacy` rejection in a temporary target.

## Evidence

Pending `learn`.

## Verification summary

`bash -n bin/spec-agents` passed. Help exposes `upgrade` without advertising
`--legacy`; modern installation creates no `.phrase`; explicit `--legacy` is
rejected; and source-repository refusal remains active.
