# Roadmap

## Goal

Keep long-term direction visible at phase granularity while letting short-term
implementation follow evidence.

## Planning Rule

Roadmap entries describe phase direction, entry conditions, acceptance gates,
and major out-of-scope boundaries. Detailed implementation tasks belong only in
`.phrase/current.md`.

## Phases

### Phase 1: Validate Living Ontology Bootstrap

**Status**: Complete

**Goal**: Determine whether a minimal Kernel Bootstrap Gate and contract-based verification improve v4 behavior without disproportionate context cost.

**Entry Condition**: The first v3/v4 Pomodoro comparison identified a missing Kernel bootstrap and unverified Action contracts.

**Acceptance Gate**:

- The v4 draft specifies Kernel Bootstrap and Contract verification boundaries.
- A fresh Luna creates a minimal Kernel before implementation.
- Browser Evidence covers the timer and task Action contracts.
- The result states whether to keep, revise, or reject the Delta.

**Major Out Of Scope**:

- Replacing the current `AGENTS.md`.
- Building schema, graph, generator, or validation infrastructure.
- Repeating the v3 implementation.

### Phase 2: Blind Cross-domain Validation

**Status**: Complete

**Goal**: Test whether Bootstrap improves first-pass semantics in a different bounded context when the implementer and gate reviewer do not know the expected defect.

**Entry Condition**: Phase 1 retained the Delta after correcting the observed Pomodoro failure mode.

**Acceptance Gate**:

- A new domain and behavior matrix are fixed before agent execution.
- K1 is audited before implementation without revealing seeded failure expectations.
- Contract Evidence and context cost are compared with a control or explicit baseline.
- Evidence decides whether the Delta is promoted, revised, or rejected.

**Major Out Of Scope**:

- Replacing `AGENTS.md` before the result.
- Ontology schema, graph, generator, or validator infrastructure.

### Phase 3: Valid End-to-end Bootstrap Repeat

**Status**: Complete — `revise / inconclusive`

**Goal**: Obtain one pure treatment sample in which the same fresh Luna creates K1, passes the Gate, implements, and records behavior evidence before testing Kernel evolution.

**Entry Condition**: Phase 2 retained the Delta direction but marked the meeting-room A/B repeat inconclusive because treatment implementation required root recovery.

**Acceptance Gate**:

- The treatment Luna completes the post-Gate implementation without root code recovery.
- A control or explicit baseline uses the same fixed Brief and browser matrix.
- K1/State/Evidence cost and R1–R12 results are recorded before deciding `promote`, `revise`, or `reject`.

**Major Out Of Scope**:

- Kernel v2 evolution, migration, schemas, graph, generators, or replacing `AGENTS.md`.

**Result**:

- Two bounded fresh-Luna attempts produced no K1 or application artifact, so the
  Gate and browser acceptance were not reached. Root performed no recovery.
- Before another treatment comparison, revise the handoff with a finite liveness
  checkpoint and explicit artifact acknowledgement. Do not start Kernel-v2 work.

### Phase 4: Direct-directory Luna Reproducibility

**Status**: Complete — `revise / inconclusive`

**Goal**: Determine whether two Luna runs can complete when given
independent experiment directories inside the current repository, while keeping
the fixed meeting-room Brief and treatment Bootstrap requirement.

**Entry Condition**: Phase 3 produced no treatment artifact in a temporary
worktree; the user requested a direct-directory experiment.

**Acceptance Gate**:

- `experiments/room-v4-direct-repro/` contains independent control/treatment
  sandboxes and the fixed Brief.
- Both assigned Luna runs land their implementations; treatment K1/State
  precede its app, and thread freshness is recorded as a validity condition.
- Root performs no code recovery or silent Brief/protocol edits.
- Static checks and the same R1–R12 browser matrix are recorded before deciding
  `promote`, `revise`, or `reject`.

**Major Out Of Scope**:

- Kernel v2, migration, schema/graph/generator tooling, or replacing `AGENTS.md`.

**Result**:

- Direct repository sandboxes allowed both Luna runs to land artifacts. Control
  passed R1–R12; treatment failed the first valid submit because `id="reset"`
  shadowed `form.reset()`, so no valid treatment sample exists.
