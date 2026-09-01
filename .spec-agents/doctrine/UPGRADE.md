# SPEC-AGENTS Upgrade Review

Use the current upstream copy of this prompt for an existing project that has
retired SPEC-AGENTS workflow material. Do not install over the project first: an
installed `UPGRADE.md` may itself be stale.

Run it with the existing project as the target:

```text
Read the current upstream .spec-agents/doctrine/UPGRADE.md and execute the upgrade review against <project>.
```

Upgrade does not translate an old workflow into the current workflow. It saves
only information the user says may still matter, moves retired state out of the
active read path, replaces doctrine through the installer, and ends at a fresh
START:

```text
inspect → preservation manifest → user confirmation → cutover receipt
        → doctrine replacement → retired-state reset → fresh START
        → completion result
```

It is an existing-project bootstrap entry, not a seventh action. Do not modify
application code, dependencies, configuration, tests, credentials, or version
history during this review.

## 1. Inspect without changing the project

Read the current upstream `.spec-agents/doctrine/AGENTS.md` and
`.spec-agents/doctrine/docs/WORKFLOW.md` for the workflow contract. Treat doctrine
already installed in the target as upgrade input, not as current authority.

Read only enough target material to identify active workflow state, project
facts, and ownership:

- application entry points, tests, configuration, and the relevant recent
  version-control history;
- root `KERNEL.md`, `CONTEXT.md`, `STATUS.md`, `EVIDENCE.md`, `ROADMAP.md`, and
  project knowledge records when they exist;
- `.specs/`, `.scratch/`, `archive/`, `.phrase/`, and old `spec_*`, `plan_*`,
  `task_*`, `change_*`, or `issue_*` bundles;
- phase-shaped STATUS, ROADMAP, or AGENTS content;
- installed doctrine: `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, and
  `docs/spec-agents/`.

These old-root names are recognition and preservation inputs only. They never
become a managed runtime fallback; after cutover, current doctrine and state
are read only from the `.spec-agents/` namespace.

These names are search leads, not proof. Read the content and cite the line,
code path, test, or commit that establishes what each item is. A project-owned
ADR, handoff note, or context document is not retired workflow material merely
because an older installation used the same filename.

If `.jj/` exists, use JJ for local history and status. Otherwise preserve the
project's existing Git workflow. Do not initialize JJ, create a bookmark, push,
or modify history during upgrade.

## 2. Build one preservation manifest

Create `.spec-agents/scratch/upgrade-review/REPORT.md`. Before user confirmation this is the
only permitted project write. The report contains:

```markdown
# Upgrade Review

