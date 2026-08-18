# Evidence — Pomodoro cross-domain revision

## Pre-edit checkpoint

- Observation: D4 proposes automatic task completion at focus finish.
- Observation: K1/R6 makes completion user-controlled through the explicit task
  toggle; timer lifecycle actions do not change `completed`.
- Interpretation: D4 conflicts with the durable task lifecycle boundary.
- Decision: `revise` before application edits.
- Mapping: D4 → K1/R6 conflict; D5 → `recordFocusSession` and R13.
- Permitted next action: implement only D5, preserving R1–R12, task completion
  semantics, and runtime-only timer state.
- Ordering checkpoint: this Kernel/State/Evidence checkpoint is complete before
  treatment `index.html` or `app.js` is edited.

## Runtime verification

- `node --check app.js` and the forbidden-API/URL/HTML string scan passed.
- Fresh Chromium at `http://127.0.0.1:4213/` exercised the baseline timer
  modes, start/pause/resume/reset, blank rejection, literal `<`/`>` task text,
  complete/restore, current-task selection, named deletion confirmation,
  task edit and reload selection, keyboard form submission, mobile layout, and
  no-overflow behavior. The focused Escape-cancel dialog check also left both
  tasks present and the dialog closed.
- R13 controlled-clock result: focus finish showed `00:00`/`已结束`, the
  selected task showed `专注 1 次`, storage kept `completed: false`, and reload
  preserved `focusSessions: 1` while resetting the runtime timer to `25:00`.
- A short-break finish left the count at `1`; it did not increment.
- A legacy task without `focusSessions` rendered as `专注 0 次` without a
  migration write, confirming the zero-default compatibility path.
- Storage keys remained exactly `currentTaskId` and `tasks`; no timer or mode
  state was persisted. No JavaScript console errors occurred.
- The initial test used a pointer click on the visually-hidden skip link and
  timed out because it is intentionally outside the viewport; this was not
  counted as a product pass. The native keyboard/button flows remained usable.
- Application files total 12,190 bytes. Browser artifacts are in
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816`
  and the follow-up dialog run is in
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816-extra2`.
