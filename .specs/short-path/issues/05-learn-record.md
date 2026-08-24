# 05 Record the repair

status: done
blocked_by: 04
writer: learn
spec_ref: `.specs/short-path/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-005`
## Goal

Record why a documented route was unexecutable and what it implies.

## Scope

- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance

- Evidence records the specific unsatisfiable preconditions, not a summary;
- it records the failure mode this invited — inventing a slice for a small
  change, which manufactures the artifact the doctrine resists;
- it records the class: a contract written for one path and assumed universal,
  the same class as the five defects recorded in `E-20260820-004`;
- no ADR is written — this repairs a contract to match the documented model
  rather than deciding anything new;
- `STATUS.md` carries no closed section.

## Verification

The Evidence entry names the three preconditions verbatim and the file they are
in.
