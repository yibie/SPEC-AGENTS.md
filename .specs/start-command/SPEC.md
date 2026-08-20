# Start project bootstrap entry

status: revised
revision: 2
context_refs: `CONTEXT.md`, `AGENTS.md`, `START.md`, `UPGRADE.md`, `README.md`

## Problem and goal

Installing SPEC-AGENTS gives a project the modern files, but it does not give
an Agent a stable project ontology on first use. Add a prompt-driven bootstrap
entry that records a confirmed-only project Kernel K1 on the first scan,
reports the remaining candidate cognition, waits for user confirmation, and
then hands the project to `plan`.

## Unchanged contracts

- `plan → capture → arrange → do → check → learn` remains the only action loop.
- `start` is an entry prompt, not a seventh action and not a replacement for
  `UPGRADE.md`.
- Existing project decisions, dirty work, application code, and version
  history remain untouched before confirmation. The one bootstrap exception is
  creating an absent `KERNEL.md` from directly confirmed facts.
- JJ remains opt-in per the JJ workflow boundary; `start` never initializes a
  repository or creates a bookmark.
- v2/v3 migration remains user-confirmed and Prompt-driven.

## Decision and boundaries

- `start` detects the project state: modern, legacy, mixed/conflicted, or
  missing modern entry points.
- It reads the minimum available context and performs a bounded architecture
  scan using project vocabulary.
- It writes `.scratch/start/REPORT.md` and, only when absent, a confirmed-only
  `KERNEL.md` K1 before confirmation.
- A legacy or mixed project is routed to `UPGRADE.md`; start does not duplicate
  the migration cutover.
- A modern project is handed to `plan` after the user confirms the report and
  reviews the K1 boundary.
- A project missing modern entry points receives installation guidance and
  remains unchanged until `spec-agents init/install` is run.
- After confirmation, any root-document cutover follows the existing six
  actions; start does not jump directly to `do`.

## Model delta

```text
Start --inspects--> ProjectState
Start --bootstraps_if_absent--> ProjectKernel(K1)
Start --produces--> StartReport
StartReport --confirmed_by--> User
Start --routes--> UPGRADE | plan | install
```

Start lifecycle:

```text
unseen → inspected → kernel_bootstrapped → report_ready → user_confirmed → handed_off
                              ↘ rejected / blocked
```

## Action Contracts

### Inspect project

- Precondition: `START.md` is available or the user explicitly asks to start.
- Effect: classify entry-point state, legacy markers, version-control marker,
  recent history, architecture, and unknowns; create a confirmed-only K1 when
  no project Kernel exists.
- Invariant: no application code, existing root cognition, or repository
  history is changed before confirmation; an absent Kernel may receive only
  directly confirmed bootstrap facts.
- Verification: `.scratch/start/REPORT.md` contains sources, classifications,
  Kernel status/version, unknowns, and a next route; a stable scan produces
  `KERNEL.md` K1.

### Confirm bootstrap

- Precondition: a StartReport exists and the user can review it.
- Effect: accept, revise, or reject the candidate project cognition.
- Invariant: rejected or unresolved findings do not enter the default context.
- Verification: the report records the user decision and selected route.

### Hand off to normal work

- Precondition: the report is confirmed and the project has a valid modern
  entry point, or the legacy route has completed its own confirmation gate.
- Effect: begin `plan` for the first actual change.
- Invariant: start never executes application implementation directly.
- Verification: `STATUS.md` has one next permitted action and the first action
  is `plan` or the explicit `UPGRADE.md` review.

## Compatibility and migration

This is a compatible entry-point addition. Existing projects can keep using
`Read AGENTS.md` or `Read UPGRADE.md`; `START.md` simply gives them a single
bootstrap route. The installer adds the file without overwriting an existing
one.

## Verification

- Installer smoke confirms `START.md` is installed and preserved on repeat runs.
- Static content checks confirm the state routes, confirmed-only K1 boundary,
  confirmation gate, and no-direct-implementation boundary.
- Temporary fixtures cover modern, legacy, mixed/conflicted, and missing-entry
  states; each route is deterministic, and only fresh projects with stable
  facts receive a new K1.
- The current SPEC-AGENTS repository and unrelated dirty files remain intact;
  no existing Kernel is overwritten.

## Out of scope

- A seventh `skills/start` action.
- Automatic code changes, root-document cutover without confirmation, or
  automatic JJ initialization.
- Replacing `UPGRADE.md` or implementing a second migration engine.
- Project-specific architecture inference beyond the bounded report, except
  the confirmed-only K1 needed to establish the initial stable floor.

## Issue map

- 01 — define Start concept and Prompt routing — done
- 02 — install and document START.md — done
- 03 — verify start routes and record evidence — done
- 04 — bootstrap the project Kernel on first Start — done

## Revision notes

- v1: user-confirmed report → confirmation → handoff-to-plan gate.
- v2: first scan creates confirmed-only K1; user confirmation governs
  candidate additions and revisions, not the existence of the initial floor.
