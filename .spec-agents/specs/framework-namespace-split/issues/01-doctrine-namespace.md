# 01 Create the doctrine namespace

status: done
blocked_by:
spec_ref: `.spec-agents/specs/framework-namespace-split/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-001`
## Goal

Give framework doctrine a single directory so a managed project's own document
names and knowledge classes stay free.

## Scope

- new `docs/spec-agents/`
- `CONTEXT.md` → `docs/spec-agents/WORKFLOW.md`
- `docs/protocols/{evidence-links,knowledge-promotion,jj-change-management}.md`
  → `docs/spec-agents/`
- `docs/runbooks/jj-project-setup.md` → `docs/spec-agents/`
- new `templates/CONTEXT.md`

## Acceptance

- the workflow model's content is unchanged by the move;
- `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/` keep only this
  repository's own records;
- relative links inside the moved records still resolve;
- `templates/CONTEXT.md` is an empty project skeleton naming no phase, task, or
  Evidence ID of this repository.

## Verification

`grep` finds no unresolved relative link in `docs/spec-agents/`; a diff of the
moved workflow model against the old `CONTEXT.md` shows only the heading and
self-reference lines required by the new location.
