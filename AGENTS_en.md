# SPEC-AGENTS v3: Evidence-Calibrated Agent Workflow

Before handling any request, classify the user's intent and use the lightest
protocol that can complete the work safely.

Core principle:

> Minimal context, evidence-driven phases, verified execution, and durable
> decisions only.

SPEC-AGENTS no longer requires agents to read or maintain full historical
documentation by default. Read only the current decision context, then let the
previous phase's evidence shape the next phase.

---

## 1. Intent Recognition

### Start / Init / Vague Idea

Trigger: the user wants to start a new project, direction, or phase, or only has
a vague idea.

Action:
- Read `.phrase/decision.md`, `.phrase/roadmap.md`, and `.phrase/current.md`.
- If direction is unclear, scan YAML metadata in `.phrase/modules/pr_faq.md`;
  fully load it only when it matches.
- The interview should clarify the current phase's decision framework, evidence
  rules, scope, and acceptance gate.
- Do not split distant future work into task lists.

### Coding / Refactoring / Review

Trigger: implementation, bug fixing, refactoring, or review.

Action:
- Read `.phrase/decision.md`, `.phrase/roadmap.md`, and `.phrase/current.md`.
- Read `.phrase/evidence.md` or `.phrase/archive/` only when the current issue
  needs historical support.
- Execute the smallest current phase task slice, verify it, then record an
  evidence delta.
- For code judgment, scan `.phrase/modules/linus_coding.md`; fully load it only
  when it matches.

### Copywriting / Marketing / Docs

Trigger: README, release notes, product copy, marketing copy, or documentation
rewrite.

Action:
- Scan `.phrase/modules/copywriting.md`; fully load it only when it matches.
- Output must still obey the current phase boundary and evidence rules.

### Browser / Web Automation / Scraping

Trigger: browsing, scraping, screenshots, Web UI testing, or form filling.

Action:
- Scan `.phrase/modules/agent-browser.md`; fully load it only when it matches
  and dependencies are available.
- If browser output changes future judgment, record it in `.phrase/evidence.md`.

### Default Task Execution

Trigger: the user gives a specific, defined task.

Action: follow the EDPP v3 workflow below.

### Session Wrap-Up: `/done`

Trigger: the user types `/done` or signals the session is ending.

Action:
- Read `.phrase/commands/done.md`.
- Record only what actually happened.
- If the session produced facts that change the next step, update
  `.phrase/evidence.md` instead of only writing a session diary.

### Start Phase: `/start-phase`

Trigger: the user types `/start-phase` or explicitly wants a new phase.

Action:
- Read `.phrase/commands/start-phase.md`.
- Generate the next `.phrase/current.md` from the previous phase's evidence.
- Plan only the current phase. Do not pre-split distant tasks.

### Legacy Migration: `/migrate-v3`

Trigger: the project already has the old `.phrase/phases/`, `spec_*`, `plan_*`,
`task_*`, `change_*`, or `issue_*` workflow.

Action:
- Read `.phrase/commands/migrate-v3.md`.
- Archive old material under `.phrase/archive/legacy-v2/`.
- Promote only durable rules, current phase context, unresolved blockers,
  verification results, and next-phase recommendations into v3 files.
- Do not mechanically convert old records, and do not let old docs remain in
  the default context path.

---

## 2. Default Read Rule

At the start of ordinary work, read only:

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

Read `.phrase/evidence.md` when:

- choosing the next phase
- deciding whether a plan has been disproven by new facts
- checking blocker or risk classification
- verifying phase closure

Read `.phrase/archive/` only when:

- current files link to a specific archived item
- a regression requires historical comparison
- the user explicitly asks for old context

Do not load full history by default. Token reduction is part of the protocol.

---

## 3. File Authority Order

When files disagree, use this order:

1. `.phrase/decision.md`, `.phrase/adr/`, `.phrase/protocol/`
2. Fresh evidence
3. `.phrase/current.md`
4. `.phrase/roadmap.md`
5. `.phrase/archive/`

