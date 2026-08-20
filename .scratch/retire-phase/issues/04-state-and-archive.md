# 04 Rebuild STATUS.md and archive the phase history

status: done
blocked_by: 01
spec_ref: `.scratch/retire-phase/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

Make this repository's own state match the new contract, and preserve the
retired history without leaving it in default context.

## Scope

- `STATUS.md`, `ROADMAP.md`, `archive/`

## Acceptance

- `ROADMAP.md` is removed from the repository root and preserved under
  `archive/` with a header explaining why it was retired;
- the closed phase sections of `STATUS.md` are preserved in the same archive
  record;
- `STATUS.md` contains no phase, no closed section, and no `taskNNN`;
- `STATUS.md` states plainly that no SPEC is active if none is;
- no history is deleted.

## Verification

`grep -c "task[0-9]" STATUS.md` returns 0; `archive/` contains the retired
material; `git status` shows a rename or an addition, not a deletion of content.
