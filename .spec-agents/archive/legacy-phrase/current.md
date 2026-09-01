# Current Phase

## Status

Complete — promote bounded cross-domain revise path

## Goal

Test whether the Kernel → State → Evidence → Code rule survives a second
bounded context and a different kind of compatible change: persistent domain
state rather than a presentation filter.

## Entry Condition

- Phase 8 validated one compatible revise in the meeting-room domain.
- The next evidence question was a different domain or change type.

## Scope

- Run `research/experiments/pomodoro-v4-cross-domain/` from the validated Pomodoro K1
  baseline.
- Review D4 auto-completion conflict and require treatment to record `revise`
  and implement the pre-registered D5 focus-session count.
- Control applies D4 directly; treatment updates Kernel/State/Evidence before
  its app edit.
- Run static checks, controlled-clock Chromium checks, and R1–R13.

## Out Of Scope

- Re-running the meeting-room delta, adding a third domain, or changing R1–R13.
- Replacing `AGENTS.md`.
- Adding ontology tooling, schemas, graphs, generators, sync, notifications,
  sounds, analytics, or server storage.

## Acceptance Gate

- D4/D5 are fixed before implementation and their compatibility relationship is
  explicit.
- Control records the direct D4 contradiction at R6.
- Treatment records `revise` and D5 in Kernel/State/Evidence before app edit,
  then passes the baseline behavior matrix plus R13.
- Static checks, ordering, cost, contradiction, and browser limitations are
  recorded; root instructions remain untouched.

## Active Task Slice

```text
task010 [x] goal:<cross-domain validation of compatible revise> | scope:<research/experiments/pomodoro-v4-cross-domain> | verify:<D4/D5 fixed + pre-edit Kernel/State/Evidence + control R6 contradiction + treatment R1–R13 + cost>
```

## Remaining Boundary

- Phase 9 supplies one Pomodoro state/persistence revision in addition to the
  meeting-room presentation revision. It is still not general model proof.
- The pointer-based skip-link check was not accepted because the link is
  intentionally visually hidden; no screen-reader audit was claimed.
- Do not add a third domain or ontology infrastructure without a new phase.

## Evidence Recorded

- D4 conflict, D5 compatible alternative, treatment ordering, and K1-D5 action
  contract.
- Control R6 contradiction, treatment R1–R13 results, controlled clock,
  storage boundary, costs, and browser artifacts.

## Close Result

- The result and bounded decision are recorded in
  `research/experiments/pomodoro-v4-cross-domain/RESULTS.md`.
- Keep `revise` concrete: preserve the existing invariant/data contract, add
  one named compatible behavior, and prove both old and new contracts.
