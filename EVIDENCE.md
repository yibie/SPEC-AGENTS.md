# EVIDENCE

新结构从本阶段开始记录证据增量。历史实验记录仍在
`.phrase/evidence.md`，只在迁移、回归或用户明确追溯时读取。

## 2026-08-16 — document and skill structure

### Observation

The repository now has the six action-named skill entry points and the standard
root document names approved in the design discussion.

### Interpretation

The action flow can separate semantic gating, design capture, work arrangement,
execution, verification, and durable learning without reusing external skill
names or creating a second requirements system.

### Recommended next action

Run one bounded smoke pass: a settled implementation-only task and a compatible
semantic revision. Do not claim a general improvement until both paths have
evidence.

### Verification

`quick_validate.py` passed for all six skills. `npx skills list --json` found
only the six new project skill entry points. `git diff --check` passed, and the
new root workflow contains no template TODOs or Matt skill aliases. Legacy
`.phrase` references are limited to explicit history/migration pointers.

### Decision

Promote the standard root layout and six action skills for the next phase. Do
not claim a behavioral improvement until the bounded smoke pass runs.

## E-20260816-001 — no-semantic-change sample

### Observation

`plan` classified a wording-only heading correction in
`skills/check/SKILL.md` as `refine / approve`. `do` changed only
`固定基线` to `固定比较基点`.

### Interpretation

The change preserves the check contract and does not require a SPEC, issue
arrangement, CONTEXT update, or migration.

### Recommended next action

Keep the direct path for settled documentation-only refinements:
`plan → do → check → learn`.

### Verification

`quick_validate.py skills/check` passed, and the resulting file contains the
expected heading with no whitespace error.

## E-20260816-002 — evidence link model

### Observation

The compatible first slice added an optional `Slice --evidence_ref--> Evidence`
relation, a protocol, and an empty issue-template field. Existing issue shapes
remain valid when the field is absent.

### Interpretation

The relation is additive and keeps the static model, issue shape, and execution
order compatible.

### Recommended next action

Allow `learn` to attach this ID to the completed issue after verification.

### Verification

`quick_validate.py skills/arrange` passed; the relation, protocol, and template
field were found by the stale-reference scan.

## E-20260816-003 — evidence link writer

### Observation

The compatible second slice documents that `do` and `check` leave
`evidence_ref` empty while `learn` appends the Evidence ID and writes it back.

### Interpretation

The writer boundary is explicit and does not introduce a second requirements or
evidence system.

### Recommended next action

Keep `evidence_ref` optional and apply it only to newly touched issues.

### Verification

All six skills passed `quick_validate.py`; `npx skills list --json` discovered
exactly six skills; the writer scan found no competing writer; `git diff --check`
passed.

## Phase 11 result

### Observation

Both smoke paths completed their required action sequence. The compatible path
left two traceable issues with `evidence_ref: E-20260816-002` and
`evidence_ref: E-20260816-003`.

### Interpretation

The six actions are internally wired: `plan` gates, `capture` records,
`arrange` slices, `do` executes, `check` verifies, and `learn` promotes. The
sample is too small to establish behavioral superiority.

### Recommended next action

Use the actions on one real bounded repository change and only choose the
multi-context branch when the work genuinely needs it.

### Verification

All six validators passed; skill discovery returned exactly six project skills;
the writer scan found only `learn` as the `evidence_ref` writer; no application
or experiment sandbox was modified.

## E-20260816-004 — installer mode boundary

### Observation

`bin/spec-agents` now defaults to the root layout and accepts `--legacy` for the
old `.phrase` layout. Modern and legacy copy installs both retain `AGENTS.md`;
only the legacy mode emits `.phrase` and Claude command files. `--link` remains
available in both modes.

### Interpretation

The installer now makes the current static model and six actions the default
without removing the compatibility path for existing v3 consumers. The mode
choice is explicit and does not migrate or delete target files.

### Recommended next action

Keep automatic migration out of the installer. Use a separate `plan` pass when
an existing project should move from `.phrase` to the root layout.

### Verification

`bash -n bin/spec-agents` passed. Temporary assertions passed for modern copy,
legacy copy, modern link, legacy link, and refusal to install into the source
repository. No application or experiment directory was touched.

