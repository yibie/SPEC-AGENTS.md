# SPEC-AGENTS v3: Evidence-Calibrated Agent Workflow

## Purpose

SPEC-AGENTS v3 combines Evidence-Driven Phase Planning (EDPP) with a small
agent execution protocol.

The old SPEC-AGENTS model emphasized static document discipline:

```text
spec -> plan -> task -> implementation -> change log
```

That model improves traceability, but it can become too heavy for AI-assisted
work. When every session must read and maintain many static records, token cost
rises, stale plans look authoritative, and the useful memory can be buried
under mechanical bookkeeping.

v3 keeps the useful discipline and removes the excess:

```text
decision framework -> roadmap -> current phase
        -> discovery or implementation -> verification
        -> evidence delta -> next phase
```

The goal is not to remember everything. The goal is to preserve the smallest
durable context that helps the next human or agent make a better decision.

## Core Principle

Doc-driven execution, evidence-driven planning.

Documents still guide the agent, but not all documents have the same authority:

- Decision documents define durable rules and boundaries.
- Fresh evidence defines what is currently known.
- The current phase brief defines the next slice of work.
- The roadmap defines direction, not detailed future implementation.
- Archived notes are history, not default context.

When fresh evidence conflicts with the current plan, update the plan. When
fresh evidence challenges a durable boundary, create an explicit decision or
protocol update.

## What Changes From the Old Model

### Removed or Weakened

- No default full-history loading.
- No mechanical `change_*` record for every touched file.
- No requirement to pre-split distant future work into `taskNNN` entries.
- No assumption that old `spec_*` or `plan_*` files remain authoritative after
  discovery contradicts them.
- No duplicate bookkeeping when the git diff already explains what changed.

### Kept

- Phase boundaries.
- Explicit acceptance gates.
- Focused task execution for the current phase.
- Verification before completion.
- Durable decisions when a choice should not be re-litigated.

### Added

- Minimal default context.
- Evidence deltas instead of exhaustive logs.
- Phase plans generated from the previous phase's evidence.
- Clear document authority rules.
- Archive-by-default treatment for old phase material.

## Minimal File Structure

```text
.phrase/
  decision.md
  roadmap.md
  current.md
  evidence.md
  archive/

  adr/          # optional
  protocol/     # optional
  runbooks/     # optional
```

### `decision.md`

Owns the decision framework.

Use it for:

- project principles
- evidence rules
- durable boundaries
- verification standards
- phase gate rules
- when ADR or protocol updates are required
- rejected paths that should not be rediscovered

This file should be stable, but not sacred. If evidence shows the rules are
wrong, update the decision framework explicitly.

### `roadmap.md`

Owns phase-level direction.

Use it for:

- project goal
- phase list
- phase status
- phase-level goals
- entry conditions
- acceptance gates
- major out-of-scope boundaries

Do not put detailed future task lists here. A roadmap is a hypothesis about
sequence, not a promise about implementation.

### `current.md`

Owns the active phase.

This is the primary default context for an agent. It should be short enough to
read every session.

It should contain:

- current phase status
- goal
- entry condition
- scope
- out of scope
- acceptance gate
- active task slice
- verification plan
- known blockers
- links to evidence or decisions only when needed

### `evidence.md`

Owns evidence deltas.

This is not a diary and not a full changelog. Record only facts that can change
future decisions:

- baseline before a phase
- discovery result
- observed blocker or risk
- classification
- verification result
- before/after comparison
- failed assumption
- rejected path
- suggested next phase

Separate observation, interpretation, and recommended next action.

### `archive/`

Owns old context.

Completed phases, obsolete specs, old task lists, and historical notes move
here. Agents do not read archive material by default. They search it only when a
current question requires historical context.

## Optional Folders

### `adr/`

Use only for decisions that should outlive the current phase:

- architecture direction
- long-lived constraints
- rejected strategic alternatives
- compatibility or product policy
- cross-cutting tradeoffs

### `protocol/`

Use only for stable contracts:

- API contracts
- schema rules
- system boundaries
- lifecycle invariants
- integration rules

### `runbooks/`

Use only for repeated manual procedures:

- release checklist
- incident procedure
- dogfood script
- manual QA flow
- operational smoke test

## Default Agent Read Rule

At the start of ordinary work, read only:

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

Read `.phrase/evidence.md` when:

- choosing the next phase
- resolving conflicting plans
- checking why a blocker was classified
- verifying phase completion

Read `.phrase/archive/` only when:

- the current files link to a specific archived item
- a regression requires historical comparison
- the user explicitly asks for past context

This rule is the main token-control mechanism.

## Workflow

1. **Establish decision framework.**
   Define evidence rules, durable boundaries, verification standards, and phase
   gate rules.

2. **Maintain roadmap.**
   Keep long-term direction visible at phase granularity only.

3. **Select current phase from evidence.**
   Use the last evidence delta to decide the next phase. Do not continue an old
   sequence just because it was written earlier.

4. **Write current phase brief.**
   Update `current.md` with the narrow phase goal, scope, out-of-scope
   boundaries, acceptance gate, and active task slice.

5. **Discover before broad implementation.**
   If blocker shape is uncertain, run the smallest useful experiment, trace,
   prototype, audit, benchmark, user test, or harness first.

6. **Classify blockers.**
   Sort blockers by nature. Use labels that fit the project: local fix, shared
   mechanism, workflow boundary, platform divergence, product ambiguity,
   operational dependency, data quality issue, and so on.

7. **Execute the measured slice.**
   Implement only what belongs to the current phase. Record unrelated findings
   as evidence for later.

8. **Verify.**
   Run the proof required by the phase gate. Use broader checks when the blast
   radius warrants it.

9. **Record evidence delta.**
   Add only decision-relevant observations to `evidence.md`: what changed, what
   was verified, what failed, what remains, and what the next phase should be.

10. **Update durable decisions only when needed.**
    If the phase changes a long-lived rule or boundary, update `decision.md`,
    `adr/`, or `protocol/`.

11. **Prepare next phase.**
    Update `roadmap.md` and `current.md` from the latest evidence. Move obsolete
    phase-local detail into `archive/`.

## Task Handling

Tasks are phase-local.

Use task IDs only inside `current.md` when they help coordinate the active
phase. Do not create task lists for distant roadmap phases.

Recommended format:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

Keep tasks small enough to verify in one work session. If a task reveals a
different blocker class, stop expanding it and update evidence.

## Completion Contract

A phase can close only when:

- the acceptance gate has been checked
- verification evidence exists
- remaining blockers are recorded
- the next phase recommendation is written
- durable decisions were updated if needed
- obsolete local context was archived or marked stale

## Migration From Current SPEC-AGENTS

1. Create `.phrase/decision.md` from the existing core principles.
2. Create `.phrase/roadmap.md` from active phase goals and known future phases.
3. Create `.phrase/current.md` from the active `spec_*`, `plan_*`, and `task_*`
   files.
4. Create `.phrase/evidence.md` from currently relevant `issue_*`, verification
   notes, and decision-changing `change_*` records.
5. Move completed or stale phase directories into `.phrase/archive/`.
6. Stop requiring mechanical per-file `change_*` updates.
7. Keep ADRs only for durable decisions.

## Summary

SPEC-AGENTS v3 should not make agents read more. It should make them read
less, but read the right things.

The new contract is:

> Minimal context, evidence-driven phases, verified execution, and durable
> decisions only.
