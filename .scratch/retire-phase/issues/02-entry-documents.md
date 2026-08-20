# 02 Repair the entry documents

status: done
blocked_by: 01
spec_ref: `.scratch/retire-phase/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

Replace the phase-and-task discipline in both Agent entry points and align the
README and Start prompt.

## Scope

- `AGENTS.md`, `AGENTS_en.md`, `START.md`, `README.md`

## Acceptance

- the "Phase and task discipline" section is replaced by a SPEC-and-slice
  discipline that states what `STATUS.md` may and may not contain;
- the default context block and the `STATUS.md` absence guard no longer name
  `ROADMAP.md`;
- the document authority order drops `ROADMAP.md` and renumbers cleanly;
- the `learn` description drops "a phase boundary" from its triggers;
- the `EVIDENCE.md` read rule no longer triggers on choosing or closing a phase;
- "without a new phase and evidence" in the safety section is restated without
  `Phase`;
- both languages describe the same model.

## Verification

Reference scan over the four files; the installed payload's relative links
still resolve.
