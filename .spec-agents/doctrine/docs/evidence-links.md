# Evidence Links

status: active
scope: newly arranged SPEC slices that need a post-verification Evidence link
applies_when: a Slice is completed and `learn` has a verified Evidence ID to attach
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260816-003`; the evidence-link writer smoke pass
verification: confirm `arrange` creates an empty field, `do` and `check` leave it empty, and only `learn` writes a stable Evidence ID

## Contract

An issue may carry one optional `evidence_ref` after its verification has been
recorded. The value is a stable Evidence ID in this project's own `.spec-agents/state/EVIDENCE.md`, in the
form `E-YYYYMMDD-NNN`.

## Ownership

- `arrange` creates the field empty in new issue templates.
- `do` leaves it empty while work is in progress and returns verification facts.
- `check` confirms that the facts are sufficient for a durable evidence entry.
- `learn` appends the Evidence ID to `.spec-agents/state/EVIDENCE.md`, then writes the same ID back
  to the issue.

## Compatibility

The field is optional. Historical issues and issues that do not need a durable
entry remain valid without it. No application data or runtime contract changes.
