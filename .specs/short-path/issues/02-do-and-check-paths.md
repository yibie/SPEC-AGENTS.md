# 02 Branch do and check on the path

status: done
blocked_by: 01
writer: do
spec_ref: `.specs/short-path/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-005`
## Goal

Stop `do` and `check` from demanding a file the short path never creates.

## Scope

- `skills/do/SKILL.md`, `skills/check/SKILL.md`

## Acceptance

- `do` states preconditions for both paths; the SPEC path keeps the existing
  slice checks unchanged;
- `do`'s short path confirms `approve`, the unchanged contract, the acceptance
  sentence, and that the work is still single-context;
- `do` creates no slice on the short path, and returns to `plan` if the work
  stops being single-context;
- `check`'s comparison baseline branches the same way;
- on the short path `check`'s contract axis compares against the acceptance
  sentence plus `KERNEL.md`, Protocol, and `AGENTS.md`;
- all three `check` axes still run on both paths.

## Verification

Walk the short path end to end on paper: every precondition of `do` and `check`
is satisfiable without a SPEC or a slice.
