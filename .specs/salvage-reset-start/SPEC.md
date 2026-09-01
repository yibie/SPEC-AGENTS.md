# Replace upgrade conversion with salvage, reset, and a fresh Start

status: verified
revision: 2
kernel_delta:
  - add: Upgrade
  - revise: ProjectState
  - retire: Legacy Upgrade Boundary
  - add: Upgrade Boundary
context_refs: `AGENTS.md`, `START.md`, `UPGRADE.md`,
  `docs/spec-agents/WORKFLOW.md`, `docs/adr/0001-framework-namespace-split.md`,
  `docs/runbooks/installer-smoke.md`, `.scratch/herdr-field-trial-20260830/RESULTS.md`

## Problem and goal

The current upgrade path tries to translate several retired state models into
the current one: v2/v3 records, phase-shaped STATUS and ROADMAP files, tracked
SPECs under `.scratch/`, pre-namespace-split documents, and local doctrine
edits. The Herdr field trial showed that these branches are not consistently
reachable from START, contradict the reconnaissance write boundary, and depend
on an installer that keeps the exact doctrine files the cutover says to
replace.

The translation is also the wrong product boundary. Old execution state is not
current truth. Preserve only information the user says may still affect future
judgment, make the old material recoverable, remove it from the active read
path, replace the installed doctrine, and run START again against the current
project. Ongoing intent is captured again; no old `doing`, `done`, phase, task,
or STATUS state is inherited.

This repository is already the current SPEC-AGENTS source. It does not upgrade
itself and receives no compatibility layout. Its prior verified SPECs and
Evidence remain audit history; this change replaces product behaviour rather
than deleting this repository's audit trail.

## Unchanged contracts

- Upgrade never changes application code, dependencies, configuration, tests,
  credentials, or repository history.
- A path is never classified from its name alone. The report cites the content
  and current project evidence that justify its proposed disposition.
- No inferred rule becomes current project knowledge. Preserved material is a
  candidate until the fresh START scan and the user confirm it.
- No archive, removal, or doctrine replacement happens before the user confirms
  the exact disposition and path manifest.
- Every removed active-path item remains recoverable until the user accepts the
  fresh START result. Permanent deletion is a later explicit choice.
- Ordinary `init` and `install` remain non-destructive and keep existing files.
- The Doctrine/Instance split and doctrine allowlist remain. `CONTEXT.md`,
  `KERNEL.md`, `STATUS.md`, `EVIDENCE.md`, `.specs/`, and project knowledge are
  never replaced merely because doctrine is refreshed.
- Fresh projects still install the modern layout and enter through START.
- `--link` and source-repository refusal remain supported.

## Decision and boundaries

### Upgrade is extraction followed by re-bootstrap

UPGRADE becomes one short path:

```text
inspect → preservation manifest → user confirmation → recoverable reset
        → doctrine replacement → fresh START
```

It does not reconstruct a modern KERNEL, STATUS, EVIDENCE, SPEC, or Slice from
retired state. It does not run the six actions to translate the old workflow.
The six actions resume only after the fresh START has established and the user
has confirmed the new project floor.

### One manifest replaces version-specific conversion branches

Reconnaissance writes `.scratch/upgrade-review/REPORT.md`. Every relevant path
appears exactly once in a preservation manifest with one of four dispositions:

- `candidate` — extract the decision-relevant content and its source into the
  report for review after START; the old record itself is still archived;
- `archive-only` — retain for explicit history or rollback, never load by
  default;
- `keep-active` — project-owned material outside the retired workflow; do not
  move or rewrite it;
- `unresolved` — stop before cutover.

The report names the proposed archive root, the exact source paths, path type,
and a verification method for path count and content hashes. It separately
lists active user intent that may need a new `capture` after START. It never
maps old task or lifecycle state into a new Slice state.

### Reset only the approved active workflow paths

After confirmation, the upgrade moves only `candidate` and `archive-only`
paths to the approved timestamped archive and writes a manifest sufficient to
prove path, type, count, and content equality. `keep-active` paths are
byte-identical; `unresolved` makes cutover refuse. Archived legacy markers are
outside the default read path.

The reset is content-classified, not a blanket deletion of filenames. A
project-owned ADR, handoff document, or context file is left active unless the
user explicitly classified it as retired workflow material. The archive stays
until the fresh START result is accepted; only then may the user explicitly
delete it.

### Doctrine replacement is an explicit installer operation

