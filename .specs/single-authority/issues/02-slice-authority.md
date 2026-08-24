# 02 Require authority on every slice

status: done
blocked_by: 01
writer: do
authority: `skills/arrange/SKILL.md` — arrange owns the slice shape
spec_ref: `.specs/single-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- `skills/arrange/SKILL.md`, `AGENTS.md`, `AGENTS_en.md`

## Acceptance
- the slice template carries `authority:` as a required field;
- a slice that neither introduces nor modifies a business rule writes
  `n/a: <reason>`; an omitted field is not a valid answer;
- the rule states why it is required rather than conditional — a conditional
  field returns the "is this a business rule?" judgment to the slice author,
  which is the judgment that failed;
- `arrange`'s completion condition includes it;
- closed slices are not back-filled;
- `AGENTS.md`'s slice shape lists the field without restating the reasoning.

## Verification
Every slice of this SPEC carries `authority:`, including this one.
