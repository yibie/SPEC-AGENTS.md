# Ontology Graph Projection Pilot — Results

## Verification

The pilot passed all intended checks:

| Check | Result |
| --- | --- |
| Actions are distinct from relations | pass; `plan` is rejected as an edge type |
| Domain/range validation | pass; `has_plan(CodeArtifact, Plan)` is rejected |
| Lifecycle gate | pass; `do` is rejected before the Slice is `ready` |
| Valid action sequence | pass; all six actions update only permitted states |
| Impact analysis | pass; `I-1` reaches `AC-do`, `CA-1`, `V-1`, and `E-1` |
| Edge provenance | pass; `R-constrains` resolves to `E-0` |
| Rejected relation | pass; the candidate remains inspectable but is not active |

Command:

```bash
python3 research/experiments/ontology-graph-pilot/run_pilot.py
```

## Observations

The typed vocabulary made three distinctions explicit that a Markdown arrow
usually hides:

1. `plan` is an ActionType; `has_plan` is a RelationType.
2. `do` has a lifecycle precondition (`Slice=ready`), not merely a source and
   target node.
3. A confirmed semantic edge can require a real Evidence reference, while a
   proposed or rejected edge remains visible without entering active queries.

The impact query was useful because it traversed typed, confirmed edges from
an `Invariant` through an `ActionContract`, implementation, verification, and
Evidence. The result is a bounded traceability query, not automatic inference.

## Decision

**Promote narrowly:** future ontology work should define object types, relation
types, action types, lifecycle constraints, relation status, and provenance
before selecting a graph database. The graph is a projection of an approved
semantic model, not the authority that invents one.

**Do not add a graph database or formal ontology tooling yet.** This pilot used
an in-memory Python graph and did not test persistence, concurrency, inference,
RDF/OWL semantics, or synchronization with Markdown.

## Next permitted experiment

If a real impact-analysis question appears, load one small confirmed model into
a temporary graph implementation and compare its query result with direct
Markdown retrieval. Do not choose a production database based on this pilot
alone.
