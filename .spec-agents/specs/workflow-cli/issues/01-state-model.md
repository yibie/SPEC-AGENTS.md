# 01 Read slice and SPEC state

status: done
blocked_by:
writer: do
authority: `.spec-agents/doctrine/bin/spec-agents` — the CLI owns state reading
spec_ref: `.spec-agents/specs/workflow-cli/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260826-011`
## Scope
- `bin/spec-agents`

## Acceptance
- reads a slice's frontmatter fields: `status`, `blocked_by`, `writer`,
  `authority`, `spec_ref`, `context_ref`, `evidence_ref`;
- reads a SPEC's `status` and enumerates its slices;
- tolerates a missing field without crashing, reporting it as absent;
- works from any directory inside the repository;
- adds no dependency beyond bash and coreutils.

## Verification
Reading every slice in `.specs/` produces one record per file with no parse error.
