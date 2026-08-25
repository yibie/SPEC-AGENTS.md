# Changelog

## [4.1.0] — 2026-08-24

**Breaking.** Everything since v4.0.4, released as one version. The intermediate
numbers 4.1.0 through 4.7.1 appeared in this file during development and were
never tagged or released; they are folded in below as sections.

The framework's own documents are now separated from the state of the repository
that produces them, `Phase` is retired, placement is a checked property, and the
read every task pays for is 374 lines instead of 586.

### Route repair — make every documented route executable

Repaired five routes that had no satisfiable next step, found by an independent
review.

- `do` required the Kernel's authority map while `START.md` said an existing
  Kernel need not have one — a conforming project could enter neither execution
  path. The comparison is now conditional: no map means a `semantic` finding to
  `plan`, not a stop.
- `AGENTS.md` drew three routes out of `plan` while `plan` emits six. The route
  diagram is gone; `skills/plan/SKILL.md` is the single routing authority, and
  the `approve` two-part test now exists in exactly one file.
- `plan-only`, `compatible revise` routed to `do`, and `breaking` each had no
  action whose preconditions would accept them. All three now do. `breaking`
  states the migration in the SPEC; the ADR stays with `learn` (ADR 0004).
- `learn`'s triggers now name a rejected or unresolved proposal.
- `authority:` states what it guarantees — an answer, not a correct one — and
  `check` verifies `n/a` against the diff, which `arrange` cannot see.
- `Start entry`, `Version-control layer`, and `SPEC and slice discipline` sank
  to their skills and Protocols. Mandatory read 400 → 374.
- No ADR: this repairs contracts to match ADR 0004 and ADR 0006.

### Single authority — make placement a checked property

**Breaking.** Made placement a checked property, after a field report in which
six gates passed and the result was wrong.

- `Architecture boundaries` in the Kernel is now the authority map: for each
  rule that could live in more than one place, the one module that owns it,
  named by path. Single authority constrains where a rule is decided, not what
  it decides.
- Every slice declares `authority:`, or `n/a: <reason>`. Required rather than
  conditional — a conditional field returns the "is this a business rule?"
  judgment to the slice author, which is the judgment that failed.
- `do` compares the target site against the map before writing and returns to
  `plan` if it is not there.
- `check`'s contract axis gains a named authority item with three tells: a
  second site for a rule that already has one, a client reimplementing a
  server-enforced rule, derived state persisted twice. Conformance to
  `KERNEL.md` does not detect duplication, and the ontology-impact question
  answers "no" for it.
- `check` declares whether it ran in the context that executed `do`. When it
  did, the authority item needs positive evidence rather than absence of
  suspicion.
- New Protocol `docs/spec-agents/single-authority.md`: the rule is not "never
  duplicate", divergence is the failure, and a second site owes a same-input
  equivalence test. It also records why green tests do not protect — a test at
  the implementation's own layer cannot show the layer is wrong.
- Recorded as `docs/adr/0006-single-authority.md`.

### Context budget — cut the mandatory read by a third

Cut the mandatory read by a third; no rule removed.

- `AGENTS.md` + `docs/spec-agents/WORKFLOW.md`: 586 → 399 lines. Two days of
  defect fixes had grown it from 299, each addition justified and each applied
  by adding prose to the file every task must read.
- `AGENTS.md`'s `## Six actions` was 111 lines restating the six `SKILL.md`
  files, which are read in full when the action runs. It is now a 38-line
  router: enough to choose an action, nothing needed after choosing.
- Rule rationale moved into the ADR that records the decision, with a pointer
  left beside the rule. Two reasons stayed inline, both for rules observed
  broken while visible.
- `check`'s engineering axis gained Fowler's twelve code smells as a named
  baseline, adapted from `mattpocock/skills`. `check` is not mandatory reading,
  so this costs nothing per task — which is the point.
- No ADR: no decision changed.

### Kernel drift — make the Kernel findable-wrong

Made ontology drift detectable.

- `check` gains a fourth finding, `semantic`, which routes to `plan` instead of
  `do`. Previously all three finding types returned to `do`, so a code/Kernel
  conflict could only be filed as a `blocker` and sent back to change the code.
- `check` never decides whether the code or the Kernel is wrong. That is
  `plan`'s job, and deciding it in `check` bypasses the rule that Kernel
  evolution passes `plan`.
