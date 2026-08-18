# Phase 7 rejection-path result

## Setup

- Both sandboxes started from the Phase 5 meeting-room baseline.
- D2 proposed permanently deleting a reservation after confirmed cancellation.
- The baseline contract requires the cancelled record to remain visible and
  survive reload (R8/R10).
- Control applied D2 directly. Treatment reviewed D2 through the copied
  Kernel/State/Evidence and was allowed to leave the app unchanged on reject.

## Verification

| Check | Control | Treatment |
|---|---:|---:|
| `node --check app.js` | pass | pass |
| forbidden API/dependency scan | pass | pass |
| D2 direct/focused check | deletes record | not authorized |
| baseline R1–R12 | R8/R10 contradiction | pass |
| app changed from baseline | yes | no (`cmp` identical) |

Control's focused browser run confirmed the expected contradiction: after
confirmation the cancelled record disappeared, the slot became reusable, and
reload did not restore the cancelled record. The first contradiction is R8;
R10 repeats it after reload.

Treatment classified D2 as `reject`, preserved the Kernel cancellation
invariant, recorded the conflict against R8/R10 in State/Evidence, and left
`index.html`, `styles.css`, and `app.js` byte-for-byte unchanged. Its unchanged
app passed the full baseline R1–R12 browser matrix.

## Cost

- Control app: 10,615 bytes across three application files; one app file
  changed for D2.
- Treatment app: 11,667 bytes across three unchanged application files.
- Treatment State/Evidence additions: 3,072 bytes; Kernel remained unchanged.
- No dependency, schema, graph, generator, server, or root recovery was used.

## Decision

**Promote the rejection gate, narrowly.** A proposed change that contradicts a
durable Kernel invariant must be classified before application edits. In this
case the correct outcome is `reject`, with the old app and R8/R10 preserved
until a separate product decision changes the cancellation policy.

This validates one conflict scenario, not general model behavior. The next
useful test is the `revise` path: propose a compatible alternative (for example,
an explicit archive view while retaining the cancelled record) and verify that
the protocol records the revised contract before implementation rather than
silently choosing one interpretation.
