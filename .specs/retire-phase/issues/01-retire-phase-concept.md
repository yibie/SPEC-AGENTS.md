# 01 Remove Phase from the workflow model

status: done
blocked_by:
spec_ref: `.specs/retire-phase/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

Remove `Phase` as a Core Concept and repair every definition and relation that
referenced it, without introducing a replacement concept.

## Scope

- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- the `Phase` Core Concept is gone;
- `State` records active SPECs, slices, blockers, and next permitted action;
- the relation reads `KnowledgeItem --applies_to--> Scope | Action`;
- the Knowledge Classes note no longer routes "phase direction" to `ROADMAP.md`;
- two invariants are added: parallel SPECs have non-overlapping scope, and
  simultaneous execution requires an isolated working copy;
- `SPEC` and `Slice` definitions are unchanged — no concept absorbs Phase's old
  job by widening its own definition.

## Verification

`grep -n "Phase\|阶段"` over the file returns only the Doctrine/Instance
sentence that names a repository's phase numbers as an example of leakage.
