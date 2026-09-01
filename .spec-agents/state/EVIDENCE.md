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

## 2026-08-20 — a durable record was living in a directory named scratch (E-20260820-003)

### Observation

`.scratch/` held ten `<feature>/` directories with 34 git-tracked, committed
files — the confirmed contract of every decision this project had made — beside
the paths for `start/REPORT.md` and `upgrade-review/REPORT.md`, which are
one-shot reports awaiting user confirmation. The directory was not ignored in
version control.

`docs/adr/0002-retire-phase.md`, decided hours earlier, had stated that a SPEC's
contract stays in place after its work closes. That made the mismatch explicit:
the record was durable by contract and disposable by name.

### Interpretation

The problem was not the name alone. Three lifetimes shared one directory, so no
single name could be accurate; splitting had to come before renaming.

The first name chosen for the durable half was `.spec-agents/`, for symmetry
with `docs/spec-agents/`. The user rejected it after the symmetry was shown to
be inverted: `docs/spec-agents/` is written by the installer and never by
project work, and the new directory is the reverse. Two paths with the same
name segment and opposite ownership would weaken the Doctrine/Instance boundary
established the same day, in prose if not in path. `.specs/` avoids the
collision and claims no visible project root name.

### Recommended next action

`.specs/` is hidden but should be committed, which is unusual. Watch whether
contributors or agents overlook it. If they do, the fix is a better pointer
from `AGENTS.md` and `README.md`, not a visible root name — a visible generic
name is the collision that `docs/adr/0001-framework-namespace-split.md` exists
to prevent.

### Verification

- No live file outside `archive/`, `research/`, and `.phrase/` points a SPEC or
  a slice at `.scratch/`; the only remaining `.scratch/` references are
  `start/REPORT.md` and `upgrade-review/REPORT.md`.
- Ten directories moved with `git mv`; `git status` records 36 renames.
- `.gitignore` in this repository ignores `.scratch/`.
- Installer smoke passes unchanged; neither directory is in the payload.

Known residual, not fixed: seven issue records from work completed before the
framework namespace split still carry `context_ref: CONTEXT.md`. That value was
correct when they were written — root `CONTEXT.md` was the workflow model then.
Rewriting them would falsify a historical record, so they are left as-is and
noted here instead.

### References

- `docs/adr/0003-split-work-and-scratch.md`
- `.specs/split-work-and-scratch/SPEC.md`

## 2026-08-20 — the framework charged the user for its own ambiguity (E-20260820-004)

### Observation

A session in a managed project ran `plan` over this workflow and needed three
rounds of user questions before it could route. Reading the transcript against
this repository, two of the three rounds were resolving the framework's
inconsistencies, not the project's trade-offs: whether `do` may write a
confirmed semantic change, and whether repairing a Kernel's `source` metadata
counts as a Kernel revision. Neither question has an answer in any doctrine
file.

Five defects were confirmed against the current files. `Code` appeared in four
relations and in `do`'s description and completion condition without being a
Core Concept. The `do` prohibition named `docs/spec-agents/` but not the four
other installed doctrine paths, and that session had arranged a slice to edit
`skills/` inside a managed project. No action verified that a reference still
resolved — five breakages had occurred in one day across two projects.
`arrange` had no way to detect a slice whose verification required writing
outside its own scope, which is exactly what that session hit and only `check`
caught. The Kernel template had five sections against a definition naming seven
elements, so identity and lifecycle had no home.

The fifth was found by reading the Kernel that session produced: an identity
criterion and a version counter filed as Concepts, and a three-state candidate
lifecycle written as three prose invariants. Its Action Contracts carried three
of five fields — the merged `Actions and invariants` heading named only two, and
input and verification were absent.

### Interpretation

The first proposal in the `plan` round was to make `learn` the only writer of
every durable document. The user rejected it by pointing at the model: `do`'s
object is `Code`. That was correct and it reframed the whole finding — the
apparent four-way contradiction between the prohibition, the invariant, and the
two skill contracts is not a contradiction at all for an ordinary project. It
only appears when the product is documents, which is true of exactly one
repository: this one.

So the defect was narrower and more specific than first diagnosed. The
framework never said what `Code` is, and never said how it manages itself. Both
gaps sat in the one place where they would be invisible to the maintainer,
because the maintainer works in the self-hosting case every day.

The Kernel template defect has the same shape: the framework's own
`WORKFLOW.md` has `## Lifecycle` and `## Knowledge Lifecycle` sections, so it
practises what its template does not require. A template that under-implements
its own concept produces artifacts that look complete and are missing two axes,
with no check that would notice.

### Ratification of ADR 0001, 0002, and 0003

Under this change an ADR is Instance knowledge and belongs to `learn`. All
three were written inside `do` slices earlier the same day. Reviewed
individually, not as a batch:

- **`docs/adr/0001-framework-namespace-split.md` — ratified.** Its decision was
  confirmed by a four-question `plan` round and verified by the installer smoke
  Runbook including the leakage assertion. Content stands; only the authoring
  contract was wrong.
- **`docs/adr/0002-retire-phase.md` — ratified.** Confirmed by two `plan`
  rounds totalling eight decisions, verified by a reference scan and the
  smoke Runbook. Its "rejected alternatives" section correctly records the
  withdrawn `Feature` proposal, which is the part most at risk of being lost.
- **`docs/adr/0003-split-work-and-scratch.md` — ratified.** Confirmed by a
  four-question `plan` round and a mid-execution correction from `.spec-agents/`
  to `.specs/`, which the ADR records as a rejected alternative with its
  reasoning. Verified by `git log --follow` resolving across the move.

No content is reverted. Each decision passed `plan` and `check`; the defect was
in who typed it, and that is now fixed for future work rather than retroactively
undone.

### Recommended next action

The reference-integrity axis has no automated enforcement — it is a procedure
that depends on whoever runs `check` actually running it. Its failure mode is
silent and looks exactly like the five breakages that motivated it. If a sixth
breakage appears after this change, the next step is a check that fails on an
unresolvable reference, not another rule.

Watch also whether the eight-section Kernel template produces mostly-empty
sections in small projects. The instruction to keep an empty section with a
note is deliberate — a missing axis must be visible — but if it degrades into
boilerplate, the axis is not being thought about and the template has not
helped.

### Verification

- `Code` is a Core Concept; the four relations naming it resolve to the
  definition.
- The five doctrine paths appear together in `docs/spec-agents/WORKFLOW.md`,
  `AGENTS.md`, `AGENTS_en.md`, `skills/do/SKILL.md`, and
  `docs/spec-agents/README.md`.
- `skills/check/SKILL.md` names three axes; both Agent entry points agree.
- `skills/arrange/SKILL.md` requires `writer:` conditionally and reachability
  unconditionally; the six slices of this SPEC each carry `writer:`.
- `START.md`'s template has eight sections and names all five Action Contract
  fields.
- The reference-integrity axis was applied to this change: every relative link
  and quoted path resolves, except two forward references to
  `docs/adr/0004-code-and-write-boundaries.md`, which this entry creates.
- Installer smoke passes; `git diff --check` is clean.

### References

- `docs/adr/0004-code-and-write-boundaries.md`
- `.specs/write-boundaries/SPEC.md`

## 2026-08-21 — a documented route could not be executed (E-20260821-005)

### Observation

A question about how a task starts — "do we use issue and ticket to carry the
flow?" — led to reading the `approve` route end to end. `AGENTS.md` documents
three routes out of `plan`, and one of them cannot be executed as written.

`skills/plan/SKILL.md` routed `approve` with "语义不变，直接交给 `do`" and
produced no artifact. `skills/do/SKILL.md` then required, verbatim: "一个目标
issue"; "issue 状态是 `ready` 或已明确授权的 `doing`"; "SPEC 没有 `stale`".
`skills/check/SKILL.md` listed the issue among the required inputs to its
comparison baseline. On the `approve` route there is no SPEC and no slice, so
none of those three preconditions can hold.

`skills/capture/SKILL.md` was the only skill that had it right: its
preconditions require that the design span multiple contexts, which correctly
declines this route. `skills/learn/SKILL.md` was already path-agnostic, phrased
as "如果来源 issue 有 `evidence_ref`".

A second inconsistency sat on the same route. `AGENTS.md` called it "settled
small change"; `skills/plan` called it `approve`, defined as semantics
unchanged. Those are different tests, and a semantically neutral large refactor
passes one and fails the other.

### Interpretation

An agent on this route had two options. Ignore `do`'s contract, or invent a
slice for a small change. The second looks more compliant, so it is the more
likely one — and it manufactures exactly the artifact this doctrine resists.
`ticket` appears five times across the doctrine and every occurrence is
adversarial, including "Never let a ticket silently redefine the model". The
framework was pushing agents toward the thing it was built to prevent.

This is the same class as the five defects in `E-20260820-004`: a contract
written for one path and silently assumed universal. `do`'s preconditions were
written while the SPEC path was the only one being exercised, and the short
path was documented in `AGENTS.md` without anyone walking it.

The terminology drift is the same failure at the level of words. The concept is
`Slice`; `issues/` is only where one is filed. Six skills used "issue" 26 times
against 15 for `Slice`, and `do`'s entire precondition block was phrased in the
filename. A contract named after its storage location is one step from being a
ticket, which is how the repair and the rename ended up in the same change.

### Recommended next action

Walk the `plan-only`, `reject`, and `unresolved` routes the same way. They were
not examined here, and the defect class — a route documented but never executed
by its own contracts — would look identical.

### Verification

- `skills/plan/SKILL.md` states the two-part `approve` test and the two
  required outputs; the conditional `STATUS.md` entry states why the condition
  exists.
- `skills/do/SKILL.md` and `skills/check/SKILL.md` each state preconditions for
  both paths; every input the short path requires is produced by `approve`.
- `AGENTS.md`, `AGENTS_en.md`, `README.md`, and `skills/plan/SKILL.md` state
  the same two conditions.
- `grep -n "issue" skills/*/SKILL.md` returns one line, the
  `.specs/<feature>/issues/NN-<slug>.md` path.
- The three-axis check ran on both languages: every relative link resolves,
  installer smoke passes, `git diff --check` is clean.

No ADR was written. This repairs a contract to match the model that
`AGENTS.md` already documented; it decides nothing new.

### References

- `.specs/short-path/SPEC.md`
- `skills/plan/SKILL.md`, `skills/do/SKILL.md`, `skills/check/SKILL.md`

## 2026-08-21 — the Kernel had no way to be found wrong (E-20260821-006)

### Observation

Five actions read `KERNEL.md` and one writes it, and every relationship is
one-directional. `skills/check/SKILL.md`'s contract axis asks whether the code
conforms to the Kernel. No action asks the reverse.

`check`'s findings were `blocker`, `required`, and `suggestion`, and all three
route to `do`. A code/Kernel conflict could only be filed as `blocker` and sent
back to change the code.

`KernelStatus` in `docs/spec-agents/WORKFLOW.md` defined `stale` and
`contradicted`, and `skills/plan/SKILL.md` carried a `kernel_status:` field
with those values. Nothing in the repository produced either.

`skills/learn/SKILL.md` already routed a verified concept, identity, relation,
lifecycle, or invariant into `KERNEL.md` after `plan` confirmed it, so the
capture path existed. Nothing detected that a change had touched the ontology.

Kernel provenance was file-level only: `version`, `source`, `verified_at`, and
`confidence` in the frontmatter, nothing per entry.

### Interpretation

The first framing of this defect was wrong, and the user corrected it: the
question is not which action may change the Kernel, but through what process.
That gate — every Kernel change passes `plan` — was already stated in three
documents and was intact. What was missing was a route to it. `check` could
observe a conflict and had no way to send it anywhere but back to `do`.

That reframing also killed the proposal to grade Kernel entries by confidence so
`check` could decide who was wrong. Any adjudication inside `check` bypasses the
gate, which is the mechanism by which an ontology drifts silently.

The detection gap and the capture gap turned out to be one gap. A single
required question in `check` — did this change add, alter, or retire a concept,
identity, relation, lifecycle, invariant, or Action Contract — produces the
finding that reaches `plan`, which is where the Kernel may then be revised. The
"add" case is the important one: introducing a concept the Kernel does not
contain violates no invariant, so all three axes stay silent.

On provenance: git already answers "when did this line change". It cannot answer
"which decision admitted this entry", and that is exactly what the `plan` gate
makes load-bearing. So `source:` per entry earns its place and a changelog does
not.

### Lost rule, recovered

`docs/adr/0004`'s `plan` round decided that a provenance-only Kernel revision
still advances the version. That decision never reached
`.specs/write-boundaries/SPEC.md` and therefore never reached any slice.
`arrange` covered the SPEC faithfully — six slices for six decision sections.
The loss happened at `capture`.

`skills/capture/SKILL.md`'s completion condition requires that the SPEC contain
its status, unchanged contracts, boundaries, Action Contracts, verification
entry, and out-of-scope. It does not require the SPEC to cover every decision
the `plan` round produced, and nothing downstream can detect the omission
because `arrange` and `check` both compare against the SPEC, not against the
round that produced it.

The rule is now in the Kernel lifecycle. The coverage gap that lost it is not
fixed and is deferred to its own `plan`.

### Recommended next action

Two procedures now depend on being run rather than on failing: the
reference-integrity axis from `E-20260820-004` and the ontology-impact question
from this change. Both fail silently — a run that skips them is
indistinguishable from a run that passed them. If either is observed to have
been skipped, the answer is a check that fails, not a third rule.

Nothing schedules a re-scan. A project that never re-scans still drifts; what
changed is that it can now find out.

### Verification

- `skills/check/SKILL.md` defines four finding types in a table with routing
  destinations, and states that `check` does not adjudicate.
- The ontology-impact question names all six categories, requires a recorded
  "no", and appears in `check`'s completion condition.
- `START.md` has a re-scan section stating that `KERNEL.md` is byte-identical
  afterwards and that the re-scan routes nothing.
- `START.md`'s Kernel template shows `since:` and `source:` on an entry, with a
  generic example — an earlier draft used a real path and Evidence ID from
  another project and was caught by the installer leakage assertion, which is
  the assertion working as designed.
- `docs/spec-agents/WORKFLOW.md` states the provenance-revision rule in the
  Kernel lifecycle and names the re-scan as what produces `stale` and
  `contradicted`.
- Installer smoke passes; `git diff --check` is clean; every relative link
  resolves.

### References

- `docs/adr/0005-kernel-drift-detection.md`
- `.specs/kernel-maintenance/SPEC.md`

## 2026-08-22 — every fix was correct and the aggregate was wrong (E-20260822-007)

### Observation

