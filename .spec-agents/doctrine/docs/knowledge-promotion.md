# Knowledge Promotion

status: active
scope: project knowledge routed through `.spec-agents/state/EVIDENCE.md` and the six actions
applies_when: a verified observation may become a reusable semantic rule, Protocol, Runbook, Lesson, or ADR
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260817-004`; the project knowledge promotion pilot
verification: each promoted record has status, scope, applicability, source Evidence, and a future check path; unverified observations remain in `.spec-agents/state/EVIDENCE.md`

## Purpose

Keep project knowledge broader than source code while preserving the same
Evidence → `learn` → `plan` → promotion → `check` discipline.

## Classes and destinations

| Class | Destination | Promotion question |
| --- | --- | --- |
| Project semantic rule | `.spec-agents/state/KERNEL.md` | Does this define a reusable project concept, identity, relation, lifecycle, or invariant? |
| Workflow semantic rule | `.spec-agents/doctrine/docs/WORKFLOW.md` | Does this define SPEC-AGENTS' own stable workflow vocabulary or invariant? |
| Project context | `CONTEXT.md` | Is this the project's own vocabulary, authority boundary, or orientation for a reader — not a framework rule? |
| Decision | `docs/adr/` | Is this a hard-to-reverse boundary or trade-off? |
| Protocol | `docs/protocols/` | Does this constrain repeatable development, review, testing, or collaboration? |
| Runbook | `docs/runbooks/` | Is this an operational procedure with preconditions, verification, and recovery? |
| Lesson | `docs/lessons/` | Is this a scoped, reusable warning derived from a verified failure or pattern? |

## Required record fields

Every promoted record names:

- `status`: `candidate`, `active`, `superseded`, or `rejected`;
- `scope`: the project area, action, SPEC, or environment where it applies;
- `applies_when`: the trigger that makes it relevant;
- `source`: the Evidence ID and supporting artifact or command;
- `verification`: how a future `check` can confirm or challenge it;
- `supersedes` or `contradicts`, when it replaces or conflicts with another
  record.

## Ownership and lifecycle

- `check` verifies that an observation is strong enough to enter `learn`.
- `learn` appends the Evidence record and is the only action that promotes or
  links durable knowledge after verification.
- In a managed project, `learn` never writes the installed Doctrine; only
  `learn` in the SPEC-AGENTS source repository may promote workflow semantics
  into the upstream Doctrine.
- `plan` confirms a promotion that changes the stable model, scope, identity,
  relation, invariant, protocol, or acceptance boundary.
- On the first `START` run only, an absent project `.spec-agents/state/KERNEL.md` may be created as
  `K1` from directly confirmed code, test, configuration, or existing-record
  facts. This bootstrap is not a promotion of inferred knowledge; later Kernel
  changes still require `plan`, verification, and `learn`.
- Future `check` reads only the records relevant to its intent and reports a
  stale, contradicted, or superseded rule instead of silently applying it.

The existing evidence-link practice is the first workflow example: `do` and
`check` leave `evidence_ref` empty, while `learn` writes the verified Evidence
ID back to the completed issue. See the evidence-links record in
`.spec-agents/doctrine/docs/`.
