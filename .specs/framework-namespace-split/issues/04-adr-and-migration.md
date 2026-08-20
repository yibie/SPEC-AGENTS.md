# 04 Record the decision and the migration path

status: done
blocked_by: 01
spec_ref: `.specs/framework-namespace-split/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-001`
## Goal

Record the breaking boundary and give an already-installed project a
user-confirmed migration path instead of a silent compatibility fallback.

## Scope

- new `docs/adr/0001-framework-namespace-split.md`
- `UPGRADE.md`
- `CHANGELOG.md`

## Acceptance

- the ADR states the decision, the three-way name collision that forced it, the
  rejected fallback alternative, and the consequences;
- `UPGRADE.md` gains a section that lets an Agent recognise the pre-split
  layout, separate framework leftovers from project files, and stop for user
  confirmation;
- the migration deletes nothing automatically and never assumes a root document
  belongs to the framework based on its name alone.

## Verification

The ADR and the `UPGRADE.md` section name the same file set as the installer
allowlist; a read-through confirms no automatic deletion is prescribed.
