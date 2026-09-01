# 04 Give this repository its own checker

status: done
blocked_by: 01
writer: do
authority: `tests/doctrine-check.sh` — this repository's own verification
spec_ref: `.spec-agents/specs/checkable-authority/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260825-010`
## Scope
- new `tests/doctrine-check.sh`, `tests/README.md`

## Acceptance
- the mandatory read (`AGENTS.md` + `docs/spec-agents/WORKFLOW.md`) is at or
  under 400 lines;
- every `ADR NNNN` pointer in doctrine resolves to a file under `docs/adr/`;
- no live file cites a CHANGELOG version heading that does not exist;
- these are the three items `STATUS.md` has been carrying as depending on
  someone remembering;
- it is Instance, not shipped;
- `bash -n` passes and the script passes on the current repository.

## Verification
Padding the mandatory read past 400 lines makes it fail.
