# 03 Record the decision, migration, and evidence

status: done
blocked_by: 02
spec_ref: `.spec-agents/specs/split-work-and-scratch/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-003`
## Goal

Record why the split happened, how an existing project converts, and what was
verified.

## Scope

- new `docs/adr/0003-split-work-and-scratch.md`
- `UPGRADE.md`, `CHANGELOG.md`, `EVIDENCE.md`, `.gitignore`

## Acceptance

- the ADR states the lifetime mismatch with counts, the accepted name
  collision and its mitigation, and the rejected `.specs/` alternative;
- `UPGRADE.md` gains a section that recognises `.scratch/<feature>/SPEC.md`,
  proposes the move, stops for user confirmation, and deletes nothing;
- neither the ADR nor `UPGRADE.md` instructs anyone to write a project's
  `.gitignore`;
- this repository's own `.gitignore` ignores `.scratch/`;
- Evidence records the change and the residual risk of the name collision.

## Verification

The ADR, the `UPGRADE.md` section, and the SPEC name the same paths; no
automatic deletion or `.gitignore` write is prescribed.
