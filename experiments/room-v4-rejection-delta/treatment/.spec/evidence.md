# Treatment evidence

## Phase 7 rejection checkpoint

- Decision: `reject`.
- File order: `../BRIEF.md` and `../RUN_PROTOCOL.md` were read first; the
  copied `.spec/kernel.md` and `.spec/state.md` were compared before any
  application file. This checkpoint updated `.spec/state.md`, then recorded
  this `.spec/evidence.md`; `index.html`, `styles.css`, and `app.js` were not
  edited.
- Conflict mapping: D2 (confirmed cancellation permanently deletes the
  record) contradicts K1/R8 (cancelled record remains visible and releases its
  slot) and K1/R10 (the cancelled state persists through reload). D2 cannot be
  applied without silently replacing durable invariants, so it is rejected.
- Permitted next step: keep the copied baseline app unchanged; reopen only
  after an explicit product decision that supplies a compatible cancellation
  retention policy.

## Static verification

- `node --check app.js`: PASS.
- Forbidden API scan (`innerHTML`, `insertAdjacentHTML`, `outerHTML`, `eval`,
  `new Function`, `fetch`, `XMLHttpRequest`, `WebSocket`): PASS; no matches.
- Baseline preservation: `cmp` reports identical `index.html`, `styles.css`,
  and `app.js` against `../../room-v4-independent-ab/treatment/`.
- Scope: only `.spec/state.md` and `.spec/evidence.md` changed; no dependency,
  schema, graph, generator, server, root, control, or legacy experiment files
  were changed.

## Runtime verification

- Fresh Chromium session at `http://127.0.0.1:4201` ran the unchanged baseline
  matrix. `R1–R12 = pass`, including cancellation retention/reuse, reload,
  literal text safety, keyboard focus, and 390×844 overflow.
- The treatment app is byte-for-byte identical to the Phase 5 baseline, so no
  D2 implementation was browser-tested; the rejection decision is the result.
- Browser artifact: `/private/tmp/spec-agents-room-v4-rejection-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
