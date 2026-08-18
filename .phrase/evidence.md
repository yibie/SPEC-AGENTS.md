# Evidence

Record only evidence that can change future planning or durable decisions.

## Template

### YYYY-MM-DD: <topic>

**Observation**:

- What was directly observed.

**Interpretation**:

- What the observation likely means.

**Verification**:

- Test, trace, benchmark, audit, manual check, or other proof.

**Remaining Blockers**:

- What still prevents completion.

**Recommended Next Action**:

- What the next phase or task should do.

### 2026-08-15: Palantir Ontology methodology discovery

**Observation**:

- Palantir's current official documentation defines the Ontology around the
  fourfold integration of data, logic, action, and security, implemented as a
  Language, Engine, and Toolchain rather than as a thin semantic layer.
- Its published use-case method starts from measurable user decisions, then
  derives an object model, action lifecycle, enrichments, and interfaces.
- Actions are governed operations whose context can be captured as data for
  later analysis and learning.

**Interpretation**:

- A knowledge graph represents only the semantic projection of Palantir's
  method. The closest fit for SPEC-AGENTS is a decision-ontology overlay, not a
  graph store or a source-code taxonomy.
- SPEC-AGENTS already has decision logic and compressed decision memory in its
  phase gates and evidence deltas. Its main gaps are explicit
  actor/decision/input/action modeling and action-level security boundaries.

**Verification**:

- Compared current Palantir primary documentation on Ontology architecture,
  design, use-case lifecycle, Actions, action logs, and change governance with
  the W3C OWL overview and the current SPEC-AGENTS v3 system model.
- Claims, source links, evidence limits, and the proposed mapping are recorded
  in `PALANTIR_ONTOLOGY_METHOD.md`.

**Remaining Blockers**:

- The primary user and highest-cost SPEC ambiguity have not yet been selected.
- No real phase has tested whether the proposed decision contract reduces
  ambiguity more than it adds maintenance cost.
- Palantir's official materials do not independently validate claimed business
  outcomes.

**Recommended Next Action**:

- Prototype the decision-ontology overlay on the existing `/start-phase`
  workflow without adding a new default-read file, then keep or reject it from
  observed ambiguity and protocol-cost evidence.

### 2026-08-15: Static and dynamic SPEC integration thought experiment

**Observation**:

- The user clarified that evidence-driven evolution alone is insufficient: a
  living SPEC must also accumulate stable abstractions, large principles, and
  an architecture framework that can change only through an explicit process.
- A throwaway state-model prototype exercised four candidates: dynamic-first
  v3, a phase-local Decision Overlay, a two-layer living ontology, and a fully
  machine-readable ontology registry.
- The prototype separated repeated evidence, a single outlier, implementation
  refactoring, and unsupported model changes. Repeated evidence promoted a
  verified invariant from version 1 to version 2; an outlier stayed local;
  implementation revisions did not change the ontology version; and a model
  change without evidence was rejected.

**Interpretation**:

- The Decision Overlay is useful as an input format but does not solve
  cross-phase abstraction by itself.
- The best current fit is a `2 + 1` model: a stable, versioned ontology kernel;
  dynamic operational facts and evidence; and an explicit evolution bridge of
  `Evidence -> Ontology Delta -> Impact Check -> Gate -> Promote or Reject`.
- "Stable" is more accurate than "static": the kernel is deliberately slow to
  change, not immutable. A fully machine-readable registry is premature until
  repeated maintenance or consistency failures justify its tooling cost.

**Verification**:

- `SPEC_ONTOLOGY_EVOLUTION_PROTOTYPE.html` contains a pure reducer plus guided
  walkthroughs for the three discriminating scenarios.
- Browser evaluation confirmed all four state checks, the guided-step wiring,
  semantic controls, and an empty warning/error console after reload.

**Remaining Blockers**:

- This is a thought experiment, not evidence from a real software delivery
  phase.
- The minimum ontology kernel vocabulary and its placement in the existing
  default-read path remain undecided.
- The promotion and impact-check contract has not yet been exercised against a
  real architecture change.

**Recommended Next Action**:

- Apply the `2 + 1` model to one real `/start-phase` decision and compare it
  with current v3 on abstraction reuse, ambiguity, context cost, and change
  traceability before updating durable protocol files.

### 2026-08-15: v4 may redesign the document model from first principles

**Observation**:

- The user explicitly removed compatibility with the current v3 document
  structure as a design constraint for the next SPEC-AGENTS version.
