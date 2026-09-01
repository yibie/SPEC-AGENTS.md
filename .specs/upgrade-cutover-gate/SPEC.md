# Make the confirmed upgrade boundary executable

status: verified
revision: 1
kernel_delta:
  - revise: Upgrade Boundary
context_refs: `UPGRADE.md`, `START.md`, `bin/spec-agents`,
  `docs/spec-agents/WORKFLOW.md`, `docs/adr/0010-upgrade-rebootstrap.md`,
  `docs/runbooks/installer-smoke.md`,
  `.specs/salvage-reset-start/SPEC.md`, `EVIDENCE.md`

## Problem and goal

The salvage/reset/fresh-START design is verified on disposable file fixtures,
but a process simulation found four gaps between its written preconditions and
the executable path.

First, `replace-doctrine` accepts any recognisable target and absent backup. It
does not require the user-confirmed report and cannot refuse a report whose
preservation manifest still has an `unresolved` row. Calling it directly can
therefore cross the confirmation boundary even though UPGRADE says cutover must
stop. The operation remains recoverable and Instance-safe, but the strongest
precondition is enforced only by Agent compliance.

Second, every successful replacement reaches the generic installer line
`Spec-AGENTS is ready`, even while active retired state remains and the warning
immediately above says not to continue ordinary work. Doctrine is ready; the
project is not.

Third, START supports a project with neither `.git/` nor `.jj/` by recording
version history as unknown. After a fresh install or upgrade such a project may
also have no `.specs/`. The workflow CLI recognises only `.git/` or `.specs/`,
so the START route ends at a `gate plan` command that refuses to recognise the
project. A native `.jj/` project without colocated `.git/` has the same defect.

Fourth, the persistent upgrade fixture proves the destructive file boundary
but leaves `User decision` and `Completion result` pending. It therefore does
not exercise the complete Prompt lifecycle. UPGRADE's overview diagram also
places recoverable reset before doctrine replacement while its safe executable
order replaces doctrine before moving the active marker.

Goal: bind doctrine replacement to a reviewable confirmation receipt, report
only the state that actually completed, make CLI project discovery agree with
START, and prove the whole report-to-START lifecycle rather than only its file
operations.

## Unchanged contracts

- Upgrade remains salvage, reset, and re-bootstrap. It never translates an old
  lifecycle into current KERNEL, STATUS, EVIDENCE, SPEC, or Slice state.
- Before explicit user confirmation, the only permitted project write is
  `.scratch/upgrade-review/REPORT.md`.
- Every relevant path has one of `candidate`, `archive-only`, `keep-active`, or
  `unresolved`; any unresolved row blocks cutover.
- Ordinary `init` and `install` remain preservation-first, retain their current
  arguments, and may report the newly installed project ready for START.
- `replace-doctrine` backs up and replaces only `AGENTS.md`, `START.md`,
  `UPGRADE.md`, `skills/`, and `docs/spec-agents/`. It never replaces an
  Instance path.
- The target must be an existing recognisable SPEC-AGENTS project, the backup
  path must be absent, broad/source targets remain refused, and failure retains
  recovery material without claiming success.
- The archive and doctrine backup remain until the user accepts fresh START;
  permanent deletion remains a later explicit choice.
- A receipt can make the confirmed sequence explicit and mechanically bound;
  it cannot cryptographically prove who expressed the user decision.
- No version-control system is initialized implicitly.

## Decision and boundaries

### Confirmation produces one fixed cutover receipt

After the user fills and confirms `## User decision` in
`.scratch/upgrade-review/REPORT.md`, Upgrade writes exactly one adjacent file:

```text
.scratch/upgrade-review/CUTOVER.tsv
```

It is a two-column, tab-separated receipt with exactly these keys:

```text
format	spec-agents-cutover-v1
target	<canonical project path>
backup_dir	<canonical absent doctrine-backup path>
report_sha256	<SHA-256 of the confirmed REPORT.md>
unresolved_count	0
decision	confirmed
```

The receipt is not a second preservation manifest and does not repeat its path
rows. It binds one exact confirmed report to one canonical target and one
canonical doctrine-backup path. The agent writes it only after showing the
complete report and receiving explicit confirmation. Before replacement, the
confirmed report is copied under the confirmed archive root as
`CONFIRMED-REPORT.md`; its hash must equal `report_sha256`. This immutable copy
makes the receipt replayable after the active report later gains its Completion
result.

If the user revises the report, changes the backup path, or chooses a new path
after recovery, the old receipt is invalid. Recompute the confirmed report hash
and write a new receipt only after the revised decision is confirmed.

### Doctrine replacement requires and validates the receipt

The command becomes:

