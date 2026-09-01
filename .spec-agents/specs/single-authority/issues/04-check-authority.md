# 04 Add the authority check and the independence declaration

status: done
blocked_by: 01
writer: do
authority: `.spec-agents/doctrine/skills/check/SKILL.md` — check owns its axes
spec_ref: `.spec-agents/specs/single-authority/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- `skills/check/SKILL.md`

## Acceptance
- the contract axis gains a named authority check, not a fourth axis, with the
  reason stated;
- all three tells appear: a second site for a rule that already has one, a
  client reimplementing a server-enforced rule, derived state persisted twice;
- the check states that conformance to `KERNEL.md` does not detect duplication,
  and that the ontology-impact question answers "no" for a duplicate;
- `check` declares at the top whether it ran in the same context that executed
  `do`;
- in the same context, the authority check requires positive evidence: name the
  site, name the map entry, show they match;
- independence is not mandated, and the text says why.

## Verification
Walk the reported incident against the new check: at least one of the three
tells fires on each of the named violation classes.
