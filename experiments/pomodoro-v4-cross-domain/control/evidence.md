# Control evidence

## Pre-runtime record

- D4 is applied directly: focus-timer finish marks the selected task complete.
- No Kernel/State conflict gate is used, as required for control.
- Expected first contradiction: R6, because task completion is user-controlled
  and timer finish must not change it.

## Runtime verification

- Static checks passed: `node --check app.js` and the forbidden-API/URL/HTML
  string scan.
- Fresh Chromium at `http://127.0.0.1:4212/` used a controlled clock to finish
  one focus timer with a selected `Deep work` task.
- The timer correctly showed `00:00` and `已结束`, but storage showed
  `completed: true` and the row exposed `恢复`; this is the first contradiction
  at R6. The direct D4 behavior was therefore observed, not accepted.
- No JavaScript console errors occurred. The server saw only local HTML/CSS/JS
  requests plus the optional `/favicon.ico` 404.
- Control application files total 11,995 bytes.
