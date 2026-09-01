# 02 Write the doctrine checker

status: done
blocked_by: 01
writer: do
authority: `.spec-agents/doctrine/docs/check-kernel.sh` — new doctrine executable
spec_ref: `.spec-agents/specs/checkable-authority/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260825-010`
## Scope
- new `docs/spec-agents/check-kernel.sh`

## Acceptance
- fails on: a malformed entry line, an authority path that does not exist, a
  `derived` entry carrying a `second site:`, a `second site:` whose equivalence
  test path does not exist;
- exits 0 with a notice when `KERNEL.md` is absent or has no
  `Architecture boundaries` section;
- prints the offending line and file for every failure;
- states in its own header that it checks form, not completeness or truth;
- contains no marker that fails the installer leakage assertion;
- `bash -n` passes.

## Verification
Each failure mode is proven with a temporary fixture, not asserted.
