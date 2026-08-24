# SPEC-AGENTS Upgrade Prompt

Run this prompt after `START.md` routes a project with v2 or v3 material here,
or after installing the modern SPEC-AGENTS entry points directly:

```text
Read UPGRADE.md and execute the upgrade review.
```

This is a cognition-preserving migration. The upgrade has two gates:

```text
reconnaissance → user confirmation → cutover → verification
```

Do not change application code during this upgrade. Do not promote an inferred
architecture rule as fact. Keep the old material recoverable until the user
confirms the candidate model.

## 1. Read the modern entry points

Read `AGENTS.md`, `docs/spec-agents/WORKFLOW.md`, `CONTEXT.md`, `KERNEL.md`,
`STATUS.md`, and `EVIDENCE.md` when they exist. Read a root `ROADMAP.md` only
if the project has one: it is retired material to be migrated, not a current
entry point. Treat a missing root document as an upgrade
finding, not as a reason to invent content. If `START.md` already created a
`KERNEL.md` K1, preserve its confirmed sections and use this review to
reconcile legacy material around it.

Inspect only the minimum legacy context needed to classify the project:

- v2 indicators: `.phrase/phases/` or `spec_*`, `plan_*`, `task_*`,
  `change_*`, `issue_*` records;
- v3 indicators: `.phrase/decision.md`, `roadmap.md`, `current.md`,
  `evidence.md`;
- both sets: classify as `mixed` and preserve both histories.

Record the classification and source paths before interpreting their meaning.

If the project contains `.jj/`, inspect `jj log`, `jj status`, and the relevant
`jj diff` before relying on Git commit history. Record JJ Change IDs and
bookmarks as version-control evidence, while keeping the workflow `Change`
concept separate. If `.jj/` is absent, use the project's existing Git history;
do not initialize JJ during upgrade unless the user makes that a separate,
explicit choice.

### Pre-split SPEC-AGENTS layout

A project installed before the framework namespace split carries framework
material under project-owned names. Recognise it by all of these together:

- root `CONTEXT.md` opens with the SPEC-AGENTS workflow model — `Change`,
  `Plan`, `SPEC`, `Slice`, `Evidence`, `Knowledge Classes` — rather than the
  project's own vocabulary;
- root `STATUS.md` or `ROADMAP.md` names phases, tasks, or file paths that do
  not exist in this project — check each named path before believing it;
- root `EVIDENCE.md` records experiments that belong to the framework rather
  than to this project;
- a record under `docs/runbooks/` or `docs/lessons/` cites an Evidence ID that
  root `EVIDENCE.md` does not contain, or a directory this project does not
  have;
- `docs/spec-agents/` is absent.

Two of these can be a coincidence. A filename is never proof on its own — a
project may legitimately own `CONTEXT.md`, `STATUS.md`, and `EVIDENCE.md`. Read the content and record the paths and the facts that support
the classification.

When the layout matches, report it and stop for the user. Do not delete
anything. Present:

1. which root files hold framework material and which hold project material,
   quoting the line that decides each one;
2. whether the project had its own `CONTEXT.md` or another context entry point
   such as `docs/HANDOFF.md`, and where it went — version history usually still
   has it;
3. whether the project already has a work index of its own, and whether
   adopting `STATUS.md` would duplicate it;
4. the proposed disposition of each file, for the user to approve, reject, or
   change one at a time.

After confirmation, reinstall the modern entry points to obtain
`docs/spec-agents/`, then apply the confirmed disposition. Framework leftovers
are removed only for files the user classified as framework material. Project
files are never removed by this review, and a conflict between an installed
document and a project instruction — for example a handoff note that forbids a
second index of in-flight work — is a question for the user, not something the
upgrade decides.

### Phase-shaped SPEC-AGENTS layout

A project installed before `Phase` was retired carries a phase model that no
longer exists. Recognise it by:

- a root `ROADMAP.md`;
- `STATUS.md` with a `**Phase**:` header, closed phase sections, or
  `taskNNN` lines;
- `AGENTS.md` with a "Phase and task discipline" section.

This is not a legacy v2/v3 project and does not need the full reconstruction
below. Reinstall the modern entry points, then present this conversion for the
user to approve:

1. Each open `taskNNN` becomes a Slice under the SPEC it belongs to, at
   `.specs/<feature>/issues/NN-<slug>.md`. A task with no SPEC needs a `plan`
   pass before it becomes work — do not invent a SPEC to hold it.
2. `STATUS.md` is rewritten to list only active SPECs, their blockers, and the
   next permitted action. Closed phase sections move to `archive/`.
3. `ROADMAP.md` moves to `archive/`. Its future-intent entries are not migrated
   anywhere: the repository no longer records intent ahead of work. Show the
   user what is being dropped and let them decide what still matters.
4. Phase results already recorded in `EVIDENCE.md` stay where they are. Do not
   re-record them.

Nothing is deleted. If the project's phases encode something the SPEC model
cannot hold, stop and ask rather than forcing the conversion.

### SPECs under `.scratch/`

A project installed before durable work contracts were separated from scratch
keeps its SPECs and slices at `.scratch/<feature>/`. Recognise it by a
`.scratch/<feature>/SPEC.md` that exists and is tracked in version control.

Reinstall the modern entry points, then present this move for the user to
approve:

1. Every `.scratch/<feature>/` directory containing a `SPEC.md` moves to
   `.specs/<feature>/`. Use the project's version-control move command so
   history follows: `jj` records the rename automatically, `git mv` otherwise.
2. `.scratch/start/REPORT.md` and `.scratch/upgrade-review/REPORT.md` stay
   where they are. They are one-shot reports, not contracts.
