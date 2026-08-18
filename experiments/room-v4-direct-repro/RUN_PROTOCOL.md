# Direct-directory run protocol

This is a reproducibility run in the repository directory, not a git
worktree. `control/` and `treatment/` are independent sandboxes. Each Luna
must work only inside its assigned directory and must not edit the repository
root or the other sandbox.

Both runs receive the same `BRIEF.md`. Do not read prior experiment results or
seeded defect expectations while implementing.

## Control

Implement the Brief directly. Do not create a Kernel snapshot. Record the
implementation and verification facts in `control/evidence.md` when done.

## Treatment

Before the first application file, create a compact `.spec/kernel.md` and
`.spec/state.md` for this bounded context. The Kernel must cover room/booking
relations, lifecycle, local-time validity, half-open overlap/adjacency,
cancellation release, text safety, persistence, accessibility, and R1–R12
Action Contracts. Self-audit the snapshot, then continue in the same run to
implement the Brief. Record K1, implementation checks, and remaining runtime
evidence in `treatment/.spec/evidence.md`.

## Shared constraints

- No root recovery: if an implementation is blocked, report the blocker and
  stop; do not ask another agent to write the missing code.
- No `AGENTS.md` changes, dependencies, server code, schemas, graphs, or
  generators. Do not commit.
- Use native HTML/CSS/JavaScript and local persistence only.
- Leave a concise completion report in the assigned directory.
