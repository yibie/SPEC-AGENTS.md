# Control evidence

- Implemented `index.html`, `styles.css`, and `app.js` in this directory.
- `node --check app.js`: passed.
- Uses native HTML controls, CSS, DOM text APIs (`textContent`), and `localStorage`; no dependencies or network requests.
- Initial agent pass did not include a browser; the root verification is recorded below.
- Cost: 3 application files plus this evidence note; no build or install step.

## Chromium verification

- Local static server: `http://127.0.0.1:4194/`; session: `direct-control`.
- R1–R12: **PASS**. This covered valid/invalid time, overlap, adjacency,
  different-room concurrency, valid and conflicting edits, cancellation and
  slot reuse, Escape/Keep confirmation, reload persistence, literal text
  rendering, keyboard focus, and `390 × 844` no-overflow.
- Console contained only the expected missing optional `favicon.ico` 404; no
  JavaScript exception was observed.
