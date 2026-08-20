# SPEC-AGENTS Start Review

Use this entry prompt when a project is new to SPEC-AGENTS, when its current
cognition is missing or stale, or when the user says `start` / `/start`.

Run it with:

```text
Read START.md and execute the start review.
```

`start` is a bootstrap entry, not a seventh action. Its job is to inspect,
record the first stable project Kernel, report what remains uncertain, and hand
the project to `plan`. The normal loop remains:

```text
plan → capture → arrange → do → check → learn
```

## 1. Read the minimum available context

Read `AGENTS.md`, `docs/spec-agents/WORKFLOW.md`, `CONTEXT.md`, and
`STATUS.md` when they exist.
Read `KERNEL.md` when it exists; it is the project's semantic model, not a
replacement for `docs/spec-agents/WORKFLOW.md`.
Read `EVIDENCE.md` only when the current state or a failed assumption needs it.
Read `UPGRADE.md` when legacy markers are present. Do not load the entire
history tree by default.

Missing `KERNEL.md` is a bootstrap condition, not permission to skip the
project's stable semantics. If the code exposes enough directly confirmed
concepts, relations, actions, or invariants, create the first `KERNEL.md`
before writing the report. Do not invent unknowns and do not overwrite an
existing Kernel.

## 2. Classify the project state

Use this routing order:

| State | Evidence | Route |
| --- | --- | --- |
| `legacy` | v2/v3 markers such as `.phrase/`, `spec_*`, `plan_*`, or `task_*` | `UPGRADE.md` |
| `mixed` | legacy markers and modern root documents both exist | `UPGRADE.md` with the conflict called out |
| `modern` | modern root documents exist and no legacy markers are active | `plan` after the Kernel bootstrap/report |
| `missing-entry` | `START.md` exists but modern root documents are missing | installation guidance, then rerun `start` |
| `blocked` | state or ownership cannot be established safely | stop at the report and ask the user |

Do not use a filename alone as proof of project behavior. Record the paths and
the facts they support.

Also record the version-control marker without changing it:

- `.jj/`: JJ is the local version-control interface;
- `.git/` without `.jj/`: preserve the Git-only workflow;
- neither: record that version history is unknown;
- never run `jj git init --colocate`, create a bookmark, or push during `start`.

Record the Kernel marker separately:

- existing `KERNEL.md`: read it and report whether the scan agrees with it;
- absent `KERNEL.md` with stable code facts: create `KERNEL.md` version `K1`;
- absent `KERNEL.md` without stable facts: report `kernel-unavailable` and stop;
- never replace an existing Kernel during `start`.

## 3. Reconstruct a bounded project picture

Inspect only the area relevant to the current project entry. Record findings
as `confirmed`, `inferred`, or `unknown`:

- recent project history and current work;
- entry points, modules, packages, storage and external boundaries;
- concepts, identities, relations, lifecycle states, and invariants visible in
  the code;
- current coding, testing, operational, and recovery conventions when they
  are observable;
- dirty work, blockers, and facts that require user confirmation.

Do not refactor, format, add dependencies, or fix unrelated findings. The
initial Kernel is limited to stable facts directly supported by the scan; it
does not include inferred or unknown claims.

## 4. Bootstrap the Kernel and write the report

When `KERNEL.md` is absent and the scan has enough confirmed facts, create it
with this minimum shape:

```markdown
# Project Kernel

status: enacted
version: K1
scope: <project>
source: START scan (<paths>)
verified_at: <date>
confidence: confirmed-only

## Concepts
## Relations
## Actions and invariants
## Architecture boundaries
## Source evidence
```

Only facts directly confirmed by code, configuration, tests, or existing
durable project records belong in the enacted sections. Candidate meanings,
conflicts, and unknowns stay in `REPORT.md` until the user decides how to
handle them.

Create or update `.scratch/start/REPORT.md` with:

```markdown
# Start Review

## Project state
## Version-control state
## Recent history
## Current architecture
## Kernel bootstrap
## Candidate project cognition
## Existing knowledge and gaps
## Conflicts and unknowns
## Proposed route
## Questions for the user
## User decision
```

Before confirmation, the only project-specific writes allowed are the report
and a new `KERNEL.md` created by the bounded bootstrap above. Do not overwrite
an existing Kernel, change application code, dependencies, configuration,
repository history, or legacy files. Ask the user to confirm, revise, or reject
the candidate additions and route; the confirmed K1 remains the project's
initial stable floor.

## 5. Continue only after confirmation

Record the user's decision in the report, then follow exactly one route:

- `modern`: enter `plan` to review or extend K1 before the first requested
  change. Do not jump directly to `do`.
- `legacy` or `mixed`: read and execute `UPGRADE.md`. Do not create a second
  migration process in the Start prompt; preserve the bootstrapped K1 while
  the upgrade reconciles legacy knowledge.
- `missing-entry`: ask the user to run `spec-agents init/install`, then rerun
  `start`; preserve a newly created K1 if the scan had enough confirmed facts.
- `blocked`: keep the report, state the blocker, and wait for user direction.

`start` is complete only when `.scratch/start/REPORT.md` contains the state,
Kernel status/version, evidence, user decision, selected route, and next
permitted action. A project with enough stable facts must also have an enacted
`KERNEL.md` version `K1`; this does not claim that the project is fully
migrated or that application work is complete.