## E-20260816-005 — modern installation guidance

### Observation

`AGENTS_en.md` now mirrors the root-document and six-action contracts. README
describes the modern files and labels `--legacy` as an explicit compatibility
option. The remaining `.phrase` default-read examples are under the historical
v3 section, while the current section names only root documents.

### Interpretation

English guidance and the installation instructions now agree with the current
static/dynamic model boundary: root documents are durable context, skills are
actions, and `.phrase` is legacy history rather than a competing default.

### Recommended next action

Use the modern installer for new projects. Revisit legacy migration only when a
real existing project supplies evidence that the compatibility boundary is
insufficient.

### Verification

All six `quick_validate.py` checks, project skill discovery, guidance
consistency assertions, and `git diff --check` passed.

## E-20260816-006 — upgrade-only installer boundary

### Observation

`bin/spec-agents` now exposes modern `init`/`install` and an explicit
`upgrade` command. `--legacy` is rejected, and attempting to install into an
existing `.phrase` project is rejected with an upgrade instruction.

### Interpretation

The old architecture is now an input state to migration, not a permanent
installation mode. Fresh projects cannot silently enter a mixed root-plus-
`.phrase` state.

### Recommended next action

Use `upgrade` for existing projects and do not reintroduce a compatibility flag
unless a future phase proves that an actual migration blocker requires it.

### Verification

`bash -n bin/spec-agents`, help assertions, modern install assertions,
`--legacy` rejection, existing `.phrase` refusal, source-repository refusal,
and `git diff --check` passed.

### References

- `.scratch/spec-agents-upgrade/SPEC.md`
- `.scratch/spec-agents-upgrade/issues/01-installer-boundary.md`

## E-20260816-007 — v2/v3 mechanical upgrade handoff

### Observation

Temporary v2, v3, and mixed fixtures were classified correctly. Each upgrade
archived the complete `.phrase` tree under a generation-specific timestamped
directory, removed the active `.phrase` path, installed the modern root shell,
and wrote `MIGRATION.md` with mappings and manual review items.

### Interpretation

The upgrade boundary can preserve old project material without pretending that
v2 task bundles or v3 decisions have been semantically converted. The archive
is recoverable history; the handoff is the bridge to six-action semantic review.

### Recommended next action

Run `plan` against each real project's handoff before promoting concepts,
invariants, current state, or evidence into root documents.

### Verification

The v2, v3, and mixed fixtures passed archive, classification, handoff, and
no-active-`.phrase` assertions. Unknown input and existing modern-state
conflicts refused without moving source files. Link-mode upgrade passed.

### References

- `.scratch/spec-agents-upgrade/SPEC.md`
- `.scratch/spec-agents-upgrade/issues/02-upgrade-preparation.md`

## E-20260816-008 — upgrade documentation and phase gate

### Observation

Current `AGENTS.md`, `AGENTS_en.md`, and README guidance describe upgrade rather
than legacy compatibility. Six skill validators and discovery still pass after
the CLI boundary change.

### Interpretation

The static workflow now has one active architecture: root documents plus six
actions. v2/v3 remain historical source generations with an explicit, bounded
cutover path.

### Recommended next action

Use the modern root layout for new work. Treat `MIGRATION.md` as a temporary
handoff and remove it only after the project's semantic review is complete.

### Verification

The full phase harness passed syntax, modern install, `--legacy` rejection,
v2/v3/mixed/conflict/unknown upgrade fixtures, source refusal, skill discovery,
all six validators, guidance checks, and `git diff --check`. No application or
experiment directory changed.

### References

- `.scratch/spec-agents-upgrade/issues/03-upgrade-verification.md`
- `ROADMAP.md` Phase 13

## E-20260817-001 — Prompt-first upgrade boundary

### Observation

The upgrade path is now a root `UPGRADE.md` Prompt. It handles v2 and v3 with
the same sequence: classify the source, reconstruct recent history, scan the
current code architecture, write a candidate report, stop for user
confirmation, then perform cutover and verification. The installer only adds
modern entry points and prints a pointer when legacy material is present.

### Interpretation

