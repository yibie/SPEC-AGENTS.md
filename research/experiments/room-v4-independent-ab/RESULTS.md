# Independent A/B result

## Setup

- Both fresh Luna agents received only `BRIEF.md` and `RUN_PROTOCOL.md`.
- Control implemented directly in `control/`; treatment created and
  self-audited `.spec/kernel.md` and `.spec/state.md` before creating any app
  file, then implemented in `treatment/`.
- No root files, `AGENTS.md`, old experiments, or the other sandbox were
  changed by either implementation agent.

## Verification

| Check | Control | Treatment |
|---|---:|---:|
| `node --check app.js` | pass | pass |
| forbidden API/dependency scan | pass | pass |
| Chromium R1–R12 | pass | pass |
| 390×844 horizontal overflow | pass | pass |

The browser run used fresh pages and cleared each app's local storage before
the matrix. Both final states contained four records, one cancelled record,
and the literal `<b>x</b>` topic as text. The only console noise was the
static server's missing `/favicon.ico` 404.

## Cost

- Control app: 3 files, 10,541 bytes; no spec artifacts or dependencies.
- Treatment app: 3 app files, 11,667 bytes, plus 4,306 bytes of K1/State/evidence
  artifacts after runtime evidence was recorded.

## Decision

This is a valid first independent sample, not a causal benchmark: `n=1` per
treatment arm and both implementations passed the same functional gate. The
useful result is that a small ontology-shaped kernel was cheap enough to add
and provided an explicit vocabulary and action-contract checklist without
requiring a graph database, RDF/OWL files, code generation, or a second
requirements document.

The next experiment should measure change handling rather than add more
features: introduce one controlled Brief delta, require each run to map the
delta to Kernel/State/Evidence, and record whether the change is accepted,
revised, or rejected while preserving the original R1–R12 gate.