- The existing structure remains useful migration input, but the new design may
  choose its own logical and physical boundaries.

**Interpretation**:

- The next version should define Living SPEC semantics before choosing files:
  an ontology kernel, operational state, and a controlled evolution protocol.
- Markdown files should be replaceable storage adapters and context views, not
  the architecture's source of truth by virtue of their filenames.

**Recommended Next Action**:

- Review `SPEC_AGENTS_V4_LIVING_ONTOLOGY.md`, then exercise its first validation
  gate on one real phase before replacing the current `AGENTS.md` entry point.

### 2026-08-15: v3 / v4 Pomodoro worktree comparison

**Observation**:

- Two `gpt-5.6-luna` agents received the same base commit, product brief,
  implementation constraints, and validation request in isolated worktrees;
  only the working protocol differed.
- After a shared large-patch execution failure was controlled by splitting the
  patch, both agents produced dependency-free Pomodoro and task-list apps.
- Browser checks passed mode switching, task add/edit/complete/select/delete,
  confirmation, persistence, and responsive rendering in both implementations.
- The v4 implementation failed the pause contract: pausing restored the full
  duration and retained a running status. Completion also immediately rendered
  the full duration. The v3 implementation preserved paused time but exposed a
  stale accessible timer label and a restart-after-completion edge case.
- v3 destructively shortened existing current/evidence files and did not load
  the required default `.phrase` context according to its own self-report. v4
  separated Adapter, State, and Evidence, but created no Kernel or Contract.
- Both agents initially treated JavaScript syntax validation as sufficient;
  external behavioral verification was required to expose timer defects.

**Interpretation**:

- A single run does not establish that v3 produces better code. It does show
  that neither protocol, as exercised, guaranteed behavioral verification.
- v4's categories improved document separation but did not ensure static
  abstraction. The draft specifies Kernel evolution more clearly than Kernel
  bootstrap, allowing a new project to classify all product semantics as local
  implementation detail.
- The missing pause invariant and the v4 pause defect are correlated evidence,
  not proof of causality.

**Verification**:

- `POMODORO_V3_V4_EXPERIMENT.md` records the controlled conditions, browser
  behavior matrix, protocol artifacts, limitations, and candidate v4 Delta.
- Both `pomodoro/app.js` files pass `node --check`.
- Real Chromium checks used the same add/edit/complete/select/reload/delete,
  mode-switch, pause, completion, and mobile-viewport flows on both apps.

**Remaining Blockers**:

- The sample size is one implementation per protocol.
- The shared initial patch interruption and subsequent recovery prompt make
  elapsed time and token use invalid comparison metrics.
- No repeat has yet tested whether a Kernel Bootstrap Gate prevents the timer
  contract failures without imposing disproportionate context cost.

**Recommended Next Action**:

- Add a minimal Kernel Bootstrap Gate and contract-based behavioral verification
  to the v4 draft, then rerun v4 with a fresh Luna before promoting the change
  or replacing the current entry point.

### 2026-08-15: v4 Kernel Bootstrap repeat

**Observation**:

- A fresh `gpt-5.6-luna` created K1 and current State before any application
  file in a new worktree from the same base commit.
- The first K1 draft expanded persistence beyond the user scope, did not require
  resume from saved remaining time, and did not require the ended `00:00` state
  to remain visible. Bootstrap was held open until those defects were corrected.
- Only after K1 passed did Luna implement the application. Static checks were
  recorded as insufficient and the State remained open for external behavior
  verification.
- Real Chromium then passed all timer lifecycle, task CRUD/current selection,
  reload persistence, text-safety, dialog, keyboard, and mobile-layout checks.
  The pause and finish failures from the first v4 run did not recur.
- K1 costs 46 lines / 3,243 bytes; all three `.spec` files cost 99 lines / 7,011
  bytes, about 6.3 KB more than the first v4 protocol artifacts.
- Playwright blocked `file://`; two separate headless Chrome direct-file checks
  hung. The result therefore claims local static-server behavior plus absence of
  external dependencies, not separately proven direct-file opening.

**Interpretation**:

- The Delta is verified for the observed failure mode: it forced stable semantics
  to exist before code and exposed the exact missing contracts while changes were
  still cheap.
- This is not causal or general proof. The gate reviewer knew the prior defects,
  and the sample remains one application with one fresh implementation agent.
