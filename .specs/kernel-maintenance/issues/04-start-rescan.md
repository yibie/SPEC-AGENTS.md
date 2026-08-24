# 04 Make start re-runnable as a read-only re-scan

status: done
blocked_by: 03
writer: do
spec_ref: `.specs/kernel-maintenance/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-006`
## Scope

- `START.md`, `docs/spec-agents/WORKFLOW.md` (the `KernelStatus` concept)

## Acceptance

- `start` may run again on a project that already has a Kernel;
- on that run it writes only `.scratch/start/REPORT.md`; `KERNEL.md` is
  byte-identical afterwards, including its provenance;
- it produces a `KernelStatus` of `present`, `stale`, or `contradicted`;
- the difference report lists entries the scan no longer supports, entries the
  code has that the Kernel lacks, and entries with missing provenance;
- the user decides what routes to `plan`; the re-scan routes nothing itself;
- `KernelStatus` in `docs/spec-agents/WORKFLOW.md` names the re-scan as what
  produces `stale` and `contradicted`.

## Verification

`START.md`'s write boundary lists exactly one file for the re-scan path.
