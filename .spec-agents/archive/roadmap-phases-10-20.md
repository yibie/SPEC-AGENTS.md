# Retired: Phase records, 2026-08-16 to 2026-08-20

status: retired
retired_on: 2026-08-20
reason: `Phase` was retired as a concept; see `docs/adr/0002-retire-phase.md`
source: former root `ROADMAP.md` and the closed phase sections of `STATUS.md`

This is history, not current context. `Phase` carried two jobs — the boundary
of a bounded piece of work, and the spine of a history ledger — and the second
job won. Eleven phases accumulated here while `STATUS.md` grew its own parallel
copy and `EVIDENCE.md` recorded every phase result a third time.

The work boundary is now the SPEC at `.specs/<feature>/SPEC.md`. What happened
is in `EVIDENCE.md`. Nothing below is a current state pointer; read it only for
an explicit historical or regression question.

---

## Retired ROADMAP

## Phase 10: Standard Documents and Action Skills

**Status**: Complete

**Goal**: Replace the custom `.phrase` default entry points with recognizable
document names and implement the six SPEC-AGENTS actions: `plan`, `capture`,
`arrange`, `do`, `check`, and `learn`.

**Entry condition**:

- Phase 9 retained the bounded Kernel → State → Evidence → Code protocol.
- The user approved a living SPEC and the standard document layout.
- The user approved the six action names.

**Acceptance gate**:

- All six skills have valid metadata and concise read/write contracts.
- `AGENTS.md` points to the root documents and the six-action flow.
- `CONTEXT.md`, `ROADMAP.md`, `STATUS.md`, and `EVIDENCE.md` exist as the new
  default entry points.
- Legacy `.phrase/` material remains available for explicit history or migration
  only and is not part of default context.
- No formal ontology tooling, application feature, or experiment rerun is added.

**Out of scope**:

- RDF/OWL/SHACL, graph storage, schema generation, synchronization, or runtime
  ontology authorization.
- Rewriting historical experiment records.
- Adding aliases with Matt's skill names.

**Result**:

- The six action skills are discoverable as `plan`, `capture`, `arrange`, `do`,
  `check`, and `learn`.
- Root documents now provide the default context; `.phrase/` remains a legacy
  history tree instead of a second active workflow.
- Metadata validation, discovery, and stale-reference checks passed.
- The next phase is a bounded smoke pass, not part of this migration.

**Next phase recommendation**:

Run one small no-semantic-change task and one multi-context compatible revision
through the six actions. Use their evidence to decide whether the skill text
needs revision before adding more documents.

Historical phase detail remains in `.phrase/roadmap.md` and is legacy context.

## Phase 11: Six-action Smoke Pass

**Status**: Complete

**Goal**: Exercise the six action skills on one no-semantic-change task and one
compatible multi-context revision, then use evidence to decide whether the
contracts need revision.

**Entry condition**:

- Phase 10 established the root documents and six action entry points.
- The user approved execution of the bounded smoke pass.

**Acceptance gate**:

- The small sample is classified as no semantic change before a one-line
  implementation-only edit, then checked and recorded.
- The compatible sample adds an optional `evidence_ref` from Slice to Evidence
  without changing existing issue validity, invariants, or execution order.
- The compatible sample runs through `capture`, `arrange`, two `do` slices,
  `check`, and `learn` with reproducible validation.
- No existing application or experiment sandbox is modified.

**Out of scope**:

- New ontology infrastructure, application features, or a third domain.
- Required evidence links on historical issues.
- General claims about model quality from this smoke pass.

**Result**:

- The no-change path classified a documentation-only refinement and completed
  `plan → do → check → learn` without a SPEC or model update.
- The compatible path completed `capture → arrange → do → check → learn` and
  added the optional Slice → Evidence link while preserving existing issue
  validity and execution order.
- Six skill validators, discovery, writer ownership, and whitespace checks
  passed. No application or experiment sandbox changed.
- The smoke pass demonstrates contract wiring, not a general improvement in
  agent behavior.

**Next phase recommendation**:

