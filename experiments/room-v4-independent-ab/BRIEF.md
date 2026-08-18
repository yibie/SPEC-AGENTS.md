# Fixed Brief: Meeting-room reservation A/B repeat

This file is the only product input for both runs. Do not change it.

Build a no-install, no-build, no-network meeting-room reservation page using
native HTML, CSS, and JavaScript.

## Product scope

- Offer exactly these three rooms: `Atlas`, `Cedar`, and `Juniper`.
- Create a reservation with topic, person, local one-day date, start time,
  end time, and room.
- Edit and cancel reservations. Cancellation requires confirmation and keeps
  the cancelled record visible.
- Clearly distinguish active and cancelled records.
- Preserve reservations, edits, and cancellation state after reload.
- Use semantic HTML, labelled native controls, keyboard operation, visible
  focus, and a responsive layout that works at `390 × 844`.
- Render topic and person as text, never as HTML.

Out of scope: accounts, permissions, server storage, notifications, recurring
bookings, duplicate reservations, timezone conversion, and cross-midnight
reservations. All times are local and belong to one date.

## Fixed behavior matrix

| ID | Scenario | Expected result |
|---|---|---|
| R1 | Initial load | Three named rooms, form, list, and clear empty state |
| R2 | Valid reservation | Active list shows the complete record immediately |
| R3 | End time earlier than or equal to start | Reject nearby the field; create nothing |
| R4 | Same date/room overlapping interval | Reject create or edit; preserve existing record |
| R5 | Same room, end equals next start | Allow both reservations |
| R6 | Same time, different room | Allow both reservations |
| R7 | Edit reservation | Re-run validation; valid edit updates one record; conflict is atomic |
| R8 | Confirm cancellation | Mark cancelled, keep record, release slot for a new reservation |
| R9 | Escape/cancel confirmation | Preserve the active record |
| R10 | Reload | Preserve active/cancelled state and edits without duplicates |
| R11 | `<`/`>` in topic or person | Show literal text; create no nested element or script |
| R12 | Keyboard/mobile | Controls and confirmation work by keyboard; no horizontal overflow |

## Static requirements

- JavaScript must parse with `node --check`.
- No external dependency, network request, or unsafe HTML injection API.
- Keep user text on safe DOM text APIs.
