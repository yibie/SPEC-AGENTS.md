# 02 Make ontology impact a required question

status: done
blocked_by: 01
writer: do
spec_ref: `.spec-agents/specs/kernel-maintenance/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- `skills/check/SKILL.md`, `AGENTS.md`, `AGENTS_en.md`

## Acceptance

- `check` answers in writing, on every run, whether the change added, altered,
  or retired a concept, identity, relation, lifecycle, invariant, or Action
  Contract;
- all six categories are named;
- a "no" is recorded rather than omitted, and the text says why — an
  unrecorded answer decays into silence;
- a "yes" produces a `semantic` finding;
- the question is stated as covering what the Kernel does *not* yet contain,
  not only what it does.

## Verification

The question names all six categories and appears in `check`'s completion
condition, not only in prose.