Project cognition remains a human-confirmed semantic decision instead of a
mechanical Bash conversion. `.phrase` can coexist temporarily as migration
input, but it is not a supported runtime mode or a second default workflow.

### Recommended next action

Use `UPGRADE.md` in a real v2/v3 project and collect evidence about which
architecture findings require repeated prompts. Do not move that judgment back
into the installer without a measured need.

### Verification

The Prompt contains explicit v2/v3 classification, reconnaissance,
confirmation, cutover, verification, and completion gates. Fresh install,
legacy-project pointer/preservation, link mode, `--legacy` rejection, old
`upgrade` CLI rejection, six skill discovery/validators, syntax, and
`git diff --check` passed. No application or experiment directory changed.

### References

- `UPGRADE.md`
- `.scratch/upgrade-prompt/SPEC.md`
- `CONTEXT.md` — Legacy Upgrade Boundary

## E-20260817-002 — JSONL dynamic ledger pilot

### Observation

The throwaway JSONL pilot merged two independent streams, preserved stable IDs,
excluded an unrelated phase from a scoped read, and represented supersession
without deleting the earlier record. In the fixture, JSONL used fewer
whitespace-delimited words but more bytes and rough tokens than equivalent
Markdown (`1,532` vs `1,425` scoped bytes; `383` vs `357` rough tokens).

### Interpretation

JSONL is a plausible format for high-cardinality dynamic evidence or task
records, but it does not automatically reduce context cost. It is not a reason
to replace the human-facing root documents or to maintain a second editable
Evidence source.

### Recommended next action

Keep `AGENTS.md`, `CONTEXT.md`, `ROADMAP.md`, `STATUS.md`, and ADR/Protocol
documents in Markdown. Revisit a JSONL dynamic ledger only when record volume
or multi-Agent writes create a measured bottleneck; then test canonical-source,
query/projection, duplicate-ID, and concurrent-write behavior in a separate
plan.

### Verification

`python3 research/experiments/jsonl-evidence-pilot/run_pilot.py` passed J1–J5. The runner
used only the Python standard library, wrote no files, and did not touch
application code or production skills.

### References

- `research/experiments/jsonl-evidence-pilot/BRIEF.md`
- `research/experiments/jsonl-evidence-pilot/RUN_PROTOCOL.md`
- `research/experiments/jsonl-evidence-pilot/RESULTS.md`

## E-20260817-003 — typed ontology graph projection pilot

### Observation

An in-memory typed graph represented the SPEC chain while distinguishing
object types, relation types, action types, lifecycle gates, relation status,
and Evidence provenance. It rejected `plan` as a relation, rejected an invalid
`has_plan` domain/range pair, blocked `do` before a Slice was ready, traced
`Invariant → ActionContract → CodeArtifact → Verification → Evidence`, and
kept a rejected candidate relation out of active queries.

### Interpretation

A graph projection is useful for bounded impact and provenance queries only
when it is driven by an explicit ontology contract. The graph should not invent
semantics, turn actions into ordinary edges, or become the authority for
unconfirmed facts.

### Recommended next action

Keep the current Markdown semantic model and six-action workflow. If a real
impact-analysis question appears, run a separate temporary graph comparison;
do not select a production graph database or formal reasoning stack from this
pilot alone.

### Verification

`python3 research/experiments/ontology-graph-pilot/run_pilot.py` passed all typed-edge,
lifecycle, impact, provenance, and rejection checks. The runner used only the
Python standard library, stored state in memory, wrote no files, and did not
modify production documents or code.

### References

- `research/experiments/ontology-graph-pilot/ONTOLOGY.md`
- `research/experiments/ontology-graph-pilot/RUN_PROTOCOL.md`
- `research/experiments/ontology-graph-pilot/RESULTS.md`

## E-20260817-004 — project knowledge promotion pilot

### Observation

The existing evidence-link sample established a reusable workflow practice:
`do` and `check` leave `evidence_ref` empty, while `learn` writes the verified
Evidence ID back to the completed issue. The direct-directory experiment also
recorded a reusable implementation lesson: an element with `id="reset"`
shadowed `form.reset()` and caused a valid submit to fail before same-submit
rendering.