- The context increase is measurable and still small in absolute size, but its
  value must be tested in another domain rather than assumed.

**Verification**:

- Worktree sequencing showed `.spec/kernel.md` and `.spec/state.md` before
  `pomodoro/` existed.
- `.spec/evidence.md` maps external results to K1 Action Contracts;
  `node --check pomodoro/app.js` passes.
- `POMODORO_V3_V4_EXPERIMENT.md` contains the first-run/repeat behavior matrix,
  cost, limitations, and Delta decision.

**Remaining Blockers**:

- No blind cross-domain repeat has tested general effectiveness.
- The full v4 entry-point gate also requires evidence for real Kernel evolution,
  migration, and rejection paths; this repeat covers Bootstrap and verification.

**Recommended Next Action**:

- Retain the Delta in the v4 draft and run a pre-registered, cross-domain blind
  validation before replacing the current `AGENTS.md`.

### 2026-08-15: meeting-room reservation A/B repeat

**Observation**:

- The fixed Brief and R1–R12 matrix were created before implementation. Two
  isolated worktrees used the same base commit and fresh Luna control/treatment
  setup.
- Control implemented without K1 or pre-code Contracts. Treatment created K1
  before application files; an initial 177-line snapshot was rejected as too
  thick, then a 78-line / 4,819-byte K1 passed after removing implementation
  actions and duplicate Brief prose.
- Treatment's implementation Luna failed to land application files after two
  recovery prompts. Root created the treatment implementation from the audited
  K1, and the deviation is recorded in the worktree Evidence.
- Real Chromium ran R1–R12 against both pages. Treatment passed all scenarios;
  control passed the domain lifecycle checks but left its empty-state card
  visible after a valid record was added (`hidden: true`, computed `display:
  grid`).
- Control `.spec` cost 43 lines / 2,973 bytes; treatment `.spec` cost 184
  lines / 9,657 bytes. Both scripts passed `node --check`; neither app made
  external requests or used unsafe HTML injection.

**Interpretation**:

- K1 successfully forced relation, lifecycle, and time-boundary semantics to be
  explicit before treatment implementation, and the treatment behavior was
  complete under the fixed matrix.
- The result is not causal evidence: treatment code was written by root after
  the Luna implementation handoff failed, while control code was written by
  Luna. The control empty-state miss is useful failure evidence but cannot be
  attributed to Bootstrap.
- The Bootstrap Delta remains promising but this phase must revise its execution
  protocol before promotion. The added static context is measurable and should
  stay scoped to current behavior.

**Verification**:

- Browser results and the control/treatment deviations are recorded in
  `MEETING_ROOM_V4_EXPERIMENT.md`.
- Treatment `.spec/kernel.md` existed before any app file and passed the root
  Bootstrap audit; both worktrees have static and browser Evidence.
- Playwright sessions were closed, local servers stopped, and artifacts moved
  to `/private/tmp/spec-agents-room-v4-playwright-artifacts-20260815`.

**Remaining Blockers**:

- No pure fresh-Luna treatment sample completed the full K1-to-code path.
- One A/B run cannot establish cross-domain effectiveness or justify replacing
  `AGENTS.md`.

**Recommended Next Action**:

- Mark this repeat `revise / inconclusive`; rerun a treatment where the same Luna
  demonstrably implements after the Gate, then test Kernel v2 evolution only if
  the end-to-end Bootstrap result is valid.

### 2026-08-15: Phase 3 pure treatment execution-reliability repeat

**Observation**:

- Two sequential fresh `gpt-5.6-luna` treatment attempts were given the same
  stage-1 instruction in `/private/tmp/spec-agents-room-v4-bootstrap-repeat`:
  read the fixed Brief/protocol, create `.spec/kernel.md` and `.spec/state.md`,
  then stop before application code.
- Neither attempt created K1, State, application files, tests, or commits. Both
  remained active through bounded status windows without a report and were
  interrupted. The worktree still contains only the copied Brief and treatment
  protocol; root made no code recovery.

**Interpretation**:

- The phase did not reach the Bootstrap Gate, so it provides no new evidence
  about K1 quality, same-Luna implementation, static behavior, or R1–R12.
- Repeated non-start is execution-reliability evidence for the current
  treatment handoff, not evidence that Bootstrap improves or harms the app.
  The Delta remains `revise / inconclusive` and must not be promoted.

**Verification**:

- `git status --short` and a `.spec` file scan after each attempt showed no K1,
  State, app, or test artifacts.
