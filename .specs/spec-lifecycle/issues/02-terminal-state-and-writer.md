# 02 Add the terminal values and name the action that writes them

status: done
blocked_by:
writer: do
authority: `skills/learn/SKILL.md` — an action's write boundary is owned by its own contract
spec_ref: `.specs/spec-lifecycle/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260828-012`

## Goal

Both terminal states a gate already enforces — `Slice.done` and `SPEC.verified`
— exist in the vocabulary and have exactly one authorised writer.

## Scope

- `skills/capture/SKILL.md`
- `skills/learn/SKILL.md`
- `skills/arrange/SKILL.md`
- `skills/do/SKILL.md`
- `AGENTS.md`, `AGENTS_en.md`

## Acceptance

- `skills/capture/SKILL.md`'s status set contains `verified`, and states that
  `capture` does not write it;
- `skills/learn/SKILL.md` grants `learn` two writes and no others: a slice's
  `status: done` together with its `evidence_ref`, after `check` has verified
  that slice; and a SPEC's `status: verified` when every slice is `done`, the
  Evidence record is appended, and the SPEC is removed from `STATUS.md` in the
  same act;
- an unmet precondition is stated to stop the write and report which one failed;
- `skills/do/SKILL.md` says `do` leaves a finished slice at `doing` with its
  verification summary and keeps `evidence_ref` empty; it no longer implies that
  `do` closes a slice;
- `skills/arrange/SKILL.md`'s ownership sentence and `skills/do/SKILL.md`'s
  write-boundary sentence both say `capture` owns the SPEC document while
  `learn` writes the terminal state at both levels;
- the `.specs/<feature>/` row of the owner table in `AGENTS.md` and
  `AGENTS_en.md` matches, and the two tables stay byte-identical;
- no other write boundary changes, and `do` still creates no slice;
- the mandatory read stays at or under 400 lines.

## Verification

`grep -rn "verified" skills/*/SKILL.md` returns a hit, and
`grep -rn "done" skills/*/SKILL.md` returns a hit outside `arrange`'s status
enum. Both return only the enum, or nothing, before this slice. The six files
agree on who writes each terminal state, with no sentence left saying `capture`
owns the SPEC without qualification. `tests/doctrine-check.sh` passes.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `skills/capture/SKILL.md` — status set gained `verified`; states that `learn`
  writes it at close and `capture` does not, and that `superseded` is a
  different exit rather than a synonym.
- `skills/learn/SKILL.md` — new section 收尾：写终态, placed after the
  promotion-record block and before 安全边界. Grants two writes: a slice's
  `evidence_ref` and `status: done` together after `check`, and a SPEC's
  `status: verified` under three preconditions. States the failure mode — stop,
  write nothing, report which precondition failed — and names the reflex it
  exists to prevent. Closes with the negative boundary: nothing else in
  `.specs/<feature>/`.
- `skills/arrange/SKILL.md` — ownership sentence now reads that `capture` owns
  the SPEC document while `learn` writes both terminal states at close.
- `skills/do/SKILL.md` — execution step 5 leaves the slice at `doing` with its
  verification summary and states plainly that `do` does not close a slice; the
  write-boundary section matches.
- `AGENTS.md`, `AGENTS_en.md` — the `.specs/<feature>/` owner row rewritten
  identically in both; the two tables remain byte-identical.

Verification: `grep -rn "verified" skills/*/SKILL.md` 0 → 4 hits;
`grep -rn "done" skills/*/SKILL.md` outside `arrange`'s status enum 0 → 4 hits.
All eight acceptance criteria checked individually. `tests/doctrine-check.sh`
passes at 379/400 — the owner-row edit was inline, so the mandatory read did not
grow. `check-state` exits 0.

One structural defect was made and repaired during this slice: the new `learn`
section was first inserted mid-list, which orphaned 每个提升后的记录都必须写明
under the wrong heading. Moved before 安全边界 and the heading order re-checked.

Left at `doing` rather than `done`, which is the rule this slice just wrote,
applied to itself for the first time. `learn` closes it after `check`.