Add:

```text
spec-agents replace-doctrine <path> <backup-dir> [lang] [--link|-l]
```

The command requires an existing target and an absent backup directory. It
backs up only the current doctrine allowlist — `AGENTS.md`, `START.md`,
`UPGRADE.md`, `skills/`, and `docs/spec-agents/` — preserving file types and
relative paths, records a content manifest, then replaces those exact doctrine
paths with the current version. It never touches the CONTEXT template or any
Instance path. If backup or installation cannot complete, it reports the
recovery path and does not claim success.

The explicit command is the only overwriting installer route. Normal install
remains idempotent and preservation-first. UPGRADE invokes doctrine replacement
only after its confirmed archive manifest covers the old doctrine and workflow
state selected by the user.

### START sees one kind of upgrade need

START no longer chooses among `legacy` and `mixed`. Any active-path retired
SPEC-AGENTS state — `.phrase`, old spec/plan/task/change/issue bundles,
phase-shaped records, tracked SPECs under `.scratch`, or a reported doctrine
generation conflict — is `upgrade-needed` and routes to the current upstream
UPGRADE prompt. Specific source generations may be reported as evidence, but
they do not select different conversion algorithms.

An existing project must begin the review from the current upstream
`UPGRADE.md`, not trust a possibly stale installed copy. After reset and
doctrine replacement, START ignores the archive unless the user explicitly
requests history or regression comparison.

### Fresh START owns the new floor

The post-reset START scans current code, tests, configuration, and retained
project-owned documents. It does not preload the archive. Candidate knowledge
from the upgrade report is compared only when the user explicitly reviews it;
it enters K1 only when directly supported and confirmed under START's existing
confirmed-only rule.

Old work state never returns. Still-relevant user intent goes through `plan`
and `capture` as new work after START. The completion report names the archive,
doctrine backup, START report, accepted candidates, rejected candidates, and
the next permitted action.

## Model delta

### Upgrade

An existing-project bootstrap entry that extracts user-approved candidate
knowledge, moves retired workflow material out of the active read path, replaces
installed doctrine through an explicit recoverable installer operation, and
hands the project to a fresh START. Upgrade does not translate old execution
state into current state and is not a seventh action.

### ProjectState

Start classifies the active project as `modern`, `upgrade-needed`,
`missing-entry`, or `blocked`. `upgrade-needed` means retired SPEC-AGENTS
workflow material is active or the installed doctrine cannot safely establish
the current entry contract. Source-generation labels are evidence in the
report, not runtime states and not selectors for separate migration engines.

### Upgrade Boundary

Retired workflow material is historical input, never a compatibility runtime
and never a source of current execution state. Upgrade first produces an exact
preservation manifest and stops for user confirmation. Confirmed cutover keeps
approved material recoverable, removes it from the active read path, replaces
only installer-owned doctrine, and ends at a fresh START. Preserved knowledge
remains candidate until the current project and the user confirm it; active
intent is planned and captured again. Application code and unclassified
project-owned documents do not change.

`Legacy Upgrade Boundary` is retired. Its version-specific state conversion and
six-action cutover are not retained as a fallback path.

## Action Contracts

- **Upgrade reconnaissance** — precondition: run the current upstream prompt
  against an existing project. Input: active workflow records, current code
  evidence, and version-control facts. Permitted effect: write only the upgrade
  report. Invariant: every path has exactly one disposition and unresolved
  paths stop. Verification: report paths resolve and no other project file
  changes.
- **Upgrade cutover** — precondition: the user confirmed the candidate content,
  exact disposition manifest, archive root, and active intent list. Input: the
  confirmed manifest. Permitted effect: move approved retired workflow paths,
  write the archive manifest, and request doctrine replacement. Invariant:
  `keep-active` paths and application files are byte-identical. Verification:
  source/destination path count, type, and hashes agree; unresolved count is
  zero.
- **`replace-doctrine`** — precondition: existing target, absent explicit
  backup directory, not the source repository. Input: target, backup path,
  language, copy/link mode. Permitted effect: back up and replace only the
  doctrine allowlist. Invariant: every Instance path including `CONTEXT.md` is
  untouched. Verification: backup manifest matches the prior doctrine,
  installed allowlist matches the selected current source, and recovery is
  possible from the printed backup path.
- **Post-upgrade START** — unchanged confirmed-only bootstrap, with two explicit
  constraints: archive material is not a default input and no old work status
  is inherited. Verification: the report cites current active evidence and the
  user decision; archived markers do not affect ProjectState.