- No root implementation or AGENTS.md change was made; no browser server or
  Playwright session was started for this invalid run.

**Remaining Blockers**:

- A valid treatment sample still requires one fresh Luna to complete the
  K1-to-code handoff without root recovery.
- The current protocol has no proven liveness/handshake mechanism for the
  pre-code stage; changing that mechanism is required before another costly
  browser comparison.

**Recommended Next Action**:

- Keep the Kernel Bootstrap direction, but revise the treatment handoff with a
  finite liveness checkpoint and an explicit artifact acknowledgement before
  starting another domain or Kernel-v2 experiment.

### 2026-08-15: Phase 4 direct-directory Luna reproducibility run

**Observation**:

- A new experiment directory was created inside the repository at
  `experiments/room-v4-direct-repro/`, with a fixed Brief and independent
  `control/` and `treatment/` sandboxes.
- The control Luna landed `index.html`, `styles.css`, `app.js`, and evidence;
  `node --check` passed. The treatment Luna landed K1/State before its three
  application files, passed `node --check`, and wrote treatment Evidence.
- The treatment thread had to be reused from the previous no-artifact Luna
  thread because the collaboration slot limit prevented a third fresh thread;
  it had never written files before this run. This is a protocol deviation.
- Real Chromium control verification passed R1–R12. Treatment R1 passed, but a
  valid R2 submit persisted a record and then threw `TypeError: form.reset is not
  a function`; the `id="reset"` button shadows the native form method. The
  treatment record was not rendered in the same submit. An extra duplicate
  `experiments/room-v4-direct-repro/styles.css` also appeared outside its
  assigned sandbox.

**Interpretation**:

- Direct repository directories removed the previous complete non-start: both
  Luna runs produced inspectable artifacts. The treatment implementation still
  failed its first runtime contract, so the direct run is not a valid positive
  Bootstrap sample.
- The control/treatment behavior cannot be attributed causally to Bootstrap:
  the runs were different implementations, the treatment thread was reused,
  and treatment failed before R3–R12. The result is `revise / inconclusive`.

**Verification**:

- Static checks and forbidden-API scans passed for both apps.
- `experiments/room-v4-direct-repro/control/evidence.md` records Chromium
  R1–R12 pass results; `treatment/.spec/evidence.md` records the R1 pass, R2
  TypeError, console output, and skipped remaining scenarios.
- The complete run summary is in `experiments/room-v4-direct-repro/RESULTS.md`.

**Remaining Blockers**:

- Treatment needs a new implementation run that removes the `form.reset`
  shadowing bug without root recovery before another comparison is meaningful.
- A fresh, independent treatment thread is still preferred for causal testing;
  the current agent-slot reuse must not be hidden in future cost comparisons.

**Recommended Next Action**:

- Keep the direct-directory fixture as the reproducibility harness. Run one
  fresh treatment correction/verification in its own slot, then rerun the full
  R1–R12 matrix; do not promote Bootstrap or start Kernel-v2 yet.

### 2026-08-16: Phase 5 independent A/B and Ontology/SPEC fusion

**Observation**:

- A new fixed Brief/protocol in `experiments/room-v4-independent-ab/` was
  supplied to two fresh `gpt-5.6-luna` agents in separate sandboxes. Control
  implemented directly; treatment created and self-audited `.spec/kernel.md`
  and `.spec/state.md` before any application file.
- Neither agent edited root files, `AGENTS.md`, the Brief, the other sandbox,
  or old experiments. No root recovery, dependency, server, schema, graph,
  generator, or commit was used.
- Both apps passed `node --check` and the forbidden-API scan. Fresh Chromium
  sessions passed all fixed R1–R12 scenarios, including atomic edit conflict,
  cancellation release/reuse, reload, literal text safety, keyboard focus,
  and 390×844 horizontal-overflow checks.
- Each final run had four records, one cancelled record, and a literal
  `<b>x</b>` topic rendered as text. Console output contained only the
  expected missing `/favicon.ico` 404 from the static server.
- Control app cost 3 files / 10,541 bytes. Treatment app cost 3 files /
  11,667 bytes; K1/State/evidence added 4,306 bytes after runtime evidence.
- The first exploratory browser assertions mismatched UI wording/case in a
  few checks; a normalized rerun passed without changing either app. This is a
  harness deviation, not an implementation repair.

**Interpretation**:

