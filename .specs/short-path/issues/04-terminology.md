# 04 Converge Slice and issue

status: done
blocked_by: 02
writer: do
spec_ref: `.specs/short-path/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260821-005`
## Goal

Stop the prose from naming the concept after its filename, now that the
preconditions are being rewritten anyway.

## Scope

- `skills/{plan,capture,arrange,do,check,learn}/SKILL.md`
- `AGENTS.md`, `AGENTS_en.md` where they name the concept

## Acceptance

- the concept is written `Slice` (or 切片) throughout;
- a file is referred to by its full path, `.specs/<feature>/issues/NN-<slug>.md`;
- the `issues/` directory is not renamed;
- `evidence_ref`, `spec_ref`, `context_ref`, and `writer:` field names are
  unchanged — they are frontmatter keys, not prose;
- no contract changes meaning as a side effect of the rewording.

## Verification

`grep -n "issue"` over `skills/` returns only full paths and frontmatter key
names; a diff review confirms no contract was altered while rewording.
