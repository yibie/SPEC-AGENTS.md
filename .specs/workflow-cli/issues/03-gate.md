# 03 gate

status: done
blocked_by: 02
writer: do
authority: `bin/spec-agents` — the CLI owns the gates
spec_ref: `.specs/workflow-cli/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- `bin/spec-agents`

## Acceptance
- `gate do <slice>` refuses when the slice is not `ready`/`doing`, a
  `blocked_by` is unfinished, `writer:` is not `do`, or `authority:` is absent;
- `gate capture` and `gate arrange` refuse without a confirmed plan outcome or
  SPEC respectively;
- every refusal names the precondition and where it is stated;
- on success it prints which skill to read and nothing else — no prose from the
  skill is reproduced;
- `gate` never modifies a file.

## Verification
Each refusal is proven against a fixture; the success path's output is compared
against `skills/do/SKILL.md` to confirm no duplication.
