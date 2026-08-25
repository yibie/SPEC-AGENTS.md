# SPEC-AGENTS: evidence-calibrated agent workflow

先识别意图，再读取最小上下文；先验证，再执行；只保留会影响未来判断的知识。

## Default context

For every task, read:

```text
AGENTS.md
docs/spec-agents/WORKFLOW.md
STATUS.md
```

Who owns what:

| Path | Owner | Written by |
| --- | --- | --- |
| `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, `docs/spec-agents/` | SPEC-AGENTS doctrine | the installer only — no action writes these; a change to any of them belongs upstream (ADR 0001) |
| `.specs/<feature>/` | the project | `capture` and `arrange`; durable, kept after the work closes (ADR 0003) |
| `.scratch/` | the project | one-shot reports awaiting confirmation; consider ignoring it in version control (ADR 0003) |
| `KERNEL.md`, `CONTEXT.md`, `STATUS.md`, `EVIDENCE.md`, `docs/{adr,protocols,runbooks,lessons}/` | the project | `learn` only (ADR 0004) |
| everything else | the project | `do` — it is the project's `Code` (ADR 0004) |

In the SPEC-AGENTS repository itself the doctrine files are the product, so
they are its `Code` and `do` writes them there.

`STATUS.md` absent means no work is recorded yet, not a file to reconstruct.

Read `KERNEL.md` when it exists — the project's stable semantic model, distinct
from `docs/spec-agents/WORKFLOW.md`, which is the workflow model. A project
without one runs `START.md` before application behavior changes.

Read `CONTEXT.md` when it exists — the project's own vocabulary, never written
by the framework. If the project orients somewhere else, such as
`docs/HANDOFF.md`, follow that and do not maintain two.

Read `EVIDENCE.md` when choosing what to work on next, checking a failed
assumption, classifying a blocker, or deciding whether a SPEC can close. Read a
record under `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, or
`docs/lessons/` when the intent points at it. Read `archive/` and the legacy
`.phrase/` tree only for explicit history or regression comparison.

If `.phrase/` or legacy `spec_*`/`plan_*` markers exist, read `UPGRADE.md`
before ordinary work.

## Start entry

On `start`, `/start`, or a request to onboard or adapt a project, read
`START.md` and execute it. It is a bootstrap entry, not a seventh action, and it
is re-runnable as a read-only re-scan. Procedure, routing table, Kernel
template, and write boundary are all in `START.md`.

## Version-control layer

When `.jj/` exists, JJ is the local version-control interface and a workflow
`Change` is not a `JJ Change`. Never initialize JJ automatically; without
`.jj/`, keep the project's existing Git workflow. Commands and publishing rules:
[JJ change-management Protocol](docs/spec-agents/jj-change-management.md),
[JJ project setup Runbook](docs/spec-agents/jj-project-setup.md).

## Document authority

When sources conflict: `AGENTS.md` → `docs/spec-agents/` → `KERNEL.md` →
`CONTEXT.md` and `docs/{adr,protocols,runbooks,lessons}/` → fresh verified
`EVIDENCE.md` → a confirmed `.specs/<feature>/SPEC.md` → `STATUS.md` →
`archive/` and legacy `.phrase/`.

Fresh evidence can challenge a durable rule but never silently overrides it.
Route that conflict through `plan` and record the decision first.

## Six actions

Six action-named skills. These names and contracts are ours; they are not
aliases for another skill collection. Each action's read list, write boundary,
and completion condition live in `skills/<action>/SKILL.md`, which is read when
the action runs — this section is only for choosing one.

```text
plan → capture → arrange → do → check → learn
```

- `plan` — any request that may change a concept, identity, relation,
  lifecycle, invariant, Action Contract, architecture boundary, or work size.
  Every route starts here.
- `capture` — confirmed work that must survive more than one context.
- `arrange` — a confirmed SPEC that needs independently verifiable slices.
- `do` — one ready slice, or an `approve` route with no slice at all.
- `check` — read-only verification after `do`, or a requested review.
- `learn` — after verification, a failed assumption, a blocker, or a new fact
  that changes later judgement. The only action that promotes knowledge.

Routes out of `plan`:

```text
plan → (see skills/plan/SKILL.md for the six outcomes and where each one goes)
```

Every route begins at `plan`. Which outcome applies, and what each one hands to
the next action, is defined in `skills/plan/SKILL.md` and nowhere else — a
second copy here is what let the two drift apart.

## Static and dynamic model

`KERNEL.md` is the project's stable semantic model; `docs/spec-agents/WORKFLOW.md`
is the workflow's; `CONTEXT.md` is the project's vocabulary. None holds a
feature-local plan. `STATUS.md` points at current state, `EVIDENCE.md` is an
append-only ledger, a SPEC is a living contract below the durable model and
above its slices. Slices are execution state, not ontology.

Never let a ticket silently redefine the model. A compatible revision names one
concrete alternative, preserves the existing invariant and data contract, and
maps the new behavior to an Action Contract before code changes.

## SPEC and slice discipline

`STATUS.md` records only what is being worked on now; a finished SPEC is removed
from it and the repository records no future intent (ADR 0002). Confirmed work
lives at `.specs/<feature>/`, and `Slice` is the only execution unit — its
fields, the reachability rule, and the parallel-work constraints are defined in
`skills/arrange/SKILL.md` and
[the parallel-work Protocol](docs/spec-agents/parallel-work.md).

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
  `KERNEL.md` created by `START.md` from directly confirmed facts as `K1`.

## Legacy upgrade

Existing v2 and v3 projects use the root `UPGRADE.md` Prompt, which reconstructs
history, scans the architecture, and asks the user to confirm before archiving
anything. The installer never infers or archives project knowledge. Old
`.phrase/commands/` files are historical material only.