```text
spec-agents replace-doctrine <project> <backup-dir> \
  --cutover <CUTOVER.tsv> [lang] [--link|-l]
```

Before creating the backup directory or changing any path, the CLI verifies:

- the receipt is the target's canonical
  `.scratch/upgrade-review/CUTOVER.tsv`;
- all six rows exist exactly once, have no unknown keys, and use the declared
  format;
- canonical `target` and `backup_dir` equal this invocation;
- `decision` is `confirmed` and `unresolved_count` is the literal `0`;
- the adjacent `REPORT.md` exists and its current SHA-256 equals
  `report_sha256`.

Missing `--cutover`, an invalid or duplicate row, a changed report, a mismatched
target or backup, or a non-zero unresolved count refuses before backup. The
error names the receipt rule and current upstream UPGRADE entry; it never
repairs or infers confirmation.

The old invocation without `--cutover` is not retained as a compatibility
branch. Ordinary install does not accept or need a receipt.

### Replacement reports doctrine state, not project readiness

A successful `replace-doctrine` prints that current doctrine was installed and
names its recovery backup. It explicitly says to continue the confirmed Upgrade
and that ordinary work must wait for retired-state removal plus user acceptance
of fresh START. It never prints `Spec-AGENTS is ready`.

The ordinary fresh/repeated `init` and `install` success message is unchanged.
UPGRADE's overview and numbered procedure use the same order:

```text
inspect → preservation manifest → user confirmation → cutover receipt
        → doctrine replacement → retired-state reset → fresh START
```

### Project discovery accepts every START-supported root

Workflow state commands recognise the nearest ancestor with any one of:

- `.specs/`;
- `.git/`;
- `.jj/`;
- the complete installed modern entry set: `AGENTS.md`, `START.md`,
  `docs/spec-agents/WORKFLOW.md`, and `skills/plan/SKILL.md`.

The complete set is one strong marker; a lone familiar filename is not enough.
This changes only workflow-command root discovery. It does not initialize
history, classify retired state, or relax doctrine replacement's separate
target guards.

### The persistent fixture completes the Prompt lifecycle

The upgrade fixture uses the full preservation-table columns required by
UPGRADE, fills User decision before producing the receipt, archives an immutable
confirmed-report copy, and fills Completion result after fresh START. A passing
fixture contains no remaining `pending` decision or completion field.

It also proves that direct calls without a receipt, receipts with unresolved
items, report/hash changes, duplicate or unknown fields, and target/backup
mismatches refuse before backup. Separate fixtures prove workflow gates from a
modern no-VCS root and a native `.jj/` root.

## Model delta

### Upgrade Boundary

Retired workflow material is historical input, never a compatibility runtime and never a
source of current execution state. Upgrade first produces an exact preservation manifest
and stops for user confirmation. Confirmation writes a cutover receipt that binds the
canonical target and backup to the confirmed report hash and records zero unresolved rows;
doctrine replacement refuses before any write unless that receipt matches the invocation
and report. Confirmed cutover keeps an immutable copy of the approved report, keeps retired
material recoverable, removes it from the active read path, replaces only installer-owned
doctrine, and ends at a fresh START. Preserved knowledge remains candidate until the current
project and the user confirm it; active intent is planned and captured again. Application
code and unclassified project-owned documents do not change.

## Action Contracts

- **Upgrade reconnaissance** — unchanged report-only pre-confirmation boundary.
  It does not create CUTOVER, an archive root, or a doctrine backup.
- **Cutover confirmation** — precondition: the user confirmed every
  disposition, candidate decision, archive/backup path, current intent, and
  unknown. Input: the final pre-cutover REPORT. Permitted effect: create the
  confirmed archive root, copy `CONFIRMED-REPORT.md`, and write CUTOVER beside
  the active report. Invariant: the snapshot and active report equal the
  receipt hash at replacement time; unresolved count is zero. Verification:
  fixed rows parse, canonical paths match, and both report hashes match.
- **`replace-doctrine`** — precondition: the existing target and absent backup
  pass current guards and the explicit CUTOVER validates. Input: target,
  backup, receipt, language, and copy/link mode. Permitted effect: unchanged
  doctrine-only backup and replacement. Invariant: no Instance path changes;
  no readiness claim describes work beyond doctrine replacement. Verification:
  receipt checks happen before backup, manifest replays, and failure/refusal
  creates no backup unless the validated operation reached its backup phase.
- **Upgrade completion** — precondition: doctrine and retired-state manifests
  replay and the user accepted fresh START. Permitted effect: fill the existing
  report's Completion result. Invariant: the archived confirmed report stays
  byte-identical to the receipt hash and no old work state appears. Verification:
  decision and completion contain no pending value and name the actual next
  route.
