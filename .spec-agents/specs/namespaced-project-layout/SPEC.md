# Keep SPEC-AGENTS conventions out of the project root

status: verified
revision: 3
kernel_delta:
  - revise: Doctrine
  - revise: Instance
  - add: Project integration entry
  - revise: Start
  - revise: Upgrade
  - revise: Project Kernel
  - revise: State
  - revise: Evidence
  - revise: SPEC
  - revise: Slice
context_refs: `AGENTS.md`, `.spec-agents/doctrine/docs/WORKFLOW.md`, `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/UPGRADE.md`, `.spec-agents/doctrine/bin/spec-agents`, `docs/adr/0001-framework-namespace-split.md`, `docs/adr/0010-upgrade-rebootstrap.md`, `docs/adr/0012-upgrade-cutover-gate.md`, `.spec-agents/specs/authority-order/SPEC.md`, `.spec-agents/specs/reference-existence/SPEC.md`, `.spec-agents/specs/evidence-reproducibility/SPEC.md`

## Problem and goal

A managed project currently receives SPEC-AGENTS conventions across its root:
`AGENTS.md`, `START.md`, `UPGRADE.md`, and an empty `CONTEXT.md`. The first Start
then adds `KERNEL.md`, and later work may add `STATUS.md` and `EVIDENCE.md`.
The names belong to the workflow convention, but they occupy the same namespace
as the product and its own documentation.

The split introduced by ADR 0001 prevented framework state from leaking into a
managed project, but it split ownership without giving SPEC-AGENTS one physical
namespace. Doctrine is spread between the root, `skills/`, and
`docs/spec-agents/`; Instance records are spread between root files, `.specs/`,
`.scratch/`, and `archive/`.

Goal: a fresh or upgraded managed project has one hidden `.spec-agents/`
namespace for every SPEC-AGENTS-specific convention. The root contains at most
one thin `AGENTS.md` integration entry because agent discovery requires it. A
project that already owns `AGENTS.md` keeps it and receives an explicit manual
integration step instead of an overwrite.

## Unchanged contracts

- `AGENTS.md` remains the agent-discovery mechanism. Automatic discovery is not
  traded away for a perfectly empty root.
- Doctrine and Instance remain different ownership classes even though both
  live below `.spec-agents/`. Doctrine replacement never removes their common
  parent.
- The installer emits Doctrine only. It does not infer project semantics,
  create work state, translate old execution state, or install this
  repository's Instance records.
- Existing project-owned `AGENTS.md`, `CONTEXT.md`, source, configuration,
  credentials, tests, and `docs/{adr,protocols,runbooks,lessons}/` are not
  overwritten.
- `CONTEXT.md` remains an optional project-owned vocabulary document. A project
  may orient somewhere else and must not be forced to maintain two entries.
- `learn` remains the only action that promotes verified knowledge. `capture`
  owns SPECs, `arrange` owns Slices, and the existing action write boundaries
  remain semantic boundaries after their paths move.
- Upgrade remains a confirmed salvage/reset/fresh-Start operation with a
  validated cutover receipt. No compatibility runtime reads both layouts.
- `--link` may link Doctrine, but no writable Instance record or project-owned
  integration file links back to this source repository.

## Decision and boundaries

### One hidden namespace

The managed-project layout becomes:

```text
AGENTS.md                                  optional thin integration entry
.spec-agents/
  doctrine/
    AGENTS.md                              full selected-language doctrine
    START.md
    UPGRADE.md
    bin/spec-agents                        workflow CLI
    skills/{plan,capture,arrange,do,check,learn}/
    docs/{WORKFLOW,README,...}.md
    docs/check-kernel.sh
  state/
    KERNEL.md
    STATUS.md
    EVIDENCE.md
  specs/<feature>/
    SPEC.md
    issues/*.md
  scratch/
  archive/
```

`state/`, `specs/`, `scratch/`, and `archive/` are created only when the
project's work needs them. A fresh install creates only `doctrine/` and, when
safe, the root integration entry.

The names under `doctrine/` are intentionally relative to the namespace. The
old `docs/spec-agents/` double namespace does not survive inside
`.spec-agents/doctrine/`.

### The root entry is an adapter, not the doctrine

