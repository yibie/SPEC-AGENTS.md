# 01 Install and run namespaced doctrine without root clutter

status: done
blocked_by:
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Doctrine
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `.spec-agents/doctrine/bin/spec-agents`, `docs/runbooks/installer-smoke.md`, `docs/adr/0001-framework-namespace-split.md`
evidence_ref: E-20260831-011

## Goal

Make a fresh managed project receive complete Doctrine below
`.spec-agents/doctrine/`, with at most a thin root discovery adapter and no
default project-root convention or state files, then run Start and all six
actions using only the new canonical paths.

## Scope

- `bin/spec-agents` — ordinary init/install payload, messages, and integration
  gate only; replacement and old-layout Upgrade remain for Slice 03
- a new copied root adapter template
- the installed `.spec-agents/doctrine/` payload, including selected-language
  AGENTS, prompts, docs, skills, checker, and CLI
- `docs/runbooks/installer-smoke.md` — fresh, repeat, link, and existing-entry
  assertions for this tracer
- focused installer fixtures under `tests/`
- full Doctrine AGENTS contracts in both languages
- `START.md` and all six `skills/*/SKILL.md`
- `docs/spec-agents/` active workflow docs, checker, Protocols, and Runbooks
- `bin/spec-agents` workflow commands, project-root detection, gates, state
  checks, transitions, and path-bearing messages
- `README.md` current-layout and workflow usage required by this tracer
- focused workflow-root, reference, and state fixtures under `tests/`
- `UPGRADE.md`, `START.md`, and `bin/spec-agents replace-doctrine` for the
  old-root → namespaced cutover, receipt gate, explicit old/new Doctrine
  manifests, recovery, reset, and fresh namespaced Start
- `tests/upgrade-reset-smoke.sh`, including its complete 10/10 lifecycle
- `tests/kernel-delta-check.sh` fixture roots and canonical references only;
  Kernel-delta semantics remain unchanged

## Acceptance

- Fresh install creates `.spec-agents/doctrine/` with the complete explicit
  Doctrine allowlist and a runnable `bin/spec-agents` plus checker.
- Root contains only an installer-generated thin `AGENTS.md` adapter; it does
  not contain `START.md`, `UPGRADE.md`, `CONTEXT.md`, `KERNEL.md`, `STATUS.md`,
  or `EVIDENCE.md`.
- An existing root `AGENTS.md` is byte-identical after install. Without the
  exact namespace reference, the command prints one actionable integration
  line and does not claim readiness; after the user-owned reference exists, a
  repeat install may claim readiness.
- The generated adapter is copied even under `--link`; Doctrine payload files
  follow the selected copy/link mode and writable Instance paths are absent.
- The installer still refuses the source repository, still uses an explicit
  allowlist, and does not leak upstream Instance material.
- Every mandatory read and write resolves the namespaced Doctrine, state,
  specs, scratch, and archive paths declared by the SPEC.
- Start writes only `.spec-agents/scratch/start/REPORT.md` before confirmation
  and creates `.spec-agents/state/KERNEL.md` only under the existing K1 gate.
- `status`, `ready`, `gate`, `transition`, and `check-state` discover
  `.spec-agents/state/` and `.spec-agents/specs/` from root and nested
  directories; they do not fall back to retired root paths.
- Complete no-VCS, Git, and native-JJ fixtures are recognised only when root
  integration resolves to complete namespaced Doctrine. Lone familiar paths
  refuse.
- The full Doctrine authority order places its own action skills immediately
  below the AGENTS contract; the authority-map Protocol carries `do`'s two
  cases; knowledge promotion permits workflow-model writes upstream only.
- No current instruction tells an agent to read a root `START.md`,
  `UPGRADE.md`, `KERNEL.md`, `STATUS.md`, `EVIDENCE.md`, `.specs/`, `skills/`,
  or `docs/spec-agents/` path.
- Root Doctrine and retired root Instance markers are Upgrade input, never a
  managed runtime fallback. The existing six-row cutover receipt still refuses
  every mismatch before writes.
- Replacement backs up explicit old/new Doctrine paths, never removes
  `.spec-agents/` as one unit, preserves Instance data on failure, installs the
  namespaced payload, and reports Doctrine completion before fresh Start.
- The persistent Upgrade fixture reaches 10/10 with archive replay, recovery,
  old-marker recognition, no dual active layout, and one fresh namespaced K1.
- Kernel-delta fixtures use complete namespaced managed roots and retain every
  existing semantic and provenance assertion.