3. Recommend that the project ignore `.scratch/` in version control. Do not
   edit the project's `.gitignore` — say what you recommend and let the user
   decide.

Nothing is moved or deleted before the user approves. If a `.scratch/` entry is
neither a SPEC directory nor a known report, report it and ask rather than
guessing which of the two it is.

### Locally modified doctrine

Installed doctrine is identical in every project and is written only by the
installer: `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, and
`docs/spec-agents/`. A project that edited any of them locally has a change
that the next install silently reverts and that no other project can see.

Detect it by comparing each installed file against the upstream copy in the
SPEC-AGENTS repository. Report every difference with the file, the lines, and
what the local version does differently.

Do not revert anything. A local edit is evidence that someone needed something
the doctrine did not provide, and reverting it destroys that evidence. Present
each difference to the user with three routes and let them choose per file:

1. the need is general — take it upstream as a `plan` in the SPEC-AGENTS
   repository, then reinstall;
2. the need is local and belongs elsewhere — move it into this project's own
   `CONTEXT.md`, a Protocol, or a Runbook, where the installer will not touch
   it;
3. the edit is obsolete — discard it, with the user saying so explicitly.

If a slice in this project's `.specs/` has installed doctrine in its scope,
report that too: the slice belongs upstream, not here, and `arrange` should
have refused it.

## 2. Reconstruct recent project history

For v2, inspect the most recent active phase and its related SPEC, plan, task,
change, and issue records. For v3, inspect the current phase, roadmap,
decision framework, and evidence deltas. For mixed projects, compare the two
records and call out conflicts.

Produce a short, cited account of:

- what the project recently completed;
- what the legacy project's current phase was trying to achieve;
- which decisions still appear durable;
- which plans or tasks are stale;
- unresolved blockers, failed assumptions, and verification results;
- facts that cannot be established from the repository.

Use file paths and commit references as evidence. Do not turn a filename into a
fact about current behavior.

## 3. Scan the code architecture

Inspect the current codebase before proposing the modern model. Use the
repository's existing language and boundaries:

- identify entry points, modules, packages, services, and storage boundaries;
- trace the main callers and data flows for the work being reconstructed;
- identify concepts, identities, relations, lifecycles, invariants, and Action
  Contracts visible in code;
- compare the code structure with the legacy SPEC claims;
- label every finding `confirmed`, `inferred`, or `unknown` and cite the code
  path that supports it.

Keep this scan bounded to the project area the upgrade actually concerns. Do
not refactor, format, add dependencies, or fix unrelated findings.

## 4. Write the candidate report and stop

Create `.scratch/upgrade-review/REPORT.md` with these sections:

```markdown
# Upgrade Review

## Source classification
## Recent history
## Current code architecture
## Candidate KERNEL changes
## Candidate CONTEXT changes
## Candidate STATUS changes
## Evidence to preserve
## Conflicts and unknowns
## Proposed archive plan
## Verification plan
## Questions for the user
```

The report is a proposal. Keep existing root documents and legacy files
unchanged at this stage. Show the user the report and ask whether the candidate
concepts, boundaries, current state, and archive plan are correct.

Stop here until the user confirms. If the user rejects or revises the report,
update the report and ask again; do not enter cutover.

## 5. Cut over only after confirmation

After explicit confirmation, use the six actions:

```text
plan → capture → arrange → do → check → learn
```

Then:

1. Merge confirmed project concepts, identities, relations, lifecycles,
   invariants, and Action Contracts into `KERNEL.md`; keep SPEC-AGENTS workflow
   semantics in `docs/spec-agents/WORKFLOW.md`. Preserve a Start-created K1
   unless the user
   explicitly confirms a `revise` or `reject` decision.
2. Record the active work in `STATUS.md`: one entry per active SPEC, with its
   scope, blockers, and next permitted action. Do not create a `ROADMAP.md` and
   do not record future intent.
3. Record only decision-relevant history, verification, blockers, rejected
   paths, and next-step facts in `EVIDENCE.md`.
4. Preserve existing confirmed root content. When a root document conflicts
   with the report, stop and ask the user instead of overwriting it.
5. Move the complete `.phrase` tree to a timestamped directory under
   `archive/legacy-v2/`, `archive/legacy-v3/`, or `archive/legacy-mixed/`.
   Archive identified legacy `spec_*`, `plan_*`, `task_*`, `change_*`, and
   `issue_*` files outside `.phrase` alongside it. Leave unrelated application
   files in place.
6. Write `MIGRATION.md` at the project root with the source classification,
   report path, archive path, confirmed decisions, unresolved questions, and
   verification result.

## 6. Verify the cutover

Before declaring the upgrade complete, prove:

- the confirmed root documents contain the preserved project cognition;
- `STATUS.md` identifies the active SPECs and the next permitted action, and
  contains no closed section;
- `EVIDENCE.md` contains the migration facts and their sources;
- the legacy material is recoverable under `archive/` and is no longer in the
  default read path;
- no application code, dependencies, configuration, or tests changed unless
  the user explicitly approved a separate task;
- the six action validators and the project's relevant checks pass.

If any proof is missing, report the blocker and keep the migration open.

## Completion report

Report:

- source classification: v2, v3, or mixed;
- recent history recovered;
- architecture findings confirmed by the user;
- root documents updated;
- archive path;
- verification commands and results;
- remaining unknowns or blockers;
- next permitted action.

`UPGRADE.md` is an entry prompt, not a replacement for the living root model.
After completion, ordinary work follows `AGENTS.md` and the six action skills.
`START.md` remains the general project bootstrap entry; it routes legacy and
mixed projects to this Prompt instead of duplicating its migration flow.
