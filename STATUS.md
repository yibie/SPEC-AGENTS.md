# STATUS

**Phase**: 15 — Project Knowledge Promotion

**Status**: Complete

## Goal

Extend the ontology/SPEC method beyond source code so development practices,
operational procedures, and implementation lessons can be captured, promoted,
scoped, and revised without enlarging the default context.

## Scope

- `CONTEXT.md`, `AGENTS.md`, `AGENTS_en.md`
- `README.md`, `EVIDENCE.md`, `ROADMAP.md`, `STATUS.md`
- `skills/plan/`, `skills/do/`, `skills/check/`, `skills/learn/`
- `docs/README.md`, `docs/protocols/`, `docs/runbooks/`, `docs/lessons/`

## Out of scope

- Application code and experiment sandboxes.
- Formal ontology infrastructure, graph storage, and automatic promotion.
- A real-project Runbook or coding-practice trial.

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
task022 [x] goal:<define project knowledge classes and routing> | scope:<CONTEXT.md, AGENTS.md, AGENTS_en.md, docs/> | verify:<knowledge classes + status/scope/applicability/source/verification contract>
task023 [x] goal:<promote one practice and one scoped lesson> | scope:<docs/protocols/knowledge-promotion.md, docs/lessons/dom-native-api-shadowing.md, EVIDENCE.md> | verify:<E-20260817-004 + link/format checks>
```

## Acceptance

- `CONTEXT.md` defines Knowledge Classes and their project-knowledge relations.
- Protocols, Runbooks, and Lessons have explicit destinations and promotion
  fields without becoming default context.
- One verified workflow practice and one scoped implementation Lesson are
  promoted with source Evidence and verification paths.
- Both language entry points and the four affected skills route knowledge by
  intent and preserve the `learn` writer boundary.
- No application or experiment sandbox changes.

## Blockers

None recorded. Keep the change limited to installer behavior, upgrade handoff,
and its user guidance.

## Previous phase result

Phase 14 established the Prompt-first v2/v3 upgrade boundary. Its evidence
remains historical in `EVIDENCE.md`; this phase extends the model without
changing that migration boundary.

## Current phase handoff

Phase 15 is closed. Evidence is recorded in `E-20260817-004`. The next permitted
action is one real-project Runbook and coding-practice routing trial; no
application code changes are implied.