When root `AGENTS.md` is absent, the installer creates a short copied adapter
whose only job is to direct the agent to
`.spec-agents/doctrine/AGENTS.md`. It contains no workflow model, action
contract, project state, or generated project knowledge.

When root `AGENTS.md` already exists:

- the installer writes `.spec-agents/doctrine/` but does not edit or replace
  the project file;
- an exact reference to `.spec-agents/doctrine/AGENTS.md` satisfies the
  integration gate;
- without that reference, installation ends as **integration required**, does
  not claim readiness, and prints the exact line the user must add;
- rerunning after the user-owned edit is repeatable and may claim readiness.

An installer-generated adapter is identified by an exact format marker. Future
doctrine replacement may replace that adapter only when the marker and expected
shape both match. A project-authored root entry is never classified as Doctrine
from its filename or from a loose mention of SPEC-AGENTS.

### No default `CONTEXT.md`

The installer stops creating `CONTEXT.md`. Actions read it only when the
project already has one. The existing template is retired from the payload; no
project-owned file is deleted during migration.

### Doctrine and Instance stay separately replaceable

Doctrine replacement owns only `.spec-agents/doctrine/` and an exact generated
root adapter. It must never remove `.spec-agents/` as a whole. The project owns
all other children.

The replacement backup and manifest record each owned path explicitly. A
failed replacement leaves state, specs, scratch material, archive material,
and project documents byte-identical.

### The source repository dogfoods the public layout

The SPEC-AGENTS repository is migrated to the same integration and Instance
paths so its tests exercise the paths users receive. Doctrine is the product
here, but its authoring source also lives below `.spec-agents/doctrine/`.
The thin root `AGENTS.md` remains only as the discovery adapter.

This migration is sequenced: current control records remain authoritative at
their old paths until the new CLI, doctrine, gates, and tests can read the new
layout. A dedicated cutover slice moves the records with the writer declared
for each owned class; no intermediate commit claims both layouts are active.

### The authority-order work is absorbed

`.specs/authority-order/SPEC.md` is superseded by this SPEC. Its confirmed
decisions remain part of the new full doctrine:

- the resolution order puts the action skills directly below the root/full
  AGENTS contract;
- the authority-map Protocol states the same two `do` cases as the `do` skill;
- `learn` may change workflow doctrine only in this upstream repository, never
  in a managed project;
- a later ADR supersedes the named conflicting consequence in ADR 0006 rather
  than editing the accepted record.

The order uses the new paths and therefore cannot be safely implemented first
against the retiring layout.

### Waiting work is preserved, not silently reinterpreted

`reference-existence` remains a real problem, but its proposed paths and
installed-set assumptions become stale when this layout lands. It returns to
`plan` for a revision after cutover. Shipping the CLI at
`.spec-agents/doctrine/bin/spec-agents` satisfies only that SPEC's distribution
decision; its other reference and checker work is not claimed complete here.

`evidence-reproducibility` keeps its confirmed meaning. Its references are
relocated mechanically from root `EVIDENCE.md` to
`.spec-agents/state/EVIDENCE.md` when it is executed.

## Model delta

### Doctrine — revise

Doctrine remains installer-owned and identical across managed projects, but
its durable home changes from five root/top-level paths to
`.spec-agents/doctrine/`. The full AGENTS contract is Doctrine; the root adapter
is only the project integration entry.

### Instance — revise

SPEC-AGENTS-specific project records share `.spec-agents/` without becoming
Doctrine. State, specs, scratch reports, and workflow archives keep their
current writers and lifecycle under dedicated children. Project vocabulary and
general durable knowledge remain in project-selected locations outside the
namespace.

### Project integration entry — add

A project integration entry is the minimal root `AGENTS.md` instruction that
connects automatic agent discovery to the full Doctrine contract. It is either
an exact installer-generated adapter or a project-owned instruction. Presence
of a root file alone does not prove integration.

### Start — revise

Start is read from `.spec-agents/doctrine/START.md`; it writes reports below
`.spec-agents/scratch/` and bootstraps the Project Kernel below
`.spec-agents/state/`. Its semantic classification and confirmation boundary do
not change.

### Upgrade — revise

Upgrade is read from current upstream Doctrine and treats the former root
layout as retired workflow material. Confirmed reset installs the namespaced
Doctrine, archives approved retired state below `.spec-agents/archive/`, and
hands off to the namespaced fresh Start. It never runs both layouts as current.