- Every `check` answers one question in writing, including when the answer is
  no: did this change add, alter, or retire a concept, identity, relation,
  lifecycle, invariant, or Action Contract? Adding one the Kernel lacks violates
  nothing, so no axis catches it.
- Each enacted Kernel entry carries `since:` and `source:`. No per-entry version
  number and no in-file changelog: git gives per-line history, `source:` gives
  which decision admitted the entry.
- `start` is re-runnable as a re-scan. It writes nothing to `KERNEL.md` and
  produces a `KernelStatus` plus a difference report. This is what produces
  `stale` and `contradicted`, which were defined but never emitted.
- A provenance-only Kernel revision still advances the file version. This rule
  was decided in the `docs/adr/0004` round and lost at `capture`; it lands here.
- Recorded as `docs/adr/0005-kernel-drift-detection.md`.

### Short path — make the `approve` route executable

Repaired the `approve` route, which was documented but could not be executed.

- `plan` routed `approve` with no artifact, while `do` required a target slice,
  a slice status, and a non-stale SPEC, and `check` listed the slice among its
  required inputs. On that route none of those exist. An agent could only
  ignore the contract or invent a slice for a small change — manufacturing the
  ticket the doctrine resists.
- `approve` now requires two conditions: semantics unchanged **and** the work
  completes in the current context. Size is not the test.
- `approve` hands `do` the contract that stays unchanged and one verifiable
  acceptance sentence. Neither is a file. `plan` records one `STATUS.md` entry
  only when the work may outlive the current context.
- `do` and `check` state preconditions per path. Neither creates a slice on the
  short path; `arrange` remains the only creator.
- Terminology converged: the concept is `Slice`, and a file is named by its full
  path. Six skills had used "issue" 26 times against 15 for `Slice`.
- No ADR: this repairs a contract to match the documented model.

### Code and write boundaries

**Breaking.** Defined `Code`, protected doctrine, and added a reference-integrity
check.

- `Code` is now a Core Concept: the artifact constrained by the SPEC, the
  Kernel, and the Action Contracts. Whatever the product is made of is that
  project's `Code`. In SPEC-AGENTS itself the doctrine documents and `bin/` are
  its `Code`; knowledge *about* the product never is, in any project.
- Installed doctrine — `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`,
  `docs/spec-agents/` — is not written by any action in a managed project.
  Previously only `docs/spec-agents/` was named, and only against "silent"
  changes.
- `check` gains a third axis: every `source`, `spec_ref`, `context_ref`,
  `evidence_ref`, relative link, and quoted path the change touches must still
  resolve. Deliberately historical references are recorded, not repaired.
- A slice whose scope contains a file `do` does not own declares `writer:`, and
  `arrange` now requires that each slice's verification be reachable within its
  own scope.
- The `START.md` Kernel template becomes eight sections matching the Kernel's
  own definition, adding `Identities` and `Lifecycles` and splitting
  `Actions and invariants` so that an Action Contract's five fields are all
  named. Existing Kernels are not required to restructure.
- `UPGRADE.md` gained a section for detecting locally modified doctrine. It
  reverts nothing.
- ADR 0001, 0002, and 0003 were written under the wrong authoring contract and
  are individually ratified in `EVIDENCE.md`; no content was reverted.
- Recorded as `docs/adr/0004-code-and-write-boundaries.md`.

### Durable work contracts move out of `.scratch`

**Breaking.** Separated durable work contracts from scratch.

- Confirmed SPECs and their slices moved from `.scratch/<feature>/` to
  `.specs/<feature>/`. They are git-tracked, committed records of every
  confirmed decision, and `.scratch` told the next context they were
  disposable.
- `.scratch/` now holds only one-shot reports awaiting user confirmation:
  `start/REPORT.md` and `upgrade-review/REPORT.md`. Documentation recommends
  ignoring it in version control; the framework does not write a project's
  `.gitignore`.
- `UPGRADE.md` gained a section for moving an existing project's SPECs. Nothing
  is moved or deleted automatically.
- `.spec-agents/` was chosen first and withdrawn: it would have shared a name
  segment with `docs/spec-agents/` while having the opposite ownership.
- Recorded as `docs/adr/0003-split-work-and-scratch.md`.

### Retire `Phase` and `ROADMAP.md`

**Breaking.** Retired `Phase` and `ROADMAP.md`.

