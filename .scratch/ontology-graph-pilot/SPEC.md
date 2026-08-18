# Ontology Graph Projection Pilot

status: confirmed
revision: 1
context_refs: AGENTS.md, CONTEXT.md, EVIDENCE.md

## Problem and goal

Test whether a small typed graph can represent the SPEC-AGENTS chain without
collapsing object types, relations, actions, lifecycle states, constraints, and
Evidence into undifferentiated edges. Use the graph to answer impact and
provenance questions that are awkward in Markdown.

## Unchanged contracts

- Current root documents and six-action skills remain authoritative.
- This is a throwaway in-memory projection; no graph database, formal ontology
  runtime, generator, or synchronization process is introduced.
- A graph query may report impact, but it cannot promote a proposed relation or
  change the project model without the existing `plan`/`learn` gates.
- A passing pilot is evidence about the fixture only.

## Decision and boundaries

Model seven workflow object types plus `Invariant` and `ActionContract`.
Represent `plan`, `capture`, `arrange`, `do`, `check`, and `learn` as actions,
not relations. Represent their results with typed relations such as
`has_plan`, `captures`, and `verified_by`. Require domain/range checks and
Evidence references for semantic constraint edges.

## Model delta

Experimental ontology vocabulary:

- object types: `Change`, `Plan`, `SPEC`, `Slice`, `CodeArtifact`,
  `Verification`, `Evidence`, `Invariant`, `ActionContract`;
- relation types: `has_plan`, `captures`, `contains_slice`, `implements`,
  `verified_by`, `produces_evidence`, `constrains`, `implemented_by`,
  `supports`, `depends_on`;
- action types: `plan`, `capture`, `arrange`, `do`, `check`, `learn`;
- relation status: `proposed`, `confirmed`, `rejected`;
- lifecycle states: the current workflow states plus object-local states used
  by the fixture.

## Action Contracts

- `add_edge`: reject unknown relation names and domain/range mismatches.
- `apply_action`: require the action's input type and lifecycle state, create
  its typed result relation, and update only the permitted states.
- `impact`: traverse confirmed outgoing relations from an invariant and return
  affected Action Contracts, code, verification, and evidence.
- `reject_edge`: retain a proposed relation, mark it rejected, and attach the
  Evidence that rejected it; rejected edges must not appear in active queries.

## Seams and verification

Run `python3 experiments/ontology-graph-pilot/run_pilot.py` and verify:

- invalid relation names and domain/range pairs fail;
- `do` fails before its Slice is arranged and succeeds after the valid action
  sequence;
- an invariant impact query reaches the affected action, code, verification,
  and Evidence nodes;
- edge provenance resolves to a real Evidence node;
- a rejected candidate relation remains inspectable but is absent from the
  active graph.

## Compatibility and migration

No production migration. If this model is useful, a new plan must choose a
human-reviewed canonical source and a graph projection strategy before any
database or formal reasoning tool is selected.

## Out of scope

- Neo4j, RDF, OWL, SHACL, or any external dependency;
- persistence, concurrent writes, graph synchronization, or generated views;
- modifying `CONTEXT.md`, skills, CLI, or application code;
- automatic inference or authorization from graph structure.

## Issue map

One bounded slice: ontology contract, in-memory graph runner, and result report.

## Revision notes

- Revision 1: initial typed-graph pilot approved after the Markdown/edge
  discussion.
