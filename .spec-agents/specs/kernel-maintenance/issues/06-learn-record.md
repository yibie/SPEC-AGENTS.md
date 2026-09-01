# 06 Record the decision and the lost rule

status: done
blocked_by: 05
writer: learn
spec_ref: `.spec-agents/specs/kernel-maintenance/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- new `docs/adr/0005-kernel-drift-detection.md`
- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance

- the ADR states that `check` is where ontology drift is detected and that
  `check` does not adjudicate, with the alternatives rejected in the `plan`
  round;
- it records why an in-file changelog was rejected against git;
- Evidence records that the provenance lifecycle rule was decided in a previous
  `plan` round and lost at `capture`, and names the missing completion
  condition — `capture` does not require the SPEC to cover every decision the
  round produced;
- Evidence records that this coverage gap is unaddressed and deferred to its own
  `plan`;
- `STATUS.md` carries no closed section.

## Verification

The Evidence entry names where the rule was lost and which completion condition
would have caught it.