- Keep the fixture, but require a fresh treatment correction and full matrix
  before promoting Bootstrap or starting Kernel-v2 work.

### Phase 5: Independent A/B and Ontology/SPEC Fusion

**Status**: Complete — retain bounded Kernel hypothesis; causal effect inconclusive

**Goal**: Obtain a clean fresh control/treatment sample using the direct-directory
fixture, while deriving a primary-source, falsifiable proposal for how Ontology
should become part of SPEC rather than another document layer.

**Entry Condition**: The corrected treatment now passes R1–R12, but the prior
direct run used a reused thread and therefore cannot serve as causal evidence.

**Acceptance Gate**:

- A new fixed Brief names the same rooms and matrix for both fresh runs.
- Treatment K1/State precede its app; both runs finish without root recovery.
- Static/browser evidence, cost, freshness, and path deviations are recorded.
- `ONTOLOGY_SPEC_FUSION_RESEARCH.md` cites primary sources, separates facts from
  mappings, rejects over-fusion, and proposes one smallest next experiment.
- No `AGENTS.md` replacement or Kernel-v2 work occurs in this phase.

**Major Out Of Scope**:

- Production ontology tooling, schema/graph/generator infrastructure, migration,
  or changing the existing control/treatment apps.

**Result**:

- Two fresh Luna agents completed the same fixed Brief in isolated direct
  directories. Treatment created and self-audited K1/State before app files;
  neither run needed root recovery.
- Static checks and real Chromium R1–R12 passed for both arms. The sample is
  valid as a reproducibility run, but `n=1` per arm with both arms passing is
  not causal evidence that K1 improves implementation.
- The ontology/SPEC proposal is retained as a bounded protocol mapping:
  Kernel = domain vocabulary/relations/invariants/action contracts, State =
  run marker and permitted next step, Evidence = verification pointers, and
  Evolution = evidence-backed promote/revise/reject. Formal RDF/OWL/SHACL,
  graph storage, generators, and production authorization remain out of scope.
- Next phase: a controlled Brief delta must test whether the mapping helps
  change handling without turning K1 into a second requirements document.

### Phase 6: Controlled Requirement Delta

**Status**: Complete — promote bounded change protocol; causal effect inconclusive

**Goal**: Test whether the proposed Kernel → State → Evidence bridge helps an
agent propagate one small requirement change across existing invariants and
actions without adding a second requirements system.

**Entry Condition**: Phase 5 produced a valid non-causal A/B sample and retained
the bounded Kernel hypothesis; the user approved one controlled delta.

**Acceptance Gate**:

- D1 (maximum two-hour reservation duration) is fixed before implementation;
  R1–R12 remain unchanged and R13 covers create plus edit rejection.
- Control changes the copied app directly. Treatment updates Kernel/State/
  Evidence before modifying its copied app.
- Static checks and real Chromium R1–R13 pass, with no mutation after a failed
  create or edit.
- Ordering, cost, first failing R-id, and any assertion normalization are
  recorded; the result chooses `promote`, `revise`, or `reject`.

**Major Out Of Scope**:

- A second delta, Kernel-v2, schema/graph/generator infrastructure, migration,
  production authorization, or replacing `AGENTS.md`.

**Result**:

- D1 was implemented in copied control/treatment sandboxes. Treatment updated
  Kernel, State, and a pre-edit Evidence checkpoint before its app edit;
  control changed the app directly.
- Both arms passed static checks and Chromium R1–R13. The new R13 rejected an
  over-two-hour create and edit without mutation, while R1–R12 remained green.
- Promote only the bounded Kernel → State → Evidence change protocol for
  traceable SPEC evolution. This does not prove treatment superiority and does
  not authorize formal ontology tooling or replacing `AGENTS.md`.
- Next phase should test a delta that conflicts with an existing invariant and
  require `revise` or `reject`, not silent overwrite.

### Phase 7: Rejection-path Conflict Review

**Status**: Complete — promote bounded rejection gate; revise path pending

**Goal**: Test whether the promoted Kernel → State → Evidence protocol prevents
silently overwriting a durable invariant when a proposed product delta
conflicts with it.