Use the six actions on one real bounded repository change. Compare the direct
and multi-context paths only when the task naturally requires multiple
contexts; do not manufacture another metadata-only delta.

## Phase 12: Modern Installer Layout (superseded compatibility result)

**Status**: Complete — superseded by Phase 13

**Goal**: Make `bin/spec-agents` install the new root document layout and six
action skills by default while retaining the old `.phrase` layout behind an
explicit `--legacy` option.

**Entry condition**:

- Phase 11 proved the action contracts on documentation and protocol changes.
- Repository inspection found the installer still emits the v3 `.phrase`
  layout and the English guide describes only that layout.

**Acceptance gate**:

- A modern install contains `AGENTS.md`, `CONTEXT.md`, `ROADMAP.md`,
  `STATUS.md`, `EVIDENCE.md`, `docs/`, `archive/`, and the six skills.
- A legacy install remains available through `--legacy` and still emits the
  old `.phrase` files.
- `--link` works for both modes and source files are not deleted or rewritten.
- English guidance and the installation section describe the modern default.
- A temporary-directory smoke test proves both modes and rejects installing
  into the source repository.

**Out of scope**:

- Migrating existing user projects automatically.
- Deleting `.phrase` from installed projects.
- Rewriting the historical protocol-cost benchmark.

**Result**:

- Modern installs now copy or link `AGENTS.md`, the four root state documents,
  `docs/`, `archive/`, and the six action skills.
- `--legacy` preserves the old `.phrase` files and Claude command shims for
  explicit compatibility, and `--link` works in both modes.
- English guidance and README now describe the modern default; historical v3
  `.phrase` examples are labeled as historical.
- Temporary copy/link installs and source-repository refusal all passed without
  touching applications or experiment sandboxes.

**Next phase recommendation**:

Use the modern installer in one real, user-selected project only when a
migration need appears. Do not add automatic migration until a concrete
existing project supplies evidence for it.

## Phase 13: Legacy Project Upgrade (superseded by Prompt-first cutover)

**Status**: Complete — superseded by Phase 14

**Goal**: Replace permanent `.phrase` compatibility with an explicit upgrade
path for projects using the v2 static SPEC or v3 `.phrase` architecture.

**Entry condition**:

- Phase 12 made the modern root layout the default installer output.
- The user confirmed that old projects should be upgraded, not remain on a
  permanent compatibility branch.
- Repository inspection found both v2 phase bundles and v3 `.phrase` files in
  the existing migration material.

**Acceptance gate**:

- Fresh `init`/`install` rejects `--legacy` and never emits `.phrase`.
- `upgrade` auto-detects v2, v3, and mixed sources, archives them without
  deletion, and writes a migration handoff.
- Existing modern state refuses safely without moving source files.
- User-facing guidance describes upgrade as mechanical preparation followed by
  semantic migration through the six actions.
- No application or experiment sandbox changes.

**Out of scope**:

- Automatic semantic summarization of v2 records.
- Formal ontology infrastructure or application migration.
- Deleting archived material.
- Rewriting the historical protocol-cost benchmark.

**Result**:

- Fresh `init`/`install` now reject `--legacy`, reject installation into an
  existing `.phrase` project, and direct users to `upgrade`.
- `upgrade` detects v2, v3, and mixed source trees, archives `.phrase` without
  deletion, installs the modern root shell, and writes `MIGRATION.md`.
- Unknown input and existing modern-state conflicts refuse without moving
  source files.
- Documentation, skill discovery, syntax, and the full temporary fixture gate
  passed without touching application or experiment sandboxes.

**Next phase recommendation**:

Use `MIGRATION.md` as the entry point for a real project's semantic review.
Do not add automatic summarization until a real v2/v3 handoff demonstrates a
repeatable missing rule.

## Phase 14: Prompt-first Project Upgrade

**Status**: Complete

**Goal**: Replace mechanical installer-side v2/v3 migration with one
user-confirmed `UPGRADE.md` Prompt while keeping the installer minimal.

**Entry condition**:

- Phase 13 demonstrated that v2/v3 detection and archiving require project
  history and code-architecture judgment.
