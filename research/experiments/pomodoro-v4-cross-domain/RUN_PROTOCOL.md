# Cross-domain revision protocol

This is a bounded transfer test of the Kernel → State → Evidence → Code rule.
Each arm is isolated under this directory. Do not modify the repository root,
`AGENTS.md`, the source baseline in `/private/tmp`, the other arm, or prior
experiments. Do not add dependencies, servers, schemas, graphs, generators,
notifications, sounds, or unrelated UI.

## Fixed order

1. Read `BRIEF.md` and the copied baseline.
2. Control applies D4 directly in its app and records the expected R6 conflict.
3. Treatment, before any app edit:
   - updates `.spec/kernel.md` with the bounded D5 concept/invariant/action;
   - records `decision: revise` and D4 → D5 in `.spec/state.md`;
   - appends the pre-edit mapping and permitted next action to
     `.spec/evidence.md`.
4. Only then does treatment implement D5.
5. Run static checks for both arms. Use a controlled `Date.now()` browser clock
   to finish a focus timer without waiting 25 minutes.
6. Run the unchanged R1–R12 smoke matrix and the focused R13 check. Control may
   stop at the first contradiction; treatment must pass R1–R13.

## Verification rules

- `node --check app.js` must pass in both arms.
- A scan must find no network APIs, external URLs, HTML-string injection, or
  animation/gradient dependency in the copied app.
- The treatment checkpoint must be written before `index.html`/`app.js` is
  edited; record the file-order evidence.
- Browser console output and any harness deviation are recorded. A fast-forward
  clock is a test technique, not a product feature.
- Decide only among `promote`, `revise`, and `reject` for this bounded rule.
