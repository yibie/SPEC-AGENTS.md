# 05 Close: Evidence, ADR, STATUS, CHANGELOG

status: done
blocked_by: 01, 02, 03, 04
writer: learn
authority: n/a: this slice writes records of the change; it introduces and modifies no rule
spec_ref: `.spec-agents/specs/kernel-delta-declaration/SPEC.md`
context_ref: `.spec-agents/state/EVIDENCE.md`
evidence_ref: `E-20260829-020`

## Goal

The work closes the way the model says work closes: evidence appended,
the decision recorded, the status board cleared.

## Scope

- `EVIDENCE.md`
- `docs/adr/`
- `STATUS.md`
- `CHANGELOG.md`
- slice `evidence_ref` fields and SPEC terminal status in
  `.specs/kernel-delta-declaration/`

## Acceptance

- an Evidence record with a stable ID covers what was verified, its sample and
  limits;
- an ADR records the breaking decision — declaration before implementation,
  the absent-field default, and the rejected alternatives (a `proposed` kernel
  state, a separate delta file);
- each slice's `evidence_ref` is written back and each reference resolves;
- `learn` writes the SPEC's terminal status and removes the
  `kernel-delta-declaration` entry from `STATUS.md` in the same act, per the
  lifecycle `spec-lifecycle` establishes;
- `CHANGELOG.md` gains the entry.

## Verification

`spec-agents check-state` exits 0. `tests/doctrine-check.sh` passes (every ADR
pointer resolves, no stale CHANGELOG citation). The removed STATUS entry's
acceptance line is satisfied by the fixtures from slice 04.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `docs/adr/0009-kernel-delta-declaration.md` — new. Records the inversion
  (Kernel constrains code, written after code), the disconnected pieces, the
  decision (Model delta as proposed delta; `kernel_delta:` field; the named
  absent default; `capture`'s refusal; `learn`'s promotion match; the gates),
  the r2 `retire` resolution, and the rejected alternatives: a `proposed`
  kernel state, a separate delta file, prose parsing, mechanical boundary
  detection, a retired tombstone, skipping `retire`.
- `EVIDENCE.md` — `E-20260829-017` (slice 01), `-018` (02, 03, and the
  early dispatch of 04 the gate refused), `-019` (04: per-entry provenance,
  the r2 decision, and one false report caught by re-running the suite),
  `-020` (the close). Sample and limits are stated per record.
- `STATUS.md` — the `kernel-delta-declaration` entry updated to 4/5 with 05
  `doing`; it is removed in the same act that sets the SPEC `verified`.
  `authority-order` then becomes the active SPEC.
- `CHANGELOG.md` — `[4.5.0] — 2026-08-29`, breaking. Version numbering
  follows the unreleased 4.2.0–4.4.0 headings; folding at release is the
  maintainer's call.
- No accepted record edited in place. ADR 0005 and 0007 untouched.

Verification: `tests/doctrine-check.sh` 389/400 (ADR pointers resolve, no
stale CHANGELOG citation); `bin/spec-agents check-state` exit 0;
`tests/kernel-delta-check.sh` 17/17; references in ADR 0009 checked by the
independent `check`.

Ontology question: no. This slice records decisions already enacted by
slices 01–04 and the r2 revision.

Left at `doing`; `learn` closes it, sets the SPEC `verified`, and removes the
`STATUS.md` entry in one act.

Post-check corrections (independent `check`, two `required` findings):

- `E-20260829-020` said `confirmed 4/5` and cited the SPEC at r1; the state at
  appending was `revised 4/5`, r2. Not edited; corrected by `E-20260829-021`.
- ADR 0009 carried two bare locators (`WORKFLOW.md`, `single-authority.md`)
  that did not resolve, so E-020's "every reference resolves" was false at
  appending. The ADR — this slice's deliverable, still under `check` — now
  carries full paths; the false claim is recorded in E-021.
