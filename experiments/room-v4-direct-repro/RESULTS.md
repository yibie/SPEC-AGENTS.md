# Direct-directory run results

Date: 2026-08-15

## Setup

- Shared fixed input: `BRIEF.md`
- Protocol: `RUN_PROTOCOL.md`
- Control: fresh `gpt-5.6-luna`, direct `control/` sandbox
- Treatment: Luna treatment thread reused from the previous no-artifact run
  because the agent-thread limit prevented a third fresh thread; it had not
  previously written files. This is a recorded protocol deviation.
- No root code recovery and no `AGENTS.md` changes.

## Agent output

| Run | Pre-code artifact | App | Static check |
|---|---|---|---|
| Control | none by protocol | `index.html`, `styles.css`, `app.js` | `node --check`: pass |
| Treatment | `.spec/kernel.md`, `.spec/state.md` | `index.html`, `styles.css`, `app.js` | `node --check`: pass |

Both implementations are native HTML/CSS/JavaScript with no external
dependencies or network API. Treatment also left a duplicate
`experiments/room-v4-direct-repro/styles.css` at the experiment root.

## Browser result

Control passed R1–R12 in real Chromium at `390 × 844` as well as the desktop
flow. Treatment passed R1, but R2 failed: valid submission persisted a record
while `form.reset()` threw because the `id="reset"` button shadows the native
form method. The remaining treatment scenarios were not used to hide that
blocker. Console noise was the optional favicon 404 plus the treatment
TypeError.

## Decision

`revise / inconclusive` for the protocol experiment. Direct repository
directories allowed both Luna runs to land artifacts, unlike Phase 3, but this
single pair does not prove Bootstrap caused the control/treatment behavior
difference. Fixing the treatment app would be a separate agent run, not root
recovery in this evidence.