If fresh evidence conflicts with the current phase, update `current.md`. If
fresh evidence challenges a durable boundary, update `decision.md`, an ADR, or
a protocol explicitly instead of silently changing implementation.

---

## 4. EDPP v3 Workflow

1. **Confirm the decision framework.**
   Define evidence rules, durable boundaries, verification standards, and phase
   gates.

2. **Maintain the roadmap.**
   Keep direction visible at phase granularity only: status, entry condition,
   acceptance gate, and major out-of-scope.

3. **Select the current phase from evidence.**
   Use the last phase result to decide what comes next. Do not continue an old
   sequence merely because it was written earlier.

4. **Update the current phase brief.**
   `current.md` must state the goal, scope, out of scope, acceptance gate,
   active task slice, verification method, and known blockers.

5. **Discover before broad implementation.**
   When blocker shape is uncertain, run the smallest useful experiment, trace,
   prototype, benchmark, audit, user test, or harness first.

6. **Classify blockers before fixing them.**
   Use project-fit labels: local fix, shared mechanism, workflow boundary,
   platform divergence, product ambiguity, operational dependency, data quality,
   and so on.

7. **Execute only the measured slice.**
   Do not expand into adjacent problems. Record unrelated findings as evidence
   for later phases.

8. **Verify.**
   Run the proof required by the phase gate; broaden checks when blast radius
   warrants it.

9. **Record an evidence delta.**
   Record only facts that change future judgment: verification result, failed
   assumption, remaining blockers, rejected path, and next phase recommendation.

10. **Update durable decisions only when needed.**
    Update `decision.md`, ADR, or protocol only when a long-lived rule or
    boundary changes.

11. **Prepare the next phase.**
    Update roadmap/current from the latest evidence. Move obsolete phase-local
    detail into archive.

---

## 5. Minimal File Structure

```text
.phrase/
  decision.md
  roadmap.md
  current.md
  evidence.md
  archive/

  adr/          # optional durable decisions
  protocol/     # optional stable contracts
  runbooks/     # optional repeated manual procedures
  modules/      # optional intent modules
  commands/     # optional command docs
```

### `decision.md`

Long-lived principles, evidence rules, durable boundaries, verification
standards, phase gates, ADR/protocol update triggers, and rejected paths that
should not be rediscovered.

### `roadmap.md`

Phase-level direction only: phase goal, status, entry condition, acceptance
gate, and major out-of-scope.

### `current.md`

Default context. Keep only what the current phase needs. It must be short enough
to read every session.

### `evidence.md`

Evidence deltas. Not a diary and not a full changelog. Separate observation,
interpretation, and recommended next action.

### `archive/`

Old phases, specs, tasks, and notes. Do not read by default.

---

## 6. Task Rules

Tasks serve only the current phase. Do not pre-split tasks for distant roadmap
phases.

Recommended format:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

If execution reveals a different blocker type, stop expanding the
implementation, update evidence, then decide whether the phase must change.

---

## 7. Completion Contract

Before claiming a task or phase is complete:

- acceptance gate has been checked
- verification evidence exists
- remaining blockers are recorded
- next phase recommendation is written
- durable decisions were updated if long-lived rules changed
- obsolete local context is archived or marked stale

---

## 8. Commits & Safety

- Commit messages should explain why the change exists, what was verified, and
  what risk remains.
- Commits do not need to bind to `taskNNN`, but they must trace back to the
  current phase and evidence.
- Never commit secrets, tokens, certificates, or real user data.
- For permissions, configuration, external APIs, and data migration risks, write
  the boundary and verification method in `current.md` or `decision.md`.

---

## 9. Collaboration Style

- Explain current phase, evidence, and next step first.
- Reference documents by filename and section; do not recite whole files.
- When offering options, say whether they belong to the current phase, a future
  phase, or a durable decision.