This pilot routed the two facts through the broader project-knowledge model:
the writer boundary became a Protocol, and the scoped DOM failure became a
Lesson with status, scope, applicability, source, and verification fields.
The model now also has explicit destinations and templates for Runbooks and
Lessons; no graph, schema, or application code was added.

### Interpretation

The existing Evidence → `learn` → `plan` → promotion → `check` loop can manage
development practices and implementation experience as well as domain
semantics, provided that each record remains scoped and evidence-linked. A
Lesson is not automatically a project-wide invariant, and a Runbook must carry
preconditions, verification, and recovery information.

### Recommended next action

Use the new routing on one real project's coding convention and one operational
runbook before adding more knowledge classes or automation. Keep the default
context minimal and load these records by intent.

### Verification

- `git diff --check` passed.
- Local Markdown/HTML links resolve after adding `docs/runbooks/` and
  `docs/lessons/`.
- `bash -n bin/spec-agents` passed; the installer remains an explicit allowlist.
- The protocol and lesson reference the existing E-20260816-003 writer evidence
  and the archived direct-directory browser result rather than inventing a new
  application claim.

### References

- `CONTEXT.md` — Knowledge Classes and project knowledge relations
- `docs/protocols/knowledge-promotion.md`
- `docs/lessons/dom-native-api-shadowing.md`
- `research/experiments/room-v4-direct-repro/RESULTS.md`

## E-20260817-005 — project knowledge routing trial

### Observation

The first contract pass found that the existing DOM Lesson and two existing
Protocol records were readable by humans but missing one or more required
top-level knowledge fields. The records were minimally repaired before the
trial continued. The bounded routing trial then passed: a temporary shell
change passed the control syntax check; the treatment also passed `git
diff --check`, two isolated installer copy runs, existing-file preservation,
and source-repository refusal. Shell intent selected the shell Protocol and
installer Runbook; browser-form intent selected only the browser Lesson.

### Interpretation

Project knowledge management provides a useful validation boundary in addition
to a filing convention: it detects incomplete durable records and makes
preconditions, verification, recovery, and applicability executable. The
relevant records added 2,584 bytes to the 30,261-byte default context in this
repository. This is routing and repeatability evidence, not a causal claim
about Agent quality.

### Recommended next action

Keep intent-routed Protocols, Runbooks, and scoped Lessons. Apply the same
pattern to one real user-project change with a non-trivial practice or recovery
path before considering an index, graph projection, automatic promotion, or
multi-Agent ownership model.

### Verification

`python3 research/experiments/project-knowledge-routing-pilot/run_pilot.py`
passed metadata, routing, temporary shell, installer-repeatability, and
source-refusal checks. `git diff --check` and the local shell syntax check
passed. The runner wrote no repository files and removed all temporary
fixtures.

### References

- `research/experiments/project-knowledge-routing-pilot/BRIEF.md`
- `research/experiments/project-knowledge-routing-pilot/RUN_PROTOCOL.md`
- `research/experiments/project-knowledge-routing-pilot/RESULTS.md`
- `docs/protocols/shell-change-validation.md`
- `docs/runbooks/installer-smoke.md`

## E-20260817-006 — JJ workflow integration

### Observation

The current SPEC-AGENTS repository has Git metadata but no `.jj/`; no automatic
initialization was performed. JJ `0.44.0` is installed locally. A disposable
Git repository was initialized in colocated mode with `jj git init --colocate`.
The smoke run created and described a JJ Change, inspected it with `jj status`,
`jj log`, and `jj diff`, exercised `jj new` followed by `jj undo`, and created a
local bookmark. It did not push to a remote because the fixture had no remote.

The installer smoke passed two isolated copy installs, existing-file
preservation, the source-repository refusal, and the presence of the new JJ
Protocol/Runbook. `bash -n`, the Git-only `git diff --check`, Markdown local
link/metadata checks, and the no-auto-init check passed as well.

### Interpretation

The six-action workflow can use JJ as a version-control layer without making
version state the semantic authority. Qualifying the term `JJ Change` avoids a
collision with the existing workflow `Change`; SPEC and Slice remain the source
of intent, while JJ records implementation state. The Git bridge preserves
remote interoperability, and the explicit setup gate prevents an installer or
agent from changing repository history silently.