- The user confirmed that this judgment belongs in an Agent Prompt, not in the
  shell installer.

**Acceptance gate**:

- `UPGRADE.md` gives one v2/v3 flow: reconnaissance, user confirmation,
  cutover, and verification.
- The installer only installs modern entry points and `UPGRADE.md`; it does not
  move, delete, archive, or summarize legacy material.
- Installing into a legacy project preserves `.phrase` and prints the Prompt
  pointer; no permanent legacy mode or `upgrade` CLI remains.
- Root guidance points legacy projects to `UPGRADE.md`.
- Prompt content, syntax, skill discovery, validators, and whitespace checks
  pass without touching applications or experiments.

**Out of scope**:

- Running the Prompt against a real user project.
- Automatic code changes or architecture inference by the installer.
- Formal ontology infrastructure.

**Result**:

- `UPGRADE.md` now provides one v2/v3 flow with reconnaissance, user
  confirmation, cutover, and verification gates.
- The installer only installs modern entry points and the Prompt. It preserves
  existing legacy material, prints a pointer, and no longer exposes a
  mechanical `upgrade` CLI or permanent `--legacy` mode.
- Prompt content, modern/legacy-pointer/link fixtures, syntax, skill discovery,
  validators, guidance, and whitespace checks passed without touching
  applications or experiments.

**Next phase recommendation**:

Run `UPGRADE.md` against one real v2 or v3 project. Treat the result as a
semantic migration review, not as proof that the Prompt generalizes to all
legacy projects.

## Phase 15: Project Knowledge Promotion

**Status**: Complete — bounded knowledge classes promoted

**Goal**: Extend the ontology/SPEC method beyond source code so development
practices, operational procedures, and implementation lessons can be captured,
promoted, scoped, and revised without enlarging the default context.

**Entry condition**:

- v4 already has `EVIDENCE.md` and `learn` promotion for semantic knowledge.
- The user identified coding conventions and implementation experience as
  unmanaged project knowledge.

**Acceptance gate**:

- `CONTEXT.md` defines Knowledge Classes and their relations without adding a
  formal ontology schema or graph database.
- `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/` have clear routing
  and record requirements.
- One verified workflow practice is represented as a Protocol and one verified
  implementation failure is represented as a scoped Lesson.
- `AGENTS.md`, `AGENTS_en.md`, `plan`, `do`, `check`, and `learn` route and
  promote these records without loading all documentation by default.
- No application or experiment sandbox is changed.

**Result**:

- Project knowledge now distinguishes semantic rules, decisions, Protocols,
  Runbooks, Lessons, Evidence, and State.
- The evidence-link writer boundary is the first promoted Protocol example.
- Native form API shadowing is the first scoped Lesson example, with browser
  verification and an explicit applicability condition.
- The pilot supports the broader method, but one Protocol and one Lesson do not
  prove general knowledge-management effectiveness.

**Next phase recommendation**:

Run the routing on one real project's coding convention and one operational
Runbook. Do not add a knowledge index, graph projection, or automatic promotion
until that real-project use exposes a measured retrieval or consistency problem.

## Phase 16: Project Knowledge Routing Trial

**Status**: Complete — bounded routing and repeatability verified

**Goal**: Test whether a real project Protocol and Runbook are selected by
intent, enforce their verification boundary, and keep scoped Lessons from
leaking into unrelated work.

**Entry condition**:

- Phase 15 defined knowledge classes, metadata, promotion ownership, and
  intent-based loading.
- The user approved a bounded experiment before adding more infrastructure.

**Acceptance gate**:

- One shell-change Protocol and one installer Runbook have complete metadata,
  source Evidence, and verification paths.
- A temporary shell change passes the control syntax check and the treatment
  Protocol/Runbook checks.
- The treatment repeats the installer operation and verifies the refusal
  boundary without touching the source repository.
- The browser-only Lesson is excluded from shell intent.
- Context cost and limits are recorded; no general model-quality claim is made.

**Out of scope**:

