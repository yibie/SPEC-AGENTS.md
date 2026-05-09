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
