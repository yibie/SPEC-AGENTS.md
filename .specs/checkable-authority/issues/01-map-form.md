# 01 Fix the map entry form and add the three states

status: done
blocked_by:
writer: do
authority: `START.md` — the Kernel template owns the Kernel's documented shape
spec_ref: `.specs/checkable-authority/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260825-010`
## Scope
- `START.md`, `docs/spec-agents/single-authority.md`

## Acceptance
- the entry form is one fixed line: rule, `authority:` path in backticks, then
  one of `owned` / `source-backed` / `derived`;
- each state is defined, and `derived` states plainly that it has no write path
  and that persisting it is the defect;
- the text says why `derived` must be explicit: a runtime protects derived state
  by absence, a prose map cannot, so absence there means nobody thought about it;
- the optional `second site:` line keeps its form;
- it is stated that this is a fixed line inside Markdown, not a schema, and the
  surrounding document gains no machine-required structure;
- the example contains no path from another project.

## Verification
The form in `START.md` and the form the checker parses are the same string.