- `Phase` is no longer a concept. The unit of bounded work is the `SPEC` that
  already existed at `.scratch/<feature>/SPEC.md`; no replacement concept was
  introduced.
- `ROADMAP.md` is retired. The repository no longer records future intent —
  direction is decided in conversation and becomes durable only as a confirmed
  SPEC.
- `taskNNN` is retired. `Slice` is the only execution unit.
- `STATUS.md` lists only active SPECs, their blockers, and the next permitted
  action. A finished SPEC is removed from it; it never accumulates closed
  sections.
- Several SPECs may be active at once. Their scopes must not intersect, and
  work that runs at the same time needs its own working copy. New doctrine
  Protocol `docs/spec-agents/parallel-work.md` covers `jj workspace` and
  `git worktree`, and states that isolation fixes execution interference, not
  scope conflict.
- `learn` loses its phase-boundary trigger; `arrange` is bounded by the
  confirmed SPEC rather than the current phase.
- `UPGRADE.md` gained a conversion section for a phase-shaped project. Nothing
  is deleted automatically.
- This repository's eleven phases are preserved at
  `archive/roadmap-phases-10-20.md`.
- Recorded as `docs/adr/0002-retire-phase.md`.

### Split framework doctrine from repository instance state

**Breaking.** Separated framework doctrine from this repository's own state.

- The installer no longer copies this repository's `STATUS.md`, `ROADMAP.md`,
  `EVIDENCE.md`, `archive/`, or its own runbooks and lessons into managed
  projects. Those files described this repository's phases, tasks, and
  experiments and became false state pointers in every target.
- The framework workflow model moved from root `CONTEXT.md` to
  `docs/spec-agents/WORKFLOW.md`. The four framework protocol and runbook
  records moved into `docs/spec-agents/` as well, so `docs/protocols/`,
  `docs/runbooks/`, `docs/lessons/`, and `docs/adr/` belong entirely to the
  managed project.
- Root `CONTEXT.md` now belongs to the managed project. The installer emits an
  empty skeleton from `templates/` and never writes it again.
- `docs/` is installed through an explicit allowlist instead of directory
  enumeration, which is what leaked instance material.
- Files sourced from `templates/` are always copied, never symlinked. Under
  `--link` a state document previously pointed back into the source repository.
- `UPGRADE.md` gained a section for recognising and migrating a pre-split
  install. Nothing is deleted automatically.
- Recorded as `docs/adr/0001-framework-namespace-split.md`.

## [4.0.4] — 2026-08-17

- Added the v2/v3/v4 comparison and concise experiment conclusions to the
  English README so both language sections describe the same evidence boundary.

## [4.0.3] — 2026-08-17

- Expanded the Chinese README with an explicit v2/v3/v4 comparison and a
  concise summary of the experiment conclusions and limits.

## [4.0.2] — 2026-08-17

- Updated the Chinese README with the current v4 workflow, default context,
  research-archive boundary, and v2/v3 upgrade path.

## [4.0.1] — 2026-08-17

- Moved design research, experiment fixtures, and historical model notes under
  `research/` so the repository root remains operational.
- Kept the installer allowlist unchanged; initialized user projects do not
  receive the research archive.
- Updated experiment and evidence references to the new paths.

## [4.0.0] — 2026-08-17

SPEC-AGENTS v4 is the first release built around a stable semantic model and a
phase-local evidence loop. It keeps the durable project model small, lets the
current phase evolve, and makes semantic changes explicit before code changes.

## Why this release exists

The earlier workflow was good at recording history but expensive to carry into
every session. v4 separates what must remain stable from what is only true for
the current phase:

```text
stable concepts and boundaries + current state + verified evidence
```

The six actions are:

```text
plan → capture → arrange → do → check → learn
```

The framework is allowed to evolve, but a change to a concept, relation,
lifecycle, invariant, Action Contract, or acceptance rule must pass through
`plan`. Evidence can revise a local plan; it cannot silently rewrite the
long-term model.

## What changed

- Added the recognizable root layout: `AGENTS.md`, `CONTEXT.md`,
  `ROADMAP.md`, `STATUS.md`, `EVIDENCE.md`, `docs/`, `archive/`, and six
  action skills.
- Added `UPGRADE.md` for user-confirmed v2/v3 project migration. The installer
  preserves old material and does not attempt semantic conversion.