This is bounded CLI and documentation evidence in a disposable local
repository. It does not establish remote push behavior, cross-host bookmark
conventions, multi-Agent coordination, or a general productivity improvement.

### Recommended next action

When the user explicitly selects a real project, run the JJ setup Runbook and
record its project-specific change/SPEC traceability. Keep automatic
initialization, history migration, and multi-Agent bookmark orchestration out
of scope until that use exposes a measured need.

### Verification

- JJ disposable smoke: `jj git init --colocate`, `jj status`, `jj describe`,
  `jj log`, `jj diff`, `jj new`, `jj undo`, and bookmark creation passed.
- `bash -n bin/spec-agents` and `bash -n link_to_system.sh`: pass.
- Git-only repository: `git diff --check`: pass.
- Local Markdown link and Protocol/Runbook metadata checks: pass.
- Installer smoke: two copy installs, existing-file preservation, and source
  repository refusal: pass.
- Current SPEC-AGENTS repository remains without `.jj/`.

### References

- `.scratch/jj-workflow/SPEC.md`
- `.scratch/jj-workflow/issues/01-jj-model-and-routing.md`
- `.scratch/jj-workflow/issues/02-jj-docs-and-operations.md`
- `.scratch/jj-workflow/issues/03-jj-validation-and-evidence.md`
- `docs/protocols/jj-change-management.md`
- `docs/runbooks/jj-project-setup.md`

## E-20260818-007 — Start project bootstrap entry

### Observation

The six-action workflow and `UPGRADE.md` had no single report-first entry for a
project that was new to SPEC-AGENTS or missing current cognition. The new
`START.md` Prompt classifies `modern`, `legacy`, `mixed`, `missing-entry`, and
`blocked` states, records version-control markers without changing them, writes
`.scratch/start/REPORT.md`, and stops for user confirmation. Confirmed modern
projects route to `plan`; legacy or mixed projects route to `UPGRADE.md`; a
missing-entry project receives installation guidance.

The installer now copies `START.md` and preserves an existing copy on repeat
installation. Four disposable route fixtures selected the expected routes.
Shell syntax, Markdown links/content, installer repeatability, source-repository
refusal, and the current repository's no-`.jj` boundary passed.

### Interpretation

Start reduces the cognitive cost of entering the workflow without adding a
seventh action or allowing startup to become an unreviewed migration engine.
The confirmation gate separates project reconnaissance from durable cognition;
the existing six actions remain responsible for any bootstrap cutover and all
subsequent changes. Routing legacy projects to `UPGRADE.md` keeps one migration
authority.

This is bounded prompt and fixture evidence. It does not establish that a
single report is sufficient for every project, nor does it test a real user's
semantic confirmation or a full v2/v3 cutover.

### Recommended next action

Run `START.md` on one real, user-selected project. Review its report with the
user and measure whether the handoff to `plan` preserves the project's durable
concepts, current state, and verification boundaries.

### Verification

- Start route matrix: modern → `plan`, legacy/mixed → `UPGRADE.md`,
  missing-entry → installation guidance: pass.
- `bash -n bin/spec-agents` and `git diff --check`: pass.
- Installer smoke: two installs, existing-file preservation, `START.md`
  presence, and source-repository refusal: pass.
- Local Markdown link/content/state checks: pass.
- Current SPEC-AGENTS repository remains without `.jj/` and no application code
  changed.

### References

- `START.md`
- `.scratch/start-command/SPEC.md`
- `.scratch/start-command/RUN_PROTOCOL.md`
- `.scratch/start-command/issues/01-start-model-and-prompt.md`
- `.scratch/start-command/issues/02-start-install-and-guide.md`
- `.scratch/start-command/issues/03-start-route-verification.md`

## E-20260819-008 — first-run project Kernel bootstrap

### Observation

The prior Start implementation stopped after writing `.scratch/start/REPORT.md`.
On the selected real `md-mode` project, the report correctly reconstructed the
Emacs package architecture and recorded 203 passing ERT tests, but no project
ontology file existed. The revised Start boundary now creates an absent
project `KERNEL.md` as a confirmed-only `K1` before waiting for confirmation;
the SPEC-AGENTS `CONTEXT.md` remains the framework model.

