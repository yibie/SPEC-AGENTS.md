# ROADMAP

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
