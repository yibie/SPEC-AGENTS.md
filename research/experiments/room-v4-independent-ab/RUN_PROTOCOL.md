# Independent A/B run protocol

This is a fresh reproducibility run inside the repository. `control/` and
`treatment/` are independent sandboxes. Each Luna must operate only in its
assigned directory and must not edit the other sandbox, this directory's
Brief/protocol, or repository-root files.

Both runs receive exactly `BRIEF.md`; do not read prior experiment results or
seeded defect expectations while implementing.

## Control

Implement the Brief directly. Do not create a Kernel snapshot. Record the
implementation, static checks, and artifact cost in `control/evidence.md`.

## Treatment

Before the first application file, create a compact `.spec/kernel.md` and
`.spec/state.md`. K1 must cover the named rooms, booking relations,
lifecycle, local-time validity, half-open overlap/adjacency, cancellation
release, text safety, persistence, accessibility, and R1–R12 Action Contracts.
Self-audit K1, then let the same fresh Luna continue to implement the Brief.
Record the ordering, checks, costs, and runtime status in
`treatment/.spec/evidence.md`.

## Shared constraints

- No root recovery: if blocked, report and stop; do not ask another agent to
  write missing code.
- No `AGENTS.md` changes, dependencies, server code, schemas, graphs,
  generators, or commits.
- Use native HTML/CSS/JavaScript and local persistence only.
- Leave a concise completion report in the assigned directory.
