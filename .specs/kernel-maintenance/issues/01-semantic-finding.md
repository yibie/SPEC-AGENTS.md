# 01 Add a finding type that routes to plan

status: done
blocked_by:
writer: do
spec_ref: `.specs/kernel-maintenance/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- `skills/check/SKILL.md`, `AGENTS.md`, `AGENTS_en.md`

## Acceptance

- `check` defines four finding types; each states where it routes;
- `blocker`, `required`, `suggestion` route to `do`; `semantic` routes to `plan`;
- the text states that `check` never decides whether the code or the Kernel is
  wrong, and says why — deciding it inside `check` bypasses the `plan` gate;
- a `semantic` finding names what was observed and which Kernel entry it bears
  on;
- `check` stays read-only.

## Verification

Read the output section against the `plan` gate stated in
`docs/spec-agents/WORKFLOW.md`: a Kernel conflict can now leave `check` toward
`plan`.