## Verification

- `bash -n bin/spec-agents` and every new shell fixture.
- Disposable Chinese, English, repeat, link, absent-AGENTS, integrated-AGENTS,
  and unintegrated-AGENTS installs.
- Exact root and payload manifests, executable checks, source refusal,
  Instance leakage scan, and `git diff --check`.
- Disposable K1, active SPEC, dependency, nested-root, no-VCS, Git, and
  native-JJ fixtures using the installed CLI path.
- `tests/doctrine-check.sh`, `tests/kernel-delta-check.sh`, Markdown reference
  resolution, mandatory-read line ceiling, and active-old-path scans.
- Full persistent Upgrade receipt, refusal, recovery, reset, and Start fixture
  with exactly ten numbered groups and its final 10/10 result.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- Implemented ordinary `init/install` as an explicit namespaced Doctrine
  payload under `.spec-agents/doctrine/`: selected-language `AGENTS.md`,
  `START.md`, `UPGRADE.md`, `bin/spec-agents`, the allowlisted Doctrine docs,
  and all six action skill directories with their prompt files. The ordinary
  branch no longer creates root `START.md`, `UPGRADE.md`, `CONTEXT.md`, or any
  Instance path; the existing replacement branch remains unchanged.
- Added the copied root adapter template with exactly these two lines:

      <!-- SPEC-AGENTS root adapter v1 -->
      Read `.spec-agents/doctrine/AGENTS.md`.

  A free root path receives a copy even under `--link`; an existing root
  `AGENTS.md` is retained byte-for-byte. An unintegrated existing entry emits
  the actionable line below and the follow-up `Doctrine installed; add the
  integration line above and rerun the installer.`; it does not claim
  readiness. A later repeat after the user adds the reference may emit
  `✨ Done! Spec-AGENTS is ready.`.

      Integration required: add this exact line to <target>/AGENTS.md: Read `.spec-agents/doctrine/AGENTS.md`.
- Added `tests/namespaced-install-check.sh` with disposable Chinese, English,
  repeat, link, absent-root-AGENTS, integrated-root-AGENTS, unintegrated-root-
  AGENTS, payload/executable, Instance-boundary, and source-refusal fixtures.
  Updated `docs/runbooks/installer-smoke.md` with the namespaced manifests and
  root/integration/repeat/link assertions.
- Verification: `bash -n bin/spec-agents` and
  `bash -n tests/namespaced-install-check.sh` passed; the focused fixture passed
  `namespaced install check: 14/14`; `tests/upgrade-reset-smoke.sh` passed
  `upgrade reset smoke: 10/10`; `tests/doctrine-check.sh` passed
  `mandatory read 400/400 lines`, all ADR pointers, and stale-citation checks;
  `bin/spec-agents gate do` passed with the SPEC Model delta pointer;
  `bin/spec-agents check-state` exited 0; `git diff --check` passed.
- Ontology: no new concept, identity, relation, lifecycle, invariant, or Action
  Contract was introduced; this implements the confirmed namespaced install
  contract and its existing Doctrine/Instance boundary. No new semantic
  decision was needed.
- Slice remains `doing`; `evidence_ref` is empty. Slice 02/03 work, EVIDENCE,
  ADR, and learn outputs were not touched.

### Post-check corrections

- The existing-root integration gate now requires the exact whole line
  below; a prose-only substring fixture is integration-required and cannot
  claim readiness.

      Read `.spec-agents/doctrine/AGENTS.md`.
- The focused fixture now scans all installed Markdown, including followed
  links, and refuses `Phase N`, `taskN`, `research/`, and unmarked `E-2026`.
  Only a line explicitly containing `upstream SPEC-AGENTS Evidence` may exempt
  an Evidence ID. The runbook retains both the adapted Leakage assertion and
  the namespaced Link resolution standing guard; the latter may report the
  known pre-Slice-02 broken internal paths.
- Reverification after the corrections: `bash -n bin/spec-agents`,
  `bash -n tests/namespaced-install-check.sh`, focused install fixture `17/17`,
  `tests/upgrade-reset-smoke.sh` `10/10`, `tests/doctrine-check.sh` (`400/400`),
  `bin/spec-agents check-state` exit 0, and `git diff --check` all passed.

### Independent check finding

