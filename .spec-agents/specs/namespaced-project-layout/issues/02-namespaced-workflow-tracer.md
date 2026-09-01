# 02 Run the full workflow from namespaced paths

status: done
blocked_by: 01
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Instance, Start, Project Kernel, State, Evidence, SPEC, and Slice
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `AGENTS.md`, `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/skills/`, `.spec-agents/doctrine/docs/`, `.spec-agents/doctrine/bin/spec-agents`, `.spec-agents/specs/authority-order/SPEC.md`
evidence_ref: E-20260831-011

## Goal

Make a newly installed project execute Start and all six actions using only the
new canonical Instance and Doctrine paths, while carrying forward every
confirmed authority-order decision.

## Scope

- full Doctrine AGENTS contracts in both languages
- `START.md` and all six `skills/*/SKILL.md`
- `docs/spec-agents/` workflow docs, checker, Protocols, and Runbooks
- `bin/spec-agents` workflow commands, project-root detection, gates, state
  checks, transitions, and messages
- `README.md` current-layout and workflow usage
- focused workflow-root and state fixtures under `tests/`

## Acceptance

- Every mandatory read and write resolves the namespaced Doctrine, state,
  specs, scratch, and archive paths declared by the SPEC.
- Start writes only `.spec-agents/scratch/start/REPORT.md` before confirmation
  and creates `.spec-agents/state/KERNEL.md` only under the existing K1 gate.
- `status`, `ready`, `gate`, `transition`, and `check-state` discover
  `.spec-agents/state/` and `.spec-agents/specs/` from root and nested
  directories; they do not fall back to retired root paths.
- Complete no-VCS, Git, and native-JJ fixtures are recognised only when root
  integration resolves to complete namespaced Doctrine. Lone familiar paths
  refuse.
- The full Doctrine authority order places its own action skills immediately
  below the AGENTS contract; the authority-map Protocol carries `do`'s two
  cases; knowledge promotion permits workflow-model writes upstream only.
- No current instruction tells an agent to read a root `START.md`,
  `UPGRADE.md`, `KERNEL.md`, `STATUS.md`, `EVIDENCE.md`, or `.specs/` path.

## Verification

- Disposable K1, active SPEC, dependency, nested-root, no-VCS, Git, and
  native-JJ fixtures using the installed CLI path.
- `tests/doctrine-check.sh`, `tests/kernel-delta-check.sh`, focused workflow
  fixtures, Markdown reference resolution, mandatory-read line ceiling, and
  `git diff --check`.

## Evidence

Stale before execution. Independent check of Slice 01 proved that moving the
full Doctrine changes the resolution base of the same links, prose paths, and
CLI markers this Slice was meant to rewrite. Its complete Goal, Scope,
Acceptance, and Verification were absorbed into Slice 01 by SPEC revision 2;
no implementation or Evidence belongs to this stale record.
