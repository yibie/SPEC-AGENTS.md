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
`START.md` and execute the Start Review. It is a bootstrap entry, not a seventh
action: inspect, create an absent `KERNEL.md` from confirmed facts, write
`.scratch/start/REPORT.md`, stop for confirmation, then route to `plan` or
`UPGRADE.md`. Never overwrite an existing Kernel. It is re-runnable as a
read-only re-scan (ADR 0005).

## Version-control layer

When `.jj/` exists, JJ is the local version-control interface. Inspect with
`jj status`/`log`/`diff`, work with `jj new`/`edit`/`describe`, recover with
`jj undo`/`op log`, and publish only after explicit authorization via a
bookmark and `jj git push`. Do not substitute `git add`/`commit`/`stash`/
`branch`/`checkout`. A workflow `Change` and a `JJ Change` are different things.

Without `.jj/`, keep the project's existing Git workflow. Never initialize JJ
automatically. Details: [JJ change-management Protocol](docs/spec-agents/jj-change-management.md)
and [JJ project setup Runbook](docs/spec-agents/jj-project-setup.md).

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
plan
  ├─ no-change → stop
  ├─ approve → do → check → learn
  └─ capture → arrange → do → check → learn
```

`approve` requires both: semantics unchanged, **and** the work completes in the
current context. Size is not the test. It creates no SPEC and no slice, so
`plan` hands `do` the contract that stays unchanged and one verifiable
acceptance sentence, and `check` compares against that sentence. Only when the
work may outlive the context does `plan` record one `STATUS.md` entry, which
`learn` removes on completion. (See ADR 0002 for why size is not the test.)

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

`STATUS.md` records only what is being worked on now: active SPECs, blockers,
verification state, next permitted action. A finished SPEC is removed from it —
never let it accumulate closed sections (ADR 0002). The repository records no
future intent; direction becomes durable only as a confirmed SPEC.

`Slice` is the only execution unit, at `.specs/<feature>/issues/NN-<slug>.md`,
carrying goal, scope, dependency, acceptance, verification, status, an optional
`evidence_ref`, `writer:` when its scope contains a file `do` does not own, and
`authority:` — the module that owns the rule it touches, or `n/a: <reason>`.
Maintain no second task list.

Several SPECs may be active at once. Their scopes must not overlap — that is a
`plan` responsibility, and isolating working copies does not fix it. Work that
runs at the same time gets its own working copy: `jj workspace add`, or
`git worktree add` in a Git-only project. Serial switching needs no isolation.
See the [parallel-work Protocol](docs/spec-agents/parallel-work.md).

A slice is complete only after its acceptance is checked, verification evidence
exists, remaining blockers are recorded, the next step is written, and durable
rules are updated when required.

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