The main context independently checked the worker's first implementation and
found one `required` issue: moving the full Doctrine changed the resolution
base of its Markdown links, prose paths, mandatory reads, and CLI root markers,
but those rewrites were deferred to the former Slice 02. A fresh install could
therefore claim readiness while its full AGENTS contract still pointed at
missing old-layout paths. This is a decomposition error, not a new product
decision. SPEC revision 2 absorbs Slice 02 into this tracer; the Slice remains
`doing` until the installed workflow and every active reference use the new
canonical paths.

### Revision 2 continuation run summary

- Completed the absorbed namespaced tracer in the Slice Scope. Ordinary
  installation now emits one explicit Doctrine allowlist below
  `.spec-agents/doctrine/` (selected full AGENTS, START, UPGRADE, CLI, workflow
  docs/checker, and all six skills) plus a copied root adapter when the root is
  free. Existing root AGENTS files remain byte-identical; readiness requires
  the exact whole line below. No managed
  command falls back to root `KERNEL.md`, `STATUS.md`, `EVIDENCE.md`,
  `.specs/`, `.scratch/`, or `archive/`.

      Read `.spec-agents/doctrine/AGENTS.md`.
- Added strong project-root detection and explicit layout helpers. Managed
  commands resolve `.spec-agents/state/`, `.spec-agents/specs/`,
  `.spec-agents/scratch/`, and `.spec-agents/archive/`; the source repository
  remains operable through the CLI's explicit source-mode exception until the
  later source cutover. A lone familiar path or partial namespace refuses.
  The source checkout was not cut over, and Slice 03 Upgrade/replacement work
  was not executed.
- Updated active Doctrine references in both full AGENTS languages, START,
  workflow docs, checker, README, and all six skills to the new canonical
  layout. The confirmed authority-order decisions are present: action skills
  directly follow AGENTS in authority order; the authority-map Protocol keeps
  `do`'s two cases (covered rule at another target stops for `plan`, absent or
  uncovered map records a semantic finding and continues); managed `learn`
  never writes installed Doctrine, while source-repository `learn` may promote
  upstream workflow Doctrine. Root-relative canonical Markdown links and the
  installer smoke Link resolution guard remain active.
- Added `tests/namespaced-workflow-check.sh` as a disposable 17/17 runtime
  fixture. It covers root and nested status/ready/gate/transition/check-state,
  canonical Model delta pointer and links, ignored retired root paths,
  namespaced Kernel, dependency suppression, no-VCS, Git, native-JJ, and lone
  or partial-root refusal. `tests/namespaced-install-check.sh` passes 17/17,
  including exact integration false-positive, full Markdown leakage scan, and
  copy/link boundary checks.
- Verification passed: the initial `gate do` and final `gate do` both pass;
  `bash -n bin/spec-agents` plus both focused fixtures pass; installed links
  resolve; `tests/namespaced-install-check.sh` is 17/17;
  `tests/namespaced-workflow-check.sh` is 17/17;
  `tests/doctrine-check.sh` reports `399/400` mandatory-read lines;
  `bin/spec-agents check-state` exits 0 with `ok: no state violations.`; and
  `git diff --check` passes.
- `tests/upgrade-reset-smoke.sh` was rerun but cannot claim 10/10: it stops at
  its old replacement assertion `START does not exclude archive`, and its
  later root matrix still expects retired root layouts to be accepted. Updating
  that Slice 03 fixture or replacement path would violate this Slice's
  boundary, so it was left unchanged. The unrelated preexisting
  `tests/kernel-delta-check.sh` likewise still constructs old no-VCS `.specs`
  fixtures with the source CLI and fails the new intentional root gate; it was
  not changed.
- Ontology: no new concept, identity, relation, lifecycle, invariant, or
  Action Contract was decided. This implements the confirmed revision 2
  namespaced install/source-mode contract and authority-order decisions; no
  Slice 03/04 semantics, EVIDENCE, ADR, STATUS, or SPEC was written.

Slice remains `doing`; `evidence_ref` remains empty.

### Full-regression decomposition correction

Parent verification after revision 2 passed both focused fixtures 17/17,
Doctrine 399/400, source `check-state`, and diff checks, but the persistent
Upgrade fixture stopped after group 6 and every kernel-delta fixture root was
rejected for using retired `.specs/`. Those failures are caused by the active
path cutover in this Slice, not independent future behavior. SPEC revision 3
therefore absorbs the former Slice 03 and the mechanical kernel-delta fixture
root migration into this tracer. Slice 01 remains `doing` until Upgrade is
10/10 and the unchanged kernel-delta suite is green.

### Revision 3 continuation run summary