The `md-mode` fixture received a new `KERNEL.md` containing source authority,
edit/render views, source-preserving relations, action contracts, invariants,
architecture boundaries, and cited source/test paths. Its existing application
files, tests, README, dependencies, configuration, and Git history were not
changed. The Start report was updated with the Kernel bootstrap result and
route `modern with KERNEL.md K1 → plan`.

### Interpretation

The first-run Kernel is not a later documentation upgrade. It is the stable
semantic floor that makes the subsequent `plan` meaningful. User confirmation
still controls inferred additions, conflicts, and revisions, but it no longer
leaves a newly onboarded project without static ontology. Existing Kernels are
preserved and challenged through `plan`; the installer does not create a
generic empty Kernel.

This is one real-project bootstrap sample plus disposable boundary fixtures.
It demonstrates the write boundary and traceability path, not general ontology
quality or a causal improvement in Agent behavior.

### Recommended next action

Run `plan` in `md-mode` using `KERNEL.md` as the project semantic authority,
confirm the inferred terms and any missing release/recovery knowledge, then
make one small non-application documentation or coding change before deciding
whether K1 needs revision.

### Verification

- Fresh fixture: confirmed-only `KERNEL.md` K1 created; application file stayed
  byte-for-byte unchanged.
- Existing-Kernel fixture: sentinel `KERNEL.md` preserved byte-for-byte.
- Legacy and mixed fixtures: K1 created or preserved while route remained
  `UPGRADE.md`.
- Insufficient-evidence fixture: no empty Kernel created; route remained
  `kernel-unavailable`.
- Installer smoke: repeat install preserves `START.md`, does not install a
  generic `KERNEL.md`, and source-repository refusal passes.
- `bash -n bin/spec-agents`, `bash -n link_to_system.sh`, `git diff --check`,
  and local Markdown-link checks pass.
- `md-mode` application source and tests have no tracked diff.

### References

- `START.md`
- `CONTEXT.md`
- `.scratch/start-command/SPEC.md` revision 2
- `.scratch/start-command/RUN_PROTOCOL.md`
- `.scratch/start-command/issues/04-kernel-bootstrap.md`
- `/Users/chenyibin/Documents/prj/md-mode/KERNEL.md`
- `/Users/chenyibin/Documents/prj/md-mode/.scratch/start/REPORT.md`

## 2026-08-20 — installer shipped repository instance state (E-20260820-001)

### Observation

A field report from a managed project showed `spec-agents init` writing this
repository's own working state into the target. Reproduced in a temporary
directory against the pre-fix installer: the target received `STATUS.md` naming
Phase 19, `task031`, and `bin/spec-agents`; `ROADMAP.md` with 481 lines of this
repository's phase history; `EVIDENCE.md` with 650 lines of this repository's
experiments; `docs/runbooks/installer-smoke.md`, a procedure for a `bin/` the
target does not have; and `docs/lessons/dom-native-api-shadowing.md`, whose
Evidence ID and `research/` references were not installed with it. Five of the
installed files matched a scan for this repository's own markers.

Two further defects were found by reading `bin/spec-agents` rather than from
the report. `install_dir_contents` enumerated `docs/`, so any file added to a
scanned directory would ship automatically. Under `--link`, a state document in
the target became a symlink to this repository's copy, so the managed project's
first status write would have overwritten the framework source. The link defect
had not fired in the field yet.

The same report showed root `CONTEXT.md` claimed by three parties at once: the
project's business glossary, another skill collection's convention, and this
framework's workflow model.

### Interpretation

The repository had no boundary between material that is true for every managed
project and material that is this repository's own state. The installer could
only copy live files because no templates existed, and an allowlist was never
written because directory enumeration appeared to work.

Naming is part of the same boundary. A framework that occupies `CONTEXT.md`,
`STATUS.md`, `ROADMAP.md`, and `EVIDENCE.md` in the project root is competing
with the project for names it may already use.

### Recommended next action

