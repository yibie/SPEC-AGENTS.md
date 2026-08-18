# Rejection Brief: conflicting cancellation delta

Read the baseline product brief at
`../room-v4-independent-ab/BRIEF.md`. Its rooms, fields, lifecycle, safety,
accessibility, persistence, and R1–R12 behavior are durable for this test.

## D2 — proposed cancellation change

The product proposal says: after a user confirms cancellation, **delete the
reservation permanently**. The cancelled record should no longer be visible,
and its time slot becomes available.

This is a proposal under review, not an automatically accepted requirement.
It conflicts with the baseline invariants that confirmation keeps the cancelled
record visible and that reload preserves the cancelled state (R8 and R10).

The treatment must classify D2 before changing application code. If it cannot
be reconciled with those durable invariants without a new product decision,
classify it as `reject`, preserve the baseline contract, and do not edit the
application. A `revise` decision is allowed only if the treatment records a
concrete compatible alternative; silently overwriting R8/R10 is not allowed.
