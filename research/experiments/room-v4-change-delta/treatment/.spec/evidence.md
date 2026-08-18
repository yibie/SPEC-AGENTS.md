# Evidence

## Phase 6 treatment checkpoint — before application edit

- Observation: D1 requires every create/edit to reject an active reservation duration over 120 minutes, with R13 covering 09:00–11:01 for both actions.
- Interpretation: `validate()` is the shared pre-mutation boundary; adding the duration gate there preserves create non-mutation and edit atomicity while leaving overlap adjacency unchanged.
- Action-to-R13 mapping: create validates before `bookings.push`; edit validates before `bookings[index] = ...`; both use the end-time error path and preserve records on rejection.
- Permitted next action: modify only `treatment/app.js`, then run `node --check`, forbidden-API scan, and the unchanged R1–R12 plus R13 browser matrix.

## Phase 6 treatment implementation evidence

- File order: `.spec/kernel.md` → `.spec/state.md` → `.spec/evidence.md` checkpoint → `app.js`; no application file was edited before the checkpoint.
- Implementation: `app.js` adds a small native JavaScript minute conversion and a shared maximum-duration guard in `validate()`. Create and edit therefore reject before `push`/replacement; the existing record remains untouched on failed edit.
- Static verification: `node --check app.js` passed; forbidden API scan for `innerHTML`, `insertAdjacentHTML`, `eval`, `fetch`, `XMLHttpRequest`, and `WebSocket` passed.
- Cost: one application file changed; +1 helper and +1 validation branch; no dependencies, schema, graph, generator, or server. Artifact sizes: `app.js` 5,835 bytes; Kernel 2,069 bytes; State 1,414 bytes; Evidence 2,496 bytes at handoff. Context read was limited to BRIEF, RUN_PROTOCOL, treatment snapshots, and copied app files.
- Runtime status at agent handoff: browser R1–R13 matrix pending; first failing
  R-id: none observed yet. Error wording is implementation-defined and should
  be asserted semantically (nearby end-time rejection plus no mutation), not as
  an exact string.
- Acceptance steps: run unchanged R1–R12; for R13 create a complete 09:00–11:01 reservation and verify rejection/no record, then create a valid record, edit it to 09:00–11:01, verify rejection near end-time and preservation of all original fields; also confirm subsequent valid create/edit, reload, cancel, and R12 mobile behavior.
- Recommendation at agent handoff: run the full Chromium matrix next; root then
  ran it without changing the app after handoff.
- Chromium verification: fresh session at `http://127.0.0.1:4199` passed the
  unchanged R1–R12 matrix plus R13. R13 rejected a 09:00–11:01 create with no
  new booking, then rejected the same edit while preserving the original
  09:00–10:00 booking exactly.
- Runtime result: `R1–R13 = pass`. The error text was asserted semantically
  (nearby end-time error and no mutation), not by exact wording.
- Ordering verification: Kernel and State were updated before `app.js`; the
  evidence file contains a separate pre-edit checkpoint followed by final
  runtime evidence. Final evidence was appended after the app edit, so its
  final file mtime is not treated as proof of the checkpoint order.
- Artifact cost after the delta: application files total 11,952 bytes; K1,
  State, and Evidence total 5,973 bytes. No dependency, schema, graph,
  generator, or server was added.
- Browser artifacts: `/private/tmp/spec-agents-room-v4-change-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