## Current project facts
## Retired workflow markers
## Preservation manifest
## Candidate knowledge
## Current user intent
## Conflicts and unknowns
## Proposed archive and doctrine backup
## Verification plan
## Questions for the user
## User decision
## Completion result
```

List every relevant path exactly once in the preservation manifest:

| Disposition | Meaning |
| --- | --- |
| `candidate` | Extract decision-relevant content and its source into the report; archive the old record. It is not current knowledge. |
| `archive-only` | Keep only for rollback or explicit history; never read by default. |
| `keep-active` | Project-owned material outside the retired workflow; leave byte-identical. |
| `unresolved` | Ownership or truth is unclear; cutover must stop. |

For each row record the source path, path type, evidence for the disposition,
proposed archive destination, and how its count and content hash will be
checked. Separately list:

- each candidate concept, identity, relation, lifecycle rule, invariant,
  Action Contract, decision, Protocol, Runbook, or Lesson, with its exact old
  source and whether current code supports, contradicts, or cannot establish it;
- each still-current user request that may need a new `plan` and `capture` after
  START;
- every old lifecycle claim (`doing`, `done`, phase, task, blocker, completed
  SPEC) as non-transferable state.

For a clean START, old SPEC-AGENTS state documents cannot remain active.
`.spec-agents/state/KERNEL.md`, `.spec-agents/state/STATUS.md`, `.spec-agents/state/EVIDENCE.md`, `.spec-agents/specs/`, phase/roadmap records, and
tracked scratch SPECs must be `candidate`, `archive-only`, or `unresolved` when
they belong to the retired workflow. A genuinely project-owned document may be
`keep-active`, but the report must show why it is independent of that workflow.

Source-generation labels such as v2, v3, pre-split, or phase-shaped may be
recorded as evidence. They never select different conversion instructions.

## 3. Stop for an exact user decision

Show the report and ask the user to confirm or revise all of these together:

1. candidate content worth reviewing after START;
2. the disposition of every path;
3. the archive root and doctrine-backup directory;
4. current intent to recapture later;
5. conflicts and unknowns.

Do not infer approval from the user's request to upgrade. Before explicit
confirmation, do not archive, move, delete, reinstall, rewrite root documents,
or run `replace-doctrine`.

Any `unresolved` row blocks cutover. A disagreement about a `keep-active` path
blocks only when the reset would otherwise touch it.

## 4. Bind the confirmed cutover

Only after explicit confirmation, create the confirmed archive root and the
doctrine-backup parent. Use a timestamped archive root such as:

```text
.spec-agents/archive/spec-agents-upgrade/<timestamp>/
```

Copy the confirmed report byte-for-byte to:

```text
.spec-agents/archive/spec-agents-upgrade/<timestamp>/CONFIRMED-REPORT.md
```

Verify that this immutable copy and the active `REPORT.md` have the same
SHA-256. Then create `.spec-agents/scratch/upgrade-review/CUTOVER.tsv` with exactly these
six tab-separated rows and no others:

```text
format	spec-agents-cutover-v1
target	<canonical project path>
backup_dir	<canonical absent doctrine-backup path>
report_sha256	<SHA-256 of the confirmed REPORT.md>
unresolved_count	0
decision	confirmed
```

The receipt binds one confirmed report to one target and backup; it is not a
second manifest. If the report or either path changes, stop, show the revision,
obtain confirmation again, refresh `CONFIRMED-REPORT.md`, and write a new
receipt. Do not create the receipt, archive root, or backup parent before the
user confirms the report.

## 5. Perform the recoverable reset

In this order:

1. Record pre-cutover hashes for every `keep-active` path and the application
   files named in the verification plan.
2. Run the current upstream installer while the recognised retired marker is
   still on the active path:

   ```text
   spec-agents replace-doctrine <project> <backup-dir> \
     --cutover <project>/.spec-agents/scratch/upgrade-review/CUTOVER.tsv [lang] [--link|-l]
   ```

   This command backs up the explicit old-root Doctrine paths and any existing
   `.spec-agents/doctrine/` payload as separate old/new manifests, then replaces
   them with the namespaced Doctrine and root adapter. It never replaces
   `CONTEXT.md` or another Instance path, and never removes `.spec-agents/` as
   one unit. It validates the receipt before creating the backup directory, and
   reports doctrine completion rather than project readiness.
3. Move every confirmed `candidate` and `archive-only` path to its exact
   archive destination using the project's version-control move operation when
   available. Do not move an unlisted path or the newly installed doctrine;
   its old content is already in the doctrine backup.
4. Write the retired-state archive manifest with source path, destination path,
   type, count, and content hash. Prove every source/destination pair.
5. Verify that retired markers are absent from the active read path, every
   `keep-active` and application hash is unchanged, the archive and doctrine
   manifests replay, and no command printed success after a failure.

If any move, hash, backup, or installation step fails, stop. Report the exact
archive and doctrine-backup paths and restore or retry only after the user
chooses. Do not continue into START from a partial reset.

The archive remains recoverable until the user accepts the fresh START result.
Permanent deletion is a later explicit choice, not part of this cutover.

## 6. Run a fresh START

Execute the newly installed `.spec-agents/doctrine/START.md`. The active project must now classify as
`modern`; archived material is not a default input. With old workflow state
removed, START builds a new K1 only from current code, tests, configuration, and
retained project-owned documents under its confirmed-only rule.

Do not preload candidate knowledge into K1. After START writes its report, show
the candidate list beside the new scan:

- a candidate directly supported by current evidence may be confirmed through
  START or routed through `plan` when it revises the new floor;
- a contradicted, unsupported, or rejected candidate stays out;
- a still-current request enters `plan` and, when needed, a new `capture`;
- no old status, completion claim, dependency, Evidence ID, SPEC revision, or
  Slice state is copied.

The six actions resume after the user confirms the fresh START route. They do
not participate in translating the retired workflow.

## 7. Complete the review

Fill `## User decision` and `## Completion result` in the existing report with:

- confirmed disposition and candidate decisions;
- archive and doctrine-backup paths;
- manifest replay results;
- unchanged application and `keep-active` hashes;
- the fresh START report path and ProjectState;
- candidates accepted, rejected, or still unresolved;
- current intent handed to `plan`;
- remaining blockers and the next permitted action.

Upgrade is complete only when the project has current doctrine, no retired
workflow material on the active read path, a user-accepted fresh START result,
and no inherited work state. The report and archive are migration aids, not a
second source of current truth.
