# SPEC-AGENTS: evidence-calibrated agent workflow

先识别意图，再读取最小上下文；先验证，再执行；只保留会影响未来判断的知识。

## Default context

For every task, read:

```text
AGENTS.md
CONTEXT.md
STATUS.md
ROADMAP.md
```

Read `EVIDENCE.md` when choosing a phase, checking a failed assumption,
classifying a blocker, or deciding whether a phase can close. Read the relevant
record under `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, or
`docs/lessons/` when the intent points to it; do not load every knowledge class
by default. Read `archive/` only for an explicit historical or regression
question.

The old `.phrase/` tree is legacy context. Read it only for migration,
regression comparison, or explicit history; do not use it as a second default
source of truth.

If `.phrase/` or legacy `spec_*`/`plan_*` markers exist, read `UPGRADE.md`
before ordinary work. It is the user-confirmed migration Prompt; the installer
does not infer or archive project knowledge.

## Document authority

When sources conflict, use this order:

1. `AGENTS.md` for workflow and safety rules.
2. `CONTEXT.md`, `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, and
   `docs/lessons/` for durable semantics, practices, operations, and lessons.
3. Fresh, verified entries in `EVIDENCE.md`.
4. A confirmed `.scratch/<feature>/SPEC.md`.
5. `STATUS.md` for current state.
6. `ROADMAP.md` for phase direction.
7. `archive/` and legacy `.phrase/` material.

Fresh evidence can challenge a durable rule, but never silently overrides it.
Route that conflict through `plan` and record the decision before changing
application code or static documents.

## Six actions

The project uses six action-named skills. These names and contracts are ours;
they are not aliases for another skill collection.

```text
plan → capture → arrange → do → check → learn
```

Use the shortest valid path:

```text
plan
  ├─ no-change → stop
  ├─ settled small change → do → check → learn
  └─ multi-context change → capture → arrange → do → check → learn
```

### `plan`

Use for any request that may change a concept, identity, relation, lifecycle,
invariant, Action Contract, architecture boundary, or work size. Ask in design
tree rounds. Confirm the need, unchanged baseline, definitions, compatibility,
migration, and verification before routing. Do not edit files before shared
understanding is confirmed.

### `capture`

Use for confirmed work that must survive multiple contexts. Create or revise
`.scratch/<feature>/SPEC.md`. Capture decisions already made; do not reopen
them. A change to a goal, boundary, identity, relation, invariant, interface,
or acceptance rule requires a new `plan` pass.

### `arrange`

Use after a confirmed SPEC when the work needs independent slices. Write
`.scratch/<feature>/issues/NN-<slug>.md` with a goal, scope, dependency,
acceptance, verification, status, and an optional empty `evidence_ref`.
Prefer vertical slices. Show the split and dependency edges to the user before
publishing it. Leave `evidence_ref` empty until `learn` records verification.

### `do`

Use for one ready, unblocked slice or a settled small change. Read the relevant
SPEC, CONTEXT, Protocol, Runbook, Lesson, tests, and callers. Make the smallest working change,
run the required checks, and update only the local issue status and verification
summary. Keep `evidence_ref` empty and do not write root Evidence. If semantics
conflict, stop and return to `plan`.

### `check`

Use after `do` or for a requested review. Fix a comparison baseline and check
two axes: the confirmed contract (SPEC, CONTEXT, Protocol) and engineering
standards (tests, types, security, accessibility, errors, and scope). Default
to read-only; confirm facts are sufficient for `learn`, leave `evidence_ref`
empty, and return required fixes to `do`.

### `learn`

Use after verification, a failed assumption, a blocker, or a phase boundary.
Append observation, interpretation, recommended next action, and verification
to `EVIDENCE.md`. Classify verified reusable knowledge before promoting it:
concepts and invariants to `CONTEXT.md`, stable development agreements to
`docs/protocols/`, repeatable operations to `docs/runbooks/`, scoped failures
and practices to `docs/lessons/`, hard-to-reverse trade-offs to `docs/adr/`,
and current state to `STATUS.md`. Every promoted record names its status,
scope, applicability, source Evidence ID, and verification path. If an issue
has `evidence_ref`, append the Evidence ID first, then write the same ID back to
the issue; `learn` is the only writer and promoter.

## Static and dynamic model

`CONTEXT.md` is the stable semantic model: concepts, identities, relations,
lifecycles, invariants, and Action Contracts. It contains no feature-local
implementation plan.

`STATUS.md` is the current state pointer. `EVIDENCE.md` is an append-only
decision-relevant ledger. `SPEC.md` is a living feature contract below the
durable model and above its issues. `docs/protocols/`, `docs/runbooks/`, and
`docs/lessons/` hold broader project knowledge without becoming default
context. Issues are execution state, not ontology.

Never let a ticket silently redefine the model. A compatible revision must name
one concrete alternative, preserve the existing invariant/data contract, and
map the new behavior to an Action Contract before code changes.

## Phase and task discipline

`ROADMAP.md` records phase goals, entry conditions, acceptance gates, and major
out-of-scope boundaries. `STATUS.md` records only the active phase, current
slice, blockers, verification, and next permitted action. Do not pre-split
future roadmap phases.

Use this task shape for the active phase:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

A phase or task is complete only after its acceptance gate is checked,
verification evidence exists, remaining blockers are recorded, the next step is
written, and durable rules are updated when required.

## Safety and scope

- Preserve user changes and unrelated dirty work.
- Do not commit secrets, tokens, certificates, or real user data.
- Treat permissions, configuration, external APIs, and migrations as explicit
  boundaries with verification.
- Treat coding practices, operational procedures, and lessons as scoped
  knowledge; do not apply a lesson outside `applies_when`, and do not promote an
  unverified suggestion into a durable rule.
- Do not add formal ontology tooling, graph storage, generators, or runtime
  authorization without a new phase and evidence.
- Do not turn a useful observation into a durable rule without `learn` and the
  required `plan` confirmation.

## Legacy upgrade

Existing v2 and v3 projects use the root `UPGRADE.md` Prompt. It reconstructs
recent history, scans the current code architecture, asks the user to confirm
the candidate project cognition, and only then archives legacy material and
promotes root documents. The installer does not infer or archive project
knowledge.

Old `.phrase/commands/` files are historical material. Read them only while
following `UPGRADE.md` or for explicit regression research; do not use
`/migrate-v3` as a new default entry point.