- Application changes, production installer redesign, automatic routing,
  knowledge indexes, graph storage, and multi-Agent scheduling.

**Result**:

- The first metadata pass caught and repaired three incomplete durable records.
- The treatment passed shell syntax, whitespace, two installer copy runs,
  existing-file preservation, source-repository refusal, and scoped routing.
- Relevant knowledge added 2,584 bytes to the 30,261-byte default context in
  this repository. The result supports routing and repeatability, not causal
  superiority of any Agent or workflow.

**Next phase recommendation**:

Apply the routing to one real user-project change with a non-trivial coding
practice or recovery path. Revisit indexes or multi-Agent ownership only if
that task produces a measured retrieval, consistency, or handoff failure.

## Phase 17: JJ Workflow Integration

**Status**: Complete — bounded JJ workflow verified

**Goal**: Make Jujutsu the default local version-control vocabulary for
JJ-enabled projects while keeping the six actions, Git remote bridge, and
explicit setup boundary clear.

**Entry condition**:

- Phase 16 established intent-routed project knowledge and repeatable Runbook
  verification.
- The user confirmed JJ as the default local version-control model.
- The existing workflow `Change` concept must remain distinct from a JJ Change.

**Acceptance gate**:

- `CONTEXT.md` defines `JJ Change` and its relations without renaming the
  workflow `Change`.
- Both language Agent entry points, the affected skills, README, and UPGRADE
  route local JJ operations and Git-only fallback consistently.
- A Protocol and setup/recovery Runbook carry complete metadata and an Evidence
  source.
- A disposable colocated repository verifies local JJ Change creation,
  description, inspection, recovery, and bookmark creation.
- The installer smoke, shell syntax, document links/metadata, and no-auto-init
  boundary pass.

**Out of scope**:

- Automatic `.jj` initialization in the installer.
- Git history rewriting, native JJ server requirements, or remote push testing
  without a configured remote.
- Multi-Agent bookmark orchestration and formal ontology infrastructure.

**Result**:

- `JJ Change` is now a qualified version-control concept in the stable model;
  semantic `Change` remains the workflow proposal.
- JJ local commands are the default when `.jj` exists; Git-only projects keep
  their current workflow.
- Remote publication is explicit through bookmarks and `jj git push`.
- A disposable JJ smoke run and existing installer checks passed. See
  `EVIDENCE.md` `E-20260817-006`.

**Next phase recommendation**:

Opt one real user project into colocated JJ only after explicit confirmation,
then measure whether change/SPEC traceability or handoff needs another
protocol. Do not add an index, graph projection, or automatic initialization
from this bounded smoke run.

## Phase 18: Start Project Bootstrap Entry

**Status**: Complete — report-first Start routing verified

**Goal**: Give projects one safe entry point for adapting to the SPEC-AGENTS
workflow without turning startup into a seventh action or an automatic
migration engine.

**Entry condition**:

- Phase 17 established the JJ boundary and explicit setup rule.
- The user requested a `start` instruction for rapid project onboarding.
- The six action names and the `UPGRADE.md` migration gate remain stable.

**Acceptance gate**:

- `CONTEXT.md` defines Start, ProjectState, and StartReport with lifecycle and
  confirmation invariants.
- `START.md` classifies modern, legacy, mixed, missing-entry, and blocked
  projects and writes a report before user confirmation.
- Modern projects hand off to `plan`; legacy/mixed projects hand off to
  `UPGRADE.md`; missing-entry projects receive installation guidance.
- The installer copies `START.md` and preserves an existing file on repeat
  installation.
- Four disposable route fixtures, shell syntax, Markdown links, and installer
  checks pass without changing the source project.

**Out of scope**:

- A seventh action skill or a `start` implementation command that edits code.
- Automatic root-document cutover without confirmation.
- Automatic JJ initialization or a second v2/v3 migration engine.

**Result**:

- `START.md` is now the report-first project bootstrap entry.
- Agent routes and both README language sections point to the same command.
- The installer includes Start while preserving existing prompts.
- The route matrix and installer smoke passed; see `EVIDENCE.md`
  `E-20260818-007`.

