# 01 Make do's map comparison conditional

status: done
blocked_by:
writer: do
authority: `.spec-agents/doctrine/skills/do/SKILL.md` — do owns its preconditions
spec_ref: `.spec-agents/specs/route-repair/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- `skills/do/SKILL.md`

## Acceptance
- with an authority map, `do` compares and stops when the site is absent;
- with no map, or no entry covering this rule, `do` records the intended site
  and emits a `semantic` finding to `plan` — it does not stop;
- the text states why: a missing map is a Kernel gap, and a hard stop makes
  conforming projects unable to move, which guarantees the rule is routed around;
- both execution paths are covered;
- `do` still never edits the map.

## Verification
A project with no `Architecture boundaries` section can complete `do` on both
paths.
