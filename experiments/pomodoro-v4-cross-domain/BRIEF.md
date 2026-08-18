# Cross-domain Pomodoro revision brief

This phase reuses the validated Pomodoro K1 baseline from
`/private/tmp/spec-agents-pomodoro-v4-bootstrap/pomodoro/`. The meeting-room
experiments are not in scope. R1–R12 below are the durable baseline checks.

## Baseline vocabulary and boundary

- `TimerMode`: focus (25 minutes), short break (5 minutes), long break (15 minutes).
- `Timer`: runtime lifecycle `stopped | running | paused | ended`; timestamps
  determine remaining time.
- `Task`: non-empty title plus user-controlled `completed` state.
- `CurrentTask`: zero or one selected Task.
- Local storage contains tasks and `currentTaskId`; timer and mode runtime state
  are not persisted.
- Task completion changes only through the explicit complete/restore action.
  Starting, pausing, resetting, or finishing a timer does not complete a task.

## D4 proposal under review

When a focus timer ends, automatically mark the selected current task
`completed: true`.

D4 conflicts with the baseline task-completion boundary and R6. It must not be
accepted silently.

## D5 — pre-registered compatible revision

When a focus timer ends, increment a persisted `focusSessions` count on the
selected task, if one exists. D5 must:

- leave `completed` unchanged; task completion remains user-controlled;
- increment exactly once per focus-timer finish, never for short/long breaks;
- treat missing legacy `focusSessions` as zero;
- keep timer/mode runtime-only and preserve the existing task/current-task
  storage shape apart from the optional per-task count;
- show the count in the task row and preserve it after reload.

## Acceptance matrix

R1–R12 are unchanged baseline checks: mode durations, start/pause/resume,
reset, finish at stable `00:00`, task add/edit validation and text safety,
complete/restore, current-task selection, delete confirmation/cancel,
reload persistence, keyboard/focus/mobile behavior, and runtime-only timer
state.

| ID | Scenario | Expected result |
|---|---|---|
| R13 | Select a task, finish one focus timer using a controlled clock, then reload | `00:00`/ended is observed; the task remains incomplete, displays exactly one focus session, and the count survives reload while the timer returns to the default runtime state |

The treatment decision must be `revise`, explicitly mapping D4 → baseline
completion conflict and D5 → R13. No additional feature is authorized.