**Entry Condition**: Phase 6 promoted the bounded change protocol after a
compatible delta; the user approved a conflict review.

**Acceptance Gate**:

- D2 (permanent deletion after cancellation) is fixed and explicitly conflicts
  with baseline R8/R10.
- Control applies D2 directly and records the first contradiction.
- Treatment records `reject` or a concrete compatible `revise` before app edit;
  on reject, its app is unchanged and baseline R1–R12 pass.
- Static checks, decision, cost, ordering, and contradiction evidence exist.

**Major Out Of Scope**:

- A second conflict, migration, Kernel-v2, schema/graph/generator tooling,
  production authorization, or replacing `AGENTS.md`.

**Result**:

- D2 proposed permanent deletion after cancellation, conflicting with baseline
  R8/R10. Control applied it directly and the focused browser check exposed R8
  first, with the same contradiction after reload at R10.
- Treatment classified D2 as `reject` before app edits, preserved the Kernel
  invariant, recorded the conflict in State/Evidence, and left the copied app
  byte-for-byte unchanged. Its baseline R1–R12 matrix passed.
- Promote the bounded rejection gate. This validates one conflict scenario and
  does not claim general model behavior; next test the compatible `revise`
  path.

### Phase 8: Compatible Revision Path

**Status**: Complete — promote bounded revise path

**Goal**: Test whether a conflicting proposal can be revised into a concrete,
compatible change that preserves durable invariants and remains traceable.

**Entry Condition**: Phase 7 promoted the rejection gate; the user approved a
pre-registered archive-view revision.

**Acceptance Gate**:

- D2 deletion and D3 archive-view revision are fixed before implementation.
- Control applies D2 directly and records the R8/R10 contradiction.
- Treatment records `revise` plus D3 in Kernel/State/Evidence before app edit.
- Treatment passes unchanged R1–R12 plus R13 archive hide/show; cancellation
  data and reload behavior remain intact.
- Static checks, ordering, cost, contradiction, and decision evidence exist.

**Major Out Of Scope**:

- A second revision, migration, Kernel-v2, schema/graph/generator tooling,
  production authorization, or replacing `AGENTS.md`.

**Result**:

- D2 direct control again contradicted R8/R10. Treatment recorded `revise`
  before app edits and implemented the pre-registered D3 archive view.
- Treatment passed R1–R13. Cancelled records remained persisted and visible by
  default; the presentation-only toggle hid and restored them without mutating
  storage.
- Promote the bounded revise path. A phase-local polarity ambiguity in the
  initial toggle wording was corrected before runtime and recorded as a
  deviation; no data contract changed.
- Keep the rule narrow: future revisions must name one compatible alternative
  and preserve durable invariants.

### Phase 9: Cross-domain Pomodoro Revision

**Status**: Complete — promote bounded cross-domain revise path

**Goal**: Test whether the Kernel → State → Evidence → Code rule transfers from
the meeting-room presentation revision to a Pomodoro timer/task state change.

**Entry Condition**: Phase 8 validated one compatible `revise` path and left a
cross-domain, different-change-type check as the next evidence question.

**Acceptance Gate**:

- D4 (auto-complete current task at focus finish) and D5 (persist a focus
  session count without changing completion) are fixed before implementation.
- Control applies D4 directly and records the first R6 contradiction.
- Treatment records `revise` plus D5 in Kernel/State/Evidence before app edit.
- Treatment preserves R1–R12 and passes R13 with focus-only increment,
  persistence, and runtime-only timer state.
- Static checks, ordering, cost, browser limitation, and decision evidence
  exist.

**Major Out Of Scope**:

- A third domain, a second Pomodoro delta, Kernel-v2, schema/graph/generator
  tooling, production authorization, or replacing `AGENTS.md`.

**Result**:

- Control's direct D4 made the selected task complete at focus finish,
  contradicting R6.
- Treatment classified D4 as `revise`, added the K1-D5 focus-session contract
  before app edits, and passed the baseline timer/task smoke matrix plus R13.
  One focus finish persisted `focusSessions: 1`, left `completed: false`, and
  a short break did not increment it.
- Promote the bounded revise rule across this second domain and change type.
  This remains a small non-causal sample; no ontology infrastructure is
  justified.
