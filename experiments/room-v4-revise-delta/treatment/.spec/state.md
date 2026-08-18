# State model

`state = { bookings: Booking[] }`, loaded once from `localStorage` key `room-v4-independent-ab-treatment`; malformed data falls back to empty. Booking identity is a generated id and never changes on edit. Rendering derives room summaries and the booking list from state; cancelled bookings remain visible but are excluded from availability checks. Mutations are create, edit (replace by id only after full validation), and cancel (lifecycle transition after confirmation), each followed by persistence and render. Dialog state is transient and never persisted.

Validation boundary: trim topic/person, require all fields, allow only the fixed room set, require ISO local date and `HH:MM` values, reject `end <= start`, and reject overlap with active bookings having same room/date. Errors attach to the relevant field or form status. DOM output uses `createElement`/`textContent`; no `innerHTML`, `insertAdjacentHTML`, eval, or network APIs.

## Decision checkpoint

`decision: revise`

D2 (permanently delete a confirmed-cancelled reservation) conflicts with the
Kernel cancellation invariant and R8/R10, which require retaining the
cancelled record, persisting it, and keeping it visible after reload. Adopt
the pre-registered D3 compatible revision: preserve cancelled records and add
the native `#archive-toggle` presentation filter. The default is the
all-visible view with `Hide archived` and `aria-pressed="true"`; the first
toggle hides cancelled records and changes to `Show archived`/
`aria-pressed="false"`. Toggling only changes which records are shown and
never changes stored state. Active records remain visible while the filter is
on, and reload returns to the default all-visible view.
