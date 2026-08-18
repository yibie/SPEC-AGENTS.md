# Rejection-path protocol

This is a fresh conflict review from the Phase 5 meeting-room baseline. Each
agent works only in its assigned directory. Do not modify the repository root,
`AGENTS.md`, this Brief, the other sandbox, the Phase 5 baseline, or any old
experiment. No root recovery, dependency, server, schema, graph, generator,
or commit.

## Baseline

The assigned files are copied from `../room-v4-independent-ab/`. The baseline
Brief and R1–R12 are durable inputs. D2 is the only proposed change.

## Control

Apply D2 directly to the copied app without a Kernel/State conflict gate. The
result is expected to expose whether direct implementation silently violates
R8/R10. Record the edit, static checks, cost, and the first baseline R-id that
the browser check contradicts in `control/evidence.md`.

## Treatment

The copied `.spec/kernel.md` and `.spec/state.md` are the baseline snapshots.
Before changing any application file:

1. Compare D2 with the existing cancellation invariant and R8/R10.
2. Preserve the Kernel invariant; do not silently rewrite it.
3. Update State with `decision: reject` (or a concrete compatible `revise`),
   the conflict reason, and the permitted next step.
4. Append an Evidence checkpoint mapping D2 to the conflicting R-ids.

For `reject`, do not modify `index.html`, `styles.css`, or `app.js`. The
unchanged app must still pass the baseline R1–R12 browser matrix. A review
decision is the treatment result; there is no D2 implementation to test.

## Shared verification

- Both app directories pass `node --check app.js` and the forbidden-API scan.
- Control runs a focused cancel/reload check and records the expected R8/R10
  contradiction if D2 was applied.
- Treatment proves its app is unchanged from the copied baseline, its State or
  Evidence records `reject`/`revise`, and its unchanged app passes R1–R12.
- Record exact decision, first failing R-id, file ordering, cost, and any
  wording-only assertion normalization. Do not call a rejected proposal an
  implementation failure.