- **Workflow project discovery** — input: current directory and ancestors.
  Permitted effect: select the nearest root matching one strong root marker.
  Invariant: no VCS is initialized and a partial doctrine set is not a modern
  root. Verification: `.specs`, Git, native JJ, full modern entry, partial
  entry, and nested-directory fixtures.

## Seams and verification

- Missing receipt, wrong path, wrong format, missing/duplicate/unknown key,
  target mismatch, backup mismatch, changed report, non-zero unresolved count,
  and non-confirmed decision all refuse before the backup path exists.
- A valid receipt reaches the existing copy and link replacement paths; the
  doctrine manifest, stale-entry removal, Instance hashes, source/broad-root
  guards, and recovery behaviour remain unchanged.
- Forced post-backup failure still names recovery material and never prints a
  replacement-complete or project-ready line.
- Replacement success prints doctrine-complete language and no project-ready
  language. Ordinary install still prints its current ready result.
- The confirmed report snapshot hash equals the receipt after the active report
  gains its final Completion result.
- The end-to-end fixture has exact report columns, one disposition per relevant
  path, no unresolved row at cutover, no pending decision/result at completion,
  no inherited work state, and a modern fresh START input.
- Workflow commands run from the root and a nested directory in no-VCS modern
  and native `.jj/` fixtures; a partial entry and arbitrary directory refuse.
- UPGRADE overview order equals the numbered order and installed doctrine is
  byte-identical to source.
- `bash -n bin/spec-agents`, `tests/upgrade-reset-smoke.sh`, installer smoke,
  `tests/doctrine-check.sh`, `tests/kernel-delta-check.sh`,
  `spec-agents check-state`, Kernel checks, Markdown reference checks, and
  `git diff --check` pass.

## Compatibility and migration

**Breaking** for direct callers of `replace-doctrine`. They must complete the
current upstream UPGRADE review, fill User decision, create the confirmed
report snapshot and CUTOVER v1 receipt, and pass `--cutover`. There is no
deprecated bypass flag or fallback to the old invocation.

Projects already upgraded by the previous command need no back-fill. The
receipt guards a future destructive invocation; it is not a new current-state
record. Ordinary init/install, existing doctrine and Instance layouts,
copy/link behaviour, backup manifests, archives, and fresh START semantics are
otherwise compatible.

A failed validated replacement that already created its backup follows the
existing recovery rule. Reusing that backup path still refuses. If the user
chooses a new backup path, update the confirmed report, create a new immutable
snapshot and receipt, and retry only after confirmation.

No-VCS and native-JJ projects gain the workflow commands START already promises.
No project has history initialized or converted by this change.

## Out of scope

- Cryptographic user identity, signatures, interactive terminal confirmation,
  or an external approval service.
- A general schema or parser for arbitrary Markdown reports.
- Automatically deciding dispositions, resolving mixed-ownership documents,
  or proving an Agent quoted the user faithfully.
- Changing the doctrine allowlist, archive deletion policy, candidate knowledge
  rules, or fresh START's confirmed-only Kernel bootstrap.
- Translating old execution state or restoring generation-specific upgrade
  branches.
- Making workflow gates create `.git/`, `.jj/`, `.specs/`, STATUS, or Evidence.
- Fixing unrelated `ready` slice-reporting defects already listed in STATUS.

## Issue map

- `01-enforce-cutover-receipt.md` — revise Upgrade Boundary and UPGRADE order;
  implement CUTOVER parsing and pre-write refusal; replace the premature ready
  message; update live command guidance.
- `02-recognize-modern-project-roots.md` — align workflow project-root discovery
  with START for native JJ and complete modern-entry projects without VCS.
- `03-prove-complete-upgrade-flow.md` — extend persistent fixtures through
  receipt bypass/refusal, confirmed snapshot, final report completion, safe
  replacement, no-VCS/native-JJ discovery, and fresh START eligibility.
- `04-promote-cutover-contract.md` — installer Runbook, Evidence, ADR 0012,
  CHANGELOG, STATUS, and terminal SPEC/Slice state. `writer: learn`.

Dependencies: slice 02 waits for slice 01 because both change the single
`bin/spec-agents` implementation; slice 03 waits for 01 and 02; slice 04 waits
for slice 03. The dependency serialises one file boundary, not a semantic
dependency between receipt validation and project-root discovery.

## Revision notes

- **r1** — captured the user-confirmed 2026-08-31 breaking plan after the
  current-version process simulation. The receipt is a deliberately small
  fixed input to one destructive command, not a second manifest or a general
  schema. Arrange serialised slices 01 and 02 after their scopes resolved to
  the same shell implementation. Kernel status is absent in this source
  repository; the one declared promotion revises the existing Workflow Upgrade
  Boundary.
