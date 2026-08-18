# 03 Upgrade verification

status: done
blocked_by: 02-upgrade-preparation
spec_ref: ../SPEC.md
context_ref: /CONTEXT.md
evidence_ref: E-20260816-008

## Goal

Verify the upgrade boundary and align user-facing guidance and phase evidence
with the removal of permanent legacy compatibility.

## Scope

- `AGENTS_en.md`
- `AGENTS.md`
- `README.md`
- `ROADMAP.md`
- `STATUS.md`
- `EVIDENCE.md`
- `.scratch/spec-agents-upgrade/`

## Acceptance

- No current documentation presents `--legacy` as a supported mode.
- v2/v3 upgrade instructions and the mechanical/semantic boundary are clear.
- v2, v3, mixed, conflict, source refusal, syntax, skill discovery, and
  whitespace checks pass.
- No application or experiment sandbox changes.

## Verification

Run the complete temporary fixture harness and all six skill validators, then
record Evidence IDs and close the phase gate.

## Evidence

Pending `learn`.

## Verification summary

Current guidance no longer presents `--legacy` as a supported path. The six
skill validators and discovery check passed; modern-only install, legacy
rejection, v2/v3/mixed upgrade, unknown/conflict refusal, source refusal, and
whitespace checks all passed. No experiment or application directory changed.
