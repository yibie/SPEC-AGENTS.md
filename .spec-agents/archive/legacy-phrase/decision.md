# Decision Framework

## Principles

- Use minimal default context.
- Let evidence choose the next phase.
- Keep roadmaps at phase granularity.
- Keep tasks local to the current phase.
- Record only decision-relevant memory.
- Verify before claiming completion.

## Evidence Rules

Accepted evidence may include tests, traces, benchmarks, audits, user
observations, incident facts, data checks, manual verification, and prototype
results.

Evidence notes should separate:

- observation
- interpretation
- recommended next action

## Durable Boundaries

- Do not silently change stable contracts; update ADR or protocol docs.
- Do not pre-split future roadmap phases into tasks.
- Do not read archive material by default.
- Do not maintain mechanical per-file changelogs when the git diff is enough.
- For experimental SPEC evolution, use a bounded `Kernel → State → Evidence`
  change protocol: update domain vocabulary/invariants/action contracts first,
  record the permitted next step, then change code and attach proof. This does
  not authorize formal ontology tooling, silent durable-rule changes, or an
  `AGENTS.md` replacement without a new phase gate.
- If a proposed delta conflicts with a durable Kernel invariant, record an
  explicit `revise` or `reject` decision before editing application code; a
  `reject` decision leaves the prior app contract unchanged.
- A `revise` decision must name one concrete compatible alternative, preserve
  the existing invariant/data contract, and map the new behavior to an explicit
  Action Contract before implementation.

## Phase Gate Rules

A phase can close only when:

- acceptance gate is checked
- verification evidence exists
- remaining blockers are recorded
- next phase recommendation is written
- durable decisions are updated if needed

## Rejected Paths

- Full-history loading as the default agent behavior.
- Static spec/plan/task/change bookkeeping for every session.
- Treating stale plans as current truth after fresh evidence contradicts them.
