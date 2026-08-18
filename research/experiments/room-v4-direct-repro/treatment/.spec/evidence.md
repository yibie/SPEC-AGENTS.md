# Treatment Evidence

## Order and scope

1. Read `../BRIEF.md`, `../RUN_PROTOCOL.md`, and local `README.md`.
2. Created `.spec/kernel.md` and `.spec/state.md` before `index.html`, `styles.css`, or `app.js`.
3. Self-audited K1 against room/booking relation, lifecycle, local-time validity, half-open overlap/adjacency, cancellation release, text safety, persistence, accessibility, and R1–R12 Contracts.
4. Created the three native application files; no root, control, AGENTS.md, dependency, server, schema, graph, or generator changes were made by this run.

## Static evidence

- `node --check app.js`: PASS.
- Forbidden API scan for `fetch`, `XMLHttpRequest`, `innerHTML`, `outerHTML`: no matches.
- No external dependencies or network code.
- Cost (`wc -l -c`): K1 36/2729; State 8/636; application: `index.html` 29/1467, `styles.css` 1/790, `app.js` 15/2851; total listed artifacts 89 lines / 8473 bytes.

## Chromium verification

- Local static server: `http://127.0.0.1:4195/`; session: `direct-treatment`.
- R1 **PASS**: three rooms, form, and the initial empty state rendered.
- R2 **FAIL**: a valid submit persisted a record to localStorage but rendered no
  article. The console reported `TypeError: form.reset is not a function` from
  `app.js`; the form control with `id="reset"` shadows the native form method.
- R3–R12 were not claimed after the R2 blocker. A later reload can expose the
  persisted record, but that does not repair the required same-submit behavior.
- Console also contained the optional missing `favicon.ico` 404. Root did not
  modify the treatment application.

## Protocol deviation

- An extra `research/experiments/room-v4-direct-repro/styles.css` appeared outside the
  treatment sandbox and duplicates treatment CSS. It is preserved as a path
  discipline deviation; the assigned treatment files remain under `treatment/`.

## Fresh treatment correction

- Root cause fixed: renamed the Cancel edit control from `id="reset"` to
  `id="cancel-edit"` and synchronized all JavaScript references, so the form's
  native `reset()` method is no longer shadowed. Product behavior and K1 are
  unchanged.
- Static checks: `node --check app.js` PASS; forbidden-API scan for
  `fetch`, `XMLHttpRequest`, `innerHTML`, and `outerHTML` PASS (no matches).
- Chromium runtime evidence is recorded below; the prior R2 blocker is
  resolved.

## Fresh correction Chromium verification

- Session `direct-treatment-correction` served this directory at
  `http://127.0.0.1:4195/`.
- R1–R12: **PASS**. The run covered valid and invalid time, overlap,
  adjacency, different-room concurrency, valid and conflicting edits, the
  Cancel edit control, confirmed cancellation and slot reuse, Keep/Escape
  confirmation, reload persistence, literal text rendering, keyboard focus,
  and `390 × 844` no-overflow.
- Console contained only the optional missing `favicon.ico` 404; no JavaScript
  exception occurred.
- Playwright artifacts were moved to
  `/private/tmp/spec-agents-room-v4-direct-treatment-correction-artifacts-20260815`.
