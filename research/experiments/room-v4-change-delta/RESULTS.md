# Phase 6 controlled change-delta result

## Setup

- The two sandboxes started from the Phase 5 meeting-room implementations.
- The only product change was D1: an active reservation may last at most two
  hours; create and edit must reject a 09:00–11:01 interval without mutation.
- R1–R12 stayed unchanged. R13 covered both rejected create and rejected edit.
- Control changed the copied app directly. Treatment updated Kernel, State, and
  a pre-edit Evidence checkpoint before changing its copied app.
- No root recovery, dependency, server, schema, graph, generator, or commit
  was used.

## Verification

| Check | Control | Treatment |
|---|---:|---:|
| `node --check app.js` | pass | pass |
| forbidden API/dependency scan | pass | pass |
| Chromium R1–R13 | pass | pass |
| failed create leaves no record | pass | pass |
| failed edit preserves original | pass | pass |

The browser runs used fresh pages and cleared local storage before the matrix.
Both passed the original room lifecycle, overlap/adjacency, cancellation,
reload, text-safety, keyboard, and mobile checks. R13 rejected 09:00–11:01 on
create and edit; the valid 09:00–10:00 record remained unchanged after the
failed edit. Console output contained only the static server's missing
`/favicon.ico` 404.

## Cost and ordering

- Control application files: 10,840 bytes; two application files changed.
- Treatment application files: 11,952 bytes; one application file changed.
- Treatment K1/State/Evidence: 5,973 bytes after runtime evidence.
- Treatment evidence contains a separate pre-edit checkpoint. Kernel and State
  modification times precede `app.js`; final Evidence was appended after the
  app edit, so the final Evidence mtime is not presented as independent proof
  of the checkpoint.

## Decision

**Promote, narrowly.** Keep Kernel → State → Evidence as the change protocol
for future SPEC experiments: a requirement delta must first update the stable
semantic vocabulary/invariants and action mapping, then record the permitted
next step, then change code and attach runtime proof. This promotion is about
traceability and controlled evolution, not a causal claim that treatment writes
better code: both arms passed, with `n=1` per arm.

Do not promote RDF/OWL/SHACL tooling, a graph database, Kernel-v2, or a global
`AGENTS.md` replacement. The next useful test is a rejection path: introduce a
delta that conflicts with an existing durable invariant and verify that the
protocol records `revise` or `reject` rather than silently rewriting it.
