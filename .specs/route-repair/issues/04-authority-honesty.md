# 04 State what authority guarantees, and check n/a

status: done
blocked_by: 01
writer: do
authority: `skills/arrange/SKILL.md` — arrange owns the field; `skills/check/SKILL.md` owns the check
spec_ref: `.specs/route-repair/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-009`
## Scope
- `skills/arrange/SKILL.md`, `skills/check/SKILL.md`

## Acceptance
- `arrange` states that a required field guarantees an answer, not a correct
  one, and that `n/a` still returns the classification to the slice author;
- the overclaiming purpose sentence is corrected, not deleted — the reason for
  requiring the field still stands;
- `check`'s placement item asks whether `n/a` was accurate against the diff;
- the text says why `check` is where this is caught: `check` reads the diff,
  `arrange` reads only intent.

## Verification
No sentence in `arrange` claims the field prevents misclassification.
