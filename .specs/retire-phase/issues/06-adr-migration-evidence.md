# 06 Record the decision, migration, and evidence

status: done
blocked_by: 02
spec_ref: `.specs/retire-phase/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

Record why Phase was retired, how a phase-shaped project converts, and what was
verified.

## Scope

- new `docs/adr/0002-retire-phase.md`
- `UPGRADE.md`, `CHANGELOG.md`, `EVIDENCE.md`

## Acceptance

- the ADR states the two-jobs diagnosis with the counts that support it, the
  rejected alternatives, and the consequences;
- `UPGRADE.md` gains a conversion section for a phase-shaped project that stops
  for user confirmation and deletes nothing automatically;
- `UPGRADE.md`'s own cutover step no longer rebuilds a phase or `ROADMAP.md`;
- legacy v2/v3 phase descriptions in `UPGRADE.md` stay, because they describe
  historical material rather than the current model;
- Evidence records the change and what remains unverified.

## Verification

The ADR, the `UPGRADE.md` section, and the SPEC name the same file set; no
automatic deletion is prescribed anywhere.