- This is the first valid independent reproducibility sample, not causal
  evidence of treatment benefit: `n=1` per arm and both arms passed the same
  gate. It supports keeping the experiment alive, not replacing `AGENTS.md`.
- The small K1 was cheap enough to add and gave the treatment a stable domain
  vocabulary, relations, invariants, and action-to-R-id checklist. The useful
  fusion is therefore a protocol bridge, not a graph platform: Kernel names
  the semantic contract, State records the current run/next permission,
  Evidence points to proofs, and Evolution turns new evidence into an
  explicit `promote | revise | reject` decision.
- Palantir/W3C research supports separating semantic objects/relations from
  actions and validation reports, but does not justify RDF/OWL/SHACL files,
  graph storage, code generation, or runtime authorization for this fixture.
  The full mapping and primary sources are in
  `ONTOLOGY_SPEC_FUSION_RESEARCH.md`.

**Verification**:

- `experiments/room-v4-independent-ab/RESULTS.md` records freshness,
  sequencing, cost, static checks, browser results, limitations, and the next
  experiment. Control and treatment evidence record the complete runtime
  matrix; browser artifacts were moved to
  `/private/tmp/spec-agents-room-v4-independent-ab-playwright-artifacts-20260816`.
- No durable rule changed, so `AGENTS.md` remains untouched. `.phrase/current.md`
  and `.phrase/roadmap.md` now close Phase 5 and keep the result explicitly
  non-causal.

**Remaining Blockers**:

- No controlled Brief-delta run has tested whether Kernel/State/Evidence helps
  an evolving requirement rather than a fixed first implementation.
- No evidence yet covers Kernel revision/rejection, migration, provenance, or
  production permissions; those remain future gates, not implied features.

**Recommended Next Action**:

- Run one small Phase 6 change experiment: keep the original R1–R12 gate, add a
  pre-registered Brief delta, require the six-field Kernel/action-contract
  acknowledgement before implementation, and record whether the delta is
  promoted, revised, or rejected with its evidence pointer. Do not build
  Kernel-v2 or ontology infrastructure before that result.

### 2026-08-16: Phase 6 controlled requirement delta

**Observation**:

- A new change fixture copied the Phase 5 meeting-room apps. D1 added one rule:
  every active reservation is at most two hours; create and edit must reject
  `09:00–11:01` without mutation. R1–R12 stayed unchanged and R13 covered
  both actions.
- Control changed its copied app directly. Treatment first updated Kernel with
  the duration invariant and affected create/edit contracts, updated State with
  the change gate, and recorded an Evidence checkpoint; only then did it edit
  the app. The treatment report and Kernel/State modification order agree;
  final Evidence was appended after the app edit, so its final mtime is not
  treated as independent ordering proof.
- Both apps passed `node --check` and the forbidden-API scan. Fresh Chromium
  sessions passed R1–R13. R13 rejected the over-two-hour create with no new
  record and rejected the over-two-hour edit while preserving the original
  record. The only console noise was each static server's `/favicon.ico` 404.
- Control application files total 10,840 bytes. Treatment application files
  total 11,952 bytes; treatment K1/State/Evidence total 5,973 bytes.
- The first R13 assertion omitted `await` on the post-edit record count and
  reported a false negative. A normalized rerun passed without changing either
  app; this is recorded as a harness deviation.

**Interpretation**:

- The shared change boundary is the important result: both implementations put
  D1 in the validation path used by create and edit, preserving atomicity and
  old overlap/adjacency behavior.
- The treatment shows the proposed ontology/SPEC fusion can express a change
  as an entity invariant plus affected action contracts, then carry that
  decision through State and Evidence. Promote this as a bounded protocol for
  traceability, not as evidence that treatment writes better code: `n=1` per
  arm and both arms passed.
- No formal ontology tool, graph, generator, or `AGENTS.md` replacement is
  justified by this result.

**Verification**:

- `experiments/room-v4-change-delta/RESULTS.md` records the fixed delta,
  ordering, costs, static/browser results, deviation, and decision. The
  browser artifacts were moved to
  `/private/tmp/spec-agents-room-v4-change-delta-playwright-artifacts-20260816`.
- `.phrase/current.md`, `.phrase/roadmap.md`, and this evidence entry close
  Phase 6. `.phrase/decision.md` records the newly promoted bounded protocol;
  `AGENTS.md` remains untouched.

**Remaining Blockers**:

