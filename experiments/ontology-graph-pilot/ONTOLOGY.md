# Experimental Ontology Contract

This file is the human-reviewed vocabulary for the throwaway graph fixture. It
is not the project's production ontology.

## Object types

`Change`, `Plan`, `SPEC`, `Slice`, `CodeArtifact`, `Verification`, `Evidence`,
`Invariant`, and `ActionContract` are object types. Every node has exactly one
type, a stable ID, and an explicit lifecycle state.

## Relation types

| Relation | Domain → range | Meaning |
| --- | --- | --- |
| `has_plan` | Change → Plan | A Change has a confirmed planning result |
| `captures` | Plan → SPEC | A Plan records a living design contract |
| `contains_slice` | SPEC → Slice | A SPEC is split into an executable slice |
| `implements` | Slice → CodeArtifact | A slice is implemented by code |
| `verified_by` | CodeArtifact → Verification | Code was checked by a verification result |
| `produces_evidence` | Verification → Evidence | Verification produces decision-relevant evidence |
| `constrains` | Invariant → ActionContract | An invariant limits an action contract |
| `implemented_by` | ActionContract → CodeArtifact | Code realizes an action contract |
| `supports` | Evidence → Invariant | Evidence supports an invariant |
| `depends_on` | ActionContract → ActionContract | One action contract depends on another |

Relation status is `proposed`, `confirmed`, or `rejected`. Active impact queries
traverse only `confirmed` relations. Semantic constraint relations require a
reference to a real Evidence node.

## Actions

Actions are not relation names. They are permitted state transitions:

| Action | Input | Result relation | Result |
| --- | --- | --- | --- |
| `plan` | candidate Change + draft Plan | `has_plan` | planned Change |
| `capture` | active Plan + draft SPEC | `captures` | captured SPEC |
| `arrange` | captured SPEC + pending Slice | `contains_slice` | ready Slice |
| `do` | ready Slice + unimplemented CodeArtifact | `implements` | implemented CodeArtifact |
| `check` | implemented CodeArtifact + pending Verification | `verified_by` | checked Verification |
| `learn` | checked Verification + pending Evidence | `produces_evidence` | recorded Evidence |

## Pilot queries

1. Which Action Contracts, code, verification, and Evidence are affected by
   `I-001`?
2. Which Evidence supports the `constrains` edge `R-001`?
3. Does a rejected `depends_on` proposal remain queryable without appearing in
   the active graph?
