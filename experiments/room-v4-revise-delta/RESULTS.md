# Phase 8 Results: Compatible Revision Path

## Decision

**Promote the bounded `revise` path.** When a proposal conflicts with a
durable invariant, the treatment must name one concrete compatible alternative,
record it in Kernel/State/Evidence, and only then edit the application.

This result validates one revision scenario. It is not a causal claim about
model behavior and does not justify ontology tooling, schemas, graphs, or a
replacement for `AGENTS.md`.

## Fixed delta

- **D2:** permanently delete a reservation after confirmed cancellation.
- **D3:** retain cancelled records and add a presentation-only
  `#archive-toggle`.
  - Default: all records visible; button is `Hide archived`,
    `aria-pressed="true"`.
  - First click: hide cancelled records; button becomes `Show archived`,
    `aria-pressed="false"`.
  - Second click: restore cancelled records.
  - Reload: return to the default all-visible view.

D2 conflicts with K1, R8, and R10. D3 preserves the cancellation/storage
contract and adds only R13 presentation behavior.

## Verification

| Check | Control | Treatment |
|---|---|---|
| Static syntax and forbidden-API scan | pass | pass |
| Baseline R1–R12 | D2 intentionally contradicts R8, then R10 after reload | pass |
| R13 archive hide/show | not applicable | pass |
| First contradiction | R8 | none |
| Storage mutation from archive view | D2 deletes the record | none; cancelled record remains persisted |

The treatment's Chromium run at `http://127.0.0.1:4203` passed R1–R13. It
showed the cancelled record by default, hid it while the active record stayed
visible, restored it on the second click, and showed it again after reload.
The control run at `http://127.0.0.1:4202` observed the direct D2 deletion:
R8 failed first and the missing record after reload failed R10.

## Protocol deviation

The initial D3 wording inverted the default button label and state flag. The
ambiguity was caught before runtime, then Brief/Protocol and the treatment
state were corrected to the baseline-compatible polarity. It changed no data
boundary and is retained as a phase-local deviation, not a new product rule.

## Cost and artifacts

- Control application files: **10,516 bytes**.
- Treatment application files: **12,186 bytes**.
- Treatment Kernel/State/Evidence: **5,976 bytes**.
- Browser artifacts:
  `/private/tmp/spec-agents-room-v4-revise-delta-playwright-artifacts-20260816`.
- Console output contained only the expected missing `/favicon.ico` 404 in
  each static server.

## Next boundary

Keep the protocol narrow: a future revision needs one named compatible
alternative, an explicit invariant mapping, and baseline proof. A second
revision in another domain is a later evidence question; no ontology
infrastructure is needed for this phase.
