# Markdown evidence baseline

## E-001

phase: jsonl-pilot
kind: observation
status: confirmed
claim: A record can be appended without rewriting earlier records.
source: agent-a
created_at: 2026-08-17T10:00:00Z

## E-002

phase: jsonl-pilot
kind: observation
status: confirmed
claim: Stable IDs let a later record point at an earlier claim.
source: agent-a
created_at: 2026-08-17T10:01:00Z

## E-003

phase: jsonl-pilot
kind: interpretation
status: proposed
claim: JSONL should be considered for append-only evidence, not normative instructions.
source: E-001, E-002
created_at: 2026-08-17T10:02:00Z

## E-004

phase: unrelated-fixture
kind: observation
status: confirmed
claim: An unrelated phase must not appear in a scoped read.
source: agent-a
created_at: 2026-08-17T10:03:00Z

## E-005

phase: jsonl-pilot
kind: observation
status: confirmed
claim: Independent Agent streams can be merged when their record IDs are unique.
source: agent-b
created_at: 2026-08-17T10:04:00Z

## E-006

phase: jsonl-pilot
kind: revision
status: confirmed
claim: A later record can supersede a prior claim without deleting source history.
source: E-001
created_at: 2026-08-17T10:05:00Z
supersedes: E-001

## E-007

phase: jsonl-pilot
kind: recommendation
status: open
claim: Try JSONL only for dynamic evidence before changing root documents.
source: E-001, E-005, E-006
created_at: 2026-08-17T10:06:00Z

## E-008

phase: jsonl-pilot
kind: observation
status: confirmed
claim: A scoped query can reduce the records shown to an Agent.
source: agent-b
created_at: 2026-08-17T10:07:00Z
