# Project Knowledge Routing Pilot — Results

## Verification

The first run intentionally stopped at metadata validation: the existing DOM
Lesson had a verification section but no top-level `verification:` field. The
same contract check found that the two existing Protocol records also lacked
the required metadata fields. Those three records were minimally repaired;
the pilot then passed.

| Check | Control | Treatment |
| --- | --- | --- |
| Temporary shell change parses with `bash -n` | pass | pass |
| `git diff --check` | not selected | pass |
| Installer copy run | not selected | pass, twice |
| Existing files kept on second run | not selected | pass |
| Source-repository install refused | not selected | pass |
| Knowledge metadata | default context did not inspect records | pass |
| Intent routing | no routed records | shell → Protocol + Runbook; browser form → DOM Lesson only |
| Repository mutation by runner | none | none |

Command:

```bash
python3 research/experiments/project-knowledge-routing-pilot/run_pilot.py
```

## Context cost

The runner measured the current root documents and the records selected by the
two intents:

| Read set | Bytes |
| --- | ---: |
| Default root context (`AGENTS`, `CONTEXT`, `STATUS`, `ROADMAP`) | 30,261 |
| Shell intent plus Protocol and Runbook | 32,845 |
| Added bytes for the relevant records | 2,584 |
| Browser-form Lesson added instead | 1,171 |

The extra context is small in this repository, but a scoped Lesson is not
automatically relevant: the shell intent selected the Protocol and Runbook and
did not apply the browser-only DOM Lesson.

## Interpretation

This is positive evidence for the routing contract, not a causal quality claim
about Agents. The knowledge records made three things executable and visible:

1. a shell change has a named verification practice;
2. installer behavior has repeatable preconditions, assertions, and recovery;
3. a failure Lesson carries an applicability boundary instead of becoming a
   project-wide rule.

The first failed run is also useful evidence: metadata requirements catch a
record that is human-readable but not machine-routable before it is used as
authority.

## Decision

**Promote narrowly.** Keep intent-routed Protocols, Runbooks, and scoped Lessons
as the project-knowledge mechanism. Require promoted records to carry the
metadata contract already defined in `docs/protocols/knowledge-promotion.md`.

Do not add a knowledge index, graph database, automatic promotion, or
multi-Agent scheduler from this result. The pilot is one repository, one
comment-only shell change, and one runner; it tests routing and operational
repeatability, not model behavior or concurrent writes.

## Next permitted experiment

Use the same routing on a real user-project change that has a non-trivial
coding practice or recovery path. Only add indexing or multi-Agent ownership
after that task produces a measured retrieval, consistency, or handoff failure.