- No conflicting delta has tested the `revise`/`reject` paths; current evidence
  covers only a compatible additive invariant.
- Treatment ordering is agent-attested and textually recorded, but not backed
  by an immutable checkpoint artifact; a later phase may test that if needed.

**Recommended Next Action**:

- Run one rejection-path experiment: propose a delta that conflicts with a
  durable invariant, require the Kernel/State/Evidence bridge to classify it as
  `revise` or `reject`, and verify that neither app silently changes the old
  contract. Do not add ontology infrastructure before that test.

### 2026-08-16: Phase 7 rejection-path conflict review

**Observation**:

- D2 proposed permanently deleting a reservation after confirmed cancellation.
  The fixed baseline requires the cancelled record to remain visible and
  survive reload (R8/R10).
- Control applied D2 directly. Its focused Chromium run confirmed the record
  disappeared after confirmation, the slot became reusable, and reload did not
  restore the cancelled record. The first contradiction was R8; R10 repeated
  it after reload.
- Treatment compared D2 with the copied Kernel/State before any app edit,
  recorded `decision: reject`, mapped the conflict to R8/R10, and left all
  application files byte-for-byte identical to the Phase 5 baseline. Its
  unchanged app passed the full baseline R1–R12 Chromium matrix.
- Both static checks passed. Console output contained only the expected
  missing `/favicon.ico` 404. Control app files total 10,615 bytes; treatment
  app files total 11,667 bytes, with 3,072 bytes of new State/Evidence review.

**Interpretation**:

- The rejection gate prevented a conflicting proposal from silently rewriting
  a durable lifecycle invariant. The important difference is not that control
  failed a generic test; it intentionally demonstrated the consequence of
  direct implementation, while treatment preserved the old contract.
- Promote the rejection gate narrowly: Kernel conflict → State decision →
  Evidence mapping must precede app edits. This validates one scenario and is
  not general proof of model behavior.
- No formal ontology tool, graph, generator, migration, or `AGENTS.md`
  replacement is justified.

**Verification**:

- `experiments/room-v4-rejection-delta/RESULTS.md` records D2, the control
  contradiction, treatment `reject`, app preservation, costs, and next test.
  Browser artifacts were moved to
  `/private/tmp/spec-agents-room-v4-rejection-delta-playwright-artifacts-20260816`.
- `.phrase/current.md`, `.phrase/roadmap.md`, and this entry close Phase 7;
  `.phrase/decision.md` records the rejection boundary. `AGENTS.md` remains
  untouched.

**Remaining Blockers**:

- The compatible `revise` path has not been tested; this run only covers
  `reject`.
- The sample is one conflict scenario and does not establish general agent
  behavior or causal treatment superiority.

**Recommended Next Action**:

- Test one compatible `revise` path, such as retaining the cancelled record
  while adding an archive view. Require the revised contract to be explicit in
  Kernel/State/Evidence before implementation, and preserve R1–R12.

### 2026-08-16: Phase 8 compatible revision path

**Observation**:

- D2 again proposed permanent deletion after cancellation. D3 was fixed before
  implementation as a compatible revision: retain cancelled records and add a
  presentation-only `#archive-toggle` with R13 hide/show behavior.
- Control applied D2 directly. The focused browser check exposed the baseline
  contradiction at R8 and again at R10 after reload.
- Treatment recorded `decision: revise`, mapped D2 to K1/R8/R10 and D3 to R13,
  then implemented the archive view. It passed the full R1–R13 Chromium
  matrix; R8/R10 remained intact, and R13 hid/restored cancelled records while
  active records stayed visible and stored data remained unchanged.
- The initial D3 wording inverted the default button label/state flag. Before
  runtime, the Brief/Protocol and treatment state were corrected to the
  baseline-compatible all-visible default (`Hide archived`/`true`). The
  correction is recorded in treatment Evidence and does not change D3's data
  boundary.
- Both static checks passed. Control application files total 10,516 bytes;
  treatment application files total 12,186 bytes, with 5,976 bytes of
  Kernel/State/Evidence. Console output contained only the expected
  `/favicon.ico` 404.

**Interpretation**:

- The revise path works when it is concrete and bounded: it converts a
  conflicting deletion proposal into a compatible presentation feature without
  weakening the lifecycle or persistence invariant.
- Promote the revise gate narrowly: conflict → one named alternative → updated
  Kernel/State/Evidence → implementation → unchanged baseline proof. This is
  not general causal evidence or permission to invent feature bundles.
