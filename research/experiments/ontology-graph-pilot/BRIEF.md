# Ontology Graph Projection Pilot

## Question

Can a small graph projection represent the SPEC-AGENTS ontology with typed
objects, typed relations, action contracts, lifecycle states, and Evidence
provenance—and then answer a useful impact query?

## Hypothesis

The graph will expose relation traversal and provenance more clearly than a
Markdown diagram, but only if actions are kept distinct from relations and
domain/range/status constraints are enforced.

## Scope

- one complete Change → Plan → SPEC → Slice → Code → Verification → Evidence
  chain;
- one invariant constraining the `do` Action Contract;
- one confirmed implementation and verification path;
- one proposed relation that is later rejected;
- an in-memory Python graph with no external dependencies.

## Non-goals

This is not a graph-database selection, formal OWL/RDF implementation, ontology
reasoner, synchronization mechanism, or production schema migration.
