# SPEC-AGENTS: evidence-calibrated agent workflow

先识别意图，再读取最小上下文；先验证，再执行；只保留会影响未来判断的知识。

## Default context

For every task, read:

```text
AGENTS.md
.spec-agents/doctrine/docs/WORKFLOW.md
.spec-agents/state/STATUS.md
```

Who owns what:

| Path | Owner | Written by |
| --- | --- | --- |
| `AGENTS.md` (root adapter), `.spec-agents/doctrine/` | SPEC-AGENTS doctrine | installer-owned; no action writes it in a managed project (ADR 0001) |
| `.spec-agents/specs/<feature>/` | the project | `capture` writes the SPEC and `arrange` its slices; on a revision `capture` also marks affected slices `stale`. `do` writes a slice's verification summary and leaves it `doing`; `learn` closes it with `evidence_ref` and `done`, and marks the SPEC `verified`. Durable, kept after the work closes (ADR 0003) |
| `.spec-agents/scratch/` | the project | one-shot reports awaiting confirmation; consider ignoring it in version control (ADR 0003) |
| `.spec-agents/state/KERNEL.md`, `CONTEXT.md`, `.spec-agents/state/EVIDENCE.md`, `docs/{adr,protocols,runbooks,lessons}/` | the project | `learn` only, except that the first `START.md` scan may create `.spec-agents/state/KERNEL.md` at `K1` from confirmed facts (ADR 0004) |
| `.spec-agents/state/STATUS.md` | the project | `learn`; `plan` may add one entry when the work will outlive the current context, and `learn` removes it (ADR 0004) |
| everything else | the project | `do` — it is the project's `Code` (ADR 0004) |

In the SPEC-AGENTS repository itself the doctrine files are the product, so
they are its `Code` and `do` writes them there.

`.spec-agents/state/STATUS.md` absent means no work is recorded yet, not a file to reconstruct.

Read `.spec-agents/state/KERNEL.md` when it exists — the project's stable semantic model, distinct from `.spec-agents/doctrine/docs/WORKFLOW.md`, which is the workflow model. A
project without one runs `.spec-agents/doctrine/START.md` before application changes.

Read `CONTEXT.md` when it exists — the project's own vocabulary, never written
by the framework. If the project orients somewhere else, such as
`docs/HANDOFF.md`, follow that and do not maintain two.

Read `.spec-agents/state/EVIDENCE.md` when choosing what to work on next, checking a failed assumption, classifying a blocker, or deciding whether a SPEC can close. Read a record under `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, or
`docs/lessons/` when the intent points at it. Read `.spec-agents/archive/` and the legacy
`.phrase/` tree only for explicit history or regression comparison.

If active retired markers exist — `.phrase/`, old bundles, phase-shaped records,
or tracked scratch SPECs — read current upstream `.spec-agents/doctrine/UPGRADE.md` first.

## Start entry

On `start`, `/start`, or a request to onboard or adapt a project, read `.spec-agents/doctrine/START.md` and execute it. It is a bootstrap entry, not a seventh action, and it
is re-runnable as a read-only re-scan. Procedure, routing table, Kernel
template, and write boundary are all in `.spec-agents/doctrine/START.md`.

## Version-control layer

When `.jj/` exists, JJ is the local version-control interface and a workflow
`Change` is not a `JJ Change`. Never initialize JJ automatically; without
`.jj/`, keep the project's existing Git workflow. Commands and publishing rules:
[JJ change-management Protocol](/.spec-agents/doctrine/docs/jj-change-management.md),
[JJ project setup Runbook](/.spec-agents/doctrine/docs/jj-project-setup.md).

## Document authority

When sources conflict: `AGENTS.md` → `.spec-agents/doctrine/skills/` → `.spec-agents/doctrine/docs/` →
`.spec-agents/state/KERNEL.md` →
`CONTEXT.md` and `docs/{adr,protocols,runbooks,lessons}/` → fresh verified
`.spec-agents/state/EVIDENCE.md` → a confirmed `.spec-agents/specs/<feature>/SPEC.md` → `.spec-agents/state/STATUS.md` →
`.spec-agents/archive/` and legacy `.phrase/`.

Fresh evidence can challenge a durable rule but never silently overrides it.
Route that conflict through `plan` and record the decision first.

## Six actions

Six action-named skills. These names and contracts are ours; they are not
aliases for another skill collection. Each action's read list, write boundary,
and completion condition live in `.spec-agents/doctrine/skills/<action>/SKILL.md`.

```text
plan → capture → arrange → do → check → learn
```

Ask the tool what may happen, then read the skill for how:

```text
spec-agents status                      active SPECs, slice states, drift
spec-agents ready                       slices whose blocked_by are satisfied
spec-agents gate <action> [target]      may this action begin? refuses with the reason
spec-agents transition <slice> <state>  change state after checking its invariants
spec-agents check-state                 every state invariant; exit 1 on violation
```

`gate` answers whether an action may begin. `.spec-agents/doctrine/skills/<action>/SKILL.md` says what
to do once it may. The tool never reproduces the skill — one rule, one place.

`plan` is where every route starts, and its outcomes are defined in
`.spec-agents/doctrine/skills/plan/SKILL.md`. `learn` is the only action that promotes knowledge.

If `spec-agents` is not available, read the skills directly and check the gates
by hand. The workflow degrades; it does not disappear.

## Static and dynamic model

`.spec-agents/state/KERNEL.md` is the project's stable semantic model; `.spec-agents/doctrine/docs/WORKFLOW.md`
is the workflow's; `CONTEXT.md` is the project's vocabulary. None holds a
feature-local plan. `.spec-agents/state/STATUS.md` points at current state, `.spec-agents/state/EVIDENCE.md` is an
append-only ledger, a SPEC is a living contract below the durable model and
above its slices. Slices are execution state, not ontology.

Never let a ticket silently redefine the model. A compatible revision names one
concrete alternative, preserves the existing invariant and data contract, and
maps the new behavior to an Action Contract before code changes.

## SPEC and slice discipline

`.spec-agents/state/STATUS.md` records only what is being worked on now; a finished SPEC is removed
from it and the repository records no future intent (ADR 0002). Confirmed work
lives at `.spec-agents/specs/<feature>/`, and `Slice` is the only execution unit — its
fields, the reachability rule, and the parallel-work constraints are defined in
`.spec-agents/doctrine/skills/arrange/SKILL.md` and
[the parallel-work Protocol](/.spec-agents/doctrine/docs/parallel-work.md).

## Safety and scope

- Preserve user changes and unrelated dirty work.
- Do not commit secrets, tokens, certificates, or real user data.
- Treat permissions, configuration, external APIs, and migrations as explicit
  boundaries with verification.
- Treat coding practices, operational procedures, and lessons as scoped
  knowledge; do not apply a lesson outside `applies_when`, and do not promote an
  unverified suggestion into a durable rule.
- Do not add formal ontology tooling, graph storage, generators, or runtime
  authorization without a confirmed SPEC and evidence.
- Do not turn a useful observation into a durable rule without `learn` and the
  required `plan` confirmation. The only bootstrap exception is an absent
  `.spec-agents/state/KERNEL.md` created by `.spec-agents/doctrine/START.md` from confirmed facts as `K1`.

## Existing-project upgrade

Use the current upstream `.spec-agents/doctrine/UPGRADE.md` to extract user-approved candidate
knowledge, archive confirmed retired paths, replace doctrine recoverably, and
run a fresh START. No old work state is inherited. The installer never infers
or archives project knowledge. Old `.phrase/commands/` files are history only.