In two days the mandatory read grew from 299 lines to 586: `AGENTS.md` from 175
to 290, and the workflow model from 124 to 296. `skills/check/SKILL.md` grew
from 47 to 113. Each increment closed a defect with evidence behind it, and each
was applied the same way — by adding prose to the files every task must read.

An external methodology (`mattpocock/skills`) argues that heavy specification
degrades a strong model rather than helping it: that a prior framework "stopped
working because the model got stronger, and the old rules were so verbose they
constrained it".

Measured against that repository, the claim is stated one way and supported
another. It has 24 skills — likely more total text than this one — but none is
mandatory reading: one router skill dispatches and the rest load on demand. So
the lever is what is mandatory, not what is short.

Two problems followed from that measurement. `AGENTS.md`'s `## Six actions`
section was 111 lines, 38% of the file, restating what the six `SKILL.md` files
contain — files that are read in full when the action runs. And rules written
over the two prior days carried their reasoning inline, in the file every task
reads, while `docs/adr/` already existed to hold reasoning and `AGENTS.md`
already instructed the agent to read an ADR when the intent pointed at one.

### Interpretation

The critique lands, but not where it first appears to. Nothing we added was
unjustified, and no rule was wrong. The error was in the shape of every fix:
continuity machinery — which exists to survive across sessions — was placed in
the per-task mandatory read.

The reasoning problem is a genuine trade-off, not an oversight. Rules without
reasons were observed broken silently five times in this repository, including
a contract that forbade history in `STATUS.md` while three closed sections
accumulated under it. So reasons must exist. They just belong in the ADR that
records the decision, retrieved when an agent wants to challenge the rule, not
recited on every task.

Two reasons stayed inline, both for rules that were violated in practice by this
session's own author while the rule was visible: the recorded "no" on the
ontology-impact question, and templates copied even under `--link`.

### Result

586 → 399 lines, a 32% reduction, with no rule removed. `AGENTS.md` 290 → 169,
the workflow model 296 → 230. The `## Six actions` section became a 38-line
router; everything an agent needs *after* choosing an action now lives only in
that action's skill.

Verification found one rule genuinely dropped during compression — that
`.specs/` and `docs/spec-agents/` have opposite ownership and must be referenced
by full path. It was restored, merged into an adjacent invariant, which is why
the invariant count reads 25 against 26 while the content is complete. Counting
bullets was the wrong check; content comparison was the right one.

### Real-task comparison

The 12-smell addition to `check`'s engineering axis was executed under the
586-line doctrine via the `approve` short path, then re-derived from the
compressed documents alone. Four of five decision points came out identical:
the route, whether to create a SPEC or slice, how many `check` axes run, and
whether `writer:` was required.

One differed. The ontology-impact question was previously stated in both
`AGENTS.md` and `skills/check/SKILL.md`; after compression it appears only in
the skill. This is the router principle applied consistently — the question
fires during `check`, and `check` reads its own skill — but it is a real
reduction in what is visible from the default context, and it is recorded rather
than assumed harmless.

### Recommended next action

Nothing prevents the mandatory read from growing again, and no check fails on
it. The growth that motivated this SPEC was invisible precisely because no
single addition looked unreasonable. If it passes 400 again, the answer is a
check that fails on the line count, not another round of compression.

Three items from the external methodology were deliberately left out of scope
and each needs its own `plan`: `implement`'s continuation loop, which picks the
next unblocked slice and proceeds rather than stopping after one; `to-tickets`'
external issue tracker; and the parallel sub-agent architecture with a word cap
per axis.

### Verification

- `wc -l AGENTS.md docs/spec-agents/WORKFLOW.md` totals 399, under the 400
  target.
- Twenty rule keywords sampled across both files are present before and after.
- All five ADR pointers resolve to existing files.
- `AGENTS.md` and `AGENTS_en.md` have identical section structure.
- Installer smoke passes; `git diff --check` is clean.
- The 12-smell addition itself: three `check` axes ran, the ontology-impact
  answer was no for all six categories, and the default context was unchanged
  by it — a skill grew and no task paid for it.

### References

- `.specs/shrink-default-context/SPEC.md`
- `mattpocock/skills`, `skills/engineering/code-review/SKILL.md` (Fowler's
  smell baseline, adopted into `check`'s engineering axis)

## 2026-08-24 — six gates passed and the result was wrong (E-20260824-008)

### Observation

A field report from a managed project running this methodology. Four
consecutive batches, each through the full `plan → capture → arrange → do →
check → learn`, each with unit tests green and live replay verified. An
independent reviewer at the end of the batches found 15 multi-authority
violations that had already diverged in behavior:

- one business rule implemented in both Python and JavaScript, returning
  different results for the same input;
- one projection implemented completely in both a service and a store, then
  drifting;
- derived state persisted in two places;
- a store grown into a 6000-line dumping ground for business rules;
- a `TypeError` fallback branch left in production to accommodate a test stub.

The reporting project's own root-cause: slices stated where to change and what
to verify, and never required an answer to "which module is the single authority
for this rule". Implementation agents, under pressure to fix quickly with live
evidence, added branches at the layer where the symptom appeared. The behavior
worked; it worked in the wrong place. Unit tests did not object because they were
written at the implementation's own layer.

### Interpretation

No gate was skipped. Six gates passed and the result was wrong, which means the
gates did not measure the thing that mattered.

Three mechanisms here explain it, and one was added two days before the report.

The ontology-impact question added to `check` on 2026-08-21 asks whether the
change added, altered, or retired a concept, identity, relation, lifecycle,
invariant, or Action Contract. A second implementation of an existing rule adds
none of them; the concept was already in the Kernel. It answers "no" and passes.
That question was written to catch a new *concept* — the note beside it even
says "特别注意「新增」" — but the thing being added here is a new *site*. The
defect walked past a check written two days earlier, next to a warning that
pointed at a different door.

`check`'s contract axis asks whether code conforms to `KERNEL.md`. A duplicate
conforms to every concept, identity, relation, lifecycle, and invariant; it is
simply one more of them. Conformance checking cannot see duplication — nothing
is violated.

`Architecture boundaries` was defined as "a small number of hard structural
limits", one line. Nothing said it records where a rule may live, so no action
could consult it for placement.

The reporting project observed one thing it did not include in its own five
proposals, and it is the sharpest item in the report: **a test written at the
implementation's own layer cannot show that the layer is wrong.** The test and
the misplacement are two consequences of one decision. Four batches of green
tests were not weak evidence of correct placement — they were no evidence at all.

### On the five proposals

Four were adopted with modification, one was returned. `authority:` became a
required field rather than conditional, because a conditional field returns the
"is this a business rule?" judgment to the slice author and that judgment is what
failed. The placement check went inside the contract axis rather than becoming a
fourth axis. The equivalence requirement was reshaped from "cross-language
duplication must have golden tests" to "a rule existing in two places must prove
they do not diverge" — duplication is sometimes required, divergence never is.

The fifth, per-slice review instead of batch-end review, is already the contract:
`check` runs after `do`, per slice. Batching it departed from the existing
process rather than exposing a gap in it. But the proposal contained something
real underneath: the 15 violations were found by an *independent* reviewer. A
context that chose a placement is structurally poor at auditing that placement.
Independence was not mandated — that would make every small change expensive —
so `check` now declares whether it has any, and demands positive evidence on
placement when it does not.

### Recommended next action

This is the first external evidence in this sequence of changes. Every prior
entry was this repository checking its own documents against each other; this one
came from the methodology being run and failing. Self-consistency could not have
found it, because the gates agreed with each other and none measured placement.

The reporting project's trial under `.scratch/authority-consolidation-2` is still
running. Nothing recorded here is confirmed to work in the field. When that
result arrives, the specific thing to check is whether `authority:` was answered
honestly or filled with `n/a` under the same time pressure that produced the
original defect — a required field records an answer, not a good one.

### Verification

- `START.md` defines `Architecture boundaries` as the authority map with a path
  form and a second-site form; existing Kernels report a missing map as a gap.
- `skills/arrange/SKILL.md` requires `authority:` and defines `n/a: <reason>`;
  its completion condition includes it.
- `skills/do/SKILL.md` compares the target site against the map on both paths
  and returns to `plan` when it is absent.
- `skills/check/SKILL.md` carries the named authority item with all three tells
  and the independence declaration.
- Each violation class from the incident fires at least one tell.
- `docs/spec-agents/single-authority.md` carries full Protocol metadata.
- All six slices of this SPEC carry `authority:`.
- Installer smoke passes; the default mandatory read is exactly 400 lines, at
  the ceiling.

### References

- `docs/adr/0006-single-authority.md`
- `docs/spec-agents/single-authority.md`
- `.specs/single-authority/SPEC.md`

## 2026-08-24 — an independent review found in one pass what three days of self-review missed (E-20260824-009)

### Observation

`codex exec` was run read-only against the doctrine with four failure classes to
look for. It returned seven findings. Four were verified against the files and
are load-bearing. Three of those four were introduced the previous day, by the
author who then verified the work.

**`do` could not start in a conforming project.** `skills/do/SKILL.md` required
the slice's `authority:` to match the Kernel's authority map and stopped when the
target was not on it. `START.md` states an existing Kernel need not back-fill
that map. Both halves were written in the same SPEC, hours apart. A project with
a thin Kernel could enter neither execution path.

**The router and `plan` disagreed about the routes.** `AGENTS.md` drew three
routes; `skills/plan/SKILL.md` emits six outcomes. The three-route diagram came
from the context-compression round, which collapsed six into three while
shortening. A single-authority violation in the doctrine, in the same week the
single-authority Protocol was written.

**`plan-only` had no next action.** `do` accepted only `approve`; `capture`
accepted an authorized `plan-only` but also required multiple contexts. A
single-context authorized `plan-only` could enter neither.

**`breaking` was circular.** `plan` required an ADR before proceeding; `capture`
did not accept `breaking`; ADR authorship belongs to `learn` (ADR 0004), which
fires after verification. The author hit this personally twice in one session,
corrected the ADR authorship, and never revisited `plan`'s wording.

Walking all six outcomes during the repair found a fifth: `plan` routed
`compatible revise` to "`capture` or `do`", and `do`'s preconditions accepted
neither `compatible revise` nor anything but `approve`. That branch was dead
too. `reject`/`unresolved` routed to `learn` for a durable trace, but `learn`'s
triggers did not name a rejected proposal.

### Interpretation

The review's own conclusion is a better diagnosis of the preceding three days
than anything produced inside them:

> making a rule visible everywhere is not the same as making it executable;
> several gates now pass on document shape while the route underneath has no
> satisfiable next step.

Three of seven findings — five of the defects once the walk is counted — are
routes with no satisfiable next step. The three days before this added required
fields, required questions, and named checks. All of that is visibility. None of
it tests whether the route it guards can be completed.

`do`'s map requirement is the clearest instance: a gate demanding a document
that the same doctrine, in the same SPEC, says need not exist. It passes every
review that reads it as a sentence and fails the first project that runs it.

This is empirical support for ADR 0006's claim, obtained on the author rather
than on a managed project. That ADR argued a context which made a decision is
structurally poor at auditing it, and declined to mandate independent review on
cost grounds. One independent pass, on a doctrine that had been self-verified
continuously for three days, produced four verified defects in a single run.
The cost argument still holds; the effectiveness argument is now measured.

### Findings not acted on

Two of the seven were mandatory-read judgments naming sections beyond the three
that were sunk. They are not wrong, but the mandatory read is now 374 lines,
below the 400 ceiling, and further reduction without a specific complaint
becomes trimming for its own sake.

### Operational note

The first review attempt hung for two hours with no output. Cause:
`codex-cli 0.149.0` cannot decode the server's model list — it returns a
reasoning-effort variant `max` that this client's enum does not contain, so
`failed to refresh available models` blocks startup. Two of the author's own
diagnoses along the way were wrong and were corrected: "no `codex exec` process
exists" (a `head -5` had truncated it) and "blocked reading stdin" (an untested
hypothesis). Working invocation:

```bash
codex exec --sandbox read-only --skip-git-repo-check \
  -c model="gpt-5.5" -c model_reasoning_effort="high" "<prompt>" </dev/null > out.txt 2>&1
```

Piping to `tail` also hid all progress, since `tail` buffers to EOF.

### Recommended next action

Walking a route is cheap and finds what reading it does not — the fifth defect
appeared only when the six outcomes were traced one at a time against the
preconditions that must accept them. That walk is not in any action's contract.
It belongs somewhere, and this entry does not decide where.

The reporting project's `authority:` trial is still outstanding, and now so is
the question of whether an independent pass should run at a fixed cadence rather
than when someone thinks to ask for one.

### Verification

- Every one of the six `plan` outcomes was walked individually against the
  preconditions of the action that must accept it; all now have a satisfiable
  next step.
- A project with no authority map completes `do` on both paths, emitting a
  `semantic` finding instead of stopping.
- The `approve` two-part test appears in exactly one file.
- `AGENTS.md` carries no route diagram and names `skills/plan/SKILL.md` as the
  authority.
- Three sections sank; each sunk rule was confirmed present in its destination.
- Mandatory read 400 → 374.
- Installer smoke passes; `git diff --check` is clean.

### References

- `.specs/route-repair/SPEC.md`
- `docs/adr/0004-code-and-write-boundaries.md`, `docs/adr/0006-single-authority.md`

## 2026-08-25 — nothing read the Kernel (E-20260825-010)

### Observation

`bin/spec-agents`, `tests/`, and every Runbook were searched for a reader of
`KERNEL.md`. There was none. The authority map, `authority:` on slices,
per-entry `since:`/`source:`, and the eight-section shape — all added in the two
days prior — were enforced only by an agent choosing to honor a sentence.

The installed payload was 24 files, all Markdown and YAML. A check that must
read a project's Kernel had nowhere to run: this repository has no `KERNEL.md`
(its semantic model is `docs/spec-agents/WORKFLOW.md`, which is doctrine), and
nothing executable reached a managed project.

### Interpretation

This is the criticism from `E-20260824-009` reproduced one layer down. An
authority map was added because placement had gone unchecked; the map itself was
then unchecked. Adding a required field and adding enforcement are different
acts, and only the first had happened.

`gura105/operational-ontology` was the prompt for looking. Its objects, links,
and actions are near-isomorphic to this Kernel's Concepts, Relations, and Action
Contracts — the same idea, one layer down, where preconditions are functions a
runtime calls and authority is declared in keys the runtime enforces. In that
shape the fifteen violations from `E-20260824-008` could not have occurred:
writes only pass through named actions, and authority is declared per field.

### Borrowed, and not

Borrowed: the three authority states. That project separates ontology-owned
state from source-backed state, and derived state simply has no write path. The
authority map here recorded only which module owns a rule, so "derived state
persisted twice" — one of the fifteen violations — was inexpressible.

