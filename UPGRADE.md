# SPEC-AGENTS Upgrade Prompt

Run this prompt after installing the modern SPEC-AGENTS entry points in a
project that still contains v2 or v3 material:

```text
Read UPGRADE.md and execute the upgrade review.
```

This is a cognition-preserving migration. The upgrade has two gates:

```text
reconnaissance → user confirmation → cutover → verification
```

Do not change application code during this upgrade. Do not promote an inferred
architecture rule as fact. Keep the old material recoverable until the user
confirms the candidate model.

## 1. Read the modern entry points

Read `AGENTS.md`, `CONTEXT.md`, `ROADMAP.md`, `STATUS.md`, and `EVIDENCE.md`
when they exist. Treat a missing root document as an upgrade finding, not as a
reason to invent content.

Inspect only the minimum legacy context needed to classify the project:

- v2 indicators: `.phrase/phases/` or `spec_*`, `plan_*`, `task_*`,
  `change_*`, `issue_*` records;
- v3 indicators: `.phrase/decision.md`, `roadmap.md`, `current.md`,
  `evidence.md`;
- both sets: classify as `mixed` and preserve both histories.

Record the classification and source paths before interpreting their meaning.

## 2. Reconstruct recent project history

For v2, inspect the most recent active phase and its related SPEC, plan, task,
change, and issue records. For v3, inspect the current phase, roadmap,
decision framework, and evidence deltas. For mixed projects, compare the two
records and call out conflicts.

Produce a short, cited account of:

- what the project recently completed;
- what the current phase is trying to achieve;
- which decisions still appear durable;
- which plans or tasks are stale;
- unresolved blockers, failed assumptions, and verification results;
- facts that cannot be established from the repository.

Use file paths and commit references as evidence. Do not turn a filename into a
fact about current behavior.

## 3. Scan the code architecture

Inspect the current codebase before proposing the modern model. Use the
repository's existing language and boundaries:

- identify entry points, modules, packages, services, and storage boundaries;
- trace the main callers and data flows for the current phase;
- identify concepts, identities, relations, lifecycles, invariants, and Action
  Contracts visible in code;
- compare the code structure with the legacy SPEC claims;
- label every finding `confirmed`, `inferred`, or `unknown` and cite the code
  path that supports it.

Keep this scan bounded to the project area relevant to the current phase. Do
not refactor, format, add dependencies, or fix unrelated findings.

## 4. Write the candidate report and stop

Create `.scratch/upgrade-review/REPORT.md` with these sections:

```markdown
# Upgrade Review

## Source classification
## Recent history
## Current code architecture
## Candidate CONTEXT changes
## Candidate STATUS and ROADMAP changes
## Evidence to preserve
## Conflicts and unknowns
## Proposed archive plan
## Verification plan
## Questions for the user
```

The report is a proposal. Keep existing root documents and legacy files
unchanged at this stage. Show the user the report and ask whether the candidate
concepts, boundaries, current state, and archive plan are correct.

Stop here until the user confirms. If the user rejects or revises the report,
update the report and ask again; do not enter cutover.

## 5. Cut over only after confirmation

After explicit confirmation, use the six actions:

```text
plan → capture → arrange → do → check → learn
```

Then:

1. Merge confirmed durable concepts, identities, relations, lifecycles,
   invariants, and Action Contracts into `CONTEXT.md`.
2. Rebuild the active phase in `STATUS.md` and phase direction in `ROADMAP.md`.
3. Record only decision-relevant history, verification, blockers, rejected
   paths, and next-step facts in `EVIDENCE.md`.
4. Preserve existing confirmed root content. When a root document conflicts
   with the report, stop and ask the user instead of overwriting it.
5. Move the complete `.phrase` tree to a timestamped directory under
   `archive/legacy-v2/`, `archive/legacy-v3/`, or `archive/legacy-mixed/`.
   Archive identified legacy `spec_*`, `plan_*`, `task_*`, `change_*`, and
   `issue_*` files outside `.phrase` alongside it. Leave unrelated application
   files in place.
6. Write `MIGRATION.md` at the project root with the source classification,
   report path, archive path, confirmed decisions, unresolved questions, and
   verification result.

## 6. Verify the cutover

Before declaring the upgrade complete, prove:

- the confirmed root documents contain the preserved project cognition;
- `STATUS.md` identifies one active phase and next permitted action;
- `EVIDENCE.md` contains the migration facts and their sources;
- the legacy material is recoverable under `archive/` and is no longer in the
  default read path;
- no application code, dependencies, configuration, or tests changed unless
  the user explicitly approved a separate task;
- the six action validators and the project's relevant checks pass.

If any proof is missing, report the blocker and keep the migration open.

## Completion report

Report:

- source classification: v2, v3, or mixed;
- recent history recovered;
- architecture findings confirmed by the user;
- root documents updated;
- archive path;
- verification commands and results;
- remaining unknowns or blockers;
- next permitted action.

`UPGRADE.md` is an entry prompt, not a replacement for the living root model.
After completion, ordinary work follows `AGENTS.md` and the six action skills.
