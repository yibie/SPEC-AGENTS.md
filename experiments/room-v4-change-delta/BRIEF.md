# Change Brief: Meeting-room reservation duration delta

Read the baseline product brief at
`../room-v4-independent-ab/BRIEF.md`. Its rooms, fields, lifecycle, safety,
accessibility, persistence, and R1–R12 behavior remain authoritative.

## D1 — maximum reservation duration

An active reservation may last **at most two hours** on its one local date.
Reject any create or edit where `end - start > 120 minutes`; show an actionable
nearby error and leave the existing records unchanged. The limit applies to
every room and does not change half-open overlap or adjacency semantics.

Add this scenario to the unchanged R1–R12 matrix:

| ID | Scenario | Expected result |
|---|---|---|
| R13 | Create a 09:00–11:01 reservation, then attempt an edit to 09:00–11:01 | Reject both attempts near the end-time field; create nothing and preserve the edited record |

The exact error wording is implementation-defined; the observable contract is
that the maximum-duration rule is enforced for both create and edit without
mutation. Keep the app no-build, no-network, native HTML/CSS/JavaScript, and
do not add dependencies or ontology infrastructure.