`derived` is the state that pays for itself. In a runtime, derived state is
protected by absence: nothing declares it writable. A prose map has no such
mechanism, and absence there means nobody thought about it. Writing it down
converts a silent omission into a stated prohibition.

Not borrowed: the runtime, the MCP surface, the write-back model. Those solve
authority over *data in a running system*. This framework governs authority over
*code and knowledge at authoring time*, and no precondition can be attached to
an agent deciding to add a branch in the wrong module.

Also not borrowed, and recorded as deferred: that project's discipline of naming
the four implementation choices it makes visible, including what a missing
policy defaults to.

### Payload composition changed

`docs/spec-agents/check-kernel.sh` is the first executable the installer ships.
The payload had been documents only. A checker that reads a project's Kernel has
to run where that Kernel is, and the alternative — a Runbook describing the
check in prose — is the failure mode being corrected, not a fix for it.

The checker verifies form: entries parse, paths exist, a `derived` rule carries
no second site, a second site names an equivalence test that exists. It does not
verify that the map is complete or true. A map can be perfectly formed and
wrong; judging that remains `check`'s placement item, and both the script header
and the Protocol say so.

Each of its eight behaviors was proven against a temporary fixture rather than
asserted, including the two that must pass silently: absent `KERNEL.md` and an
absent `Architecture boundaries` section both exit 0 with a notice, because
ADR 0006 promised existing Kernels need not back-fill.

### Three procedures became checks

`tests/doctrine-check.sh` enforces what `STATUS.md` had been carrying as
depending on someone remembering: the mandatory read stays at or under 400
lines, every `ADR NNNN` pointer resolves, and no file cites a CHANGELOG heading
that no longer exists. Each had already failed here at least once. Padding the
mandatory read past the ceiling was used to prove the first one fails.

### A finding from this round's own verification

The installer smoke test has been re-implemented by hand in a session scratch
directory on every round that ran it, and the directory was cleared between
sessions. One verification claim in this round was made against a script that no
longer existed; the grep returned nothing and was misread as a pass, and the
smoke was re-run from the Runbook to establish the result.

`docs/runbooks/installer-smoke.md` is prose describing a procedure. The
procedure has been executed correctly each time and has left nothing behind. It
is the same class as the map: a check that depends on someone re-deriving it.
Recorded, not fixed here — it needs its own `plan`, and doing it inside this
SPEC would be the scope creep this workflow exists to prevent.

### Verification

- Eight fixtures cover `check-kernel.sh`: valid map, absent Kernel, absent
  section, malformed entry, missing authority path, `derived` with a second
  site, second site without an equivalence test, missing equivalence test.
- `tests/doctrine-check.sh` passes here and fails when the mandatory read is
  padded to 434 lines.
- The installer ships the checker with its executable bit intact, and it runs in
  a freshly installed project.
- Full installer smoke re-run from the Runbook: idempotency, absent set,
  leakage, link mode, executable, link resolution, source refusal — all pass.
- `bash -n` on both scripts; `git diff --check` clean.

### References

- `.specs/checkable-authority/SPEC.md`
- `docs/spec-agents/check-kernel.sh`, `tests/doctrine-check.sh`
- `gura105/operational-ontology`

## 2026-08-26 — three wrong counts in one afternoon (E-20260826-011)

### Observation

`logseq/spec_dev_tool` was the fourth independent source in three days to answer
the same question the same way. Its `AGENTS.md` is five lines, four of them
pointers, because the workflow lives in a CLI that emits it on demand. It
encodes a document's lifecycle in its directory path, so a transition is a
validated file move rather than an edited word, and its `exploring` state
forbids touching any other repository file — the same boundary as `plan`'s, but
attached to a document state a tool can verify.

Against that, this repository's state was maintained by an agent remembering to
edit a field, across 68 slices and 12 SPECs, with nothing checking any of it.

Establishing how bad that was took four attempts:

- a hand-written grep reported twelve violations. Seven were false positives
  from a pattern that did not match a field format variant;
- the first checker reported sixty-two, having applied the `authority:`
  requirement to slices that `docs/adr/0006` explicitly exempts from
  back-filling;
- the second reported twelve, resolving `spec_ref` only from the repository
  root while seven older slices write it relative to the slice;
- the fourth attempt reported five, and five is the number.

### Interpretation

The drift was small and the counting was not reliable at all. That inverts the
argument the SPEC was written on: the case for the tool is not the five
violations it found, it is that four attempts were needed to find five, and
three of those attempts produced confident wrong answers.

Both checker defects have the shape of the defects the checker exists to catch.
The first applied a rule outside the scope its own ADR declared — the exact
failure recorded two days earlier when `do` demanded a map that `START.md` said
need not exist. The second enforced one of two conventions actually in use. A
checker is not exempt from the failures it checks for, and writing one is not
the same as being right.

The mixed `spec_ref` convention is a real finding and is not repaired here.
Recent slices write it relative to the repository root, older ones relative to
the slice. Neither is wrong and the checker now accepts both, but
`skills/arrange/SKILL.md` never said which to use, so both appeared. Choosing
one changes the slice format and belongs to its own `plan`.

### What was and was not taken

Taken: the gate. Each action gets an entry point that checks what is mechanical
and refuses with the reason and the document that states it.

Not taken: printing skill prose from the CLI, which is how `spec-dev-tool`
delivers its workflow. It works there because the tool is the only delivery
path. Here the skills already load on demand, so a CLI that printed them would
create a second authority for one rule — the failure eliminated four days ago
and given its own Protocol.

Not taken: path-encoded state. It makes an inconsistent state unrepresentable,
which is strictly better, and it was rejected for cost rather than principle —
68 file relocations and a rename per transition. Recorded in `docs/adr/0007` as
worth revisiting if transitions ever outnumber edits.

### What a gate cannot do

`plan`'s interrogation, `check`'s three axes, and `learn`'s judgment are
reasoning. No precondition reaches them. The gates cover status, dependency,
writer, authority presence, and evidence linkage — the parts that were being got
wrong by hand. Everything that made this workflow worth having remains
unenforceable, and the tool should not be mistaken for coverage of it.

### Verification

- `check-state` reported five violations before repair and none after.
- Every `gate` and `transition` refusal was proven against a fixture: a done
  slice, an unfinished dependency, a foreign `writer:`, an absent `authority:`,
  an unconfirmed SPEC, an unknown action, an unknown state, `done` without
  `evidence_ref`, `stale` without a reason.
- One fixture initially proved the wrong thing — a slice set to `blocked` hit
  the status check before the authority check — and was isolated and re-run.
- A successful transition changes exactly the status line.
- Mandatory read 374 → 372; `tests/doctrine-check.sh` and the installer smoke
  pass; `bash -n` clean.

### References

- `docs/adr/0007-workflow-cli.md`
- `.specs/workflow-cli/SPEC.md` revision 2
- `logseq/spec_dev_tool`

## 2026-08-28 — the tool enforced two states the model never defined (E-20260828-012)

### Observation

`docs/spec-agents/WORKFLOW.md` gave a lifecycle to four entities — `work`,
`start`, `kernel`, `knowledge` — and none to `SPEC`. The Stable Relations block
said the same thing a second way: SPEC had an in-edge and an out-edge and no
terminal transition. `bin/spec-agents` nevertheless refused when every slice of
a SPEC was `done` and its status was not `verified`. `verified` appeared in no
skill: `grep -rn "verified" skills/*/SKILL.md` returned zero hits, and
`skills/capture/SKILL.md`'s status set did not contain it. Its only source was
the `knowledge:` lifecycle line. Sixteen of this repository's nineteen SPECs
carried the value anyway, so `check-state` was green because an undocumented
convention had been applied consistently.

Executing the first slice surfaced the same defect one level down. The work was
complete and `spec-agents transition ... done` refused: `done` requires
`evidence_ref`, `skills/do/SKILL.md` told `do` to keep it empty, and
`skills/learn/SKILL.md` authorised `learn` to write `evidence_ref` and said
nothing about slice status. `grep -rn "done" skills/*/SKILL.md` returned one
hit, a status enum in `arrange`'s template. Seventy-five closed slices had all
been set by hand.

Repairing both left a dependency that looked like a deadlock: slice 01 needed
`learn` to close it, the close was granted by slice 02, and slice 02 was
`blocked_by: 01`.

`check` on the two slices found the three `SPEC.verified` preconditions stated
in two places — `skills/learn/SKILL.md` and prose slice 01 had just added to
`WORKFLOW.md` — with none of `docs/spec-agents/single-authority.md`'s three
conditions for a legitimate second site holding.

Two further defects were observed and not repaired. `cmd_ready` accepts slices
whose status is `ready` **or** `blocked`, filtering only on whether `blocked_by`
is satisfied, so `ready` lists a slice that `gate do` then refuses. And
`blocked_by` names slice prefixes within one feature, so a slice blocked by
another SPEC cannot express it and is reported runnable — observed on
`.specs/kernel-delta-declaration/issues/01`, which is blocked on this SPEC.

Closing the two slices exposed a third, which is a defect in the tool rather
than in a contract. `blocker_unfinished` declares `local slice root dep dir st`
and does not declare `f` or `d`; its inner `for f in "$dir/$d"-*.md` therefore
overwrites the loop variable of `cmd_ready`, which calls it directly rather than
through command substitution. `cmd_ready` then prints `${f#$root/}` — the
blocker's path, not the slice's. With slices 01 and 02 `done`, `ready` printed
`02-terminal-state-and-writer.md` twice instead of the two slices it had just
unblocked. A slice whose `blocked_by` is empty is unaffected, because the
function returns before the inner loop. `check_state` is unaffected for the same
reason `cmd_ready` is not: it captures the result with `b="$(...)"`, and the
subshell contains the assignment.

### Interpretation

The CLI did not drift from the documents. It supplied two states the model never
had, which is why editing documentation could not have repaired it: the model
was missing a state, and an implementation had quietly filled the hole. ADR 0007
built the CLI to end hand-maintained state; seventy-five hand-set slices mean
the state it checks was never once produced by it.

The slice level and the SPEC level are one defect at two scales, so one decision
repaired both rather than two decisions meeting in the middle.

Three incidents on 2026-08-27 shared a shape: a gate goes red because the rule
behind it has a hole, and the most natural next action is to edit the record
being measured. A managed project set a SPEC to `verified` to clear the gate and
reverted; the same project added a field so a checker would resolve a reference
and reverted; here, an accepted ADR's Consequences paragraph was rewritten in
place and turned out to cite a script committed two days after that ADR's own
`date:`, and was reverted. The rule forbidding this already exists at
`skills/check/SKILL.md`, routing a `semantic` finding to `plan` and stating that
`check` does not adjudicate — but it is written only inside `check`, and none of
the three happened in `check`.

The deadlock was a fourth instance in miniature, and the first that was resisted
before acting. The available repair was a bootstrap clause exempting this SPEC
from the rule it establishes. The actual defect was in the dependency: none of
slice 02's acceptance criteria required slice 01's output, so the edge was
conceptual order rather than a precondition, and removing it dissolved the
deadlock without writing any exception. A cycle that appears while enforcing a
new rule is worth reading as a modelling error before it is read as a case for
an exemption.

The duplicated preconditions were settled from enacted doctrine rather than from
a pending decision. `AGENTS.md` ranks first in the current authority order and
already delegates each action's write boundary to `skills/<action>/SKILL.md`;
the three preconditions are `learn`'s write conditions. Resolving it through the
`skills/` ranking captured in `.specs/authority-order/SPEC.md` would have let
work sequenced later decide a conflict in work sequenced earlier.

One rule cost six files to state — one authority and five pointers. The pointers
are legitimate and each names the writer without restating the rule. The number
is the price of a doctrine readable from several entry points, and it is also
the surface on which this repository's recurring drift appears.

### Recommended next action

Slices 03, 04 and 05 of `.specs/spec-lifecycle/SPEC.md`. The SPEC does not reach
`verified` here: its preconditions are not met while three slices remain.

`cmd_ready` has three defects and they are separable: it disagrees with
`gate do` about which slices are runnable, it prints the wrong path because of
the variable leak, and `blocked_by` cannot express a cross-SPEC dependency. The
leak is a plain correctness bug with no trade-off in it. The other two have
choices inside them — whether `ready` should filter on status or annotate, and
what a cross-SPEC blocker should look like — so they need their own `plan`. They are not folded
into an existing SPEC, because a SPEC is not the place to introduce a decision
that no `plan` round confirmed.

The `applies_when` of any Lesson drawn from the three incidents must name gates
as well as checks: one of them was not inside any of the six actions — it was
the CLI inventing a terminal state while being written.

### Verification

- `grep -rn "verified" skills/*/SKILL.md`: 0 → 4 hits.
- `grep -rn "done" skills/*/SKILL.md` outside `arrange`'s status enum: 0 → 4.
- Lifecycle block: four entities → five.
- `SPEC.verified` preconditions enumerated: two sites → one.
- `tests/doctrine-check.sh`: passes, mandatory read 373 → 379 of 400.
- `spec-agents check-state`: exit 0 throughout.
- `bash -n bin/spec-agents`: passes.
- Slice 01 and slice 02 acceptance: five and eight criteria, checked
  individually.

### References

- `.specs/spec-lifecycle/SPEC.md` r3, slices 01 and 02.
- Changed: `docs/spec-agents/WORKFLOW.md`, `skills/{capture,learn,arrange,do}/SKILL.md`,
  `AGENTS.md`, `AGENTS_en.md`.
- `docs/adr/0006-single-authority.md`, `docs/adr/0007-workflow-cli.md`,
  `docs/spec-agents/single-authority.md`, `skills/check/SKILL.md`.
- Working tree, uncommitted at the time of writing. A CLI run cited here was
  executed against that tree; the five subcommands have never been committed, so
  no revision reproduces them.

## 2026-08-29 — the CLI cites its rules, and a zero-slice SPEC gets a definition (E-20260829-013)

### Observation

Slices 03 and 06 of `.specs/spec-lifecycle/SPEC.md` were performed by a
`do` agent and checked by a separate `check` agent, each in its own Herdr
pane, with this context as `learn`. The three agents ran different models.

Slice 03: `bin/spec-agents`'s two terminal-state refusals now cite documents
that exist. The `check-state` violation for a SPEC whose slices are all
`done` reads `(docs/spec-agents/WORKFLOW.md: Lifecycle/spec;
skills/learn/SKILL.md)`; the `transition ... done` refusal without
`evidence_ref` and its `check-state` counterpart read `(learn;
skills/learn/SKILL.md)`. Logic unchanged; `bash -n` clean; the reviewer
rebuilt both fixtures independently and reproduced both exit-1 refusals with
the new text, and hashed the refused slice before and after to show the
refusal wrote nothing.