- Simplified the CLI to modern `init` and `install`; the old `upgrade` command
  and permanent `--legacy` mode are intentionally not supported.
- Added Action Contracts, optional Evidence IDs, and typed ontology vocabulary
  to keep architecture, state, verification, and code traceable without
  introducing a graph platform.
- Kept historical `.phrase/` material available for explicit migration or
  regression work, outside the default context.

## Experiment record

The repository records **9 v3/v4 and Kernel protocol phases** (Phases 1–9 in
the legacy research roadmap), plus **2 focused pilots** added during the v4
design: a JSONL evidence-ledger pilot and a typed ontology graph-projection
pilot. These are 11 documented experimental rounds, not 11 independent
statistical samples; several contain control/treatment arms or repeat runs.

### Results in one view

| Round | Result | What it established |
| --- | --- | --- |
| Initial v3/v4 Pomodoro comparison | v3 was more correct in the single sample; v4 classified knowledge more clearly but did not bootstrap a static model | A living workflow needs an explicit first Kernel gate |
| Phases 1–4: bootstrap and execution repeats | Several runs were inconclusive because of liveness, handoff, or implementation artifacts | Do not infer model quality from an invalid or recovered treatment run |
| Phase 5: independent A/B | Both arms passed the same room matrix; `n=1` per arm | Retain the bounded Kernel hypothesis, make no causal quality claim |
| Phase 6: compatible requirement delta | Both arms passed R1–R13 | Promote the bounded `Kernel → State → Evidence → Code` traceability protocol |
| Phase 7: invariant conflict | Treatment rejected the incompatible deletion proposal and left code unchanged | A durable invariant needs an explicit `reject` path |
| Phase 8: compatible revision | Treatment recorded `revise`, preserved cancellation data, and passed R1–R13 | A revision must name one compatible alternative and preserve the data contract |
| Phase 9: cross-domain Pomodoro revision | Treatment preserved completion semantics while adding a focus-session count | The bounded `revise` rule transfers to a second domain/change type; still not general proof |
| JSONL ledger pilot | IDs, streams, selection, and supersession worked; JSONL did not reduce fixture bytes or rough tokens | Keep Markdown for stable documents; consider JSONL only for a future high-cardinality dynamic ledger |
| Ontology graph projection pilot | Typed relations, action/lifecycle gates, impact traversal, provenance, and rejected edges worked in memory | Define ontology semantics before choosing a graph database; do not add one yet |

Detailed primary records live under [`research/experiments/`](research/experiments/), including
the [JSONL results](research/experiments/jsonl-evidence-pilot/RESULTS.md) and [ontology
graph results](research/experiments/ontology-graph-pilot/RESULTS.md).

## Benefits

- **Lower default context cost.** The agent starts with the four root state
  documents and reads evidence, protocols, and archive material only when the
  current decision needs them. The historical v2/v3 comparison benchmark
  measured 51.7% fewer estimated read tokens; that benchmark is a reference
  point, not a claim about v4 model intelligence.
- **Static abstraction survives dynamic work.** Concepts, relations,
  invariants, and Action Contracts have a durable home; phase-local facts stay
  local until `learn` proves they should be promoted.
- **Semantic drift becomes visible.** `reject` and `revise` prevent a ticket or
  implementation from silently redefining a durable invariant.
- **Migration preserves project cognition.** v2/v3 material remains recoverable
  while an Agent reconstructs history and architecture and waits for user
  confirmation before cutover.
- **Ontology stays useful without premature infrastructure.** The release
  treats the ontology as typed semantics and provenance first; Markdown remains
  the human-reviewed source and graph storage remains a future projection.

## Limits and honest claims

- The experiments are bounded, mostly `n=1` per arm, and are designed to find
  protocol failures—not to prove that one model or workflow is universally
  better.
- The release does not include a formal RDF/OWL/SHACL stack, a graph database,
  JSONL as a canonical ledger, automatic migration, or runtime authorization.
- The next evidence-worthy step is a real v2/v3 upgrade review or a concrete
  impact-analysis question, not more infrastructure for its own sake.

## Verification

The release gate includes shell syntax, CLI help, six-skill metadata and
discovery checks, temporary installer fixtures, the protocol-cost comparison,
the JSONL pilot, the ontology graph pilot, and `git diff --check`.