- No formal ontology tool, graph, generator, migration, or `AGENTS.md`
  replacement is justified.

**Verification**:

- `experiments/room-v4-revise-delta/RESULTS.md` records D2/D3, the control
  contradiction, treatment `revise`, R1–R13, costs, and polarity deviation.
  Browser artifacts were moved to
  `/private/tmp/spec-agents-room-v4-revise-delta-playwright-artifacts-20260816`.
- `.phrase/current.md`, `.phrase/roadmap.md`, and this entry close Phase 8;
  `.phrase/decision.md` records the compatible-alternative boundary.
  `AGENTS.md` remains untouched.

**Remaining Blockers**:

- Only one compatible revise scenario has been tested; no sample-size or
  generalization claim is warranted.
- The protocol still relies on agent-attested pre-edit checkpoints rather than
  an immutable handoff artifact; adding one is not necessary for this phase.

**Recommended Next Action**:

- Keep the current bounded fusion protocol as the experimental default. If more
  evidence is needed, run a second domain or a second compatible revision; do
  not add ontology infrastructure or broaden the Kernel document until a
  materially different failure mode appears.

### 2026-08-16: Phase 9 cross-domain Pomodoro revision

**Observation**:

- The fixed Pomodoro baseline defined user-controlled task completion and
  runtime-only timer/mode state. D4 proposed auto-completing the selected task
  when focus ended; D5 proposed a persisted per-task `focusSessions` count
  while preserving completion semantics.
- Control applied D4 directly. A controlled-clock Chromium run reached
  `00:00`/`已结束` and persisted `completed: true`; the first contradiction was
  R6.
- Treatment recorded `decision: revise`, added the K1-D5 concept/invariant/
  action contract, and wrote State/Evidence before its app edit. It passed the
  baseline timer/task checks and R13: one focus finish produced count 1,
  retained `completed: false`, survived reload, and a short break did not
  increment the count.
- Static syntax and forbidden-API scans passed in both arms. No JavaScript
  console errors occurred; only local resources and an optional favicon 404
  were observed. Treatment application files total 12,190 bytes; its
  Kernel/State/Evidence total 7,142 bytes.

**Interpretation**:

- The bounded revise rule transfers to a different domain and a different
  change type: a persistent domain-state extension rather than a presentation
  filter. The useful abstraction remains a compact semantic Kernel plus a
  phase-local State/Evidence transition, not a second requirements archive.
- Promote the cross-domain result narrowly. It is not causal or general proof,
  and it does not justify graph/schema/generator infrastructure.

**Verification**:

- `experiments/pomodoro-v4-cross-domain/RESULTS.md` records D4/D5, the R6
  contradiction, treatment ordering, R1–R13 results, cost, and browser
  artifacts. Artifacts are under
  `/private/tmp/spec-agents-pomodoro-v4-cross-domain-playwright-artifacts-20260816`
  and its `-extra2` follow-up; the legacy-task check is under the matching
  `-legacy` path.
- `.phrase/current.md`, `.phrase/roadmap.md`, and this entry close Phase 9;
  no durable rule was changed in `.phrase/decision.md`; `AGENTS.md` remains
  untouched.

**Remaining Blockers**:

- This is one cross-domain revision in addition to the meeting-room sample;
  no sample-size or model-generalization claim is warranted.
- The pointer-based skip-link check was not accepted because the link is
  intentionally visually hidden; no screen-reader audit was claimed.

**Recommended Next Action**:

- Keep the current bounded fusion protocol. Do not start a third domain or
  formal ontology tooling unless a materially different failure mode appears.

### 2026-08-16: Plan-before-doing gate

**Observation**:

- Replaced the local `should-we-change` skill with
  `skills/plan-before-doing/SKILL.md`.
- The skill now follows the current `grilling` design-tree/frontier loop,
  separates repository facts from user decisions, and routes confirmed changes
  through the bounded Kernel → State → Evidence → Code → Verify protocol.

**Interpretation**:

- The human-facing name makes the gate's purpose clearer without adding a
  second requirements document or changing the durable ontology rules.

**Verification**:

- `quick_validate.py skills/plan-before-doing` passed; no application code or
  Kernel artifacts changed.

**Recommended Next Action**:

- Use `plan-before-doing` for the next proposed ontology or semantic change and
  observe whether the confirmation gate exposes an unnecessary change before
  implementation.