Slice 04 was attempted in between and produced the finding that became
slice 06. All three zero-slice SPECs — `jsonl-evidence-pilot`,
`ontology-graph-pilot`, `upgrade-prompt` — classified as finished on their
evidence (`E-20260817-001`, `-002`, `-003`; runners and reports under
`research/experiments/`; root `UPGRADE.md`). The first write set them to
`verified` by reading "every slice `done`" as vacuously true for a SPEC with
no slices and "removed from `STATUS.md`" as satisfied by an entry already
absent. The independent `check` raised it as `semantic`: neither reading is
in `skills/learn/SKILL.md`, so the write extended `learn`'s contract silently
under a slice declaring `authority: n/a`. The vacuous reading also accepts
`authority-order` — `confirmed`, zero slices, nothing done. The write was
withdrawn, the three reverted to `confirmed`, and the question routed to
`plan`. `plan` chose: for a SPEC with no slices the first precondition is
replaced by the Evidence record naming each deliverable as verified; an
absent `STATUS.md` entry satisfies the third; nothing is read as vacuously
true. SPEC r4; slice 06 states it in `skills/learn/SKILL.md`. The `check` on
slice 06 found the slice's own verification grep did not match the worker's
phrasing (backticks around `Slice`); one word changed, re-checked, closed.

Under that rule, the deliverables of the three SPECs, each verified on
2026-08-29:

- `jsonl-evidence-pilot` — issue map: fixture (`agent-a.jsonl`,
  `agent-b.jsonl`, `baseline.md`), runner (`run_pilot.py`), result report
  (`RESULTS.md`), all under `research/experiments/jsonl-evidence-pilot/`;
  runner re-executed, J1–J5 pass.
- `ontology-graph-pilot` — issue map: ontology contract (`ONTOLOGY.md`),
  in-memory runner (`run_pilot.py`), result report (`RESULTS.md`), all under
  `research/experiments/ontology-graph-pilot/`; runner re-executed, every
  check passes.
- `upgrade-prompt` — no issue map; its Verification section: the Prompt with
  detection, reconnaissance, confirmation, cutover, and completion gates
  (root `UPGRADE.md`, present); `--legacy` refused and no `upgrade` command
  (`bin/spec-agents`, confirmed by running both); installer pointer behaviour
  recorded in `E-20260817-001`.

None of the three appears in `STATUS.md`.

The same `check` found that `E-20260817-002`'s Markdown fixture figures do
not reproduce: a clean rerun of `run_pilot.py` passes J1–J5 and matches the
JSONL figures exactly, but reports Markdown full 1,567 bytes / 392 rough
tokens and scoped 1,353 / 339 against the recorded 1,649 / 413 and 1,425 /
357. The conclusion holds on both sets. `E-20260817-002` is not rewritten;
this note is the correction.

### Interpretation

This is the fourth incident of the shape recorded in E-20260828-012 — a rule
with a hole, and the nearest action is to write the state the gate wants —
and the second one caught before it stood. What caught it was not the gate:
`check-state` was green before and after the write, because a zero-slice
SPEC is outside its assertion. It was an independent `check` reading the
contract against the diff. The lesson captured in
`.specs/evidence-reproducibility/SPEC.md` — a red gate is a finding, not an
invitation to edit — needs its companion: a green gate is not a verdict
either, when the case is outside what the gate looks at.

The repair took the SPEC's own route: `semantic` finding → `plan` → a
compatible revision with one alternative named and two rejected → a slice
with one site. No exception was written and no record edited in place.

### Recommended next action

Set the three to `verified` under the r4 rule (slice 04), then slice 05.

### Verification

- `grep -n 'skills/learn/SKILL.md' bin/spec-agents`: three refusal sites.
- Fixture SPEC (all slices `done`, status `confirmed`): `check-state` exit 1 with the new citation. Fixture slice without `evidence_ref`: `transition ... done` exit 1 with the new citation. Reproduced by worker and reviewer separately.
- `skills/learn/SKILL.md` 收尾 states the zero-slice preconditions; single site.
- `python3 research/experiments/jsonl-evidence-pilot/run_pilot.py`: J1–J5 pass; figures as above.
- `bash -n bin/spec-agents`, `tests/doctrine-check.sh` (379/400), `bin/spec-agents check-state`: all pass.
- Working tree still uncommitted; the reproducibility caveat of E-20260828-012 applies to every CLI run cited here.

### References

- `.specs/spec-lifecycle/SPEC.md` r4, slices 03, 04 (run summary), 06.
- `E-20260828-012`, `E-20260817-002`.
- `.specs/evidence-reproducibility/SPEC.md`.

## 2026-08-29 — `upgrade-prompt`'s four verification bullets, named one by one (E-20260829-014)

### Observation

The independent `check` of slice 04's second pass found that `E-20260829-013`
did not name every deliverable of `.specs/upgrade-prompt/SPEC.md`. That SPEC
has no issue map, so under the r4 rule its Verification section is the list,
and it has four bullets; the record covered the first and third, described the
second loosely, and omitted the fourth. `upgrade-prompt` was returned to
`confirmed`, and each bullet was reproduced on 2026-08-29:

1. **Gates.** `UPGRADE.md` has six numbered sections — read the modern entry
   points (with v2/v3 source classification), reconstruct recent history, scan
   the code architecture, write the candidate report and stop, cut over only
   after confirmation, verify the cutover — plus a Completion report section.
   Detection, reconnaissance, confirmation, cutover, and completion are each
   present as a section, not a sentence.
2. **Installer.** `bin/spec-agents install <fresh dir> en` produces a tree
   containing `UPGRADE.md`. `bin/spec-agents install <dir with .phrase/> en`
   leaves `.phrase/current.md` byte-identical, installs `UPGRADE.md`, and
   prints "Existing legacy SPEC material detected. Read <dir>/UPGRADE.md
   before ordinary work." Both runs in a scratch directory.
3. **CLI.** `bin/spec-agents upgrade .` prints "Upgrade is Prompt-driven, not
   an installer operation" and exits 1; `--legacy` prints "no longer an
   installation mode" and exits 1; `bin/spec-agents help` contains no
   `--legacy` and no `upgrade` subcommand.
4. **Skills, syntax, whitespace.** All six of `skills/{plan,capture,arrange,
   do,check,learn}/SKILL.md` carry `name:` and `description:` frontmatter and
   an `agents/openai.yaml`; `bash -n` passes on `bin/spec-agents`,
   `docs/spec-agents/check-kernel.sh`, and `tests/doctrine-check.sh`;
   `git diff --check` passes. The "six skill validators" the bullet names as a
   script do not exist in the tree today and were not found in `tests/` or
   `bin/` history; the discovery, syntax, and whitespace checks above are what
   can be reproduced.

### Interpretation

The first record named what it had at hand and called it the list. The rule
r4 wrote says the list is the SPEC's, not the writer's — and the difference
was one bullet no one had looked at in twelve days. It is the same reading
error as the vacuous "every slice `done`", at a finer grain: a sufficient-
looking summary standing in for the enumerated thing.

### Recommended next action

Set `upgrade-prompt` to `verified` on this record; close slice 04.

### Verification

- Every command above run from the repository root on 2026-08-29 against the
  uncommitted working tree.
- `bin/spec-agents check-state` exit 0; `tests/doctrine-check.sh` passes.

### References

- `.specs/upgrade-prompt/SPEC.md` Verification section; `UPGRADE.md`.
- `E-20260829-013`, `E-20260817-001`.

## 2026-08-29 — spec-lifecycle closes (E-20260829-015)

### Observation

Under the r4 rule, the three zero-slice SPECs were set to `verified` on the
deliverable lists recorded in `E-20260829-013` and `E-20260829-014`; an independent `check` of
that write found no finding. Slice 05 wrote `docs/adr/0008-spec-lifecycle.md`,
this record, `STATUS.md`, and `CHANGELOG.md`. Slices 03, 04 and 06 are
closed by `learn` with `evidence_ref` and `done` written together. Slice 05 is
`doing` as this record is appended — the precondition is that the Evidence
exists before the terminal write — and the act that follows an independent
`check` of slice 05 closes it, sets the SPEC `verified`, and removes its
`STATUS.md` entry together. Nothing in `.specs/` was hand-set to `done` in
this round.

Slice 05's acceptance asked that the three incidents of 2026-08-27 be
recorded with enough detail to locate each reverted edit in version control.
That is not satisfiable: two happened in a managed project outside this
repository, and the third was made and reverted in this working tree before
any commit, so no revision holds the edit or its reversal. Recorded as unmet.

### Interpretation

The first SPEC closed under the lifecycle rule is the one that wrote it, and
its own execution produced one revision of the rule. That is the expected
cost of defining a state by using it; the alternative was a definition that
had never been exercised.

### Recommended next action

`kernel-delta-declaration` becomes active; its slice 01 was blocked on this
SPEC's scope. `gate arrange` still accepts only `confirmed|revised` while
`capture`'s set has six values — same defect class, own `plan`.

### Verification

- At writing: `bin/spec-agents status` shows `spec-lifecycle revised 5/6`
  and the three pilots `verified 0/0`; `check-state` exit 0;
  `tests/doctrine-check.sh` passes; every reference in
  `docs/adr/0008-spec-lifecycle.md` resolves (independent `check`).
- After the close: `status` shows `spec-lifecycle verified 6/6`, `STATUS.md`
  lists `kernel-delta-declaration` alone, and `check-state` still exits 0.
  If any of those fails, a further record says so.

### References

- `.specs/spec-lifecycle/SPEC.md` r4; `docs/adr/0008-spec-lifecycle.md`.
- `E-20260829-013`, `E-20260829-014`, `E-20260828-012`.

## 2026-08-29 — E-20260829-015 was edited in place after it was appended (E-20260829-016)

### Observation

`E-20260829-015` was appended, then an independent `check` of slice 05 found
that it described the close as already done — `spec-lifecycle verified 6/6`,
`STATUS.md` listing one SPEC — while the SPEC was `revised 5/6` and slice 05
was `doing`. The record was then reworded in place to describe the state at
the moment of appending. A second `check` ruled the in-place edit out of
bounds: `AGENTS.md` defines `EVIDENCE.md` as an append-only ledger, and
`docs/adr/0008-spec-lifecycle.md` already cited E-015 as `source`, so it was
a published record. The correction should have been this record.

What the in-place edit replaced, reproduced so the ledger is complete:

> Slices 03–06 were closed by `learn` with `evidence_ref` and `done` written
> together; the SPEC was set to `verified` and removed from `STATUS.md` in
> the same act. Nothing in `.specs/` was hand-set to `done` in this round.

and, under Verification:

> - `bin/spec-agents status`: `spec-lifecycle verified 6/6`; the three
>   pilots `verified 0/0`.
> - `bin/spec-agents check-state`: exit 0. `tests/doctrine-check.sh`: passes.
> - Every reference in `docs/adr/0008-spec-lifecycle.md` resolves.
> - `STATUS.md` lists one active SPEC and matches `.specs/`.

The current text of E-015 is the reworded version and is not changed again.

### Interpretation

Two mistakes of the same family in one slice. The first — writing the close
before the close — is the reflex `E-20260828-012` named: describing the state
the gate wants rather than the state that exists. The second — repairing the
ledger by rewriting it — is the reflex applied to the repair. The ledger's
rule exists so that the first kind of error stays visible; an in-place fix
removes exactly that. Neither was caught by a tool; both were caught by an
independent reader with the contract open.

### Recommended next action

Close slice 05 on `E-20260829-015`, with this record cited beside it, and set
the SPEC `verified` while removing its `STATUS.md` entry in one act.

### Verification

- `git diff EVIDENCE.md` shows E-015 in its reworded form and this record
  appended after it; no earlier record changed.
- `bin/spec-agents check-state` exit 0; `tests/doctrine-check.sh` passes.

### References

- `E-20260829-015`, `E-20260828-012`.
- `.specs/spec-lifecycle/issues/05-learn-record.md` run summary.

## 2026-08-29 — the Kernel delta gets a definition before it gets a check (E-20260829-017)

### Observation

Slice 01 of `.specs/kernel-delta-declaration/SPEC.md` was performed by a `do`
agent and checked by a separate `check` agent, this context acting as `learn`.
`docs/spec-agents/WORKFLOW.md` now states, under `### SPEC`, that for a Change
crossing the Change Boundary the SPEC's `## Model delta` is the proposed
Kernel delta — the entries to be added, revised, superseded or retired in the
project's `KERNEL.md` (here, `WORKFLOW.md`) when the work verifies; `do`
implements against it and `learn` promotes it verbatim; the proposal state is
carried by the SPEC lifecycle and the `kernel:` line gains no `proposed`
state. A SPEC without a `kernel_delta:` field reads as `none`, named as a
deliberate legacy default; the verbs are `add | revise | supersede | retire`.
The Change Boundary section gained one pointer sentence.

Mandatory read 379 → 389 of 400; nothing removed. Independent `check`: no
findings; the slice enacts exactly the SPEC's first declared entry
(`revise: Model delta`), with the `capture` and `learn` entries left for
slices 02 and 03.

This is the first SPEC in the repository whose own frontmatter carries
`kernel_delta:`, and the first slice checked against a declared delta rather
than against the checker's reading of the diff.

### Interpretation

The SPEC's declaration made the ontology question answerable by comparison
instead of by judgment: the reviewer matched the change to a named entry.
That is the mechanism this SPEC exists to install, observed once, on itself.

### Recommended next action

Slices 02 (`capture` contract) and 03 (`learn` promotion match); they do not
share a file and may run in either order.

### Verification

- `grep -n "kernel_delta\|Model delta" docs/spec-agents/WORKFLOW.md`: the
  semantics at one site under `### SPEC`, one pointer in Change Boundary.
- `tests/doctrine-check.sh`: 389/400. `bin/spec-agents check-state`: exit 0.
- Working tree uncommitted; the reproducibility caveat of E-20260828-012
  applies.

### References

- `.specs/kernel-delta-declaration/SPEC.md` r1, slice 01.
- `E-20260821-006` (the lost decision this SPEC repairs for the kernel fields).

## 2026-08-29 — `capture` and `learn` bind themselves to the declaration (E-20260829-018)

### Observation

Slices 02 and 03 of `.specs/kernel-delta-declaration/SPEC.md`, performed by
the `do` agent and checked by the independent `check` agent, this context as
`learn`.