### Project Kernel — revise

The Project Kernel keeps its meaning and lifecycle; its default home changes
from root `KERNEL.md` to `.spec-agents/state/KERNEL.md`.

### State — revise

Current work state keeps its meaning and lifecycle; its home changes from root
`STATUS.md` to `.spec-agents/state/STATUS.md`.

### Evidence — revise

The append-only Evidence ledger keeps its meaning and promotion rules; its home
changes from root `EVIDENCE.md` to `.spec-agents/state/EVIDENCE.md`.

### SPEC — revise

The living feature contract keeps its schema and lifecycle; its home changes
from `.specs/<feature>/SPEC.md` to
`.spec-agents/specs/<feature>/SPEC.md`.

### Slice — revise

The execution unit keeps its schema, reachability rule, and writer boundaries;
its home changes with its SPEC to
`.spec-agents/specs/<feature>/issues/*.md`.

## Action Contracts

### `install`

- **Preconditions:** target is not the source repository and contains no
  unresolved retired-workflow conflict.
- **Input:** target, language, and copy/link mode.
- **Allowed effects:** install or retain namespaced Doctrine; create an absent
  root adapter; report a required manual integration for an existing
  non-integrated root entry.
- **Forbidden effects:** create root convention/state files, alter an existing
  root `AGENTS.md`, create `CONTEXT.md`, or claim readiness while integration is
  missing.
- **Verification:** exact installed-set, root-set, repeat-install, link, and
  existing-entry fixtures.

### `replace-doctrine`

- **Preconditions:** the existing cutover receipt still binds the canonical
  target, backup, report hash, zero unresolved rows, and confirmed decision.
- **Allowed effects:** back up and replace explicit old/new Doctrine paths and
  an exact generated adapter; write a replayable manifest.
- **Forbidden effects:** remove `.spec-agents/` as a unit or change Instance and
  project-owned paths.
- **Verification:** invalid receipts refuse before writes; forced failures leave
  recovery material; pre/post Instance manifests are identical.

### `start`

- **Preconditions:** root integration resolves to complete namespaced Doctrine.
- **Allowed effects:** the same report and first-Kernel bootstrap as today, at
  the new Instance paths.
- **Forbidden effects:** read old root convention/state as current or create
  any other root file.
- **Verification:** fresh, re-scan, missing integration, and upgrade handoff
  fixtures.

### Six workflow actions

The six actions retain their semantics and writer boundaries. Their mandatory
reads, gate messages, state lookup, SPEC/Slice discovery, Evidence references,
and completion checks resolve only the new canonical paths. Old paths are
upgrade evidence, never fallback authority.

### Source-repository cutover

- **Preconditions:** new-path implementation and fixtures pass while old
  control paths still anchor the work.
- **Allowed effects:** relocate each current record to its new canonical path
  under the action that owns that record; replace root doctrine with the thin
  adapter.
- **Forbidden effects:** drop history, leave duplicate active authorities, or
  move untracked scratch material without an exact inventory and recovery path.
- **Verification:** Git records renames where applicable; all gates work from
  root and nested directories after cutover; old active paths are absent.

## Seams and verification

- A fresh install has no root `START.md`, `UPGRADE.md`, `CONTEXT.md`,
  `KERNEL.md`, `STATUS.md`, or `EVIDENCE.md`; it has at most the thin root
  `AGENTS.md` adapter.
- The complete installed Doctrine set is below `.spec-agents/doctrine/`, with
  the selected full AGENTS contract, prompts, docs, skills, checker, and CLI.
- An existing project-owned `AGENTS.md` is byte-identical after install. A
  missing namespace reference prevents a readiness claim and prints one exact
  integration instruction.
- Copy, repeat-copy, link, and replacement installs all preserve the
  Doctrine/Instance boundary. Writable files are never links into upstream.
- `status`, `ready`, `gate`, `transition`, and `check-state` work from root and
  nested directories in Git, native-JJ, `.spec-agents/specs`, and complete
  no-VCS projects.
- Project-root detection requires a strong integrated entry, not a lone
  `.spec-agents/` directory or root `AGENTS.md`.
- Every active Markdown link and every current-layout path in Doctrine resolves
  in the installed target; no command tells a user to read a retired root path.