**Next phase recommendation**:

Run Start on one real, user-selected project. Measure whether the report is
enough to establish project cognition and whether the handoff to `plan` needs a
project-specific Protocol. Do not add automatic migration from this fixture
run alone.

## Phase 19: First-run Project Kernel Bootstrap

**Status**: Complete — first-run K1 boundary and md-mode bootstrap verified

**Goal**: Ensure the first `START.md` scan establishes the managed project's
minimal stable semantic Kernel before waiting for user confirmation, instead of
leaving the project with only a reconnaissance report.

**Entry condition**:

- Phase 18 proved a report-first Start route but did not create project
  cognition.
- The user identified that a first run must record the current project's stable
  Kernel immediately.
- Existing research requires a Bootstrap Kernel before the first implementation.

**Acceptance gate**:

- A fresh project with directly confirmed facts receives `KERNEL.md` K1 during
  the first Start scan.
- Candidate, inferred, and unknown claims remain in the report and do not enter
  enacted K1.
- Existing `KERNEL.md` is preserved; conflicts route to `plan`.
- Legacy/mixed routes preserve K1 while `UPGRADE.md` reconciles older material.
- Static checks and disposable fixtures prove no application, dependency,
  configuration, or repository-history changes.

**Out of scope**:

- Formal ontology schema, graph database, generator, automatic promotion, or a
  seventh action.
- Replacing `CONTEXT.md` for SPEC-AGENTS' own workflow semantics.
- Automatic overwrite or migration of an existing project Kernel.

**Result**:

- `START.md` now creates an absent, confirmed-only `KERNEL.md` K1 and records
  its source/version in the Start report.
- `CONTEXT.md`, both Agent entry points, the six relevant skills, upgrade path,
  README, installer guidance, and knowledge-promotion Protocol distinguish
  project Kernel from framework Context.
- The disposable fixture matrix passed for fresh, existing-Kernel, legacy,
  mixed, and insufficient-evidence projects. The real `md-mode` project now
  has `KERNEL.md` K1; application source and tests remained unchanged. See
  `EVIDENCE.md` `E-20260819-008`.

**Next action**:

Use `plan` on the selected `md-mode` project with its new K1, confirm inferred
terms and missing operational knowledge, and make one small bounded change
before considering further Kernel evolution.

## Phase 20: Framework Namespace Split

**Status**: Complete

**Goal**: Separate framework doctrine from this repository's own working state,
so that installing SPEC-AGENTS adds a workflow to a project without adding that
project a second, false identity.

**Entry condition**:

- A field report showed `spec-agents init` writing this repository's Phase 19
  state, phase history, and experiment ledger into a managed project.
- Reproduction in a temporary directory confirmed five installed files carried
  this repository's own markers.
- The same report showed root `CONTEXT.md` contested by the project's glossary,
  another skill collection, and this framework at the same time.

**Acceptance gate**:

- The installer emits doctrine only, through an explicit allowlist rather than
  directory enumeration.
- `STATUS.md`, `ROADMAP.md`, `EVIDENCE.md`, `archive/`, and the project
  knowledge classes are absent from a fresh install.
- A leakage assertion fails against the pre-fix installer and passes after it.
- `templates/`-sourced files are copied under `--link`, never symlinked.
- The breaking boundary is recorded as an ADR with a user-confirmed migration
  path that deletes nothing automatically.

**Out of scope**:

- Migrating or deleting anything in an already-installed target.
- Changing the six action names, their order, or their contracts.
- Changing the workflow model's content while moving it.

**Result**:

- `Doctrine` and `Instance` are explicit concepts in
  `docs/spec-agents/WORKFLOW.md`, with an invariant that binds the installer to
  an allowlist.
- The workflow model moved to `docs/spec-agents/WORKFLOW.md` and four framework
  records moved into the same namespace, leaving `docs/adr/`,
  `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/` to the project.
- Root `CONTEXT.md` belongs to the project; the installer emits an empty
  skeleton once.
