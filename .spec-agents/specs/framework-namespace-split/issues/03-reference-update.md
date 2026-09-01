# 03 Update references and English documents

status: done
blocked_by: 01
spec_ref: `.spec-agents/specs/framework-namespace-split/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260820-001`
## Goal

Point every live reference at the new doctrine location and keep the Chinese
and English entry documents consistent.

## Scope

- `AGENTS.md`, `AGENTS_en.md`, `START.md`, `UPGRADE.md`, `README.md`
- `skills/{plan,capture,arrange,do,check,learn}/SKILL.md`
- `docs/spec-agents/knowledge-promotion.md`, `docs/lessons/README.md`
- `STATUS.md`, `ROADMAP.md`

## Acceptance

- the document authority order names `docs/spec-agents/WORKFLOW.md` for
  workflow semantics and keeps `CONTEXT.md` as project material;
- `learn` promotes workflow concepts to `docs/spec-agents/WORKFLOW.md` and
  project context to `CONTEXT.md` or `KERNEL.md`;
- no live file outside `archive/`, `research/`, `.phrase/`, and `.scratch/`
  treats root `CONTEXT.md` as the workflow model;
- English and Chinese entry documents describe the same layout.

## Verification

`grep -rn 'CONTEXT\.md'` over live files shows only project-context uses; the
installed-file lists in `README.md` and the installer output agree.
