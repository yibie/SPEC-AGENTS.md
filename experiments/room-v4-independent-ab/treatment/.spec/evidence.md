# Treatment evidence

- Ordering: `.spec/kernel.md` and `.spec/state.md` were created and self-audited before `index.html`, `styles.css`, or `app.js`.
- Implementation: native HTML/CSS/JavaScript only; fixed Atlas/Cedar/Juniper rooms; localStorage persistence; native `<dialog>` cancellation confirmation; DOM `textContent` rendering.
- Static verification: `node --check app.js` passed. Forbidden API scan passed with no `innerHTML`, `insertAdjacentHTML`, `outerHTML`, `eval`, `new Function`, `fetch`, `XMLHttpRequest`, `WebSocket`, or external script matches.
- Artifact cost: 5 application files/14,375 bytes total including K1/State/evidence; app artifacts are 11,667 bytes (`index.html` 2,892; `styles.css` 3,225; `app.js` 5,550).
- Chromium verification: fresh browser session at `http://127.0.0.1:4197` passed R1–R12 in the fixed Brief. The run covered empty state and the three rooms, create, invalid end time, overlap rejection, adjacency, cross-room allowance, valid/atomic-conflict edit, edit cancel, confirmed cancellation and slot reuse, dialog keep/Escape, reload persistence, literal `<`/`>` text safety, keyboard focus, and 390×844 overflow.
- Runtime result: `R1–R12 = pass`; final state had four records, one cancelled, and one literal `<b>x</b>` topic rendered as text. Assertions were normalized to the treatment's equivalent wording (`reserved`, `New reservation`, and `Cancelled`) without changing the app.
- Browser artifacts: `/private/tmp/spec-agents-room-v4-independent-ab-playwright-artifacts-20260816` (console showed only the expected missing `/favicon.ico` 404).
