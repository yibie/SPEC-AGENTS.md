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

`python3 experiments/jsonl-evidence-pilot/run_pilot.py` passed J1–J5. The runner
used only the Python standard library, wrote no files, and did not touch
application code or production skills.

### References

- `experiments/jsonl-evidence-pilot/BRIEF.md`
- `experiments/jsonl-evidence-pilot/RUN_PROTOCOL.md`
- `experiments/jsonl-evidence-pilot/RESULTS.md`

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

`python3 experiments/ontology-graph-pilot/run_pilot.py` passed all typed-edge,
lifecycle, impact, provenance, and rejection checks. The runner used only the
Python standard library, stored state in memory, wrote no files, and did not
modify production documents or code.

### References

- `experiments/ontology-graph-pilot/ONTOLOGY.md`
- `experiments/ontology-graph-pilot/RUN_PROTOCOL.md`
- `experiments/ontology-graph-pilot/RESULTS.md`