Doctrine and Instance are now explicit concepts in
`docs/spec-agents/WORKFLOW.md`, and the installer emits Doctrine only, through
an explicit allowlist. The boundary is guarded by the leakage assertion in the
installer smoke Runbook rather than by review attention.

Run the pre-split migration section of `UPGRADE.md` against one real project
that was installed before this change, and record what the classification step
gets wrong before trusting it broadly.

### Verification

- `bash -n bin/spec-agents` and `git diff --check` pass.
- Installed set is exactly the doctrine allowlist; the absent set contains no
  `STATUS.md`, `ROADMAP.md`, `EVIDENCE.md`, `KERNEL.md`, `archive/`, or project
  knowledge-class directory.
- Leakage assertion passes: no installed file names this repository's phases,
  tasks, scripts, research, or Evidence, except on lines explicitly labelled as
  upstream Evidence.
- `--link` assertion passes: `AGENTS.md` is a symlink, `CONTEXT.md` is a
  regular file.
- Every relative Markdown link in the installed payload resolves inside the
  target.
- Repeat install keeps four existing files; source-repository install is
  refused.
- The leakage assertion fails against the pre-fix installer, which is what
  produced the reproduction above.

### References

- `docs/adr/0001-framework-namespace-split.md`
- `docs/runbooks/installer-smoke.md`
- `docs/spec-agents/WORKFLOW.md`
- `templates/CONTEXT.md`
- `.scratch/framework-namespace-split/SPEC.md`

## 2026-08-20 — Phase carried two jobs and lost the first (E-20260820-002)

### Observation

A question about `learn` still referencing `ROADMAP.md` led to a count of what
the phase model was actually holding. `ROADMAP.md` held eleven phases across
481 lines. `STATUS.md` held three closed phase sections, despite `AGENTS.md`
stating that it records only the active phase. `EVIDENCE.md` already contained
every phase result independently. `STATUS.md` also held 26 `taskNNN` entries
while `.scratch/<feature>/issues/` held Slice records for the same work, with
`AGENTS.md` binding `taskNNN` to the active phase.

`Feature` was in use throughout — `.scratch/<feature>/`, the `State`
definition — but was never a defined Core Concept.

### Interpretation

`Phase` was doing two jobs: bounding a piece of work, and indexing history. The
second job accumulates by nature, so it displaced the first. The contract
forbidding history in `STATUS.md` had already been broken three times without
anyone noticing, which is evidence that the rule was not the constraint — the
concept was.

The first proposal in the `plan` round was to promote `Feature` to a Core
Concept. The user rejected it with the right question: what would then
distinguish `Feature` from `KERNEL.md` as an ontology unit? The answer is that
no new unit was needed. `SPEC` already bounds work and is already `plan`-gated;
`KERNEL.md` describes what exists, `SPEC` describes what this work changes.
Promoting `Feature` would have created a second unit competing for the same
job.

Recording future intent was the separate half. Direction fixed ahead of work
drifts from the work, and nothing forces reconciliation.

### Recommended next action

Watch whether `STATUS.md` starts accumulating again under the new contract. The
previous rule failed silently; the new one has no automated guard, only the
`learn` completion condition. If it drifts, the next step is a check that
fails on a closed section rather than another rule.

### Verification

- No live file outside `archive/`, `research/`, `.phrase/`, and `.scratch/`
  defines or requires `Phase`. Remaining occurrences describe legacy v2/v3
  material or name phase numbers as an example of instance leakage.
- `grep -c "task[0-9]" STATUS.md` returns 0; `STATUS.md` is 52 lines with no
  closed section.
- `ROADMAP.md` is absent from the root and preserved with the closed `STATUS.md`
  sections at `archive/roadmap-phases-10-20.md`.
- `docs/spec-agents/parallel-work.md` carries the required Protocol metadata.
- `jj workspace add|list|forget|update-stale|root|rename` confirmed present in
  `jj 0.44.0` before being documented.
- Installer smoke passes: installed set, absent set, leakage, link mode, link
  resolution, idempotency, source refusal.

### References

- `docs/adr/0002-retire-phase.md`
- `docs/spec-agents/parallel-work.md`
- `archive/roadmap-phases-10-20.md`
- `.scratch/retire-phase/SPEC.md`
