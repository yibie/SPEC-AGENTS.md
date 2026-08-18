# Compatible-revision protocol

This is a fresh revise-path run from the Phase 5 meeting-room baseline. Each
agent works only in its assigned directory. Do not modify the repository root,
`AGENTS.md`, this Brief, the other sandbox, the Phase 5 baseline, or old
experiments. No root recovery, dependency, server, schema, graph, generator,
or commit.

## Baseline

The assigned files are copied from `../room-v4-independent-ab/`. R1–R12 are
durable. D2 is the conflicting proposal; D3 is the only pre-registered
compatible revision.

## Control

Apply D2 directly to the copied app without a Kernel/State conflict gate. The
focused browser check should expose the same R8/R10 contradiction as the prior
control. Record the direct edit, static checks, cost, and first contradiction in
`control/evidence.md`. Do not implement D3 in control.

## Treatment

Before changing any application file:

1. Compare D2 with the Kernel cancellation invariant and R8/R10.
2. Record `decision: revise` in State, explicitly naming D3 as the compatible
   archive-view alternative and preserving the cancelled-record invariant.
3. Append an Evidence checkpoint mapping D2 → conflict and D3 → R13.
4. Only then implement D3 in the copied app.

The treatment must keep R1–R12 and implement the exact `#archive-toggle`
contract in the Brief. No silent deletion, no new dependencies, and no
additional product features.

Protocol correction before runtime: the initial D3 wording inverted the button
label and state flag. The baseline-compatible meaning is now explicit: default
all-visible is `Hide archived`/`aria-pressed=true`; the first click hides
cancelled records and changes to `Show archived`/`false`. This correction is
phase-local and must be recorded as a harness/spec deviation in Evidence.

## Shared verification

- Both app directories pass `node --check app.js` and the forbidden-API scan.
- Control runs the focused D2 cancel/reload contradiction check.
- Treatment runs baseline R1–R12 plus R13 archive hide/show, including
  cancellation persistence and no data mutation.
- Record decision, file ordering, cost, first contradiction R-id, and any
  wording-only assertion normalization.
