# Evidence

## Pre-edit checkpoint

- Observation: D2 proposes permanent deletion after confirmed cancellation.
- Observation: K1 requires cancellation to keep the record visible and
  persist the complete booking array; R8 requires the record to remain and
  release its slot; R10 requires cancellation state to survive reload.
- Interpretation: D2 contradicts the durable cancellation invariant and both
  R8/R10, so it cannot be accepted silently.
- Decision: `revise` before application edits.
- Mapping: D2 → K1/R8/R10 conflict; D3 → retained `cancelled` records plus
  `#archive-toggle` presentation behavior covered by R13.
- Next action: implement only D3, preserving R1–R12 and storage semantics.

## Protocol-semantic correction

- Observation: the initial D3 implementation used the wrong presentation
  polarity (`Show archived`/false) for the default view.
- Interpretation: R8/R10 require a cancelled record to remain visible by
  default; this is a UI-state correction, not a change to D3's data boundary.
- Correction: default is now all-visible with `Hide archived` and
  `aria-pressed="true"`; the first toggle hides cancelled records and the
  second restores them.

## Verification record

- Observation: `node --check app.js` passed.
- Observation: forbidden-API scan passed for `index.html`, `app.js`, and
  `styles.css`.
- Observation: application edits followed the ordering checkpoint: State and
  Evidence were updated before `index.html`/`app.js`.
- Chromium verification: fresh session at `http://127.0.0.1:4203` passed
  `R1–R13`. R8/R10 continued to show cancelled records and persistence; R13
  showed the cancelled record by default, hid it while the active record stayed
  visible, restored it on the second click, and kept it visible after reload.
- R13 UI evidence: default `Hide archived`/`aria-pressed=true`, hidden state
  `Show archived`/`false`, restored state `Hide archived`/`true`; no stored
  booking mutation occurred.
- Protocol deviation: the initial D3 wording inverted the button label and
  state flag. Before runtime, the Brief/Protocol and treatment state were
  corrected to the baseline-compatible polarity; the correction was recorded
  above and did not change D3's data boundary.
- Application files total 12,186 bytes; Kernel/State/Evidence total 5,976
  bytes. Browser artifacts are in
  `/private/tmp/spec-agents-room-v4-revise-delta-playwright-artifacts-20260816`;
  console output contained only the expected missing `/favicon.ico` 404.
