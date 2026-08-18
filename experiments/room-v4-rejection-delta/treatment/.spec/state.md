# State model

`state = { bookings: Booking[] }`, loaded once from `localStorage` key `room-v4-independent-ab-treatment`; malformed data falls back to empty. Booking identity is a generated id and never changes on edit. Rendering derives room summaries and the booking list from state; cancelled bookings remain visible but are excluded from availability checks. Mutations are create, edit (replace by id only after full validation), and cancel (lifecycle transition after confirmation), each followed by persistence and render. Dialog state is transient and never persisted.

Validation boundary: trim topic/person, require all fields, allow only the fixed room set, require ISO local date and `HH:MM` values, reject `end <= start`, and reject overlap with active bookings having same room/date. Errors attach to the relevant field or form status. DOM output uses `createElement`/`textContent`; no `innerHTML`, `insertAdjacentHTML`, eval, or network APIs.

## Phase 7 treatment decision

- `decision: reject`
- Conflict: D2 permanently deletes a confirmed cancellation and makes its
  record invisible. K1 requires confirmed cancellation to keep the record
  visible while releasing its slot (R8), and requires the cancelled lifecycle
  to survive reload without loss or duplication (R10). Deletion therefore
  changes both the cancellation contract and persisted lifecycle state; it is
  not compatible with the durable baseline without a new product decision.
- Permitted next step: preserve the baseline cancellation behavior and ask for
  an explicit product decision before considering any retention/deletion
  policy. No application change is authorized in this treatment.
