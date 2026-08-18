# Evidence Links

## Contract

An issue may carry one optional `evidence_ref` after its verification has been
recorded. The value is a stable Evidence ID such as `E-20260816-001`.

## Ownership

- `arrange` creates the field empty in new issue templates.
- `do` leaves it empty while work is in progress and returns verification facts.
- `check` confirms that the facts are sufficient for a durable evidence entry.
- `learn` appends the Evidence ID to `EVIDENCE.md`, then writes the same ID back
  to the issue.

## Compatibility

The field is optional. Historical issues and issues that do not need a durable
entry remain valid without it. No application data or runtime contract changes.
