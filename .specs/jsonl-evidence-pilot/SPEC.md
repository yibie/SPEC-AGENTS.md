# JSONL Evidence Ledger Pilot

status: verified
revision: 1
context_refs: AGENTS.md, CONTEXT.md, EVIDENCE.md

## Problem and goal

Determine whether JSONL is a better storage format for high-cardinality,
append-only evidence than the current human-maintained Markdown ledger. The
pilot must test selective reads, independent Agent streams, revisions, and
human review cost without changing the production workflow.

## Unchanged contracts

- `AGENTS.md`, `CONTEXT.md`, `ROADMAP.md`, `STATUS.md`, and `EVIDENCE.md` remain
  the current project workflow and evidence surfaces.
- Stable semantic rules remain human-reviewable and Markdown-backed.
- No application code, action skill, root document, formal ontology schema,
  graph storage, or generator is changed by this pilot.
- A passing fixture is evidence about this fixture only, not a general claim
  about JSONL or Agent quality.

## Decision and boundaries

Use two independent JSONL append streams and one equivalent Markdown fixture.
The runner merges records in memory, validates stable IDs and references,
selects one phase, and reports a rough size comparison. The pilot ends with a
recommendation; it does not select a production filename or migration path.

## Model delta

Experimental record fields are:

- `id`: stable record identifier;
- `kind`: observation, interpretation, revision, or recommendation;
- `phase`: query scope;
- `status`: confirmed, proposed, or open;
- `claim`: the human-readable fact or proposal;
- `source`: file, Agent, or prior record references;
- `created_at`: sortable timestamp;
- optional `supersedes`: prior record IDs.

## Action Contracts

- Append: add one complete JSON object per line without rewriting earlier lines.
- Merge: combine independent streams and reject duplicate IDs or unknown
  `supersedes` references.
- Select: return only records for the requested phase.
- Revise: keep the earlier record and mark it superseded through a later record.

## Seams and verification

Run `python3 research/experiments/jsonl-evidence-pilot/run_pilot.py` and verify:

- both Agent streams parse and merge with unique IDs;
- phase selection excludes an unrelated record;
- the superseded record remains in history but not in the active view;
- open/proposed records remain distinguishable;
- the JSONL and Markdown fixture sizes are reported with their limits stated.

## Compatibility and migration

No migration is performed. If the pilot supports JSONL, a separate plan must
decide whether JSONL becomes a canonical dynamic ledger and how a human-readable
view is generated. Do not maintain two independently editable evidence sources.

## Out of scope

- converting `EVIDENCE.md`;
- changing `learn` or any other skill;
- adding a query CLI or dependency;
- concurrent filesystem locking;
- ontology graph infrastructure;
- claiming a universal token or merge advantage.

## Issue map

One bounded slice: fixture, runner, and result report.

## Revision notes

- Revision 1: initial throwaway pilot approved after discussion of a Beads-like
  JSONL ledger.
