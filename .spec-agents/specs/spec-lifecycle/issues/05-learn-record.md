# 05 Record the decision

status: done
blocked_by: 03, 04, 06
writer: learn
authority: n/a: records only
spec_ref: `.spec-agents/specs/spec-lifecycle/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260829-015`

## Goal

The decision, the evidence behind it, and the state change are durable.

## Scope

- a new record under `docs/adr/`
- `EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`

## Acceptance

- the ADR records that SPEC had no lifecycle while four other entities did, and
  that the CLI supplied the missing terminal state on its own;
- it records the slice level as the same defect one step down — the CLI required
  `evidence_ref` and `done` together while no contract named a writer for the
  pair — and that both were repaired by one decision rather than two;
- it records why `verified` was kept rather than renamed: sixteen SPECs already
  carried it, so the vocabulary change costs no migration, and reusing a state
  name across entities was already established by `superseded`;
- it records why `learn` and not `capture` writes the terminal states: `capture`
  is the entry action and neither of its preconditions holds at close;
- it records the rejected alternatives: removing the CLI's assertions, relaxing
  `done`'s `evidence_ref` requirement, and giving `capture` a second trigger;
- `EVIDENCE.md` records that seventy-five closed slices were set by hand, which
  is the practice ADR 0007 built the CLI to end, and the three same-shaped
  incidents that made the gap visible, each with enough detail to locate the
  reverted edit in version control — or, where no revision holds it, a
  statement of why it cannot be located (r5);
- `STATUS.md` drops the `spec-lifecycle` entry once it is finished;
- no accepted record is edited in place.

## Verification

Every reference in the new ADR resolves. `tests/doctrine-check.sh` passes.
`STATUS.md` matches the repository's actual state.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `docs/adr/0008-spec-lifecycle.md` — new. Records the missing SPEC lifecycle,
  the CLI supplying the terminal state, the slice level as the same defect one
  step down, why `verified` was kept, why `learn` and not `capture` writes it,
  the r4 zero-slice rule and how it was found, and the rejected alternatives
  (remove the assertions; relax `done`; a second `capture` trigger; the
  vacuous reading; a bootstrap exemption).
- `EVIDENCE.md` — `E-20260829-013` (slices 03 and 06, the withdrawn write, the
  JSONL rerun figures), `E-20260829-014` (`upgrade-prompt`'s four bullets),
  `E-20260829-015` (the close). The seventy-five hand-set slices and the three
  2026-08-27 incidents are in `E-20260828-012`; E-015 records that the
  reverted edits cannot be located in version control and why, as an unmet
  acceptance item rather than a claim.
- `STATUS.md` — `spec-lifecycle` removed; `kernel-delta-declaration` is the
  one active SPEC and its slice 01 moved `blocked → ready`; the three waiting
  SPECs listed in order; `gate arrange`'s vocabulary copy added to the open
  items.
- `CHANGELOG.md` — `[4.4.0] — 2026-08-29`, marked breaking. The version
  number follows the existing unreleased 4.2.0 and 4.3.0 headings; folding at
  release is the maintainer's call, as the 4.1.0 heading describes.
- No accepted record edited in place; ADR 0006 and 0007 untouched.

Verification: `tests/doctrine-check.sh` passes at 379/400 (the ADR is not in
the mandatory read); `bin/spec-agents check-state` exits 0; every path and
Evidence ID in the ADR resolves (checked by the independent `check`).

Ontology question: no. This slice records a decision already enacted by
slices 01, 02 and 06.

Left at `doing`; `learn` closes it, sets the SPEC `verified`, and confirms it
is absent from `STATUS.md` in the same act.

Post-check corrections (independent `check` of this slice, two findings):

- `blocker` — `STATUS.md` had dropped the `spec-lifecycle` entry before the
  SPEC was `verified`; r4's already-absent clause covers zero-slice SPECs
  only. The entry was restored, stating that `learn` removes it in the same
  act as the terminal write, and `E-20260829-015` was reworded to describe the
  state at the moment it was appended rather than the state after the close.
- `required` — the version-control locatability criterion was unsatisfiable
  as written. Routed to `plan`; r5 amends the bullet to accept a stated
  reason. `E-20260829-015` already carries that statement.
- `blocker` (second re-check) — the E-015 rewording above was itself an
  in-place edit of an appended ledger record. Recorded as `E-20260829-016`
  with the replaced text reproduced; E-015 is not touched again.
