# Operational State — Pomodoro cross-domain revision

kernel: K1 → K1-D5
phase: cross-domain compatible revision
status: revise before implementation

## Decision checkpoint

`decision: revise`

D4 (auto-complete the current task when focus ends) conflicts with the K1 task
completion boundary and R6. Adopt the pre-registered D5 alternative: record a
per-task `focusSessions` count on focus finish while leaving `completed`
unchanged. The count defaults to zero for legacy tasks, increments once per
focus finish, persists with the existing task array, and is visible in the task
row. Timer and mode remain runtime-only.

## Acceptance gate

- State and Evidence are written before application files change.
- D5 maps to R13 and does not alter R1–R12.
- A controlled-clock browser run proves one increment, no auto-completion,
  reload persistence, and default timer state after reload.
