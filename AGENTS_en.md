# SPEC-AGENTS: Evidence-Calibrated Agent Workflow

Classify the user's intent first. Read the smallest useful context, verify
before executing, and keep only knowledge that will affect future decisions.

## Default context

For every task, read:

```text
AGENTS.md
docs/spec-agents/WORKFLOW.md
STATUS.md
```

`STATUS.md` is the project's own state. A fresh install does not have one:
`learn` creates it once there is real state to record. Its absence means no
work is recorded yet — it is not a missing file to reconstruct or invent.

`docs/spec-agents/` holds SPEC-AGENTS doctrine: identical in every managed
project, written only by the installer. Everything else in the repository
belongs to the project.

Read `KERNEL.md` when it exists. It is the managed project's stable semantic
model; `docs/spec-agents/WORKFLOW.md` is the workflow model. If a project has no
`KERNEL.md`, run `START.md` before changing application behavior.

Read `CONTEXT.md` when it exists. It is the project's own context and
vocabulary, not a framework document; the installer emits an empty skeleton and
never writes it again. If the project keeps its orientation somewhere else, such
as `docs/HANDOFF.md`, follow that instead and do not maintain two.

Read `EVIDENCE.md` when choosing what to work on next, checking a failed
assumption, classifying a blocker, or deciding whether a SPEC can close. Read the relevant
record under `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, or
`docs/lessons/` when the intent points to it; do not load every knowledge class
by default. Read `archive/` only for an explicit historical or regression
question.

The old `.phrase/` tree is legacy context. Do not use it as a second default
source of truth.

If `.phrase/` or legacy `spec_*`/`plan_*` markers exist, read `UPGRADE.md`
before ordinary work. It is the user-confirmed migration Prompt; the installer
does not infer or archive project knowledge.

## Start entry

When the user says `start`, `/start`, or asks to onboard/adapt a project, read
`START.md` and execute the Start Review. Start is a bootstrap entry, not a
seventh action: inspect the project, create an absent `KERNEL.md` from directly
confirmed facts, write `.scratch/start/REPORT.md`, stop for user confirmation,
then route a modern project to `plan` and a legacy/mixed project to
`UPGRADE.md`. Never overwrite an existing Kernel during Start. If `START.md`
is missing, report that the modern entry points must be installed first.

## Version-control layer

When `.jj/` exists, use JJ as the local version-control interface. Keep the
workflow concept `Change` distinct from a version-control `JJ Change`:

- inspect with `jj status`, `jj log`, and `jj diff`;
- start or switch local work with `jj new` and `jj edit`;
- describe intent with `jj describe` and recover with `jj undo`/`jj op log`;
- publish only after explicit authorization, using a bookmark and
  `jj git push`;
- do not use `git add`, `git commit`, `git stash`, `git branch`, or
  `git checkout` as local JJ substitutes.

If `.jj/` is absent, keep the project on its existing Git workflow or ask the
user to opt into the [JJ change-management Protocol](docs/spec-agents/jj-change-management.md).
Never initialize JJ automatically. Read the [JJ project setup Runbook](docs/spec-agents/jj-project-setup.md)
when the user explicitly chooses colocated JJ.

## Document authority

When sources conflict, use this order:

1. `AGENTS.md` for workflow and safety rules.
2. `docs/spec-agents/` for workflow semantics and framework practice.
3. `KERNEL.md` for managed-project semantics, then `CONTEXT.md`, `docs/adr/`,
   `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/` for the project's
   own context, decisions, practices, operations, and lessons.
4. Fresh, verified entries in `EVIDENCE.md`.
5. A confirmed `.scratch/<feature>/SPEC.md`.
6. `STATUS.md` for current state.
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
Prefer vertical slices. Show the split and dependency edges before publishing
it. Leave `evidence_ref` empty until `learn` records verification.

### `do`

Use for one ready, unblocked slice or a settled small change. Read the relevant
SPEC, project `KERNEL.md` when present, WORKFLOW, CONTEXT, Protocol, Runbook, Lesson, tests, and callers. Make the smallest working change,
run the required checks, and update only the local issue status and verification
summary. Keep `evidence_ref` empty and do not write root Evidence. If semantics
conflict, stop and return to `plan`.

### `check`

Use after `do` or for a requested review. Fix a comparison baseline and check
two axes: the confirmed contract (SPEC, project `KERNEL.md`, WORKFLOW, CONTEXT, Protocol) and engineering
standards (tests, types, security, accessibility, errors, and scope). Default
to read-only; confirm facts are sufficient for `learn`, leave `evidence_ref`
empty, and return required fixes to `do`.

### `learn`

Use after verification, a failed assumption, a blocker, or a new fact that
changes later judgement.
Append observation, interpretation, recommended next action, and verification
to `EVIDENCE.md`. Classify verified reusable knowledge before promoting it:
project concepts and invariants to `KERNEL.md`, project vocabulary and
authority boundaries to `CONTEXT.md`, workflow concepts to
`docs/spec-agents/WORKFLOW.md`, stable development agreements to
`docs/protocols/`, repeatable operations to `docs/runbooks/`, scoped failures
and practices to `docs/lessons/`, hard-to-reverse trade-offs to `docs/adr/`,
and current state to `STATUS.md`. Every promoted record names its status,
scope, applicability, source Evidence ID, and verification path. If an issue
has `evidence_ref`, append the Evidence ID first, then write the same ID back to
the issue; `learn` is the only writer and promoter.

## Static and dynamic model

`KERNEL.md` is the managed project's stable semantic model: concepts,
identities, relations, lifecycles, invariants, and Action Contracts.
`docs/spec-agents/WORKFLOW.md` is the stable model of the SPEC-AGENTS workflow
itself. `CONTEXT.md` is the project's own context and vocabulary. None of them
contains a feature-local implementation plan.

`STATUS.md` is the current state pointer. `EVIDENCE.md` is an append-only
decision-relevant ledger. `SPEC.md` is a living feature contract below the
durable model and above its issues. `docs/protocols/`, `docs/runbooks/`, and
`docs/lessons/` hold broader project knowledge without becoming default
context. Issues are execution state, not ontology.

Never let a ticket silently redefine the model. A compatible revision must name
one concrete alternative, preserve the existing invariant/data contract, and
map the new behavior to an Action Contract before code changes.

## SPEC and slice discipline

`STATUS.md` records only what is being worked on now: the active SPECs, their
blockers, their verification state, and the next permitted action. When a SPEC
is finished it is removed from `STATUS.md`; its result is already in
`EVIDENCE.md` and its contract stays at `.scratch/<feature>/SPEC.md`. Never let
`STATUS.md` accumulate closed sections — that turns the state pointer into a
second history ledger.

The repository does not record future intent. Direction is decided in
conversation and becomes durable only when it becomes a confirmed SPEC.

`Slice` is the only execution unit. A slice lives at
`.scratch/<feature>/issues/NN-<slug>.md` and carries a goal, scope, dependency,
acceptance, verification, status, and an optional `evidence_ref`. Do not
maintain a second task list anywhere.

Several SPECs may be active at once, under two different constraints:

- their scopes must not overlap — overlapping scope is a `plan` failure, and
  isolating working copies defers the conflict rather than solving it;
- work that must run at the same time needs its own working copy:
  `jj workspace add` in a project with `.jj/`, `git worktree add` otherwise.
  Switching between SPECs serially needs no isolation. See the
  [parallel-work Protocol](docs/spec-agents/parallel-work.md).

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

Existing v2 and v3 projects use the root `UPGRADE.md` Prompt. It reconstructs
recent history, scans the current code architecture, asks the user to confirm
the candidate project cognition, and only then archives legacy material and
promotes root documents. The installer does not infer or archive project
knowledge.

Old `.phrase/commands/` files are historical material. Read them only while
following `UPGRADE.md` or for explicit regression research; do not use
`/migrate-v3` as a new default entry point.
