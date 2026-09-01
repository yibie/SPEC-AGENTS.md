# 07 Promote the layout and finish the source state cutover

status: done
blocked_by: 06
writer: learn
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — Knowledge Classes and the SPEC Model delta
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `.spec-agents/state/STATUS.md`, `.spec-agents/state/EVIDENCE.md`, `.spec-agents/archive/`, `CHANGELOG.md`, `docs/adr/0001-framework-namespace-split.md`, `.spec-agents/specs/authority-order/SPEC.md`
evidence_ref: E-20260901-002

## Goal

Record verified evidence, promote the declared Model delta exactly, move this
repository's remaining workflow state to the canonical namespace, and close
the feature without leaving a second active layout.

## Scope

- `.spec-agents/doctrine/docs/WORKFLOW.md` — exact declared Model delta
  promotion
- `.spec-agents/state/EVIDENCE.md` and
  `.spec-agents/state/STATUS.md`, including relocation from current root files
- `.spec-agents/archive/` for existing workflow archive material that is
  classified and tracked
- a new superseding ADR for the layout and authority-order consequence; do not
  edit accepted ADRs in place
- `CHANGELOG.md`
- terminal SPEC/Slice state and Evidence references
- waiting-work pointers for `reference-existence` and
  `evidence-reproducibility`

## Acceptance

- Evidence records exact observations, commands, source identity, results,
  interpretation, and remaining limits; it does not claim more than the
  fixtures prove.
- WORKFLOW's enacted entries equal the SPEC `kernel_delta` and Model delta
  without adding undeclared rules.
- The superseding ADR names ADR 0001 and ADR 0006 consequences affected by the
  new layout; accepted records remain byte-identical.
- Root `STATUS.md`, `EVIDENCE.md`, and tracked workflow `archive/` are absent as
  active paths; their canonical records exist below `.spec-agents/` with no
  content loss.
- Untracked scratch material is moved only from an exact reviewed inventory;
  otherwise it is explicitly left as inactive local material with a recovery
  note and is not claimed migrated.
- All seven Slices have stable `evidence_ref` values and `done`; the SPEC is
  `verified`; active STATUS no longer lists it.
- `reference-existence` is routed back to `plan` for path revision and
  `evidence-reproducibility` points to the new Evidence home without changing
  its confirmed meaning.

## Verification

- Final Evidence-reference, Model-delta equality, ADR pointer, Changelog,
  doctrine, state, archive-manifest, root-cleanliness, and link checks.
- Full repository suite from root and nested directory after the state move.
- `git diff --check` and final status show one canonical layout and no
  unclassified tracked loss.

## Evidence

Stage-A run summary (not final Slice Evidence; `evidence_ref` stays empty):

- `gate learn` passed, then the canonical CLI transitioned this Slice from
  `ready` to `doing`. Stage A did not close this Slice or the SPEC, did not
  append a new Evidence ID, and did not change Slices 02/03 from `stale`.
- The pre-move inventory was preserved: root `STATUS.md` SHA-256
  `e96b861cdc6d76b800e5996d17f653e3a4457f61ae181de53f7c5103522be4c4`, root
  `EVIDENCE.md` SHA-256
  `4bbcf4fa0d4942a1ed6e345501694dc868d6087a6e1d0c36c3df325b31772aa0`, two
  tracked archive files with normalized manifest hash
  `a9cf365b707c3765464717d07fc7858e203237f1baf54c6c219c6def0a775c09`, and
  `.scratch` with 454 files, 338 directories, 2220 KiB, top tree
  `herdr-field-trial-20260830`, and normalized manifest hash
  `9db681c83de6eba434f6de554204ddebd3620fbecfcd2244e4e2120493b22e4e`.
  The exact moves were `STATUS.md` and `EVIDENCE.md` to
  `.spec-agents/state/`, `archive` to `.spec-agents/archive/`, and `.scratch`
  to `.spec-agents/scratch/`; the old active paths are absent. Post-move
  counts remain 2 archive files and 454 scratch files/338 directories/2220
  KiB; the Evidence file retains its pre-move SHA-256. `STATUS.md` was then
  intentionally updated to the canonical state pointer, active Slice 07
  pointer, and `next: check Slice 07 final state cutover`.
- The source CLI now resolves `state_root` as `.spec-agents/state` for both
  source and managed roots; obsolete `LAYOUT_MODE` and `set_layout_mode` were
  removed. `SOURCE_CHECKOUT` root detection and source-repository install
  refusal remain present. The temporary source-exception sentence was removed
  from both full AGENTS contracts. Current frontmatter State/Evidence/archive/
  scratch pointers were reanchored; the source-SPEC guard rejects unqualified
  forms while historical prose and Upgrade/legacy fixtures remain unchanged.
- WORKFLOW now carries one compact provenance mapping for exactly the ten
  declared entries—Doctrine, Instance, Project integration entry, Start,
  Upgrade, Project Kernel, State, Evidence, SPEC, and Slice—to upstream
  SPEC-AGENTS namespaced-project-layout SPEC r3 and `E-20260831-011`,
  `E-20260831-012`, `E-20260831-013`, and `E-20260901-001`; no source-only
  concrete SPEC path is exposed in installed Doctrine. No eleventh concept or
  rule was added. `docs/adr/0013-namespaced-project-layout.md` is proposed in
  Stage A, superseding only the specified physical consequences of ADR 0001
  and ADR 0006; their ownership and single-authority decisions remain
  accepted, as do ADR 0010/0012 with canonical paths. Git blob SHA-1 checks passed: ADR 0001
  `255ab9684882a5cd8b91a728c35b7832dc8d9f5d`, ADR 0006
  `7e6c4e15f42934c36bc27f5bb4303ed649762e24`, ADR 0012
  `9d14c9cdc2202a5ac5c619141f5867a45d49cff5`.