- The full smoke Runbook passes: installed set, absent set, leakage, link mode,
  link resolution, idempotency, and source refusal. See `EVIDENCE.md`
  `E-20260820-001`.

**Next action**:

Run the `UPGRADE.md` pre-split section against one real project installed before
this change. Record where the classification step is wrong before trusting it on
projects whose root documents are genuinely their own.


---

## Retired closed phase sections of STATUS.md

## Phase 19 — First-run Project Kernel Bootstrap (closed)

**Status**: Complete — first-run K1 boundary and md-mode bootstrap verified

## Goal

Ensure the first `START.md` scan records the project's directly confirmed
stable semantic Kernel before waiting for user confirmation, while keeping
candidate, inferred, and unknown claims outside the enacted layer.

## Scope

- `START.md`, `CONTEXT.md`, `AGENTS.md`, `AGENTS_en.md`, `UPGRADE.md`
- `skills/plan/`, `skills/capture/`, `skills/check/`, `skills/learn/`
- `README.md`, `bin/spec-agents`, knowledge-promotion guidance
- `.scratch/start-command/`

## Out of scope

- Overwriting an existing `KERNEL.md` or changing application code.
- Formal ontology schemas, graph storage, generators, automatic promotion, or
  a seventh action.
- Treating inferred or unknown claims as enacted Kernel semantics.

## Active tasks

```text
task031 [x] goal:<define first-run K1 and separate project Kernel from framework CONTEXT> | scope:<START.md, CONTEXT.md, AGENTS*.md> | verify:<model and boundary scan>
task032 [x] goal:<route Kernel bootstrap through six actions and upgrade guidance> | scope:<skills/, UPGRADE.md, README.md, docs/> | verify:<cross-document consistency>
task033 [x] goal:<verify K1 creation, preservation, and insufficient-evidence routes> | scope:<.scratch/start-command/, EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<disposable fixture matrix + static checks>
```

## Acceptance

- A fresh project with stable code facts receives a confirmed-only `KERNEL.md`
  K1 during its first Start scan.
- User confirmation governs candidate additions and revisions, not the
  existence of the initial stable floor.
- An existing Kernel is preserved byte-for-byte by Start and conflicts are
  reported for `plan`.
- Legacy/mixed projects preserve K1 while UPGRADE reconciles old material.
- No application files, dependencies, configuration, or repository history are
  changed by the bootstrap.

## Blockers

Fresh, existing-Kernel, legacy, mixed, and kernel-unavailable fixtures passed;
the selected `md-mode` project now has a confirmed-only K1. See
`E-20260819-008`.

## Handoff

Phase 19 is closed. The next permitted action is `plan` in `md-mode`, using its
new `KERNEL.md` as the project semantic authority before any application change.

## Phase 18 — Start Project Bootstrap Entry (closed)

## Goal

Provide a single `start` entry that reconstructs a bounded project picture,
waits for user confirmation, and hands a project to `plan` or `UPGRADE.md`
without silently changing code or project history.

## Scope

- `START.md`, `CONTEXT.md`, `AGENTS.md`, `AGENTS_en.md`, `UPGRADE.md`
- `README.md`, `bin/spec-agents`, `docs/runbooks/installer-smoke.md`
- `.scratch/start-command/`

## Out of scope

- Application code, automatic semantic migration, and a seventh action skill.
- Automatic JJ initialization, Git history rewriting, and multi-Agent
  orchestration.

## Completed tasks

