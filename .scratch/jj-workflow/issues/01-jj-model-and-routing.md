# 01 Define JJ model and agent routing

status: done
blocked_by:
spec_ref: `.scratch/jj-workflow/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260817-006`

## Goal

Make the JJ Change distinction, default local commands, Git bridge, and
no-auto-init boundary explicit to agents.

## Scope

- `CONTEXT.md`
- `AGENTS.md`
- `AGENTS_en.md`
- `skills/do/SKILL.md`
- `skills/check/SKILL.md`
- `skills/learn/SKILL.md`
- `UPGRADE.md`

## Acceptance

- The existing workflow `Change` concept is not renamed or conflated with JJ.
- JJ is the default local vocabulary when `.jj/` exists.
- Remote publication and Git-only fallback are explicit.
- No automatic repository initialization is instructed.

## Verification

The targeted model/routing reference scan passes; contradiction checks remain
part of the final `check` before `learn`.

## Evidence

Leave `evidence_ref` empty until `learn` records the final verification.
