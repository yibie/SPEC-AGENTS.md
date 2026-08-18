# K1 — room reservation kernel

- Rooms are exactly `Atlas`, `Cedar`, `Juniper`; a Booking has id, topic, person, local one-day date, start/end time, room, and lifecycle `active|cancelled`.
- Times are local wall-clock values on one date; cross-midnight is invalid. An active interval is half-open `[start,end)`: `start < end`; overlap iff `a.start < b.end && b.start < a.end`; equal end/start is adjacent and allowed.
- Every active Booking duration is at most 120 minutes on its one local date; a duration over 120 minutes is invalid for every room and does not alter state.
- Create/edit validate required fields, room membership, local date/time, maximum duration, and active same-room/date overlap. Edit is atomic: any validation failure leaves the existing booking unchanged.
- Cancellation requires confirmation, changes lifecycle to cancelled, keeps the record visible, and removes it from conflict checks so its slot is released.
- Persist the complete booking array in local storage; reload must not duplicate or lose edits/cancellation state. User text is rendered only with text nodes / `textContent`, never HTML parsing.
- Semantic labelled native controls, keyboard-operable confirmation, visible focus, responsive layout without horizontal overflow, and non-color state labels are required.

## Action contracts

R1 initial: exactly three rooms, form, list, and empty state. R2 valid create: complete active record appears immediately. R3 end <= start: nearby error, no create. R4 overlap: nearby error, existing record preserved. R5 adjacency allowed. R6 same time/different room allowed. R7 valid edit updates one; conflict is atomic. R8 confirmed cancel keeps record and releases slot. R9 escape/cancel confirmation preserves active record. R10 reload preserves state without duplicates. R11 `<`/`>` remain literal text with no nested/script nodes. R12 keyboard/mobile controls work at 390px with no horizontal overflow. R13 create and edit of 09:00–11:01 are rejected near end-time; create makes no record and edit preserves the original record.
