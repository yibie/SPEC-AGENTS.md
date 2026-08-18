# Control evidence

- Files: `index.html`, `styles.css`, `app.js`; native HTML/CSS/JavaScript only, localStorage persistence.
- Static checks: `node --check app.js` passed. Forbidden-API scan found no `fetch`, `XMLHttpRequest`, external URL, `innerHTML`, `outerHTML`, `insertAdjacentHTML`, or dependency imports.
- Behavior coverage: form validation, half-open overlap checks, atomic edit, cancellation confirmation via native dialog, safe text rendering with `textContent`, reload persistence, responsive layout and keyboard-native controls are implemented.
- Artifact cost: 3 application files + this evidence file; no dependencies, build step, server, or schema.
- Chromium verification: fresh browser session at `http://127.0.0.1:4196` passed R1–R12 in the fixed Brief. The run covered empty state and the three rooms, create, invalid end time, overlap rejection, adjacency, cross-room allowance, valid/atomic-conflict edit, edit cancel, confirmed cancellation and slot reuse, dialog keep/Escape, reload persistence, literal `<`/`>` text safety, keyboard focus, and 390×844 overflow.
- Runtime result: `R1–R12 = pass`; final state had four records, one cancelled, and one literal `<b>x</b>` topic rendered as text. The first exploratory assertion used title-case `Cancelled` while the UI intentionally emits uppercase `CANCELLED`; the normalized rerun passed without changing the app.
- Browser artifacts: `/private/tmp/spec-agents-room-v4-independent-ab-playwright-artifacts-20260816` (console showed only the expected missing `/favicon.ico` 404).
