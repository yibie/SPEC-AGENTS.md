# Control evidence

## Observation

- D2 was applied directly in `app.js`: after confirmed cancellation, the
  matching reservation is filtered out of `reservations`, persisted, and the
  list is re-rendered. The confirmation copy now states that the record will
  be deleted.
- Static checks passed: `node --check app.js`; the forbidden-API scan found no
  `fetch`, `XMLHttpRequest`, external URL, `innerHTML`, `outerHTML`, or
  `insertAdjacentHTML`.
- Ordering: direct application edit first, then this evidence record; no
  Kernel/State conflict gate was used, as required for control.
- Artifact cost: one changed application file plus this evidence file; the
  copied `index.html` and `styles.css` remain unchanged. No dependency, build
  step, server, schema, graph, or generator was added.

## Interpretation

- D2 releases the time slot and removes the cancelled record, but it directly
  contradicts baseline R8, whose expected result is to mark cancelled and keep
  the record visible. The same deletion remains absent after reload, so R10's
  cancelled-state persistence also fails. The first contradiction is R8.
- A focused cancel+reload acceptance should create one reservation, confirm
  cancellation, assert the record is absent and the slot can be reused, then
  reload and assert the deleted record is still absent. This is expected to
  expose the control-versus-baseline contradiction at R8, with the R10
  contradiction visible on reload; it was not run here because no browser
  server or recovery is authorized in this control task.

## Recommended next action

- Treat the direct D2 result as the intended control contradiction, not as a
  regression to repair. Compare it with the treatment's pre-edit `reject` or
  compatible `revise` decision before closing Phase 7.

## Runtime verification

- Fresh Chromium session at `http://127.0.0.1:4200` ran the focused D2 check.
- Baseline R8 expectation failed: after confirmation the record count was `0`
  instead of one visible cancelled record. D2's own deletion behavior passed:
  the empty state appeared and the slot was reusable.
- Baseline R10 expectation failed after reload: the cancelled record was still
  absent. The new replacement record persisted, confirming that the observed
  failure is deletion rather than a storage outage.
- First contradiction: `R8`; reload exposes the same conflict at `R10`.
- Browser artifact: `/private/tmp/spec-agents-room-v4-rejection-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
