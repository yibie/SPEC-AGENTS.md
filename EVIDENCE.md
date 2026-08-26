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
