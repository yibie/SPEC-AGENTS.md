# STATUS

**Phase**: 14 — Prompt-first Project Upgrade

**Status**: Complete

## Goal

Replace mechanical installer-side migration with one user-confirmed
`UPGRADE.md` Prompt for projects using the v2 static SPEC or v3 `.phrase`
architecture.

## Scope

- `bin/spec-agents`
- `AGENTS.md`, `AGENTS_en.md`, `README.md`
- `CONTEXT.md`, `EVIDENCE.md`, `ROADMAP.md`, `STATUS.md`, `UPGRADE.md`
- `.scratch/upgrade-prompt/`

## Out of scope

- Application code and experiment sandboxes.
- Formal ontology infrastructure.
- Rewriting the historical protocol-cost benchmark.

## Completed tasks

```text
task013 [x] goal:<classify and execute a no-semantic-change edit> | scope:<skills/check/SKILL.md> | verify:<plan no-change/approve + quick_validate + check>
task014 [x] goal:<add optional evidence_ref traceability> | scope:<CONTEXT.md, AGENTS.md, skills/, docs/protocols/, .scratch/six-action-smoke/> | verify:<SPEC + two slices + static validation>
task015 [x] goal:<record smoke evidence and phase result> | scope:<EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<learn entry + acceptance gate>
task016 [x] goal:<modernize installer with legacy escape hatch> | scope:<bin/spec-agents, AGENTS_en.md, README.md> | verify:<modern and legacy temp installs>
task017 [x] goal:<record installer evidence and phase result> | scope:<EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<learn entry + acceptance gate>
task018 [x] goal:<remove permanent legacy mode> | scope:<bin/spec-agents> | verify:<modern install + --legacy rejection + upgrade help>
task019 [x] goal:<prepare v2/v3 upgrade path> | scope:<bin/spec-agents> | verify:<v2/v3/mixed/conflict fixtures>
task020 [x] goal:<record upgrade verification and phase result> | scope:<AGENTS.md, AGENTS_en.md, README.md, CONTEXT.md, EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<full upgrade harness>
task021 [x] goal:<replace mechanical migration with upgrade Prompt> | scope:<UPGRADE.md, bin/spec-agents, AGENTS.md, AGENTS_en.md, README.md, CONTEXT.md> | verify:<prompt content + modern install + legacy pointer>
```

## Acceptance

- Modern installation is the only fresh-install path.
- `UPGRADE.md` handles v2 and v3 source layouts with user confirmation.
- The installer never moves, deletes, archives, or summarizes old material.
- English guidance and README point legacy projects to the Prompt.

## Blockers

None recorded. Keep the change limited to installer behavior, upgrade handoff,
and its user guidance.

## Previous phase result

Phase 13 tested a mechanical upgrade CLI. Phase 14 supersedes it with a
user-confirmed Prompt; the earlier evidence remains historical in
`EVIDENCE.md`.

## Current phase handoff

Phase 14 is closed. Evidence is recorded in `E-20260817-001`. The next permitted
action is one real-project Prompt run; no application code changes are implied.
