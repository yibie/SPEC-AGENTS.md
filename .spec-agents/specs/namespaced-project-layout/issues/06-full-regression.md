# 06 Prove the namespaced layout as one system

status: done
blocked_by: 05
authority: `n/a: this Slice adds verification and corrects references without introducing another workflow rule`
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `tests/`, `docs/runbooks/installer-smoke.md`, `.spec-agents/specs/namespaced-project-layout/SPEC.md`
evidence_ref: E-20260901-001

## Goal

Exercise the installed layout, workflow lifecycle, upgrade lifecycle, and
source dogfood cutover together, and correct only defects exposed by those
tests within the confirmed SPEC.

## Scope

- installer and Upgrade fixtures under `tests/`
- doctrine, kernel-delta, state, reference, link, executable, and source-layout
  checks
- `docs/runbooks/installer-smoke.md` final executable procedure
- active README and Changelog references needed to make the shipped workflow
  reproducible
- confirmed-contract corrections in implementation files when a failing test
  proves the current Slice 01–05 implementation incomplete

## Acceptance

- Fresh Chinese/English, repeat, link, existing integrated/unintegrated AGENTS,
  no-VCS, Git, native-JJ, nested-root, old-root Upgrade, forced-failure restore,
  and source-dogfood fixtures all pass.
- Exact manifests prove fresh root cleanliness, complete Doctrine payload,
  Instance isolation, archive replay, and absence of active old-layout paths.
- Every current Markdown link and path instruction resolves inside either the
  source repository or installed target as appropriate.
- `tests/doctrine-check.sh`, `tests/kernel-delta-check.sh`, full Upgrade smoke,
  `check-state`, shell syntax, whitespace, and executable-bit checks pass.
- Any test-discovered semantic conflict stops and returns to `plan`; this Slice
  does not widen the confirmed contract to make a check green.

## Verification

- Run every repository test plus the installer Runbook from a clean disposable
  root; record command, source revision identity, assertion counts, and result.
- Re-run after the last correction and require `git diff --check` plus a final
  active-old-path scan.

## Evidence

Pending Slice 05.

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `./.spec-agents/doctrine/bin/spec-agents gate do .spec-agents/specs/namespaced-project-layout/issues/06-full-regression.md` passed and printed the canonical `SPEC.md: ## Model delta` pointer. The same canonical CLI transitioned this Slice from `ready` to `doing` before verification.
- Read the Slice, SPEC r3, current root `STATUS.md`, `.spec-agents/doctrine/AGENTS.md`, `.spec-agents/doctrine/docs/WORKFLOW.md`, `.spec-agents/doctrine/skills/do/SKILL.md`, and `docs/runbooks/installer-smoke.md`. The authority answer is honestly `n/a`: this Slice performs verification and reference correction only, not a second implementation of a workflow rule.
- Executed the Runbook procedure in a fresh `mktemp` root: help, CLI syntax, clean English install, repeat install, linked install, `tests/namespaced-install-check.sh`, and `tests/upgrade-reset-smoke.sh`. A separate clean disposable install ran the installed `check-kernel.sh`, which exited 0 with the expected no-Kernel notice. The temporary roots were removed by traps.
- All repository test fixtures passed: `tests/protocol-cost-comparison.sh`; namespaced install 17/17; namespaced workflow 17/17 (root/nested Git, native-JJ, no-VCS, project-root, gate, transition, and retired/partial-root refusal cases); Upgrade reset 10/10 (failure, recovery, archive, reset, and fresh-Start paths); kernel delta 17/17; source Doctrine 13/13; source SPEC 16/16; and Doctrine 399/400. Source and installed exact-manifest checks, source/managed Markdown links, and README path checks passed.
- The source SPEC fixture verified the canonical `.spec-agents/specs/` manifest and exact counts: 129 files, 27 `SPEC.md` records, and 101 `issues/*.md` Slice records. It also exercised all six gates and transitions from both root and nested directories against a synthetic canonical SPEC/Slice, and confirmed the Git-only throwaway rename review.
- Shell verification passed: `bash -n` passed for all 11 active shell files (source CLI, checker, link helper, and repository tests), and all 11/11 have executable bits. `./.spec-agents/doctrine/bin/spec-agents check-state` exited 0; the source-spec fixture's nested check-state passed; and `git diff --check` passed.
- The final active-old-path scan found 0 retired-path hits in current root/Doctrine instructions, current workflow/skills/docs, CLI-independent instructions, and test documentation after treating README's canonical namespace manifest line as non-retired. Allowed hits were classified separately: `.spec-agents/doctrine/START.md` and `UPGRADE.md` plus CLI replacement markers are Upgrade recognition; the installer Runbook is a standing retired-path guard; namespaced/Upgrade tests are explicit fixtures; and CHANGELOG/EVIDENCE are history. Current SPEC/Slice frontmatter passed the focused guard in source SPEC 16/16.
- Git-only baseline under review: `HEAD` is `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`; the worktree is intentionally dirty with 164 porcelain entries from the shared cutover work. No commit or Git-state operation was performed.
- No test exposed a defect inside Slices 01–05, so no implementation correction was needed. No semantic conflict or SPEC widening was encountered. This Slice did not edit `EVIDENCE.md`, `STATUS.md`, SPEC status, WORKFLOW Model delta, ADRs, Slice 07, State, archive, or scratch paths.
- The ontology answer is no: this Slice adds no concept, identity, relation, lifecycle, invariant, or Action Contract. Its changes are verification/reference corrections and reproducible fixtures only. The confirmed SPEC Model delta remains for the later learn-owned promotion in Slice 07.
