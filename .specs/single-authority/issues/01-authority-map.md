# 01 Make Architecture boundaries the authority map

status: done
blocked_by:
writer: do
authority: `START.md` — the Kernel template owns the Kernel's documented shape
spec_ref: `.specs/single-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260824-008`
## Scope
- `START.md`, `README.md` (the Kernel description, both languages)

## Acceptance
- `Architecture boundaries` is defined as the authority map: for each rule that
  could live in more than one place, the one module that owns it;
- an entry names a path, not an aspiration;
- a legitimate second site is recorded as such with its reason;
- the section states that single authority constrains where a rule is decided,
  not what it decides — content stays revisable through `plan`;
- existing Kernels are not required to back-fill; a re-scan reports a missing or
  thin section as a gap;
- the example in the template contains no path from another project.

## Verification
The definition is specific enough that `do` can compare a target site against it
and get a yes or no.
