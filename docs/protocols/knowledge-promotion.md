# Knowledge Promotion

## Purpose

Keep project knowledge broader than source code while preserving the same
Evidence → `learn` → `plan` → promotion → `check` discipline.

## Classes and destinations

| Class | Destination | Promotion question |
| --- | --- | --- |
| Semantic rule | `CONTEXT.md` | Does this define a reusable concept, identity, relation, lifecycle, or invariant? |
| Decision | `docs/adr/` | Is this a hard-to-reverse boundary or trade-off? |
| Protocol | `docs/protocols/` | Does this constrain repeatable development, review, testing, or collaboration? |
| Runbook | `docs/runbooks/` | Is this an operational procedure with preconditions, verification, and recovery? |
| Lesson | `docs/lessons/` | Is this a scoped, reusable warning derived from a verified failure or pattern? |

## Required record fields

Every promoted record names:

- `status`: `candidate`, `active`, `superseded`, or `rejected`;
- `scope`: the project area, action, phase, or environment where it applies;
- `applies_when`: the trigger that makes it relevant;
- `source`: the Evidence ID and supporting artifact or command;
- `verification`: how a future `check` can confirm or challenge it;
- `supersedes` or `contradicts`, when it replaces or conflicts with another
  record.

## Ownership and lifecycle

- `check` verifies that an observation is strong enough to enter `learn`.
- `learn` appends the Evidence record and is the only action that promotes or
  links durable knowledge after verification.
- `plan` confirms a promotion that changes the stable model, scope, identity,
  relation, invariant, protocol, or acceptance boundary.
- Future `check` reads only the records relevant to its intent and reports a
  stale, contradicted, or superseded rule instead of silently applying it.

The existing evidence-link practice is the first workflow example: `do` and
`check` leave `evidence_ref` empty, while `learn` writes the verified Evidence
ID back to the completed issue. See `E-20260816-003`.
