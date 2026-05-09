# SPEC-AGENTS System Model

## Purpose

This document clarifies the overall structure of SPEC-AGENTS before migration.
It separates the current static document model from the EDPP-based v3 model
so migration can happen without ambiguity.

## Current Model

The current SPEC-AGENTS design is a static doc-driven workflow:

```text
intent -> spec -> plan -> task -> implementation -> verify -> change / issue / adr
```

Its strengths are traceability and clear task discipline.

Its costs are:

- high token usage from reading many historical files
- stale plans that still look authoritative
- repeated bookkeeping for small changes
- too much memory captured as low-value records

## v3 Model

The v3 model is EDPP-based and evidence-calibrated:

```text
decision framework -> roadmap -> current phase
        -> discovery / implementation -> verification
        -> evidence delta -> next phase
```

Its goals are:

- keep durable principles stable
- keep the default context small
- let evidence revise the next phase
- store only decision-relevant memory
- keep historical detail out of the default read path

## Migration Map

### What Stays

- phase boundaries
- explicit acceptance gates
- verification before completion
- durable decisions when a rule should not be re-litigated
- task execution for the current slice of work

### What Changes

- roadmap becomes phase-level direction, not detailed future planning
- current phase context becomes the default read surface
- evidence becomes the main source for the next phase decision
- ADR and protocol files hold only durable rules and boundaries
- task lists become phase-local instead of globally pre-expanded

### What Goes

- default full-history loading
- mechanical per-file change bookkeeping
- distant future task decomposition
- treating old plans as current truth after new evidence appears

### What Gets Archived

- completed phase folders
- obsolete task lists
- stale plans
- historical notes that are no longer part of the active decision path

## Authority Order

When files disagree, use this order:

1. Decision framework / ADR / protocol
2. Fresh evidence
3. Current phase brief
4. Roadmap
5. Archive

If fresh evidence conflicts with the current phase, update the phase.
If fresh evidence changes a durable rule, update the decision framework or
ADR/protocol explicitly.

## Summary

The migration should not make agents read more. It should make them read less,
but read the right things.

The target shape is:

> minimal context, evidence-driven phases, verified execution, durable
> decisions only
