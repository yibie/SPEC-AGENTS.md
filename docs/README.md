# Project Knowledge

`docs/` stores durable project knowledge that is broader than the domain model
and the current feature SPEC. It is part of the repository's cognition, but it
is not all default context for every task.

## Knowledge classes

- `adr/` — decisions and hard-to-reverse trade-offs.
- `protocols/` — stable development, review, testing, and collaboration
  agreements.
- `runbooks/` — repeatable operational procedures with preconditions,
  verification, and rollback.
- `lessons/` — reusable experience distilled from a verified failure or a
  repeated pattern.

Raw observations remain in `EVIDENCE.md` until `learn` classifies and promotes
them. A knowledge record should state its scope, applicability, status, source
Evidence ID, and verification path. Do not load every class by default; route
to the relevant record from the current intent.
