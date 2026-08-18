# Revision Brief: compatible archive-view revision

Read the baseline product brief at
`../room-v4-independent-ab/BRIEF.md`. Its rooms, fields, lifecycle, safety,
accessibility, persistence, and R1–R12 behavior remain durable.

## D2 proposal under review

The proposal again says: after confirmed cancellation, permanently delete the
reservation record. That conflicts with the baseline cancellation invariant and
R8/R10.

## D3 — pre-registered compatible revision

The treatment is authorized to revise D2 into this compatible alternative:

- Keep the cancelled record and its persisted `cancelled` lifecycle exactly as
  R8/R10 require.
- Add one labelled native button with `id="archive-toggle"`, initially showing
  `Hide archived` and `aria-pressed="true"`; the default view therefore keeps
  cancelled records visible as required by R8/R10.
- Clicking it changes the label to `Show archived`, sets `aria-pressed="false"`,
  and hides cancelled records from the visible list while leaving active records
  visible. Clicking again shows the cancelled records again.
- This is a presentation filter only: it must not delete, mutate, or rewrite
  stored records. Reload returns to the default visible-all view unless the
  implementation explicitly persists the filter without changing data.

Add this scenario to the unchanged R1–R12 matrix:

| ID | Scenario | Expected result |
|---|---|---|
| R13 | After creating and cancelling one reservation, toggle the archive view off and on | Cancelled record hides while active records remain; toggling again restores it; record data and R8/R10 behavior remain intact |

The decision must be recorded as `revise`, not as silent acceptance of D2.