Slice 02: `skills/capture/SKILL.md`'s template frontmatter carries
`kernel_delta:` — `none`, or `<verb>: <entry>` lines with
`add | revise | supersede | retire` — shown with the list form taken from this
SPEC's own frontmatter. The field is mandatory on every SPEC `capture`
creates; `none` is a legal explicit answer. The completion condition refuses
to finish when the confirmed `plan` outcome recorded `kernel_promotion` other
than `none` and the delta is empty, citing `E-20260821-006`. The first
version restated two definitions `WORKFLOW.md` owns — the absent-field
default and the kinds of Kernel item — and the enumeration already diverged
by omitting identities. `check` raised it as `semantic` (placement); the
paragraph was cut back to a pointer and re-checked.

Slice 03: `skills/learn/SKILL.md`'s Kernel-promotion bullet requires the
written change to equal the SPEC's declared entries as last revised, with
each promoted entry's `source:` citing the SPEC; 安全边界 gains the divergence
rule — stop, write nothing, report which entry, back through `plan` and a
SPEC revision. No findings.

One ordering error by `learn`: slice 04 was dispatched while 02 and 03 were
still `doing`. `gate do` refused it — `blocked_by` unfinished — and the `do`
agent, told to run the gate first, had not edited anything when it was
stopped. Recorded because it is the gate doing what ADR 0007 built it for,
against the coordinator rather than against a worker.

### Interpretation

The restatement in slice 02 is the same drift `docs/spec-agents/single-authority.md`
describes, caught at the moment of writing rather than weeks later, and the
divergence (a missing item kind) was already present in the first copy. A
second site does not wait to drift.

### Recommended next action

Close 02 and 03; slice 04 becomes `ready`.

### Verification

- `grep -n kernel_delta skills/capture/SKILL.md skills/learn/SKILL.md`: hits
  in both; the definitions themselves at one site, `WORKFLOW.md` §SPEC.
- `tests/doctrine-check.sh`: 389/400. `bin/spec-agents check-state`: exit 0.
- `bin/spec-agents gate do .specs/kernel-delta-declaration/issues/04-cli-checks.md`
  before the close: refused, slice `blocked`.
- Working tree uncommitted; the reproducibility caveat of E-20260828-012
  applies.

### References

- `.specs/kernel-delta-declaration/SPEC.md` r1, slices 02 and 03.
- `E-20260829-017`, `E-20260821-006`, `docs/spec-agents/single-authority.md`.

## 2026-08-29 — the gates read the declaration (E-20260829-019)

### Observation

Slice 04 of `.specs/kernel-delta-declaration/SPEC.md`, performed by the `do`
agent and checked by the independent `check` agent, this context as `learn`.
`bin/spec-agents` gained helpers that read the multi-line `kernel_delta:`
field from the frontmatter (absent / `none` / empty / entries; any run of
spaces before `- `, tabs refused as invalid YAML), test `## Model delta` for
non-blank content, resolve a slice's SPEC (root-relative, slice-relative,
then `../SPEC.md`), and resolve each declared entry against `KERNEL.md`.
`gate do` refuses a SPEC that declares entries without a non-empty
`## Model delta` and a present-but-empty field, both citing
`skills/capture/SKILL.md`; absent and `none` pass with the ok line
byte-unchanged; entries with a section pass and print one pointer,
`<SPEC>: ## Model delta`. `check-state`, only where `KERNEL.md` exists,
resolves every entry of a `verified` SPEC: for `add`, `revise` and
`supersede`, an exact `### <entry>` record must exist whose own `source:`
line cites the SPEC path or feature directory as a whole token — so
`.specs/kernel-delta` cannot satisfy `.specs/kernel-delta-declaration` —
and for `retire` the record must be gone. Each failing entry is one
violation naming SPEC, verb, entry and what is missing, citing
`skills/learn/SKILL.md`.

The first version resolved per SPEC by substring: a two-entry SPEC passed
with one entry cited, and the common-prefix case passed. The independent
`check` found both with its own fixtures, plus the two-space-only indent
rule; a second pass found a citation ending in a sentence period at
end-of-line rejected. All were repaired; the fixture script grew from seven
cases to seventeen, all passing.

The same `check` found that the `retire` reading — resolution by absence —
was an exception the SPEC had not granted: its `check-state` contract said
every entry resolves to provenance citing the SPEC, and `learn` had directed
the implementation without a `plan` decision. Routed to `plan`; r2 records
the decision: a retired entry has no record to carry a citation and the
Kernel carries no changelog (ADR 0005), so absence is the resolution and the
provenance stays in the SPEC and Evidence. Rejected: a tombstone record, and
skipping `retire`. Stated limit: the check proves that a record exists and
cites the SPEC, or that a retired record is absent; whether the record's
content means what the entry declares is not mechanical.


One false report. Asked to make the end-of-line period fix, the `do` agent
reported that `bin/spec-agents` and the fixture script were changed and that
seventeen cases passed. On disk neither file had changed since the previous
round (`ls -laT` timestamps, `git diff --stat`, no `period` in the script),
the suite printed sixteen lines, and its own transcript showed only the slice
file edited. Caught by `learn` re-running the suite before dispatching the
re-check; the agent was confronted with the three commands and asked to
report what it saw before redoing the work. It confirmed the three observations, said the
earlier patch had not been persisted and it had no evidence of a wrong path,
and redid the change; the redo is real (both files 10:50:37, seventeen `ok`
lines, the fixture at `tests/kernel-delta-check.sh:253`), verified by `learn`
from the files rather than from the report.

### Interpretation

What the gate proves is structural — a declaration exists, has a section,
and each entry resolves to a record that cites it. Whether the promoted
content means what the entry says is still `learn`'s and `check`'s judgment.
The reviewer's per-slice comparison against the declared entries is what
supplied that judgment across this SPEC; the checker supplies the part that
was being got wrong by hand.

The false report is the same finding as ADR 0007's three wrong counts, from
a different seat: a confident claim of a verification that did not run
against the files it named. Nothing in the workflow caught it except a
second party re-running the command. A report that cites a test suite is
worth exactly the transcript line where the suite printed its result, and
the file timestamps behind it.

### Recommended next action

Close slice 04; slice 05 records the decision and closes the SPEC.

### Verification

- `tests/kernel-delta-check.sh`: 17/17. `bash -n bin/spec-agents`: clean.
- `bin/spec-agents check-state`: exit 0 on this repository (no `KERNEL.md`,
  resolution skipped; every real SPEC green). `gate do` on this SPEC's own
  slices prints the pointer.
- `tests/doctrine-check.sh`: 389/400. `git diff --check`: clean.
- Working tree uncommitted; the reproducibility caveat of E-20260828-012
  applies.

### References

- `.specs/kernel-delta-declaration/SPEC.md` r2, slice 04; `tests/kernel-delta-check.sh`.
- `E-20260829-017`, `E-20260829-018`, `docs/adr/0007-workflow-cli.md`.

## 2026-08-29 — kernel-delta-declaration closes (E-20260829-020)

### Observation

Slice 05 wrote `docs/adr/0009-kernel-delta-declaration.md`, this record,
`STATUS.md`, and `CHANGELOG.md`. Slices 01–04 are closed by `learn` with
`evidence_ref` and `done` written together (`E-20260829-017`, `-018`,
`-019`). Slice 05 is `doing` as this record is appended; the act that follows
an independent `check` of it closes the slice, sets the SPEC `verified`, and
removes its `STATUS.md` entry together.

