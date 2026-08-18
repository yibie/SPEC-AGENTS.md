# K1 Kernel — Pomodoro Bootstrap

version: K1
status: enacted after Bootstrap Gate
source: explicit user intent in the v4 Bootstrap request
scope: one install-free native browser page; current phase only

## Concepts

- `TimerMode`: focus 25m, short break 5m, long break 15m.
- `Timer`: selected mode countdown with stopped, running, paused, ended states.
- `Task`: non-empty title plus completion state.
- `CurrentTask`: zero or one selected Task.
- `LocalState`: tasks, completion state, and CurrentTask persisted locally; mode and timer state are runtime state.

## Invariants

- Remaining time never goes below zero; running time is calculated from timestamps.
- Task titles are trimmed and non-empty at add/edit boundaries.
- Task titles are rendered as text, never interpreted as HTML.
- CurrentTask is absent or references an existing Task.
- Controls have visible labels, keyboard access, and visible focus; deletion requires a named native dialog.
- No network or external dependency is required.

## Action Contracts

For every action: guard -> effect -> observable outcome -> verify.

- `selectMode`: valid mode -> select mode, stop timer -> 25:00/5:00/15:00 visible -> select each mode and observe duration.
- `start`: stopped/paused with time remaining -> record a timestamp while retaining saved remaining time -> countdown decreases and pause is available; paused resume continues from saved remaining, not the full mode duration -> start, pause, wait, resume, and observe continuation from the paused value.
- `pause`: running -> calculate elapsed time and store remaining, mark paused -> display stops changing -> pause, wait 2s, observe unchanged time.
- `reset`: selected mode exists -> stop and restore configured duration -> exact mode duration and stopped state -> reset after start/pause.
- `finish`: timestamp reaches zero -> clamp zero and mark ended -> `00:00` and explicit ended status remain visible, with no negative or continued running -> observe both at zero without an immediate reset.
- `addTask`: trimmed title non-empty -> create incomplete Task and persist -> title appears once and survives reload; blank rejected -> submit whitespace and valid title, reload.
- `editTask`: target exists and trimmed title non-empty -> replace title and persist -> valid edit appears; blank preserves old title -> edit with both values, reload.
- `toggleTask`: target exists -> toggle completion and persist -> complete/restore state visible and survives reload -> toggle twice, reload each time.
- `deleteTask`: target exists and named dialog confirmed -> remove only target, clear matching CurrentTask, persist; cancel no-op -> confirm removes/cancel retains -> test both, including selected task, reload.
- `selectCurrentTask`: target exists -> set and persist CurrentTask -> exactly one current indication survives reload -> select two in sequence and reload.

## Bootstrap Gate self-check

- [x] Every current user-observable result maps to a contract.
- [x] Every contract has guard, effect, observable outcome, and verification scenario.
- [x] Product, behavior, accessibility, safety, and data-error assumptions are invariants.
- [x] Scope contains no future model.
- [x] Source is traceable to the user intent.

## K1-D5 compatible evolution checkpoint

- `FocusSessionCount` is optional per Task and normalizes to a non-negative
  integer, defaulting to zero for legacy tasks.
- The existing completion invariant is protected: only the explicit task
  toggle changes `completed`; timer finish never auto-completes a task.
- `recordFocusSession`: focus timer reaches zero with a selected task -> add
  one to that task's count and persist -> the row shows the new count after
  finish and reload; short/long break finish has no count effect.
- D4 is therefore classified as a conflict and D5 is the one named compatible
  alternative. Timer and mode remain runtime-only.
