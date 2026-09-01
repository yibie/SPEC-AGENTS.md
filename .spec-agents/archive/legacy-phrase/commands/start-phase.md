---
description: Start the next EDPP phase by updating roadmap/current/evidence
---

# /start-phase — Start an EDPP Phase

Start a new phase from current evidence. Do not create a static
`spec/plan/task/change` bundle.

## Inputs

Read:

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
.phrase/evidence.md
```

Read `.phrase/archive/` only if the active files point to a specific archived
item or the user explicitly asks for historical context.

## Steps

1. **Review latest evidence.**
   Identify the last verified result, remaining blockers, and recommended next
   action.

2. **Choose phase center of gravity.**
   The new phase should focus on one blocker cluster, one risk boundary, or one
   coherent capability slice.

3. **Update `.phrase/roadmap.md`.**
   Keep the roadmap at phase granularity:

   - phase title
   - status
   - goal
   - entry condition
   - acceptance gate
   - major out-of-scope

4. **Rewrite `.phrase/current.md`.**
   Include only active phase context:

   - status
   - goal
   - entry condition
   - scope
   - out of scope
   - acceptance gate
   - active task slice
   - known blockers
   - verification plan
   - evidence to record

5. **Archive stale local context.**
   Move or link obsolete phase-local notes under `.phrase/archive/`. Do not
   carry stale details into `current.md`.

## Task Slice Format

Use task IDs only for the current phase:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

## Output

Report:

- selected phase
- evidence used
- active task slice
- acceptance gate
- verification plan

## Constraints

- Do not pre-split distant roadmap phases.
- Do not create mechanical `change_*` logs.
- If evidence contradicts the old plan, update the plan.
- If evidence changes a durable boundary, update `decision.md`, ADR, or
  protocol explicitly.