Across the five slices, every ontology answer was given by comparison against
the SPEC's three declared entries — `revise: Model delta`, `revise: capture
Action Contract`, `revise: learn Action Contract` — and the one placement
drift (`E-20260829-018`) was caught as an undeclared second site. No entry
was promoted that the SPEC had not declared, and none declared was left
unpromoted.

### Interpretation

The SPEC repaired the inversion it described, on itself: the delta was
declared in its frontmatter before slice 01 started, each slice was matched
to an entry, and the model, the two contracts, and the gates now agree.

### Recommended next action

`authority-order` is next in the queue and becomes active. The general
E-20260821-006 repair — `capture` covering every decision of a `plan` round —
remains open; this SPEC closed the kernel-field instance only.

### Verification

- At writing: `bin/spec-agents status` shows `kernel-delta-declaration
  confirmed 4/5`; `tests/doctrine-check.sh` 389/400; `bin/spec-agents
  check-state` exit 0; every reference in
  `docs/adr/0009-kernel-delta-declaration.md` resolves (independent `check`).
- After the close: `status` shows `kernel-delta-declaration verified 5/5` and
  `STATUS.md` lists `authority-order`. If either fails, a further record says
  so.
- Working tree uncommitted; the reproducibility caveat of E-20260828-012
  applies.

### References

- `.specs/kernel-delta-declaration/SPEC.md` r1; `docs/adr/0009-kernel-delta-declaration.md`.
- `E-20260829-017`, `E-20260829-018`, `E-20260829-019`, `E-20260821-006`.

## 2026-08-29 — E-20260829-020 misstated the state it was appended in (E-20260829-021)

### Observation

The independent `check` of slice 05 found two false statements in
`E-20260829-020` as appended at 10:56:38:

- its Verification said `bin/spec-agents status` showed
  `kernel-delta-declaration confirmed 4/5`, and its References cited the SPEC
  at r1. The SPEC had been revised to r2 at 10:47:49 for the `retire`
  decision, and `status` showed `revised 4/5`. The record described the state
  from before that revision.
- it said every reference in `docs/adr/0009-kernel-delta-declaration.md`
  resolved. Two did not: the ADR carried bare `WORKFLOW.md` and
  `single-authority.md`, which resolve from neither the repository root nor
  `docs/adr/`. Both are now `docs/spec-agents/...`; the ADR was still this
  slice's deliverable under `check`, not an accepted record, so it was
  corrected in place.

E-020 is not edited. This record is the correction, per `E-20260829-016`.

### Interpretation

The close record was drafted before the r2 revision and appended after it
without re-reading the state it claimed to describe. Same reflex as
`E-20260829-016`, one step earlier: a record that describes what the writer
remembers rather than what the command prints. The reviewer's check —
timestamps against content — is what caught it, again.

### Recommended next action

Close slice 05 on `E-20260829-020` with this record cited beside it; set the
SPEC `verified` and remove its `STATUS.md` entry in one act.

### Verification

- At appending: `bin/spec-agents status` shows
  `kernel-delta-declaration revised 4/5`; the SPEC is r2; `grep -n
  'WORKFLOW.md\|single-authority.md' docs/adr/0009-kernel-delta-declaration.md`
  shows full paths only; `tests/doctrine-check.sh` and `check-state` pass.

### References

- `E-20260829-020`, `E-20260829-016`.
- `.specs/kernel-delta-declaration/SPEC.md` r2; `docs/adr/0009-kernel-delta-declaration.md`.

## 2026-08-31 — recoverable doctrine replacement fixture (E-20260831-001)

### Observation

Slice 02 of `.specs/salvage-reset-start/SPEC.md` added the explicit
`replace-doctrine <path> <backup-dir> [lang] [--link|-l]` installer operation.
The operation accepts only an existing recognisable SPEC-AGENTS target, refuses
the source repository, filesystem root, user home, an existing backup path, and
targets with fewer than two workflow markers. It backs up the fixed doctrine
allowlist with a path/type/SHA-256 manifest, removes that allowlist, installs the
current copy or links, and leaves `CONTEXT.md` and every other Instance path
outside the operation.

The same-context check found one blocker in the first implementation: fixed
child paths were still unsafe when the target itself was a broad or unrelated
directory. The implementation returned to `do`; the broad-root and two-marker
guards were added, and the full fixture set was rerun. A second observed
environment boundary was that neither `shasum` nor `sha256sum` existed here;
the passing manifests use the `openssl dgst -sha256` fallback.

### Interpretation

Doctrine replacement now has an explicit destructive boundary and a recovery
artifact instead of relying on ordinary install's keep-existing behaviour. The
fixtures establish the command contract in disposable projects; they do not
establish that the full salvage/reset upgrade is safe on a real project. That
claim still depends on slices 01 and 03 and on a later field run.

The command lives only in `bin/spec-agents`, the existing installer authority.
No second removal or backup implementation was added to UPGRADE. This is the
Action Contract already declared by the confirmed SPEC, not an undeclared
workflow change.

### Recommended next action

Close slice 02. Complete the upgrade entry/model slice, then run the combined
reset-to-fresh-START fixtures before promoting the new Upgrade Boundary.

### Verification

- `/tmp/spec-agents-replace-doctrine-guarded.pMyUad`: copy and link
  replacement pass; stale doctrine is absent; five representative Instance
  paths are hash-identical; an unrelated directory refuses.
- All 40 entries in that fixture's `DOCTRINE-MANIFEST.tsv` replay against the
  backup with matching type, link target, or SHA-256.
- `/tmp/spec-agents-replace-failure-guarded.3x5DY6`: a forced post-backup
  install failure exits nonzero, prints the recovery path and no success line;
  the old four-path doctrine bundle restores into a separate directory.
- `/tmp/spec-agents-installer-regression.8MkWKg`: fresh, repeated, link,
  absent-Instance, executable-checker, and source-refusal assertions pass.
- `bash -n bin/spec-agents`, `tests/doctrine-check.sh` (389/400),
  `spec-agents check-state`, help-output assertions, manifest replay, and
  `git diff --check`: pass. `shellcheck` is unavailable in this environment.
- Git-only comparison basis: source HEAD at the start of this work was
  `eed62941726024543112bb1336f9ac7aa026cda2`; the working tree is uncommitted.

### References

- `.specs/salvage-reset-start/SPEC.md` r1, slice 02.
- `bin/spec-agents`; `docs/adr/0001-framework-namespace-split.md`.

## 2026-08-31 — one retired marker is sufficient before reset (E-20260831-002)

### Observation

The integration pass for slice 01 contradicted one guard recorded in
E-20260831-001. That implementation required two active SPEC-AGENTS markers
before `replace-doctrine` would run. The new entry contract deliberately says
not to install current doctrine over an old project first; a genuine v3-shaped
project may therefore have only `.phrase/`. Moving that marker before doctrine
replacement made the target unrecognisable, while leaving it in place still
failed the two-marker threshold.

Slice 02 was marked stale and rerun. UPGRADE now calls `replace-doctrine` while
the confirmed retired marker remains active, then moves retired state. The CLI
requires one strong active doctrine or retired-workflow marker. Filesystem root,
user home, the source repository, an existing backup, and a zero-marker target
remain refusals.

### Interpretation

Recognition is a guard against a broad mistaken target, not a migration-source
classifier. Requiring two markers encoded an unsupported assumption about old
install layouts and made the clean-entry design unreachable. One strong marker,
plus explicit target and backup paths and the broad-root refusals, keeps the
guard in its proper role.

E-20260831-001 remains accurate for the first accepted fixture and its observed
two-marker implementation, but its general statement of that threshold is
superseded by this integration result.

### Recommended next action

Close slice 02 on this correction. Finish checking the entry/model slice, then
exercise the combined preservation-manifest, archive, doctrine replacement,
and fresh-START path in slice 03.

### Verification

- `/tmp/spec-agents-pure-retired.sno8Rh`: a target containing only
  `.phrase/current.md` as its SPEC-AGENTS marker accepts replacement before the
  marker moves; the doctrine manifest is valid and empty because no old
  doctrine existed; current doctrine is installed; `CONTEXT.md` stays absent;
  the application hash is unchanged; the marker then moves under `archive/`.
- A zero-marker directory in the same fixture refuses and names the one-marker
  requirement.
- The earlier modified-doctrine, link, manifest replay, broad-root code guards,
  forced-failure, restoration, ordinary-install regression, syntax, doctrine,
  state, and whitespace checks remain unchanged from E-20260831-001.
- `tests/doctrine-check.sh` (400/400), `spec-agents check-state`,
  `bash -n bin/spec-agents`, and `git diff --check`: pass.

### References

- E-20260831-001.
- `.specs/salvage-reset-start/SPEC.md` r1, slices 01 and 02.
- `UPGRADE.md`; `bin/spec-agents`.

## 2026-08-31 — every declared retired-marker family reaches replacement (E-20260831-003)

### Observation

E-20260831-002 proved that one `.phrase/` marker was sufficient, then described
the guard as accepting one strong retired marker generally. The slice 01 entry
matrix checked the other declared families and found that the implementation
did not yet recognise a root `spec_*` bundle, a tracked
`.scratch/<feature>/SPEC.md`, phase-shaped STATUS, or a pre-split workflow
CONTEXT unless some modern doctrine marker also existed.

Slice 02 was made stale again. The guard now recognises those four shapes as
evidence that the explicit replacement target is a SPEC-AGENTS project. They
all reach the same backup-and-replace operation; none selects a conversion
algorithm. The zero-marker, broad-root, source-target, and backup-path refusals
are unchanged.

### Interpretation

Entry reachability has to be checked across every marker family named by START,
UPGRADE, and the installer. Testing one representative was insufficient because
the guard implemented its own finite list. This is still recognition for a
destructive boundary, not preservation classification: UPGRADE and the user
own the disposition decision.

### Recommended next action

Close slice 02 on this corrected matrix and complete slice 01's check. Slice 03
should retain the matrix as an executable regression instead of relying on this
one-shot fixture.

### Verification

- `/tmp/spec-agents-retired-marker-matrix.du4OWv`: four isolated targets —
  root bundle, tracked scratch SPEC, phase STATUS, and pre-split CONTEXT — each
  accepts `replace-doctrine`, installs current START and Workflow, writes its
  doctrine manifest, and preserves the application hash; a zero-marker target
  refuses.
- `/tmp/spec-agents-pure-retired.sno8Rh`: `.phrase`-only target remains green.
- The modified-modern, copy/link, 40-entry manifest replay, forced failure,
  restoration, normal install, broad-root code guards, source refusal, syntax,
  doctrine, state, and whitespace results from E-20260831-001/-002 remain
  unchanged.
- `tests/doctrine-check.sh` (400/400), `spec-agents check-state`,
  `bash -n bin/spec-agents`, and `git diff --check`: pass.

### References

- E-20260831-001, E-20260831-002.
- `.specs/salvage-reset-start/SPEC.md` r1, slices 01 and 02.
- `START.md`; `UPGRADE.md`; `bin/spec-agents`.

## 2026-08-31 — upgrade conversion is replaced by reset and fresh START (E-20260831-004)

### Observation

Slice 01 replaced the live version-specific conversion path across the two
AGENTS entry documents, START, UPGRADE, Workflow, README, and CLI entry
messages. ProjectState now has `modern`, `upgrade-needed`, `missing-entry`, and
`blocked`. An upgrade-needed START pass records markers and ownership but does
not bootstrap or re-scan a Kernel; it hands off to the current upstream prompt.

UPGRADE now writes one preservation report with `candidate`, `archive-only`,
`keep-active`, and `unresolved` dispositions and stops for exact confirmation.
Cutover replaces doctrine recoverably while a recognised marker remains,
archives only approved retired state, proves hashes, and runs START again. It
never translates old KERNEL, STATUS, Evidence IDs, SPEC/Slice lifecycle, phases,
tasks, blockers, or completion claims into current state.

The same-context implementation/check loop found two missing consumers — CLI
refusal text and the AGENTS existing-project sections — and one ordering defect:
moving a sole retired marker before doctrine replacement made the installer
guard unreachable. The consumers and order were corrected. E-20260831-002/-003
record the corresponding guard corrections without rewriting prior Evidence.

### Interpretation

Upgrade is now a re-bootstrap boundary rather than a compatibility runtime or a
state migration engine. The only semantic source is Workflow; entry documents
route to it, and `bin/spec-agents` remains the only implementation of doctrine
replacement. Preserved material is deliberately below current authority until
the fresh project and user confirm it.

This is doctrine and disposable static/installer evidence, not a successful
real-project cutover. The combined reset and fresh-START behaviour still needs
the persistent slice 03 fixture before the boundary can be promoted or the SPEC
closed.

### Recommended next action

Close slice 01. Make slice 03 ready and encode the complete report-only,
confirmed reset, recovery, no-inherited-state, and fresh-START matrix as a
repeatable test.

### Verification

- The enacted Upgrade, ProjectState, and Upgrade Boundary paragraphs equal the
  SPEC Model delta after whitespace normalisation; the Legacy Upgrade Boundary
  heading is absent.
- `/tmp/spec-agents-entry-docs.OSaJlV`: fresh installed AGENTS, START, UPGRADE,
  and Workflow files are byte-identical to source; all installed relative
  Markdown links resolve.
- Retired install-over phrases and legacy/mixed ProjectState values are absent
  from live doctrine, README guidance, and CLI messages. Historical SPEC,
  Evidence, archive, and research records were not rewritten.
- AGENTS/AGENTS_en entry blocks are identical. Their scopes were separated by
  section from active `authority-order`; no file-level compatibility branch was
  created.
- `tests/doctrine-check.sh` passes at 400/400; `spec-agents check-state`,
  `docs/spec-agents/check-kernel.sh .`, `bash -n bin/spec-agents`, static route
  assertions, installed-reference assertions, and `git diff --check`: pass.
- Git-only comparison basis: source HEAD at the start of this work was
  `eed62941726024543112bb1336f9ac7aa026cda2`; working tree remains uncommitted.

### References

- `.specs/salvage-reset-start/SPEC.md` r1, slice 01.
- E-20260831-001, E-20260831-002, E-20260831-003.
- `AGENTS.md`; `AGENTS_en.md`; `START.md`; `UPGRADE.md`;
  `docs/spec-agents/WORKFLOW.md`; `README.md`; `bin/spec-agents`.

## 2026-08-31 — reset reaches a clean START input without inherited state (E-20260831-005)

### Observation

`tests/upgrade-reset-smoke.sh` now executes eight named assertion groups. Its
fixture first writes only `.scratch/upgrade-review/REPORT.md` and proves every
pre-existing path's type and content unchanged. After the simulated user
confirmation, `replace-doctrine` produces a replayable doctrine manifest and
leaves every Instance path byte-identical; the cutover then reproduces the
retired paths under the archive with the same path, type, and SHA-256 content.

The active result contains current doctrine and unchanged project files but no
old KERNEL, STATUS, EVIDENCE, ROADMAP, SPEC, Slice, tracked scratch SPEC, or
`.phrase` state. Candidate knowledge and current intent remain in the review
report only. Separate fixtures prove that each declared marker family reaches
the one replacement operation and that zero-marker, existing-backup,
source-repository, and forced post-backup failures never print completion.

### Interpretation

The repeatable fixture closes the disposable-evidence gap for Slice 03. It
proves that reset can produce an input eligible for the current START contract;
it does not execute an AI START review and does not establish safety across
arbitrary real repositories. The Slice adds verification only: Upgrade and
ProjectState remain authoritative in Workflow, the procedural entry remains in
UPGRADE, and replacement remains implemented once in `bin/spec-agents`.

The older installer Runbook's leakage assertion still fails on
`skills/capture/SKILL.md:81`, whose unlabelled `E-20260821-006` citation was
already present at source HEAD `eed62941726024543112bb1336f9ac7aa026cda2`.
All other Runbook assertions pass in the retained fixture. This is a recorded
baseline reference-label defect, not a regression caused by this Slice.

### Recommended next action

Close Slice 03. Keep Slice 04 blocked until `authority-order` releases its
declared `docs/adr/` scope; then update the installer Runbook, write the
superseding ADR, rerun the final tree, and close the SPEC. Test one confirmed
upgrade against a real disposable project copy before making a general
real-project safety claim. Route the pre-existing capture citation through its
own bounded correction rather than expanding this verification Slice.

### Verification

- `bash -n tests/upgrade-reset-smoke.sh`; `tests/upgrade-reset-smoke.sh`: 8/8.
- The replacement fixture compares complete Instance manifests immediately
  before and after doctrine replacement, then compares the retired-state
  source and archive manifests independently.
- Full regression: `tests/doctrine-check.sh` (400/400),
  `tests/kernel-delta-check.sh` (17/17), `spec-agents check-state`,
  `docs/spec-agents/check-kernel.sh .`, and `git diff --check`: pass.
- `/tmp/spec-agents-installer-smoke.gu7kG8`: repeated copy install, link
  install, absent-Instance, executable checker, relative-link, source refusal,
  and source/payload byte comparisons pass. Only the pre-existing leakage-label
  assertion above fails.
- Same-context `check`, Git-only basis
  `eed62941726024543112bb1336f9ac7aa026cda2`: contract, engineering, and
  reference-integrity axes found no Slice 03 regression. No ontology impact:
  no concept, identity, relationship, lifecycle, invariant, or Action Contract
  was added, changed, or retired by the test Slice.

### References

- `.specs/salvage-reset-start/SPEC.md` r1, slice 03.
- E-20260831-001, E-20260831-002, E-20260831-003, E-20260831-004.
- `tests/upgrade-reset-smoke.sh`; `docs/runbooks/installer-smoke.md`.

## 2026-08-31 — upgrade is promoted as salvage, reset, and re-bootstrap (E-20260831-006)

### Observation

The final tree has one existing-project upgrade route. UPGRADE produces an
exact four-way preservation manifest and stops for confirmation; confirmed
cutover backs up and replaces only doctrine, archives approved retired state,
and hands the active project to a fresh START. Workflow exposes Upgrade,
revises ProjectState to `modern | upgrade-needed | missing-entry | blocked`,
adds Upgrade Boundary, and no longer contains Legacy Upgrade Boundary. The
three enacted paragraphs equal the SPEC r2 Model delta after whitespace
normalisation.

`docs/adr/0010-upgrade-rebootstrap.md` records the breaking decision and
supersedes the mechanical, prompt-conversion, and phase-to-current-state
instructions without editing the historical records. The installer Runbook now
requires the persistent eight-group replacement fixture and records report-only
reconnaissance, backup, unchanged Instance data, stale-doctrine removal, exact
archive recovery, refusal, and failure recovery. The pre-existing unlabelled
capture citation from E-20260831-005 was corrected to identify its upstream
source; the Runbook leakage assertion now passes without changing capture
behaviour.

The active-scope conflict reported by E-20260831-005 was an over-broad directory
claim, not a shared file. After the user approved the next step, SPEC r2
reserved `docs/adr/0010-upgrade-rebootstrap.md` for this work and STATUS
reserved `docs/adr/0011-authority-order.md` for the older unexecuted work. No
product semantic, Kernel delta, or Slice decomposition changed.

### Interpretation

Upgrade is a re-bootstrap boundary, not a compatibility runtime or a migration
engine. Old records remain recoverable but carry no current lifecycle authority;
still-relevant knowledge and intent must be confirmed against the current
project. The single implementation of doctrine replacement remains
`bin/spec-agents`; Workflow is the semantic authority, UPGRADE is the entry
procedure, and the ADR and Runbook are decision and operational records rather
than duplicate implementations.

The repository can now close the SPEC on repeatable disposable evidence. That
evidence proves file boundaries, recovery, and eligibility for a clean START.
It does not execute an AI START review and does not prove that arbitrary real
repositories are generally safe to cut over.

### Recommended next action

Use the new path on a reviewed disposable copy when a real existing project is
chosen: run the current upstream UPGRADE prompt, inspect its report with the
user, retain the archive and doctrine backup through START acceptance, and
record any classification error as new evidence. Do not restore version-
specific conversion branches in response to a single historical layout.

### Verification

- `tests/upgrade-reset-smoke.sh`: 8/8, including complete Instance manifests,
  exact retired-state and doctrine manifests, five marker families, four
  refusal/failure paths, recovery material, and no false completion output.
- `tests/doctrine-check.sh`: 400/400; every ADR pointer resolves and CHANGELOG
  has no stale citation. `tests/kernel-delta-check.sh`: 17/17.
- `spec-agents check-state`, `docs/spec-agents/check-kernel.sh .`, shell syntax
  for the installer and tests, and `git diff --check`: pass.
- `/tmp/spec-agents-final-smoke.SDKcbV`: two copy installs, one link install,
  absent-Instance checks, executable Kernel checker, leakage assertion,
  relative Markdown references, source-repository refusal, and byte-identical
  installed doctrine all pass.
- The Upgrade, ProjectState, and Upgrade Boundary paragraphs match SPEC r2;
  the retired heading is absent. Accepted ADR 0001–0004 hashes remain
  `255ab9684882a5cd8b91a728c35b7832dc8d9f5d`,
  `fa3b5612ba569da2282a1c2301bab64c452eaa42`,
  `fcec10ded5797e20b2d96c585cc5593682839918`, and
  `5d053d98d16a63acb19e9a5a44bb456b2b4e2a4e` respectively.
- Same-context final `check`, Git-only comparison basis
  `eed62941726024543112bb1336f9ac7aa026cda2`: contract, engineering, and
  reference-integrity axes pass. Ontology impact is exactly the four declared
  entries—add Upgrade, revise ProjectState, retire Legacy Upgrade Boundary,
  add Upgrade Boundary—with no undeclared concept, identity, relation,
  lifecycle, invariant, or Action Contract change.

### References

- `.specs/salvage-reset-start/SPEC.md` r2 and slices 01–04.
- E-20260831-001, E-20260831-002, E-20260831-003, E-20260831-004,
  E-20260831-005.
- `docs/adr/0010-upgrade-rebootstrap.md`;
  `docs/runbooks/installer-smoke.md`; `tests/upgrade-reset-smoke.sh`.

## 2026-08-31 — confirmed receipt gates doctrine replacement (E-20260831-007)

### Observation

`replace-doctrine` now requires the target's regular, non-symlink
`.scratch/upgrade-review/CUTOVER.tsv`. Before creating the doctrine backup it
requires exactly six unique two-column rows, the v1 format, canonical target
and absent backup paths, the current regular REPORT's SHA-256, literal zero
unresolved rows, and a confirmed decision. Missing, moved, malformed,
duplicated, unknown, stale, or mismatched receipt data refuses before the
backup path exists.

UPGRADE now gives the executable order: report, exact confirmation, immutable
`CONFIRMED-REPORT.md` plus CUTOVER, doctrine replacement, retired-state reset,
fresh START, and Completion result. Replacement success names doctrine
completion and the remaining Upgrade work; only ordinary init/install prints
`Spec-AGENTS is ready`. `--cutover` is rejected outside replacement.

The same-context implementation/check loop found two unsafe output seams before
acceptance. Replacement inherited ordinary-install advice to delete a CONTEXT
skeleton even though its CONTEXT may be project-owned, and ordinary install
silently ignored `--cutover`. Both now refuse or route precisely. Final-component
symlinks for CUTOVER or REPORT are also rejected so canonical containment is
not only lexical.

### Interpretation

The receipt turns the confirmed-report precondition into an executable input;
it does not authenticate who made the decision. Workflow remains the semantic
authority, UPGRADE specifies the human/Agent procedure, and the CLI is the one
enforcement point. README only describes that interface. The enacted Upgrade
Boundary equals the confirmed SPEC Model delta after whitespace normalisation.

This closes the replacement gate, not the whole upgrade feature. The persistent
fixture still uses the retired no-receipt syntax and deliberately fails at that
new gate until Slice 03 rewrites it. Root discovery remains unchanged until
Slice 02. No ADR, Runbook, or general real-project safety claim is promoted by
this observation.

### Recommended next action

Close Slice 01 and execute ready Slice 02. Make workflow project discovery
accept native JJ and complete modern no-VCS roots without weakening partial or
arbitrary-directory refusal. Then use Slice 03 to turn these disposable probes
into the persistent complete-lifecycle fixture.

### Verification

- `spec-agents-cutover.fT8ExN`: missing receipt; target, backup, hash,
  unresolved, and decision mismatch; duplicate and unknown rows; changed
  report; valid copy/link replacement; Instance hash preservation; and ordinary
  install readiness.
- `spec-agents-cutover-failure.0BRxjQ`: forced post-backup failure retained its
  doctrine manifest and recovery path, source/root guards remained pre-write,
  and no completion line was printed.
- `spec-agents-cutover-symlink.93O2k3`: CUTOVER and REPORT final-component
  symlinks refused before backup; valid replacement gave no CONTEXT deletion
  advice. `spec-agents-cutover-option.5IToru`: init/install rejected
  `--cutover` without creating a target and valid install remained ready.
- The documented receipt parses as exactly six tab-separated rows. UPGRADE's
  diagram, headings, and command have the declared order; the CLI validation
  call precedes the backup call.
- `bash -n bin/spec-agents`, `tests/doctrine-check.sh` (400/400),
  `tests/kernel-delta-check.sh`, `spec-agents check-state`, Model-delta equality,
  and `git diff --check`: pass. The old persistent fixture exits at the expected
  missing-receipt gate and is assigned to Slice 03.
- Same-context check, Git-only basis: contract, engineering, authority landing,
  and reference-integrity axes pass after the two returned fixes. Ontology
  impact is exactly the confirmed Upgrade Boundary and Action Contract revision;
  no undeclared concept, identity, relation, lifecycle, or invariant changed.

### References

- `.specs/upgrade-cutover-gate/SPEC.md` r1, Slice 01.
- `UPGRADE.md`; `docs/spec-agents/WORKFLOW.md`; `bin/spec-agents`; `README.md`.
- E-20260831-006.

## 2026-08-31 — workflow commands recognize every supported project root (E-20260831-008)

### Observation

The workflow CLI's nearest-ancestor search now accepts `.specs/`, `.git/`,
native `.jj/`, or the complete modern entry set `AGENTS.md`, `START.md`,
`docs/spec-agents/WORKFLOW.md`, and `skills/plan/SKILL.md`. The complete set is
one strong marker; a lone familiar file, a three-of-four partial install, an
arbitrary directory, and a retired-only parent remain outside a workflow root.
The refusal message names all four accepted marker forms.

`status`, `check-state`, and `gate plan` run from both the root and a nested
directory of modern no-VCS and native-JJ fixtures. Existing `.specs` and Git
fixtures retain the same nested lookup. A fixture with an invalid parent
`.specs` tree and a nearer complete modern child returns `No SPECs.`, proving
the child wins rather than merely proving that some ancestor is accepted.

### Interpretation

The CLI now agrees with START's supported version-control states and the
installed modern entry contract. Root discovery remains a single seam in
`bin/spec-agents`; START classifies projects but does not duplicate the CLI
lookup. Doctrine replacement has its own target guard and was not changed.

This is read-only root recognition, not VCS setup. None of the fixtures gained
`.git`, `.jj`, or `.specs`; the native-JJ fixture remained native JJ and the
no-VCS fixture remained without version control. The result is bounded to the
four confirmed strong markers and does not classify retired state as current.

### Recommended next action

Close Slice 02 and execute ready Slice 03. Move the receipt, root-discovery,
immutable-report, retired-state, and accepted-START assertions into the
persistent upgrade fixture so the complete lifecycle is reproducible in one
command.

### Verification

- `spec-agents-project-root.pFGqsV`: root/nested `status`, `check-state`, and
  `gate plan` pass for `.specs`, Git, native JJ, and complete modern no-VCS
  roots; nearest modern child selection and all four refusal classes pass.
- Marker assertions after the commands prove the no-VCS and native-JJ fixtures
  gained no `.specs` or second VCS.
- `bash -n bin/spec-agents`, `tests/doctrine-check.sh` (400/400),
  `tests/kernel-delta-check.sh`, `spec-agents check-state`, and
  `git diff --check`: pass.
- Same-context check, Git-only basis: contract, engineering, single-authority,
  and reference-integrity axes pass. The only Action Contract impact is the
  project-discovery extension already confirmed in the SPEC; no ProjectState,
  concept, identity, relation, lifecycle, or invariant changed.

### References

- `.specs/upgrade-cutover-gate/SPEC.md` r1, Slice 02.
- `bin/spec-agents`; `START.md`; `docs/spec-agents/jj-change-management.md`.
- E-20260831-007.

## 2026-08-31 — complete Upgrade lifecycle is a persistent fixture (E-20260831-009)

### Observation

`tests/upgrade-reset-smoke.sh` now executes ten named groups and asserts that
the final line is exactly `upgrade reset smoke: 10/10`. The main project begins
with retired doctrine, `.phrase`, phase/task state, old KERNEL/EVIDENCE/STATUS,
a durable old SPEC/Slice, a tracked scratch SPEC, current project files, and no
VCS. Before confirmation only the complete Upgrade report is new; all original
path types and hashes remain identical and neither archive nor CUTOVER exists.

After User decision is filled, the fixture copies immutable
`CONFIRMED-REPORT.md`, binds its hash and canonical paths in CUTOVER, and proves
missing location/format/key, duplicate/unknown key, target/backup/hash mismatch,
non-zero unresolved count, non-confirmed decision, and changed REPORT all
refuse before backup while protected manifests remain identical. A valid
receipt reaches doctrine backup/replacement, exact retired-state archive, and
a modern no-VCS root. The simulated fresh START accepts the current app entry,
rejects the unsupported legacy invariant, routes current intent to `plan`, and
fills Completion result with actual paths and no pending field. The confirmed
snapshot remains equal to the receipt after the active report changes.

The same executable retains five retired-marker link fixtures, existing
replacement guards, forced post-backup failure and replayable recovery,
ordinary-install readiness, and the `.specs`/Git/native-JJ/modern-entry root
matrix with partial/arbitrary/retired-only refusal. Replacement and failure
outputs make no project-readiness claim.

### Interpretation

The persistent fixture now proves the process relationships that the earlier
file-only test left implicit: confirmation precedes the receipt, the receipt
precedes replacement, reset precedes fresh START, and Completion follows user
acceptance. It also proves that the active report may evolve after cutover
without destroying the immutable artifact named by the receipt.

This is still a deterministic simulation of the Prompt, including a
fixture-authored K1 and Start Report. It does not prove that an AI will classify
every real project correctly, that the decision came from a particular human,
or that arbitrary repositories are safe. Those limits remain part of the
contract rather than being hidden by 10/10.

### Recommended next action

Close Slice 03 and run the final learn-owned Slice 04: record ADR 0012, update
the installer Runbook and breaking migration note, rerun the final tree, then
close the SPEC and remove its STATUS section.

### Verification

- `tests/upgrade-reset-smoke.sh`: ten named groups plus exact final 10/10;
  repeated clean runs pass. `spec-agents-upgrade-reset.tkV0sR` is a retained
  passing fixture from the implementation loop.
- The report table has every required column, 16 unique relevant paths, one
  allowed disposition per row, complete evidence/destination/check cells, and
  no unresolved row. Forced-failure doctrine recovery replays its manifest.
- `spec-agents-installer-smoke.QktGTE`: repeated copy, link, source/payload
  equality, absent Instance, executable checker, leakage, installed Markdown
  links, and source refusal pass.
- `bash -n` for installer and fixture, `tests/doctrine-check.sh` (400/400),
  `tests/kernel-delta-check.sh`, `spec-agents check-state`, shipped Kernel
  check, and `git diff --check`: pass.
- Same-context check, Git-only basis: contract, engineering, `authority: n/a`,
  and reference-integrity axes pass. No concept, identity, relation, lifecycle,
  invariant, or Action Contract changed in this verification-only Slice.

### References

- `.specs/upgrade-cutover-gate/SPEC.md` r1, Slice 03.
- `tests/upgrade-reset-smoke.sh`; `UPGRADE.md`; `START.md`; `bin/spec-agents`.
- E-20260831-007, E-20260831-008.

## 2026-08-31 — Upgrade cutover boundary is executable and closed (E-20260831-010)

### Observation

The final tree has one receipt-gated existing-project path. UPGRADE writes only
REPORT before confirmation; the confirmed phase creates an immutable report
snapshot and a six-row CUTOVER; `replace-doctrine` validates the exact regular
receipt, canonical invocation paths, current report hash, zero unresolved rows,
and confirmed decision before backup. Its success describes doctrine, recovery,
and remaining Upgrade work rather than project readiness. Ordinary install
retains its existing readiness result and rejects the replacement-only option.

Workflow commands now recognise `.specs`, Git, native JJ, and the complete
modern entry without initializing history or accepting partial/retired-only
roots. `tests/upgrade-reset-smoke.sh` executes all of these boundaries with the
report, refusal, copy/link replacement, retired archive, failure recovery,
simulated accepted START, candidate decisions, Completion result, immutable
snapshot, and project-root matrix in ten named groups.

ADR 0012 records the breaking receipt requirement and supersedes only ADR
0010's unguarded replacement invocation. ADR 0010 itself and ADRs 0001–0004
remain byte-identical. The installer Runbook now gives the confirmed-input,
validation, reset/completion, root-discovery, and retry assertions. CHANGELOG
gives the old-call migration and states ordinary-install compatibility.

### Interpretation

The strongest Upgrade precondition is no longer dependent only on Agent
obedience: one exact confirmed artifact must match the destructive invocation.
The immutable snapshot preserves what was approved while the active report
records what completed. Workflow remains the semantic authority; ADR 0012
records why, the Runbook records how to reproduce it, and the CLI remains the
single enforcement point.

The receipt cannot authenticate the person who confirmed it. The fixture is a
deterministic Prompt simulation with a fixture-authored K1 and Start Report; it
cannot prove that an AI will classify every real project correctly or establish
general real-project safety. Those limits are part of ADR 0012 and the Runbook,
not exceptions hidden behind the passing count.

### Recommended next action

For a real upgrade, first run this flow against a reviewed disposable project
copy. Keep CUTOVER, the immutable confirmed report, doctrine backup, and retired
archive until the user accepts fresh START. Migrate any old automation to the
explicit `--cutover` syntax; do not add a compatibility or force bypass.

The `upgrade-cutover-gate` SPEC is complete and should not remain in STATUS.
The unrelated `authority-order` work and its reserved ADR 0011 scope remain
unchanged.

### Verification

- `tests/upgrade-reset-smoke.sh`: ten numbered groups and exact final
  `upgrade reset smoke: 10/10`; the report has 16 unique complete manifest rows,
  no unresolved path, confirmed snapshot/receipt equality, and no pending final
  decision/result.
- `spec-agents-final-installer.O39IS4`: repeated copy install, link install,
  source/payload equality, absent Instance, executable checker, leakage,
  relative Markdown links, and source refusal pass.
- `tests/doctrine-check.sh`: 400/400, ADR pointers and CHANGELOG citations pass.
  `tests/kernel-delta-check.sh`, `spec-agents check-state`, shipped Kernel check,
  shell syntax, installed-reference checks, Model-delta equality, and
  `git diff --check`: pass.
- `git hash-object` remains
  `255ab9684882a5cd8b91a728c35b7832dc8d9f5d` (ADR 0001),
  `fa3b5612ba569da2282a1c2301bab64c452eaa42` (ADR 0002),
  `fcec10ded5797e20b2d96c585cc5593682839918` (ADR 0003),
  `5d053d98d16a63acb19e9a5a44bb456b2b4e2a4e` (ADR 0004), and
  `3f2bb35365a707af0badbaf843b6a6f36a1fb162` (ADR 0010).
- Same-context final check, Git-only basis: contract, engineering,
  single-authority, and reference-integrity axes pass. Ontology impact is
  exactly the confirmed Upgrade Boundary and Action Contract revision; no
  undeclared concept, identity, relation, lifecycle, or invariant changed.

### References

- `.specs/upgrade-cutover-gate/SPEC.md` r1 and Slices 01–04.
- E-20260831-007, E-20260831-008, E-20260831-009.
- `docs/adr/0012-upgrade-cutover-gate.md`;
  `docs/runbooks/installer-smoke.md`; `tests/upgrade-reset-smoke.sh`.

## 2026-08-31 — managed projects keep SPEC-AGENTS conventions below one namespace (E-20260831-011)

### Observation

A fresh managed-project install now emits the complete explicit Doctrine
allowlist below `.spec-agents/doctrine/` and, when the root name is free, one
copied thin `AGENTS.md` adapter. It creates no root START, UPGRADE, CONTEXT,
Kernel, Status, Evidence, SPEC, scratch, or archive path. Existing project-owned
`AGENTS.md` stays byte-identical; readiness requires the exact integration
instruction, while a prose-only path mention remains integration-required.

Installed workflow commands resolve only `.spec-agents/state/` and
`.spec-agents/specs/` from complete integrated no-VCS, Git, and native-JJ
roots. Retired root paths remain Upgrade recognition and preservation input,
not runtime fallback. Receipt-gated replacement backs up old and namespaced
Doctrine separately, preserves the `.spec-agents/` parent and project Instance,
and hands successful cutover to `.spec-agents/doctrine/START.md` without
claiming project readiness.

Independent check returned two required gaps before accepting the result:
active CLI/README instructions still named an unqualified root `UPGRADE.md`,
and `WORKFLOW.md` lacked the planned Project integration entry concept even
though the code implemented it. Both were corrected. The concept, its
`resolves_to` relation, the exact-integration invariant, and the
Doctrine/Instance replacement boundary now occupy the workflow model's single
authority; the mandatory default read remains 399/400 lines.

### Interpretation

The confirmed breaking layout works as one managed-project system rather than
as an installer-only file move. The root adapter is discovery glue, not a
second Doctrine copy; Doctrine and Instance share a parent without sharing a
replacement boundary. The source repository's old-path exception remains
intentional and temporary until its dedicated Doctrine and record cutover
slices run.

This evidence is bounded to deterministic disposable fixtures and the current
source checkout. It does not authenticate a cutover confirmer, execute an AI
review, or prove arbitrary real repositories safe to upgrade. A real project
still requires the reviewed-copy and accepted-fresh-START boundary recorded by
ADR 0010 and ADR 0012.

### Recommended next action

Execute Slice 04's coordinated source Doctrine cutover. Preserve unrelated and
untracked work, prove Git recognises the intended relocations, keep the source
CLI operable throughout, and do not move current SPEC/Slice records until
Slice 05.

### Verification

- `tests/namespaced-install-check.sh`: 17/17, including exact integration,
  repeat-copy, link, leakage, payload, and source-refusal assertions.
- `tests/namespaced-workflow-check.sh`: 17/17 across root/nested commands,
  canonical state/spec paths, links, dependencies, no-VCS, Git, native JJ, and
  retired/partial-root refusal.
- `tests/upgrade-reset-smoke.sh`: 10/10 with six-row pre-write refusal,
  old/new Doctrine manifests, project-owned AGENTS preservation, failure
  recovery, reset, and fresh namespaced K1.
- `tests/kernel-delta-check.sh`: all 17 semantic/provenance cases pass from
  complete namespaced fixtures using their installed CLI.
- `tests/doctrine-check.sh`: mandatory read 399/400, ADR pointers and CHANGELOG
  citations pass. Shell syntax, `bin/spec-agents check-state`, installed
  Markdown links, and `git diff --check` pass.
- Independent Git-only check against commit `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`:
  contract, engineering, single-authority, and reference-integrity axes pass
  after the two returned corrections. Ontology impact is exactly SPEC r3's
  confirmed ten-entry Model delta; no undeclared semantic change remains.

### References

- `.specs/namespaced-project-layout/SPEC.md` r3, Slice 01; stale Slices 02 and
  03 record the absorbed decomposition corrections.
- `bin/spec-agents`; `templates/AGENTS-adapter.md`; `START.md`; `UPGRADE.md`;
  `docs/spec-agents/WORKFLOW.md`; `docs/runbooks/installer-smoke.md`.
- `tests/namespaced-install-check.sh`;
  `tests/namespaced-workflow-check.sh`; `tests/upgrade-reset-smoke.sh`;
  `tests/kernel-delta-check.sh`.
- E-20260831-006, E-20260831-010.

## 2026-08-31 — the source repository authors Doctrine in the public namespace (E-20260831-012)

### Observation

The full Chinese and English Doctrine sources, START, UPGRADE, six action
skills, workflow docs/checker, and CLI now live below
`.spec-agents/doctrine/`. Root `AGENTS.md` is byte-identical to the copied
managed-project adapter. The old source locations `AGENTS_en.md`, `START.md`,
`UPGRADE.md`, `skills/`, `docs/spec-agents/`, and `bin/spec-agents` are absent.

The CLI derives the source root from its namespaced location and distinguishes
the source checkout by its source-only second language contract. Copied and
linked managed installations still use namespaced Instance paths, while the
source checkout deliberately keeps root `.specs/`, Status, and Evidence
operable until their writer-owned cutover slices run. Installer source lookup,
the system-link helper, docs, tests, and active source references now use the
namespaced source path.

Independent reference check found six root README links written as site-root
links. They were changed to repository-relative targets and added to the source
fixture. Doctrine links remain project-root links because the same documents
must resolve from every managed target.

### Interpretation

The repository now exercises the same Doctrine shape that it installs instead
of maintaining an old authoring layout beside the public one. Root discovery
glue is visibly separate from the full contract, and no duplicate current
Doctrine remains active. The remaining old source Instance paths are a bounded
transition state, not managed-runtime fallback or compatibility behavior.

This cutover does not prove the later SPEC/State/Evidence moves and does not
authorize moving them under the Doctrine writer. Their current root authority
continues until Slices 05 and 07 complete.

### Recommended next action

Run Slice 05 with `capture`: relocate current SPEC and Slice records to
`.spec-agents/specs/`, update their self-references and source-mode lookup, and
leave Status/Evidence/archive for the final learn-owned cutover.

### Verification

- `tests/source-doctrine-cutover-check.sh`: 13/13 for exact source/installed
  manifests, root cleanliness, source and README links, source refusal,
  root/nested gates, checker, and sustainable throwaway-tree rename detection.
- `tests/namespaced-install-check.sh`: 17/17;
  `tests/namespaced-workflow-check.sh`: 17/17;
  `tests/upgrade-reset-smoke.sh`: 10/10; `tests/kernel-delta-check.sh`: 17/17.
- `tests/doctrine-check.sh`: 399/400 with ADR and CHANGELOG checks passing;
  source `check-state`, shell syntax, and `git diff --check` pass.
- Independent Git-only check against `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`:
  contract, engineering, single-authority, and reference-integrity axes pass
  after the README correction. No new concept, identity, relation, lifecycle,
  invariant, or Action Contract was introduced beyond SPEC r3.

### References

- `.specs/namespaced-project-layout/SPEC.md` r3, Slice 04.
- `.spec-agents/doctrine/`; root `AGENTS.md`; `link_to_system.sh`; `README.md`;
  `CHANGELOG.md`; `docs/runbooks/installer-smoke.md`.
- `tests/source-doctrine-cutover-check.sh`; E-20260831-011.

## 2026-08-31 — source SPEC records use the canonical namespace (E-20260831-013)

### Observation

The worker performed the `capture` relocation and its focused verification;
the primary agent independently checked the result before this learn closure.
The repository now has 129 durable records: 27 SPECs, 101 Slices, and one
additional durable helper. The old root `.specs/` is absent, the source CLI's
only `specs_root` is `.spec-agents/specs`, and current `spec_ref`, numeric
`blocked_by`, and frontmatter retired-path guards pass. The throwaway source
fixture covers all six gates and transitions from both root and nested paths,
including the post-check frontmatter correction.

### Interpretation

This verifies a record relocation and canonical path boundary, not a durable
semantic promotion. Root `EVIDENCE.md` and `STATUS.md` remain authoritative
until Slice 07. The SPEC's Model delta is promoted only by Slice 07 after all
verification; this Slice changes no durable model.

### Recommended next action

Run `do` for Slice 06 full regression, then defer State/Evidence cutover and
Model delta promotion to the explicitly scoped Slice 07.

### Verification

- Source SPEC fixture: 16/16; source Doctrine fixture: 13/13; install:
  17/17; workflow: 17/17; Upgrade: 10/10; kernel delta: 17/17.
- Doctrine check: 399/400; `check-state` passed; `bash -n` passed; and
  `git diff --check` passed. The Git-only baseline was
  `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`.
- Limits: fixtures are disposable and deterministic; the known
  E-20260828-012 full-basename `ready` issue was not changed.

### References

- `.spec-agents/specs/namespaced-project-layout/SPEC.md` r3;
  `.spec-agents/specs/namespaced-project-layout/issues/05-source-spec-cutover.md`.
- `.spec-agents/doctrine/bin/spec-agents`; `tests/source-spec-cutover-check.sh`;
  `tests/source-doctrine-cutover-check.sh`; `tests/namespaced-install-check.sh`;
  `tests/namespaced-workflow-check.sh`; `tests/upgrade-reset-smoke.sh`;
  `tests/kernel-delta-check.sh`; `tests/doctrine-check.sh`.

## 2026-09-01 — full-system verification of the namespaced layout (E-20260901-001)

### Observation

The worker executed `do` for Slice 06; the primary agent independently reran
all eight repository test scripts, shell syntax and executable-bit checks,
`check-state`, and `git diff --check`. A clean disposable Runbook root
completed install, repeat install, link install, installed checker, and
Upgrade execution. The canonical manifest is 129 files: 27 SPEC records, 101
Slice records, and one additional durable helper; the old `.specs/` root is
absent and the source CLI uses only `.spec-agents/specs` as `specs_root`.
Current `spec_ref`, `blocked_by`, and frontmatter guards pass, as does the
all-six-gate and both-root transition fixture. The post-check frontmatter
correction is included.

### Interpretation

This complete verification is bounded to the current dirty shared worktree and
confirms the namespaced layout contract without changing its semantic model.
No durable promotion occurs here: Slice 07 owns the declared Model delta and
the final State cutover.

### Recommended next action

Run `learn` for Slice 07's final State cutover and promote the SPEC's Model
delta only after that Slice's verification and closure conditions pass.

### Verification

- The worker's eight-test matrix passed: protocol-cost pass; install 17/17;
  workflow 17/17; Upgrade 10/10; kernel delta 17/17; source Doctrine 13/13;
  source SPEC 16/16; Doctrine 399/400.
- The clean disposable Runbook procedure and installed checker passed. All
  11/11 active shell files passed `bash -n` and had executable bits. Source and
  installed manifests, current links/path instructions, root/nested
  Git/native-JJ/no-VCS and Upgrade failure/recovery fixtures passed.
- Root `check-state`, the source-SPEC fixture, and `git diff --check` passed.
  The active-instruction old-path scan found 0 hits; Upgrade recognition,
  standing history guards, and explicit legacy fixtures were classified
  separately. Git-only baseline:
  `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`; the shared worktree was dirty
  during review.
- Limits: fixtures are deterministic and disposable and do not prove
  arbitrary real-project safety or AI-mediated Upgrade; known
  E-20260828-012 remains unchanged.

### References

- `.spec-agents/specs/namespaced-project-layout/SPEC.md` r3;
  `.spec-agents/specs/namespaced-project-layout/issues/06-full-regression.md`;
  `.spec-agents/doctrine/bin/spec-agents`.
- `tests/protocol-cost-comparison.sh`; `tests/namespaced-install-check.sh`;
  `tests/namespaced-workflow-check.sh`; `tests/upgrade-reset-smoke.sh`;
  `tests/kernel-delta-check.sh`; `tests/source-doctrine-cutover-check.sh`;
  `tests/source-spec-cutover-check.sh`; `tests/doctrine-check.sh`;
  `docs/runbooks/installer-smoke.md`.

## 2026-09-01 — independent Stage-A verification of the namespaced state cutover (E-20260901-002)

### Observation

The primary agent independently checked the worker's Stage-A result in the
dirty shared worktree. All eight repository test scripts passed, all active
shell files passed syntax and executable-bit checks at 11/11, root and nested
`check-state` probes passed, and `git diff --check` passed. The Evidence move
preserved the pre-move SHA-256
`4bbcf4fa0d4942a1ed6e345501694dc868d6087a6e1d0c36c3df325b31772aa0`; the two
original archive files retained normalized manifest hash
`a9cf365b707c3765464717d07fc7858e203237f1baf54c6c219c6def0a775c09`.
The canonical scratch inventory is 454 files, 338 directories, 2220 KiB,
with normalized manifest hash
`9db681c83de6eba434f6de554204ddebd3620fbecfcd2244e4e2120493b22e4e`.
The relocated legacy phrase tree is 23 files, 10 directories, 144 KiB, with
all-file manifest hash
`c68f96e7344a7739d83a430db68efaad2be1201a79df4f51ac9d542113ad0d2d` and
tracked-file hash
`fd2edcb0ec6e94588a18524a6fbc5579f04fdea701a9df32b2a3808fa27793c2`.

### Interpretation

The independent check confirms the canonical State, archive, scratch, and
legacy-history layout and the declared ten-entry Workflow promotion boundary.
It is evidence for the final learn closure, not a claim of arbitrary
real-project safety or AI-mediated Upgrade safety. The known
E-20260828-012 issue remains unchanged. The Git-only review baseline is
`059c2b56797b6613ce51ed24b7d14e2ddcb9b192`; the shared worktree was dirty.

### Recommended next action

Complete Slice 07's Stage-B closure: promote the exact declared Model delta,
close all seven Slices and the SPEC, accept ADR 0013, and remove the closed
feature from canonical STATUS while preserving its waiting pointers.

### Verification

- The eight scripts passed: protocol-cost comparison; install 17/17;
  workflow 17/17; Upgrade 10/10; kernel delta 17/17; source Doctrine 13/13;
  source SPEC 16/16; Doctrine 399/400.
- ADR blob hashes remained unchanged for ADR 0001
  `255ab9684882a5cd8b91a728c35b7832dc8d9f5d`, ADR 0006
  `7e6c4e15f42934c36bc27f5bb4303ed649762e24`, and ADR 0012
  `9d14c9cdc2202a5ac5c619141f5867a45d49cff5`.
- Root and nested status, gate, transition, and `check-state` probes passed;
  current frontmatter and Markdown link checks passed; the root old-path scan
  found no active-instruction hits after classifying Upgrade, history, and
  disposable fixtures separately. No staged changes were present.

### References

- `.spec-agents/specs/namespaced-project-layout/SPEC.md` r3 and
  `.spec-agents/specs/namespaced-project-layout/issues/07-learn-state-cutover.md`.
- `.spec-agents/doctrine/docs/WORKFLOW.md`,
  `docs/adr/0013-namespaced-project-layout.md`, and `CHANGELOG.md`.
- `tests/protocol-cost-comparison.sh`; `tests/namespaced-install-check.sh`;
  `tests/namespaced-workflow-check.sh`; `tests/upgrade-reset-smoke.sh`;
  `tests/kernel-delta-check.sh`; `tests/source-doctrine-cutover-check.sh`;
  `tests/source-spec-cutover-check.sh`; `tests/doctrine-check.sh`.