- Reworked `replace-doctrine` to recognize old-root Doctrine and Instance
  material as Upgrade inputs only: root `AGENTS.md`, `START.md`, `UPGRADE.md`,
  `skills/`, `docs/spec-agents/`, `KERNEL.md`, `STATUS.md`, `EVIDENCE.md`,
  `.specs/`, `.scratch/`, and `archive/` are never managed-runtime fallbacks.
  A full old Doctrine AGENTS is replaceable; a project-owned root AGENTS is
  protected byte-for-byte and receives integration guidance. The source
  repository remains operable through its explicit source-mode exception.
- Kept the strict six-row CUTOVER prewrite gate and moved its active receipt
  and report to `.spec-agents/scratch/upgrade-review/`. Replacement now backs
  up explicit old and new Doctrine trees under `old/` and `new/`, writes
  `OLD-DOCTRINE-MANIFEST.tsv`, `NEW-DOCTRINE-MANIFEST.tsv`, and aggregate
  `DOCTRINE-MANIFEST.tsv`, removes only the owned Doctrine paths, retains the
  `.spec-agents/` parent, and installs the namespaced Doctrine before the
  fresh namespaced Start handoff. A failed install leaves replayable recovery
  material and does not print success.
- Updated `UPGRADE.md`, `START.md`, and
  `docs/runbooks/installer-smoke.md` to describe the canonical receipt,
  archive, state, and fresh-Start paths while retaining old-root recognition,
  preservation, no-dual-layout, project-owned AGENTS, Instance, and recovery
  boundaries. No source Doctrine or source SPEC cutover was performed.
- Reworked `tests/upgrade-reset-smoke.sh` to exercise canonical managed
  scratch/archive/state paths, old-root archive recognition, explicit old/new
  Doctrine backup manifests, the copied adapter under `--link`, protected
  project-owned AGENTS, no-VCS/Git/native-JJ namespaced roots, retired-root
  refusal, and fresh namespaced K1. It reports exactly `10/10` groups.
- Reworked `tests/kernel-delta-check.sh` so all 17 existing semantic and
  provenance assertions create complete namespaced managed projects and call
  each fixture's installed `.spec-agents/doctrine/bin/spec-agents`; SPECs and
  Slices use `.spec-agents/specs/`, and Kernel records use
  `.spec-agents/state/KERNEL.md`. Its README description was left unchanged
  because that file is outside this Slice's Scope.
- Verification: target `gate do` passed with the
  `.specs/namespaced-project-layout/SPEC.md: ## Model delta` pointer;
  `bash -n bin/spec-agents`, `bash -n tests/upgrade-reset-smoke.sh`, and
  `bash -n tests/kernel-delta-check.sh` passed; `tests/upgrade-reset-smoke.sh`
  passed all ten groups and `upgrade reset smoke: 10/10`;
  `tests/kernel-delta-check.sh` passed all 17 cases;
  `tests/namespaced-install-check.sh` passed `17/17`;
  `tests/namespaced-workflow-check.sh` passed `17/17`;
  `tests/doctrine-check.sh` passed with `399/400` mandatory-read lines;
  source-root `bin/spec-agents check-state` exited 0 with no state violations;
  and `git diff --check` passed.
- Ontology: no new concept, identity, relation, lifecycle, invariant, or
  Action Contract was added. This implements the confirmed revision 3
  Upgrade/namespace contracts and absorbed fixture requirements; no new
  semantic decision was needed. Slice 03 was not separately executed, no
  EVIDENCE or ADR was written, and the slice remains `doing` with an empty
  `evidence_ref`.
- Post-check engineering cleanup removed one duplicated installer summary
  branch without changing behavior. Reference-integrity review also found and
  corrected six active CLI/README instructions that still named an unqualified
  root `UPGRADE.md`; historical old-layout references remain unchanged. The
  complete final matrix passed again: `bash -n`, `git diff --check`,
  `check-state`, namespaced install `17/17`, workflow `17/17`, Upgrade `10/10`,
  kernel delta `17/17`, and Doctrine `399/400`.
- Final ontology check found that the code implemented the planned Project
  integration entry while `WORKFLOW.md` had only received mechanical path
  rewrites. The existing SPEC r3 Model delta now has its single authoritative
  concept, `resolves_to` relation, integration invariant, and Doctrine/Instance
  replacement boundary in `WORKFLOW.md`; the same full matrix passed afterward
  while the mandatory read remained `399/400`.
