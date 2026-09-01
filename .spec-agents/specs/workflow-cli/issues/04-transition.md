# 04 transition

status: done
blocked_by: 02
writer: do
authority: `.spec-agents/doctrine/bin/spec-agents` — the CLI owns state changes
spec_ref: `.spec-agents/specs/workflow-cli/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- `bin/spec-agents`

## Acceptance
- `transition <slice> <state>` edits the frontmatter field in place;
- `done` is refused without `evidence_ref`;
- `doing` is refused while a `blocked_by` is unfinished;
- an unknown state is refused with the valid set;
- the file is otherwise byte-identical — only the status line changes;
- `--reason` is required for `stale`, and recorded in the file.

## Verification
Each refusal proven with a fixture; a successful transition produces a one-line
diff.
