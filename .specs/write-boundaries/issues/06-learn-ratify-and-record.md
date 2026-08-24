# 06 Ratify the three ADRs and record the decision

status: done
blocked_by: 05
writer: learn
spec_ref: `.specs/write-boundaries/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Correct the authorship of three ADRs written under the wrong contract, and
record this change.

## Scope

- `EVIDENCE.md`, new `docs/adr/0004-code-and-write-boundaries.md`
- `UPGRADE.md`, `CHANGELOG.md`, `STATUS.md`

## Acceptance

- ADR 0001, 0002, and 0003 are reviewed one at a time, each with its own line
  in Evidence stating ratified or rejected and why; a blanket approval is not
  acceptable;
- no ADR content is reverted — the decisions passed `plan` and `check`, only
  their authorship contract was wrong;
- ADR 0004 records this decision, the alternatives rejected in the `plan`
  round, and the consequences;
- `UPGRADE.md` gains a section that detects locally modified installed
  doctrine, reports it against the upstream copy, and hands the decision to the
  user without reverting anything;
- Evidence records the residual risk: the reference-integrity axis is a
  procedure with no automated enforcement.

## Verification

Three separate ratification lines exist; the `UPGRADE.md` section prescribes no
automatic revert; `STATUS.md` carries no closed section.