- The tracked `.phrase/` tree was moved exactly from root to
  `.spec-agents/archive/legacy-phrase/`: 23 files, 10 directories, 144 KiB,
  all-file manifest `c68f96e7344a7739d83a430db68efaad2be1201a79df4f51ac9d542113ad0d2d`,
  and 22-file tracked manifest
  `fd2edcb0ec6e94588a18524a6fbc5579f04fdea701a9df32b2a3808fa27793c2`.
  A throwaway Git commit and clone preserved all 22 tracked legacy files and
  reported the Doctrine and legacy-phrase moves as renames; root `.phrase/`
  is rejected by the source-root-clean fixture. Canonical `.spec-agents/scratch`
  remains optional in clean clones: the fixture requires root `.scratch/`
  absence and `.gitignore` routing, while Stage A separately verifies its
  reviewed local 454-file inventory and hash.
- The installed-target leakage guard rejects the source-only concrete SPEC
  path `.spec-agents/specs/namespaced-project-layout/SPEC.md`; Workflow now
  uses a non-path upstream SPEC citation. `reference-existence` remains
  confirmed in lifecycle status, while its layout assumptions are stale; Stage B routes it to
  `plan`, appends `E-20260901-002` to ADR 0013's source/verification, and only
  then changes that ADR from `proposed` to `accepted` after the final Evidence
  append.
- The Unreleased Changelog, installer Runbook, source Doctrine fixture, and
  current machine-readable frontmatter now describe the canonical State,
  Evidence, scratch, archive, and SPEC layout. `reference-existence` remains
  confirmed in lifecycle status, its layout assumptions are stale, and it is
  routed to `plan`; `evidence-reproducibility` points to the new
  Evidence home. The canonical STATUS keeps `namespaced-project-layout`
  active, records Slice 07 as `doing`, lists 7 records/4 done/2 stale, and
  points next to `check Slice 07 final state cutover`.
- Final root test matrix: protocol-cost pass; install `17/17`; workflow
  `17/17`; Upgrade `10/10`; kernel delta `17/17`; source Doctrine `13/13`;
  source SPEC `16/16`; Doctrine `399/400`. The fixtures exercised exact
  source/installed manifests, root/nested Git/native-JJ/no-VCS discovery,
  current Markdown links, Upgrade failure/recovery, and root/nested status,
  gates, transition, and check-state paths after the move. All 11/11 active
  shell files passed `bash -n` and executable-bit checks. Root
  `check-state`, source-spec fixture, and `git diff --check` passed. The
  active-instruction old-path scan found 0 hits, with Upgrade recognition,
  history, and explicit fixture paths classified separately. Git-only baseline
  was `059c2b56797b6613ce51ed24b7d14e2ddcb9b192`; the shared worktree remained
  dirty.
- This Stage A has promoted only the ten declared Workflow entries and their
  provenance record; it has not set `status: verified`, removed the active
  STATUS section, or performed Slice 07's terminal State cutover. Limits are
  deterministic disposable fixtures, not arbitrary real-project or AI-Upgrade
  proof; known `E-20260828-012` remains unchanged.

Stage-B learn closure summary (final; Evidence `E-20260901-002` was appended
before these terminal writes):

- The seven Slice records are now `done` with stable references: Slices 01,
  02, and 03 use `E-20260831-011`; Slice 04 uses `E-20260831-012`; Slice 05
  uses `E-20260831-013`; Slice 06 uses `E-20260901-001`; and Slice 07 uses
  `E-20260901-002`. The SPEC is `verified`, and its active section was removed
  from canonical `.spec-agents/state/STATUS.md`; it now states `No SPEC is
  active` and retains only the requested `reference-existence` and
  `evidence-reproducibility` waiting pointers.
- ADR 0013 is `accepted`, cites all five Evidence records including
  `E-20260901-002`, and retains the confirmed lifecycle status plus stale
  layout-assumptions reading for `reference-existence`. WORKFLOW's provenance
  still names exactly the ten declared entries, uses the non-path upstream
  SPEC r3 citation, and now includes `E-20260901-002`; no eleventh entry was
  added.
- Final verification passed: protocol-cost comparison; install 17/17;
  workflow 17/17; Upgrade 10/10; kernel delta 17/17; source Doctrine 13/13;
  source SPEC 16/16; Doctrine 399/400; shell syntax and executable bits
  11/11; root and nested `check-state`; and `git diff --check`. E002 is
  present exactly once, all seven Slices are done, the SPEC is verified, ADR
  0013 is accepted, and canonical STATUS no longer lists this feature.
- Ontology answer: exactly the SPEC's ten declared Model-delta entries were
  promoted. No additional concept, identity, relation, lifecycle, invariant,
  or Action Contract was added. The remaining limits are the deterministic
  disposable fixtures, the dirty shared worktree, and the known
  `E-20260828-012` issue; arbitrary real-project and AI-mediated Upgrade
  safety remain unproven.
