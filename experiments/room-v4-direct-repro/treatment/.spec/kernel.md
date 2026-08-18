# K1 Kernel — meeting-room reservation

## Concepts and invariants

- `Room` is one of exactly three selectable rooms; each `Booking` belongs to one room.
- `Booking` has topic, person, local one-day date, `start`, `end`, room, and `status` (`active|cancelled`).
- A valid local interval has `end > start` on the same date. Intervals are half-open `[start,end)`: overlap iff `a.start < b.end && b.start < a.end`; equal endpoints are adjacent and allowed.
- Only active bookings in the same date and room occupy a slot. Cancel changes status, retains the record, and releases its slot.
- Create/edit validation is atomic: invalid time or conflict causes no write; edit updates one existing id, never a duplicate.
- Reload persists records, edits, status, and uniqueness in local storage. User topic/person are rendered as text, never HTML.
- Native labelled controls, keyboard focus/operation, confirmation dialog, and responsive layout are observable accessibility boundaries.

## Lifecycle and actions

`form → active → edited active | cancelled`; Escape/cancel on confirmation leaves active unchanged.

Each contract has guard, effect, outcome, and verification scenario:

| ID | Guard | Effect | Outcome | Verify |
|---|---|---|---|---|
| R1 | initial load | read records, render rooms/form/list | 3 rooms + clear empty/list state | load empty |
| R2 | complete fields, valid interval, no conflict | append active record + persist | complete active row | submit valid |
| R3 | `end <= start` | reject, no write | nearby error, no row | submit invalid time |
| R4 | same date/room active overlap | reject create/edit | error, prior record intact | submit overlap |
| R5 | same room, adjacent endpoints | accept both | two rows | submit adjacency |
| R6 | same time, different room | accept both | two rows | submit rooms |
| R7 | existing id, new values pass checks | replace same id atomically | one updated row | edit valid/conflict |
| R8 | active row, confirmed cancel | set cancelled + persist | retained cancelled row; slot free | cancel then reuse |
| R9 | confirmation Escape/cancel | no state change | active row remains | both exits |
| R10 | persisted records | reload and render once | edits/status survive, no duplicates | refresh |
| R11 | text contains `<`/`>` | assign text nodes | literal text only | submit markers |
| R12 | keyboard or 390×844 | native focus/dialog/layout | operable, no overflow | keyboard/mobile |

## Self-audit

R1–R2 cover presentation/create; R3–R7 cover local-time and relation boundaries; R8–R9 lifecycle; R10 persistence; R11 safety; R12 accessibility/responsive. No server, accounts, notifications, recurrence, timezone conversion, or cross-midnight model is present.
