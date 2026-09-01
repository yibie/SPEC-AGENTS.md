# 02 Repoint the doctrine references

status: done
blocked_by: 01
spec_ref: `.spec-agents/specs/split-work-and-scratch/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-003`
## Goal

Point every reference at the correct one of the two directories, and keep the
name collision unambiguous in prose.

## Scope

- `AGENTS.md` (6), `AGENTS_en.md` (6), `START.md` (2), `UPGRADE.md` (2),
  `skills/capture/SKILL.md`, `skills/arrange/SKILL.md`, `README.md` (5)

## Acceptance

- SPEC and Slice paths point at `.specs/<feature>/`;
- `start/REPORT.md` and `upgrade-review/REPORT.md` still point at `.scratch/`;
- both Agent entry points carry an explicit contrast line between
  `docs/spec-agents/` and `.specs/`;
- no document says "spec-agents" without `docs/` or the leading dot;
- the two languages describe the same layout;
- `docs/adr/0002-retire-phase.md` is not rewritten — it is a historical record.

## Verification

Reference scan; the installed payload's relative links still resolve.