- **`plan`/`capture` after START** — any still-current intent is new work. No
  lifecycle value or completion claim is copied from the old records.

## Seams and verification

- START route fixtures cover clean modern, each retired-marker family,
  archived-only markers, missing entry, and unsafe/unknown ownership.
- UPGRADE fixture stops after writing only the report and produces one
  disposition per relevant path.
- Cutover fixture proves exact path/type/hash recovery, no active legacy
  markers, and byte-identical application and `keep-active` files.
- `replace-doctrine` fixture starts with modified and stale doctrine, proves the
  backup manifest, proves obsolete doctrine entries are gone, and proves every
  Instance hash is unchanged.
- Failure fixtures cover an existing backup directory, source-repository
  target, incomplete backup, unresolved disposition, and interrupted install;
  none may claim success.
- Post-reset START classifies the fixture as modern, builds its floor only from
  current active evidence, and does not import old status or candidates.
- Normal repeated install still preserves existing files; link mode and the
  installed allowlist still pass the installer smoke Runbook.
- `bash -n bin/spec-agents`, `tests/doctrine-check.sh`,
  `spec-agents check-state`, Kernel checks, Markdown reference checks, and
  `git diff --check` pass.

## Compatibility and migration

**Breaking.** Projects with retired SPEC-AGENTS state no longer receive a
generation-specific conversion into modern STATUS, EVIDENCE, SPEC, Slice, or
Kernel records.

- Existing project code and project-owned documents are compatible and stay in
  place.
- Existing doctrine can be refreshed only through the explicit recoverable
  operation; ordinary install keeps its old behaviour.
- Existing work records are archived according to the confirmed manifest. A
  still-relevant requirement is captured again without inherited lifecycle
  state.
- Existing automation that expects `legacy` or `mixed` ProjectState must adopt
  `upgrade-needed`.
- Existing instructions that say "install current entry points, then trust the
  installed UPGRADE.md" must instead point to the current upstream prompt and
  the recoverable doctrine replacement step.
- This repository is changed in place as the upstream product. Its verified
  audit records are not upgrade inputs and are not removed by this work.

## Out of scope

- Automatically deciding which old knowledge is still true.
- Automatically deleting the archive after START.
- Translating old task, phase, Slice, SPEC, STATUS, Evidence, or Kernel states.
- Modifying application code or general project-owned documents during
  upgrade.
- Supporting old upgrade conversion branches as compatibility modes.
- Deleting this repository's historical verified SPECs or Evidence.
- Formal schemas, graph storage, generated ontology, or runtime authorization.

## Issue map

Proposed for `arrange`:

- `01-upgrade-model-and-entry.md` — replace the version-specific UPGRADE prompt,
  ProjectState route, START handoff, existing-project AGENTS entry, CLI refusal
  text, README guidance, and Workflow model.
- `02-replace-doctrine.md` — implement the explicit recoverable installer
  operation and verify it against disposable fixtures.
- `03-reset-start-fixtures.md` — disposable fixtures for report-only
  reconnaissance, exact archive/reset, doctrine recovery, and fresh START.
- `04-learn-record.md` — installer smoke Runbook, Evidence, superseding ADR,
  STATUS, and CHANGELOG. `writer: learn`; its ADR is
  `docs/adr/0010-upgrade-rebootstrap.md`.

All four Slices remain disjoint from the active `authority-order` SPEC. That
SPEC reserves `docs/adr/0011-authority-order.md`; directory membership alone
does not make two distinct ADR files an overlapping write scope.

## Revision notes

- **r2** — narrowed the two active SPECs' ADR scopes after the user approved
  the next step on 2026-08-31. This work owns
  `docs/adr/0010-upgrade-rebootstrap.md`; the older but not yet executed
  `authority-order` work reserves `docs/adr/0011-authority-order.md`. Upgrade
  semantics, Kernel delta, implementation, and acceptance behaviour are
  unchanged; only the over-broad directory lock and sequencing constraint are
  removed.

- **r1** — captured the user-confirmed breaking route on 2026-08-31: preserve
  knowledge rather than old workflow state; use an exact recoverable archive;
  replace doctrine explicitly; run a clean START; recapture current intent.
  The user also confirmed that this upstream repository should adopt the new
  method directly and retain no old conversion behaviour. Its verified audit
  records remain history, not a compatibility path.
