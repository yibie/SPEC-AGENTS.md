# 05 Publish the parallel-work Protocol

status: done
blocked_by: 01
spec_ref: `.specs/retire-phase/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-002`
## Goal

State when parallel SPECs are allowed and when an isolated working copy is
required, for both JJ and Git-only projects.

## Scope

- new `docs/spec-agents/parallel-work.md`
- `docs/spec-agents/README.md`, `AGENTS.md`, `AGENTS_en.md` pointers

## Acceptance

- the Protocol has `status`, `scope`, `applies_when`, `owner`, source Evidence,
  and `verification`;
- it separates scope conflict from execution interference and says isolation
  does not fix the first;
- it gives `jj workspace add|list|forget|update-stale` for a project with
  `.jj/` and `git worktree add|list|remove` otherwise;
- it states that serial switching in JJ needs no isolation, because there is no
  staging area and the working copy is snapshotted;
- it never instructs an agent to initialize JJ or push;
- it contains no marker that would fail the installer leakage assertion.

## Verification

Metadata check, installer smoke including leakage, and confirmation that the
JJ subcommands exist in the installed `jj`.