- Upgrade simulation proves old root Doctrine and Instance state are
  recoverable, inactive after cutover, and followed by a fresh namespaced K1.
- Doctrine and kernel-delta checks pass after the source repository cutover.
- The authority-order acceptance from the superseded SPEC passes against the
  new full doctrine locations, and the superseding ADR is created only by
  `learn` after verification.

## Compatibility and migration

**Breaking.** There is one canonical layout and no runtime fallback.

### Fresh projects

Fresh installation writes namespaced Doctrine. It creates a root adapter only
when the name is free, and creates no project Instance record or context
skeleton. First Start creates the namespaced K1 only after the existing
confirmed-facts gate.

### Projects with the current root layout

They classify as `upgrade-needed`. The current upstream Upgrade review:

1. inventories root Doctrine, root Instance records, `.specs/`, `.scratch/`,
   and workflow archive material;
2. preserves only user-approved candidate knowledge and confirms exact
   dispositions;
3. binds the report to a cutover receipt;
4. backs up and removes old Doctrine recoverably;
5. archives approved retired state without translating its execution status;
6. installs namespaced Doctrine and completes root integration;
7. runs a clean namespaced Start and waits for user acceptance.

Project-owned root documents that merely share a familiar name are never moved
without an explicit confirmed classification. Application code and general
project documentation remain byte-identical.

### This repository

Implementation uses a final coordinated cutover after the new gates and tests
pass. Tracked files are relocated with history; current untracked scratch data
is inventoried and either moved recoverably or left untouched as explicitly
retired local material. The current SPEC remains reachable throughout the
transition and is closed only from the new canonical path.

## Out of scope

- Removing the root `AGENTS.md` integration entry and giving up automatic agent
  discovery.
- Defining or overwriting a project's own `CONTEXT.md` or other orientation
  document.
- Moving general project knowledge from `docs/{adr,protocols,runbooks,lessons}`
  into the framework namespace.
- Supporting both layouts as live read paths after cutover.
- Translating legacy SPEC, Slice, Status, Kernel, or Evidence records into
  current execution state.
- Completing the remaining reference checker and archive-signpost work from
  `reference-existence`; it must be revised against this layout.
- Changing the meaning of the reproducibility Protocol proposed by
  `evidence-reproducibility`.

## Issue map

- `01-managed-install-tracer.md`: namespaced Doctrine payload, thin root
  integration, and a runnable installed workflow using the new Instance paths.
  Installation and runtime path rewrites are one tracer because moving the
  full contract changes the resolution base of every active reference.
- `02-namespaced-workflow-tracer.md`: stale; absorbed into Slice 01 after the
  first independent check proved that a ready installation with old
  root-oriented references cannot pass reference integrity.
- `03-upgrade-tracer.md`: stale; absorbed into Slice 01 after canonical path
  migration made the existing Upgrade lifecycle and its 10/10 fixture part of
  the same shippable tracer.
- `05-source-cutover.md`: relocate this repository's Doctrine and Instance
  records without duplicate authority.
- `06-verification.md`: installed-set, root-cleanliness, link/reference,
  workflow-root, upgrade, and regression fixtures.
- `07-learn-record.md`: Workflow promotion, superseding ADR, Evidence,
  Changelog, terminal state, and waiting-SPEC follow-up. `writer: learn`.

## Revision notes

- **r1** — captured the user-confirmed breaking layout on 2026-08-31. The
  confirmed plan chose one `.spec-agents/` namespace, a minimal root AGENTS
  adapter, no installed CONTEXT skeleton, no dual-layout runtime, an explicit
  migration, and absorption of `authority-order`.
- **r2** — corrected the execution decomposition after independent check of
  Slice 01. The installer payload and installed workflow paths are one tracer:
  the new payload changes the resolution base of the full AGENTS contract, so
  the former Slice 02 cannot remain a downstream acceptance dependency. No
  product decision, Model delta, migration rule, or final acceptance changed.
- **r3** — absorbed the former Upgrade Slice 03 after full regression proved
  that namespaced Start/archive paths and doctrine replacement cannot remain a
  red downstream fixture while Slice 01 closes. The cutover receipt, backup,
  recovery, reset, and fresh-Start contracts are unchanged; only their
  execution unit changed. Kernel-delta fixtures also move mechanically to
  complete namespaced managed roots without changing their assertions.
