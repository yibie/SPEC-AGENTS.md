# Changelog

## [4.0.1] — 2026-08-17

- Moved design research, experiment fixtures, and historical model notes under
  `research/` so the repository root remains operational.
- Kept the installer allowlist unchanged; initialized user projects do not
  receive the research archive.
- Updated experiment and evidence references to the new paths.

## [4.0.0] — 2026-08-17

SPEC-AGENTS v4 is the first release built around a stable semantic model and a
phase-local evidence loop. It keeps the durable project model small, lets the
current phase evolve, and makes semantic changes explicit before code changes.

## Why this release exists

The earlier workflow was good at recording history but expensive to carry into
every session. v4 separates what must remain stable from what is only true for
the current phase:

```text
stable concepts and boundaries + current state + verified evidence
```

The six actions are:

```text
plan → capture → arrange → do → check → learn
```

The framework is allowed to evolve, but a change to a concept, relation,
lifecycle, invariant, Action Contract, or acceptance rule must pass through
`plan`. Evidence can revise a local plan; it cannot silently rewrite the
long-term model.

## What changed

- Added the recognizable root layout: `AGENTS.md`, `CONTEXT.md`,
  `ROADMAP.md`, `STATUS.md`, `EVIDENCE.md`, `docs/`, `archive/`, and six
  action skills.
- Added `UPGRADE.md` for user-confirmed v2/v3 project migration. The installer
  preserves old material and does not attempt semantic conversion.
- Simplified the CLI to modern `init` and `install`; the old `upgrade` command
  and permanent `--legacy` mode are intentionally not supported.
- Added Action Contracts, optional Evidence IDs, and typed ontology vocabulary
  to keep architecture, state, verification, and code traceable without
  introducing a graph platform.
- Kept historical `.phrase/` material available for explicit migration or
  regression work, outside the default context.

## Experiment record

The repository records **9 v3/v4 and Kernel protocol phases** (Phases 1–9 in
the legacy research roadmap), plus **2 focused pilots** added during the v4
design: a JSONL evidence-ledger pilot and a typed ontology graph-projection
pilot. These are 11 documented experimental rounds, not 11 independent
statistical samples; several contain control/treatment arms or repeat runs.

### Results in one view

| Round | Result | What it established |
| --- | --- | --- |
| Initial v3/v4 Pomodoro comparison | v3 was more correct in the single sample; v4 classified knowledge more clearly but did not bootstrap a static model | A living workflow needs an explicit first Kernel gate |
| Phases 1–4: bootstrap and execution repeats | Several runs were inconclusive because of liveness, handoff, or implementation artifacts | Do not infer model quality from an invalid or recovered treatment run |
| Phase 5: independent A/B | Both arms passed the same room matrix; `n=1` per arm | Retain the bounded Kernel hypothesis, make no causal quality claim |
| Phase 6: compatible requirement delta | Both arms passed R1–R13 | Promote the bounded `Kernel → State → Evidence → Code` traceability protocol |
| Phase 7: invariant conflict | Treatment rejected the incompatible deletion proposal and left code unchanged | A durable invariant needs an explicit `reject` path |
| Phase 8: compatible revision | Treatment recorded `revise`, preserved cancellation data, and passed R1–R13 | A revision must name one compatible alternative and preserve the data contract |
| Phase 9: cross-domain Pomodoro revision | Treatment preserved completion semantics while adding a focus-session count | The bounded `revise` rule transfers to a second domain/change type; still not general proof |
| JSONL ledger pilot | IDs, streams, selection, and supersession worked; JSONL did not reduce fixture bytes or rough tokens | Keep Markdown for stable documents; consider JSONL only for a future high-cardinality dynamic ledger |
| Ontology graph projection pilot | Typed relations, action/lifecycle gates, impact traversal, provenance, and rejected edges worked in memory | Define ontology semantics before choosing a graph database; do not add one yet |

Detailed primary records live under [`research/experiments/`](research/experiments/), including
the [JSONL results](research/experiments/jsonl-evidence-pilot/RESULTS.md) and [ontology
graph results](research/experiments/ontology-graph-pilot/RESULTS.md).

## Benefits

- **Lower default context cost.** The agent starts with the four root state
  documents and reads evidence, protocols, and archive material only when the
  current decision needs them. The historical v2/v3 comparison benchmark
  measured 51.7% fewer estimated read tokens; that benchmark is a reference
  point, not a claim about v4 model intelligence.
- **Static abstraction survives dynamic work.** Concepts, relations,
  invariants, and Action Contracts have a durable home; phase-local facts stay
  local until `learn` proves they should be promoted.
- **Semantic drift becomes visible.** `reject` and `revise` prevent a ticket or
  implementation from silently redefining a durable invariant.
- **Migration preserves project cognition.** v2/v3 material remains recoverable
  while an Agent reconstructs history and architecture and waits for user
  confirmation before cutover.
- **Ontology stays useful without premature infrastructure.** The release
  treats the ontology as typed semantics and provenance first; Markdown remains
  the human-reviewed source and graph storage remains a future projection.

## Limits and honest claims

- The experiments are bounded, mostly `n=1` per arm, and are designed to find
  protocol failures—not to prove that one model or workflow is universally
  better.
- The release does not include a formal RDF/OWL/SHACL stack, a graph database,
  JSONL as a canonical ledger, automatic migration, or runtime authorization.
- The next evidence-worthy step is a real v2/v3 upgrade review or a concrete
  impact-analysis question, not more infrastructure for its own sake.

## Verification

The release gate includes shell syntax, CLI help, six-skill metadata and
discovery checks, temporary installer fixtures, the protocol-cost comparison,
the JSONL pilot, the ontology graph pilot, and `git diff --check`.
