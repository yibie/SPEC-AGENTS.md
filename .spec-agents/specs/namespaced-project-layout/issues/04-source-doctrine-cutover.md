# 04 Move this repository's Doctrine source behind the adapter

status: done
blocked_by: 01
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Doctrine and Project integration entry
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `.spec-agents/doctrine/AGENTS.md`, `.spec-agents/doctrine/AGENTS_en.md`, `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/UPGRADE.md`, `.spec-agents/doctrine/skills/`, `.spec-agents/doctrine/docs/`, `.spec-agents/doctrine/bin/spec-agents`
evidence_ref: E-20260831-012

## Goal

Make this repository author and exercise the same namespaced Doctrine layout it
installs, with root `AGENTS.md` reduced to the thin discovery adapter.

## Scope

- relocate full Chinese and English AGENTS sources, Start, Upgrade, action
  skills, workflow docs, checker, and installed CLI source below
  `.spec-agents/doctrine/`
- replace root `AGENTS.md` with the copied adapter shape
- installer source lookup and development entrypoints
- active source-relative links in `README.md`, `CHANGELOG.md`, tests, and
  project records when required for the source tree to remain executable
- source-layout assertions

## Acceptance

- Git records the Doctrine relocation; root has no full Doctrine prompt,
  `START.md`, `UPGRADE.md`, `AGENTS_en.md`, `skills/`, or
  `docs/spec-agents/` active path.
- Root `AGENTS.md` is the same minimal integration format a managed project
  receives and resolves to the full Chinese source contract.
- Installer source discovery, ordinary install, replacement, CLI gates, and
  check-kernel all run from their new source locations without environment-only
  path assumptions.
- No duplicate current Doctrine exists at old paths, and historical path
  mentions are clearly historical rather than active instructions.
- The source worktree remains recoverable throughout the move and unrelated
  user changes are preserved.

## Verification

- Source and installed exact manifests; root cleanliness scan.
- Fresh/repeat/link/replacement smoke, source refusal, executable and reference
  checks invoked from the new source paths.
- `git status --short`, rename review, `git diff --check`, and a clean old-path
  authority scan.

## Evidence

Pending Slice 03.

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- The complete Doctrine source was relocated with explicit, recoverable moves:
  `AGENTS.md` and `AGENTS_en.md` → `.spec-agents/doctrine/`, `START.md` and
  `UPGRADE.md` → `.spec-agents/doctrine/`, `skills/` →
  `.spec-agents/doctrine/skills/`, `docs/spec-agents/` →
  `.spec-agents/doctrine/docs/`, and `bin/spec-agents` →
  `.spec-agents/doctrine/bin/spec-agents`. The root adapter is exactly:

  ```text
  <!-- SPEC-AGENTS root adapter v1 -->
  Read `.spec-agents/doctrine/AGENTS.md`.
  ```

  No `.specs/`, `STATUS.md`,
  `EVIDENCE.md`, archive, or other project Instance was moved.
- The source CLI now resolves its repository root three levels above its
  namespaced location and uses the presence of both language sources to
  distinguish source checkout from managed install. Source mode keeps the
  repository's root `.specs/` and root state files operational; managed mode
  remains namespaced. Installer source lookup, `link_to_system.sh`, README,
  CHANGELOG, runbook, doctrine checks, and workflow tests use the canonical
  source path. The installer still emits only the selected-language Doctrine
  manifest and the copied root adapter.
- Added `tests/source-doctrine-cutover-check.sh`. It proves the source manifest
  has exactly 26 files, the installed Chinese manifest has exactly 25 files,
  source and installed docs/skills match, old root Doctrine paths are absent,
  source Markdown links resolve, source install refuses, source root and nested
  gates work, and Git reports the expected source-to-namespace renames in a
  throwaway tree. The source checker omits the source-only `AGENTS_en.md` from
  the installed selected-language manifest; the existing install fixture covers
  the English selection as well.
- Verification: initial `gate do` passed; final source cutover fixture passed
  `13/13`; `tests/namespaced-install-check.sh` passed `17/17`; the fresh,
  repeat, link, replacement, source-refusal, and persistent Upgrade matrix
  passed `tests/upgrade-reset-smoke.sh` at `10/10`; the canonical kernel-delta
  suite passed `17/17`; `tests/namespaced-workflow-check.sh` passed `17/17`;
  `tests/doctrine-check.sh` passed at `399/400`; source-root
  `.spec-agents/doctrine/bin/spec-agents check-state` exited 0; source and
  managed `bash -n` checks passed; and `git diff --check` passed. The source
  checker also ran `.spec-agents/doctrine/docs/check-kernel.sh` successfully
  with the expected no-Kernel note.
- The rename verification used a throwaway Git repository/tree and reported
  renames for `AGENTS_en.md`, `START.md`, `UPGRADE.md`, `bin/spec-agents`, all
  workflow docs, and all six skills. It did not alter this repository's Git
  index or create a commit. Historical old-layout references remain only in
  Upgrade input descriptions, ADR/Evidence history, or generated old-layout
  fixtures; no current source Doctrine is duplicated at the old paths.
- Ontology answer: no concept, identity, relation, lifecycle, invariant, or
  Action Contract was added, altered, or retired. This slice is a physical
  Doctrine source cutover plus source/managed path resolution and test coverage;
  it implements the confirmed namespace and Project integration entry already
  decided by the SPEC. Slice 03 was not separately executed, source SPEC
  cutover was not performed, and no Evidence, ADR, STATUS, or new SPEC was
  written. Slice remains `doing` with an empty `evidence_ref`.
- Independent reference check corrected six source-only README links from
  site-root form to repository-relative `.spec-agents/doctrine/docs/...`
  targets and added the 13th source fixture assertion. Installed Doctrine keeps
  project-root links because those resolve inside each managed target.
