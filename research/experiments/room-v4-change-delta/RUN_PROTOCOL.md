# Controlled change-delta protocol

This is a fresh evolution run from the Phase 5 meeting-room baseline. Each
agent works only in its assigned directory. Do not read prior result files or
modify the repository root, `AGENTS.md`, the baseline experiment, this Brief,
or the other sandbox. No root recovery, dependencies, servers, schemas,
graphs, generators, or commits.

## Baseline

The assigned app files are copied from
`../room-v4-independent-ab/`. They are the starting implementation, not a new
product. The only product change is D1 in `BRIEF.md`.

## Control

Apply D1 directly to the copied app. Do not create or update a Kernel before
the application edit. Record the implementation, static checks, cost, and
change evidence afterward in `control/evidence.md`.

## Treatment

The copied `.spec/kernel.md` and `.spec/state.md` are the baseline snapshots.
Before changing any application file:

1. Update Kernel with D1's entity/invariant and the affected create/edit action
   contracts, including R13.
2. Update State with a finite change-gate checkpoint and permitted next step.
3. Append the checkpoint and action-to-R13 mapping to `.spec/evidence.md`.

Only after that checkpoint may the same agent edit the application. Record the
final static/runtime evidence and artifact cost in the same evidence file.

## Shared verification

- `node --check app.js` and the existing forbidden-API scan must pass.
- Re-run unchanged R1–R12 plus R13 in real Chromium.
- R13 must exercise both a rejected create and a rejected edit, with the
  original record preserved after the failed edit.
- Record file ordering, context/artifact cost, first failing R-id, and any
  wording-only assertion normalization. A passing matrix is not causal proof.
