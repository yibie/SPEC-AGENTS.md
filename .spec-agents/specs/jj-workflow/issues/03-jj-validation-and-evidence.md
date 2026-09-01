# 03 Validate JJ workflow and record evidence

status: done
blocked_by:
spec_ref: `.spec-agents/specs/jj-workflow/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260817-006`

## Goal

Prove the documented JJ command surface in a disposable colocated repository,
run the existing installer/shell checks, and record the bounded result.

## Scope

- temporary repository under `/tmp`
- `EVIDENCE.md`
- `STATUS.md`
- `ROADMAP.md`

## Acceptance

- A temporary repository creates, describes, inspects, bookmarks, and recovers
  a JJ Change without touching this source repository.
- Existing static and installer checks pass.
- The current repository remains uninitialized for JJ.
- Evidence states the sample and limitations; no general superiority claim is
  made.

## Verification

The disposable colocated repository completed `jj status`, `jj describe`,
`jj log`, `jj diff`, `jj new`, `jj undo`, and bookmark creation. The installer
smoke, shell syntax, diff, link, metadata, and no-auto-init checks also passed.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
