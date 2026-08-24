# 03 Make do compare against the map before writing

status: done
blocked_by: 02
writer: do
authority: `skills/do/SKILL.md` — do owns its own preconditions
spec_ref: `.specs/single-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- `skills/do/SKILL.md`

## Acceptance
- before executing, `do` compares the slice's `authority:` against the Kernel's
  authority map;
- a site not on the map stops execution and returns to `plan`, with the reason
  stated: either the map is incomplete or the site is wrong, and neither is
  `do`'s call;
- the precondition applies on both paths, with the short path comparing against
  the map even without a slice;
- `do` never edits the map itself.

## Verification
The precondition appears in `do`'s 开始前 section for both paths.
