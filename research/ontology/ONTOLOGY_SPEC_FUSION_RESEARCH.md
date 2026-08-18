# Ontology-spec fusion: bounded research note

## Scope and decision

**Observation — project evidence at research start.** When this note was
written, the active phase was `revise / inconclusive`: the control passed
R1–R12, while treatment failed R2 because an element id shadowed
`form.reset()`. The current durable boundary explicitly excludes Kernel-v2,
ontology schemas/graphs/generators, and replacing `AGENTS.md`. The later Phase
5 independent repeat is recorded in
`research/experiments/room-v4-independent-ab/RESULTS.md`; [current phase brief](../../.phrase/current.md)
now records that result separately.

**Recommendation — decision.** Do **not** build an ontology implementation or adopt RDF/OWL/SHACL tooling. Use the small, human-readable contract below only to make the next fresh treatment handoff measurable. It is a protocol refinement, not a new platform layer.

## Questions mapped to primary-source facts

| Question | Observation (primary source) | Engineering inference for this experiment |
| --- | --- | --- |
| What is the smallest useful semantic core? | Palantir separates semantic elements—objects, properties, links—from kinetic elements—actions, functions, and dynamic security. [Palantir: Ontology overview](https://www.palantir.com/docs/foundry/ontology/overview) | Keep **entity**, **property**, **relation**, and **action** as the only semantic labels needed to connect the Brief to observable behavior. |
| Why separate structure from concrete data? | Palantir distinguishes ontology resources (object/link/action types that define schema) from objects and links that contain actual key/property values. [Palantir: Object permissioning](https://www.palantir.com/docs/foundry/object-permissioning/overview) | K1 should name the intended concepts/contracts; the application and R1–R12 output are the instance-level evidence. Do not mistake either for the other. |
| Why explicitly name actions? | In Foundry an Action is a single transaction that changes one or more objects according to user-defined logic. [Palantir: Object edits](https://www.palantir.com/docs/foundry/object-edits/overview) | Record each user-visible mutation (e.g. valid submit, reset) with precondition, effect, and evidence; this catches a broken submit/reset path rather than merely recording HTML. |
| Why preserve relations rather than a flat field list? | RDF’s core model is a graph of subject–predicate–object triples; predicates denote binary relations. [W3C RDF 1.1 Concepts §1.1–1.2](https://www.w3.org/TR/rdf11-concepts/) | K1 can state relations in plain language (`Booking --uses--> Room`); no RDF serialization is justified for a single bounded experiment. |
| Why make validation a distinct gate? | SHACL defines validation as taking a data graph and shapes graph and producing results; its report includes conformance and individual violations. [W3C SHACL §3](https://www.w3.org/TR/shacl/#validation) | Keep the existing Gate and R1–R12 as the executable analogue: report pass/fail plus the failing contract and observed evidence. Do not add a SHACL processor. |
| Does a formal ontology standard force an implementation choice? | OWL describes ontologies as formal vocabularies of domain terms and relationships, but its overview presents several syntaxes and semantics. [W3C OWL 2 Overview §1–2](https://www.w3.org/TR/owl2-overview/) OMG ODM supplies normative PDF and machine-readable metamodel artifacts. [OMG ODM 1.1](https://www.omg.org/spec/ODM/) | No. These are useful vocabulary precedents, not evidence that this repository needs a formal language, metamodel, or interoperability surface. |
| What must not be dropped if the experiment later becomes operational? | Palantir models decisions by integrating data, logic, action, and security. [Palantir: Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system) | Security/provenance are out of scope for the local fixture, but ownership, version, and evidence pointer should remain in the handoff record so a later phase can judge governance without reconstructing history. |

## Minimal fusion contract (recommendation)

This is a **Markdown protocol fragment**, not a schema. A fresh treatment may create one `K1.md` containing exactly these six fields:

| Field | Required content | Measured by |
| --- | --- | --- |
| `goal` | One observable outcome copied from the fixed Brief. | Brief-to-K1 comparison. |
| `entities` | The two to five domain nouns used by the app. | K1 review. |
| `relations` | Only relations required by R1–R12, in `A --verb--> B` form. | K1 review. |
| `actions` | Each user-visible state change: precondition → effect → matching R-id(s). | Browser matrix. |
| `invariants` | The acceptance conditions that must hold before/after actions. | Static check and R1–R12. |
| `evidence` | Artifact paths plus commands/results to be recorded after implementation. | Run log/evidence record. |

The existing fixed Brief remains authoritative for behavior. K1 adds a short, inspectable bridge from its nouns to the action contracts; it must not add product requirements.

## Required Kernel / State / Evidence / Evolution mapping

| SPEC element | Minimal mapping | Explicit non-mapping |
| --- | --- | --- |
| **Kernel (K1)** | The semantic vocabulary and action contracts: entities, properties, relations, action preconditions/effects, and invariants. This aligns with Palantir’s semantic objects/properties/links plus kinetic actions/functions. [Palantir: Ontology overview](https://www.palantir.com/docs/foundry/ontology/overview) | Not an RDF/OWL ontology, type system, code generator, or executable business-logic layer. |
| **State** | A compact run marker: fresh-thread declaration, K1 path, gate outcome, next permitted step, elapsed checkpoint time, and deviations. | Not a domain-object store, materialized graph, or a replacement for the application’s runtime state. |
| **Evidence** | The immutable pointers to static-check output, browser R1–R12 result, exact first failing R-id, and artifact sequencing. SHACL’s useful analogue is a validation report with conformance and individual results. [W3C SHACL §3.6](https://www.w3.org/TR/shacl/#validation-report) | Not a provenance platform, audit database, or claim that the tests establish semantic completeness. |
| **Evolution bridge** | A one-line next-phase recommendation based on the measured result: `promote`, `revise`, or `reject`, including the blocker classification. | Not automatic migration, ontology versioning, or permission to change durable decisions/`AGENTS.md` without a new phase decision. |

### Action contract and authorization boundary

**Recommendation.** For every K1 action, record exactly: `actor`, `precondition`, `input`, `permitted effect`, `R-id`, and `evidence pointer`. The protocol’s authorization is deliberately narrow: the treatment is authorized to create K1/State and, only after the measured gate, implement the already-fixed Brief. It is **not** authorized to change the Brief, R1–R12, durable project decisions, or to recover another agent’s code.

This boundary is an experimental simplification, not a claim that authorization is optional in production. Palantir treats object/link/action types as resources with security controls, while objects and links are concrete data; it also states that its decision model integrates data, logic, action, and security. [Palantir: Object permissioning](https://www.palantir.com/docs/foundry/object-permissioning/overview) [Palantir: Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system)

## Palantir responsibility model: retained versus deferred

| Stable responsibility in official architecture | Experimental treatment | Why |
| --- | --- | --- |
| **Objects and relations**: disparate sources are unified into objects, properties, and links. [Palantir: Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system) | Retain as K1 nouns/properties/relations. | Enough to trace UI behavior to domain language. |
| **Business logic**: action logic may range from a rule to models or orchestration. [Palantir: Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system) | Defer; implementation remains ordinary app code. | A logic framework would confound the Bootstrap experiment. |
| **Actions**: an Action is a transaction changing object properties under user-defined logic. [Palantir: Object edits](https://www.palantir.com/docs/foundry/object-edits/overview) | Retain as the small action contract above. | It connects the Gate to the R matrix, including reset/submit. |
| **Security**: Palantir exposes control over ontology resources and concrete objects/links. [Palantir: Object permissioning](https://www.palantir.com/docs/foundry/object-permissioning/overview) | Retain only protocol authority/ownership boundary; defer runtime authorization. | The fixture has no users, persistence, or external write surface. |
| **Operational feedback and governance**: Palantir describes governed updates and audit/security systems across human and machine activity. [Palantir: Ontology overview](https://www.palantir.com/docs/foundry/ontology/overview) [Palantir: Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system) | Retain evidence pointer, deviation, and next-phase decision; defer platform audit/feedback loops. | This supplies decision-relevant feedback without inventing operational infrastructure. |

## Exact next-treatment change (recommendation, not observed fact)

Add one finite checkpoint before implementation:

```text
K1 acknowledgement/liveness checkpoint
1. Fresh treatment creates K1.md and STATE.md before any application file.
2. It prints the two exact paths and a one-line acknowledgement:
   "K1 acknowledged: <goal>; next: implement R1–R12."
3. Gate reviewer checks (a) both files exist, (b) all six K1 fields are non-empty,
   and (c) every K1 action maps to at least one R-id.
4. Only then does the same fresh treatment implement. If the checkpoint is absent
   by the fixed time budget, stop and record `liveness failure`; do not recover code.
```

**Measured gate.** `K1 exists ∧ STATE exists ∧ six fields non-empty ∧ action-to-R mapping complete ∧ acknowledgement captured` is the entry condition for implementation. Completion remains: static checks plus the unchanged R1–R12 matrix. Record elapsed time to checkpoint, protocol deviation, and exact first failing R-id; this separates handoff liveness from application correctness.

## Anti-patterns

- **Recommendation:** Do not introduce RDF/OWL/SHACL files, a graph database, a generator, or a validator for this single treatment repeat. W3C/OMG standards show what those tools can express; they do not establish a need here.
- **Recommendation:** Do not allow K1 to become a second requirements document. Its only job is a traceable map from the fixed Brief to R1–R12.
- **Recommendation:** Do not treat artifact presence as behavioral success. The prior treatment reached artifacts but failed the first valid submit; preserve browser evidence as the behavioral authority.
- **Recommendation:** Do not silently repair a missing checkpoint or failed treatment. Classify it as liveness/protocol versus local implementation evidence, then let that result choose the next phase.

## Source verification

All external claims above were checked on 2026-08-16 against the linked publisher-owned pages: `palantir.com` documentation, W3C Recommendations, and OMG’s specification registry. The sources were used for conceptual vocabulary and validation framing only; none prescribe a repository change.
