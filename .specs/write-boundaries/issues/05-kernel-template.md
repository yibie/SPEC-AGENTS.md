# 05 Make the Kernel template match its definition

status: done
blocked_by: 01
writer: do
spec_ref: `.specs/write-boundaries/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-004`
## Goal

Give identity and lifecycle a home in the Kernel, and stop the merged heading
from suppressing two Action Contract fields.

## Scope

- `START.md`
- `README.md` (the Kernel description, both languages)

## Acceptance

- the template has eight sections: Concepts, Identities, Relations, Lifecycles,
  Action Contracts, Invariants, Architecture boundaries, Source evidence;
- each Action Contract carries precondition, input, permitted effect,
  invariant, and verification;
- an empty section is kept with a note that the scan found nothing confirmed,
  so a missing axis is visible rather than absent;
- a `start` rescan of an existing Kernel reports a missing Identities or
  Lifecycles section under the report's gaps and stops for the user;
- restructuring for format alone does not advance the Kernel version;
- no existing Kernel is required to change.

## Verification

The eight sections match the seven elements of the Project Kernel definition
plus Source evidence, one to one, with no element unhoused.
