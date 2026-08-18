# Phase 9 Results: Cross-domain Pomodoro Revision

## Decision

**Promote the bounded `revise` path across this second domain.** The protocol
held when the change was a persistent domain-state extension rather than a
presentation filter:

```text
conflict → one named compatible alternative → Kernel/State/Evidence
→ implementation → old contracts + new contract
```

This is still a small, non-causal sample. It does not prove model superiority,
general ontology transfer, or justify schema/graph/generator infrastructure.

## Fixed delta

- **D4:** automatically mark the selected task complete when a focus timer ends.
- **D5:** increment a persisted `focusSessions` count on the selected task at
  focus finish, while leaving `completed` user-controlled.

D4 conflicts with K1/R6. D5 adds one optional per-task value, normalizes legacy
tasks to zero, increments once for focus only, and keeps timer/mode runtime-only.

## Verification

| Check | Control | Treatment |
|---|---|---|
| Static syntax and forbidden-API scan | pass | pass |
| Focus finish | `00:00`/ended, but task became complete; first contradiction R6 | `00:00`/ended and task stayed incomplete |
| R1–R12 representative baseline flows | direct D4 stopped at R6 | timer modes, pause/resume/reset, task validation/text, edit, complete/restore, selection/reload, delete confirm/cancel, keyboard form submit, mobile/no overflow passed |
| R13 focus-session contract | not applicable | focus count became 1 and survived reload |
| Short/long break count | not applicable | short break left count at 1 |
| Legacy task without count | not applicable | rendered as zero without a migration write |
| Storage boundary | D4 persisted completion | only `tasks` and `currentTaskId`; timer/mode remained runtime-only |

Treatment Chromium runs used a controlled `Date.now()` clock to finish timers
without waiting 25 minutes. No JavaScript console errors occurred; the only
server noise was the optional `/favicon.ico` 404. The pointer check for the
visually-hidden skip link timed out because the link is intentionally outside
the viewport; it is recorded as a harness limitation, not counted as a pass.

## Protocol evidence

Treatment updated the copied Kernel with `FocusSessionCount` and its action
contract, recorded `decision: revise` and D4 → D5 in State, and wrote the
pre-edit Evidence checkpoint before modifying `app.js`. Existing timer/task
contracts were preserved; the app change is limited to count normalization,
display, persistence, and focus-finish increment.

## Cost and artifacts

- Control application files: **11,995 bytes**.
- Treatment application files: **12,190 bytes**.
- Treatment Kernel/State/Evidence: **7,142 bytes**.
- Browser artifacts:
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816`
  and the follow-up dialog run at
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816-extra2`;
  the legacy-task check is in
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816-legacy`.

## Boundary

The protocol now has one meeting-room presentation revision and one Pomodoro
state/persistence revision. Keep the rule narrow and continue to treat the
Kernel as a compact domain model, not a second requirements archive. A later
phase may test a third domain only if a materially different failure mode
appears; formal ontology infrastructure remains out of scope.