```text
task013 [x] goal:<classify and execute a no-semantic-change edit> | scope:<skills/check/SKILL.md> | verify:<plan no-change/approve + quick_validate + check>
task014 [x] goal:<add optional evidence_ref traceability> | scope:<CONTEXT.md, AGENTS.md, skills/, docs/protocols/, .scratch/six-action-smoke/> | verify:<SPEC + two slices + static validation>
task015 [x] goal:<record smoke evidence and phase result> | scope:<EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<learn entry + acceptance gate>
task016 [x] goal:<modernize installer with legacy escape hatch> | scope:<bin/spec-agents, AGENTS_en.md, README.md> | verify:<modern and legacy temp installs>
task017 [x] goal:<record installer evidence and phase result> | scope:<EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<learn entry + acceptance gate>
task018 [x] goal:<remove permanent legacy mode> | scope:<bin/spec-agents> | verify:<modern install + --legacy rejection + upgrade help>
task019 [x] goal:<prepare v2/v3 upgrade path> | scope:<bin/spec-agents> | verify:<v2/v3/mixed/conflict fixtures>
task020 [x] goal:<record upgrade verification and phase result> | scope:<AGENTS.md, AGENTS_en.md, README.md, CONTEXT.md, EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<full upgrade harness>
task021 [x] goal:<replace mechanical migration with upgrade Prompt> | scope:<UPGRADE.md, bin/spec-agents, AGENTS.md, AGENTS_en.md, README.md, CONTEXT.md> | verify:<prompt content + modern install + legacy pointer>
task022 [x] goal:<define project knowledge classes and routing> | scope:<CONTEXT.md, AGENTS.md, AGENTS_en.md, docs/> | verify:<knowledge classes + status/scope/applicability/source/verification contract>
task023 [x] goal:<promote one practice and one scoped lesson> | scope:<docs/protocols/knowledge-promotion.md, docs/lessons/dom-native-api-shadowing.md, EVIDENCE.md> | verify:<E-20260817-004 + link/format checks>
task024 [x] goal:<route a real-project coding practice and installer Runbook> | scope:<docs/protocols/, docs/runbooks/, research/experiments/project-knowledge-routing-pilot/> | verify:<E-20260817-005 + temporary control/treatment checks>
task025 [x] goal:<define JJ Change semantics and local command routing> | scope:<CONTEXT.md, AGENTS.md, AGENTS_en.md, skills/, UPGRADE.md> | verify:<targeted reference scan>
task026 [x] goal:<publish JJ Protocol, setup Runbook, and user guidance> | scope:<docs/, README.md> | verify:<metadata/link checks + installer smoke>
task027 [x] goal:<verify disposable JJ workflow and record evidence> | scope:<.scratch/jj-workflow/, EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<JJ smoke + static checks + no-auto-init check>
task028 [x] goal:<define Start concept and confirmation gate> | scope:<CONTEXT.md, AGENTS.md, AGENTS_en.md, START.md> | verify:<route/content checks>
task029 [x] goal:<install and document Start entry> | scope:<bin/spec-agents, README.md, UPGRADE.md, docs/runbooks/> | verify:<installer smoke + shell syntax>
task030 [x] goal:<verify four Start routes and record evidence> | scope:<.scratch/start-command/, EVIDENCE.md, STATUS.md, ROADMAP.md> | verify:<route matrix + static checks + no-auto-init check>
```

## Acceptance

- `CONTEXT.md` defines Knowledge Classes and their project-knowledge relations.
- Protocols, Runbooks, and Lessons have explicit destinations and promotion
  fields without becoming default context.
- One verified workflow practice and one scoped implementation Lesson are
  promoted with source Evidence and verification paths.
- Both language entry points and the four affected skills route knowledge by
  intent and preserve the `learn` writer boundary.
- A real-project routing trial has complete metadata, repeated operational
  verification, scoped negative routing, and recorded context cost.
- JJ-enabled projects have one explicit local command vocabulary, with Git kept
  as the remote bridge and Git-only projects preserved.
- Projects have a single report-first Start entry that routes modern, legacy,
  mixed, missing-entry, and blocked states without adding a seventh action.
- No application or production installer behavior changed.

## Blockers

None recorded. Do not add indexes, graph storage, automatic promotion, or
multi-Agent scheduling without a separate measured need.

## Previous phase result

Phase 17 established the JJ local version-control boundary and explicit setup
Runbook. Its evidence is `E-20260817-006`; this phase adds a report-first
project bootstrap entry without adding an action or migration engine.

## Current phase handoff

Phase 18 is closed. Evidence is recorded in `E-20260818-007`. The next
permitted action is to run `START.md` on one real user project and inspect the
report before deciding whether any project-specific cutover is needed.
