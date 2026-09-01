# ADR 0013: Put Doctrine and workflow Instance records below one namespace

status: accepted
date: 2026-09-01
scope: the physical source and managed-project layout for Doctrine, workflow Instance records, and their active references
applies_when: installing, discovering, or reading SPEC-AGENTS Doctrine and project workflow state after the namespaced layout cutover
owner: project maintainer
source: E-20260831-011; E-20260831-012; E-20260831-013; E-20260901-001; E-20260901-002
verification: source and installed manifests, root/nested workflow fixtures, Upgrade recovery fixtures, source-SPEC fixture, Doctrine 399/400, kernel delta 17/17, full-system regression, and independent Stage-A verification E-20260901-002
supersedes: ADR 0001 only for its old physical Doctrine/Instance placement and root CONTEXT-template consequences; ADR 0006 only for its old physical single-authority document path consequence

## Context

ADR 0001 separated installer-owned Doctrine from project-owned Instance data,
but its accepted physical layout left Doctrine across root paths and left
Instance records at root, `.specs/`, `.scratch/`, and `archive/`. The source
checkout then had one layout while the managed project received another. ADR
0006 also named the former `docs/spec-agents/single-authority.md` location.

The namespaced layout has now been implemented and verified as one source and
managed-project contract. A root `AGENTS.md` remains only the discovery adapter;
Doctrine lives below `.spec-agents/doctrine/`, durable SPEC records below
`.spec-agents/specs/`, State and Evidence below `.spec-agents/state/`, scratch
below `.spec-agents/scratch/`, and retired workflow material below
`.spec-agents/archive/`.

## Decision

The source checkout and managed projects use one canonical physical layout.
The CLI resolves State through `.spec-agents/state/` for both source and
managed roots. Source root detection still requires the source Doctrine marker
and remains distinct from the managed-project integration check; source install
refusal remains in force. No command falls back to the retired root State,
Evidence, scratch, archive, or SPEC paths.

The ten declared Model-delta entries are promoted exactly as mapped in
`.spec-agents/doctrine/docs/WORKFLOW.md`: Doctrine, Instance, Project
integration entry, Start, Upgrade, Project Kernel, State, Evidence, SPEC, and
Slice. Their source is the r3 SPEC and their verification is the five Evidence
records named in this ADR; this decision introduces no additional model entry.

`reference-existence` remains confirmed in lifecycle status; its layout
assumptions are stale and it is routed to `plan` for a path-aware revision.
`evidence-reproducibility` keeps its confirmed meaning and points to
the canonical Evidence home. Historical Evidence, Changelog, ADR, and Slice
prose remains historical; only current machine-readable pointers were
reanchored.

Final post-check Evidence `E-20260901-002` was appended before this ADR was
accepted and is now included in its `source:` and `verification:` fields.

## Consequences

This is a breaking physical-layout change. Root `STATUS.md`, `EVIDENCE.md`,
`.scratch/`, and tracked `archive/` are no longer active paths in this source
checkout. The moved records retain their content and the ignored scratch tree
retains its reviewed inventory. Git recognizes the tracked moves as renames;
the untracked scratch move is governed by its exact pre-move manifest.

ADR 0001's ownership split, explicit Doctrine allowlist, non-overwrite rule,
root CONTEXT ownership, and template-copy decision remain accepted. ADR 0006's
authority-map and single-authority decisions remain accepted; the current
single-authority document is below `.spec-agents/doctrine/docs/`. ADR 0010's
salvage/reset/fresh-START semantics and ADR 0012's receipt gate remain accepted
with their canonical namespaced paths.

The source repository is now a dogfood instance of the public layout. The
verification covers deterministic disposable fixtures and this dirty shared
worktree; it does not prove arbitrary real-project safety or AI-mediated
Upgrade classification. Known E-20260828-012 remains unchanged.
