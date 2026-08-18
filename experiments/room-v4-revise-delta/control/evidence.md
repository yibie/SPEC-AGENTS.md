# Control evidence

## Observation

- D2 was applied directly in `app.js`: after confirmed cancellation, the
  matching reservation is filtered out of `reservations`, persisted, and the
  list is re-rendered. The confirmation copy now states that the record will
  be permanently deleted.
- Static checks passed: `node --check app.js`; the forbidden-API scan found no
  `fetch`, `XMLHttpRequest`, external URL, `innerHTML`, `outerHTML`, or
  `insertAdjacentHTML`.
- Ordering: the direct application edit preceded this evidence record; no
  Kernel/State conflict gate was used, as required for control.
- Artifact cost: one changed application file plus this evidence file. No
  dependency, build step, server, schema, graph, or generator was added; the
  copied `index.html` and `styles.css` remain unchanged.

## Interpretation

- D2 releases the time slot and permanently removes the cancelled record, but
  contradicts baseline R8, which requires marking it cancelled and keeping it
  visible. The same deletion after reload contradicts R10's cancelled-state
  persistence. The first contradiction is R8.

## Focused acceptance recommendation

- Create one reservation, confirm cancellation, assert the record is absent
  and the slot can be reused, then reload and assert the deleted record remains
  absent. This verifies the direct D2 behavior while exposing the baseline
  contradiction at R8 and again at R10 after reload; the baseline assertions
  should fail because they expect a persisted visible cancelled record.

## Recommended next action

- Use this control result as the D2 contradiction when comparing the treatment's
  pre-edit `revise` decision and D3 archive-view implementation.

## Runtime verification

- Fresh Chromium session at `http://127.0.0.1:4202` ran the focused D2 check.
- Baseline R8 expectation failed: confirmation left `0` records instead of a
  visible cancelled record. The D2 deletion behavior and slot reuse were
  observed as intended; reload kept only the replacement record, so baseline
  R10 also failed.
- First contradiction: `R8`; reload repeats it at `R10`.
- Application files total 10,516 bytes. Browser artifacts are in
  `/private/tmp/spec-agents-room-v4-revise-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
