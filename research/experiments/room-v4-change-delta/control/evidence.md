# Control evidence

- Implementation: `app.js` rejects any create or edit whose end-start exceeds
  120 minutes in the shared `validate()` path; the existing save/mapping logic
  runs only after validation, so rejected create and edit attempts do not mutate
  records. The time error is rendered beside the end-time field in `index.html`.
- Static checks: `node --check app.js` passed. The forbidden-API scan found no
  `fetch`, `XMLHttpRequest`, external URL, `innerHTML`, `outerHTML`,
  `insertAdjacentHTML`, or dependency imports.
- Artifact cost: 2 changed application files + this evidence file; no
  dependencies, build step, server, schema, graph, generator, or ontology
  artifact.
- Recommended acceptance: run unchanged R1–R12, then R13 in real Chromium:
  create 09:00–11:01 and confirm rejection with no record; create a valid
  record, edit it to 09:00–11:01, confirm rejection near the end-time field,
  and confirm the original record remains unchanged. Record the first failing
  R-id, if any, plus ordering, context/artifact cost, and wording-only
  assertion normalization.
- Runtime status at agent handoff: pending; root then ran the shared Chromium
  matrix below.
- Chromium verification: fresh session at `http://127.0.0.1:4198` passed the
  unchanged R1–R12 matrix plus R13. R13 rejected a 09:00–11:01 create with no
  new record, then rejected the same edit while preserving the original
  09:00–10:00 record byte-for-byte in the rendered record.
- Runtime result: `R1–R13 = pass`. The error text was asserted semantically
  (nearby end-time error and no mutation), not by exact wording.
- Artifact cost after the delta: application files total 10,840 bytes; the
  control delta changed `app.js` and moved the error hint beside the end field
  in `index.html`. No spec artifact or dependency was added.
- Browser artifacts: `/private/tmp/spec-agents-room-v4-change-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
