# 03 Give each Kernel entry its provenance

status: done
blocked_by: 01
writer: do
spec_ref: `.spec-agents/specs/kernel-maintenance/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- `START.md`, `README.md` (the Kernel description, both languages)

## Acceptance

- each enacted entry carries `since:` and `source:`;
- `since:` is a pointer into the file's version sequence, not a second counter,
  and the text says so;
- no per-item version number and no in-file changelog, with the reason stated:
  git already gives per-line history, and `source:` carries what git cannot —
  which decision admitted the entry;
- a revision that only re-anchors `source` leaves every `since:` unchanged;
- existing Kernels are not required to back-fill; missing provenance is a gap
  for the re-scan to report.

## Verification

The template shows one entry with both fields; no text implies a second version
axis.
