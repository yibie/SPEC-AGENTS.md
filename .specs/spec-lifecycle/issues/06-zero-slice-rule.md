# 06 State what `verified` requires of a SPEC with no slices

status: done
blocked_by:
writer: do
authority: `skills/learn/SKILL.md` — an action's write boundary is owned by its own contract
spec_ref: `.specs/spec-lifecycle/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260829-013`

## Goal

`learn`'s three preconditions for `SPEC.status = verified` say what a SPEC with
no slices must show, instead of leaving it to be read as vacuously true.

## Scope

- `skills/learn/SKILL.md`, section 收尾：写终态 only

## Acceptance

- the section states, for a SPEC with no slices: the first precondition
  (every slice `done`) is replaced by "the Evidence record names each item of
  the SPEC's issue map — or, if it has none, each deliverable in its
  Verification section — and states that it was verified"; the third
  precondition (removed from `STATUS.md` in the same act) is satisfied by a
  SPEC already absent from `STATUS.md`; the second is unchanged;
- it states that nothing is read as vacuously true, in one sentence;
- the existing three preconditions, the stop-write-nothing rule, and the
  negative boundary (nothing else in `.specs/<feature>/`) are unchanged in
  wording;
- no other section of the file changes; `AGENTS.md`, `WORKFLOW.md`, and the
  other five skills are untouched — this rule has one site;
- the addition is in the same register and language as the section around it
  (Chinese prose, backticked identifiers).

## Verification

`grep -n "没有 Slice\|零.*Slice\|no slices" skills/learn/SKILL.md` returns a hit
inside 收尾：写终态. `tests/doctrine-check.sh` passes. `spec-agents check-state`
exits 0. A reader can answer "how does a zero-slice SPEC reach `verified`" from
that section alone.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- Exact paragraph added to `skills/learn/SKILL.md`:

  对于零个 `Slice` 的 SPEC，第一条前置——每个 `Slice` 都已 `done`——替换为：
  `Evidence` 记录点名该 SPEC 的 `issue map` 中每一项；若没有 `issue map`，则点名
  其 `Verification` section 中的每个交付物，并说明这些内容已验证。第三条前置——同一
  次动作里从 `STATUS.md` 移除——由已经不在 `STATUS.md` 中的 SPEC 满足；第二条不变。
  任何一条前置都不按空集成立（vacuously true）来读取。
- Verification: `bin/spec-agents gate do
  .specs/spec-lifecycle/issues/06-zero-slice-rule.md` passed; `grep -n
  "没有 Slice\|零.*Slice\|no slices" skills/learn/SKILL.md` exits 0 and shows
  the paragraph inside 收尾：写终态;
  `tests/doctrine-check.sh` passed at 379/400; repository
  `bin/spec-agents check-state` exited 0; `git diff --stat
  skills/learn/SKILL.md` showed the pre-existing 27 insertions and 2 deletions
  in this already-dirty file, with this slice contributing only one insertion;
  the transition to `doing` passed and `evidence_ref` remains empty.
- Post-check correction: changed only the paragraph opening from `对于没有
  \`Slice\` 的 SPEC` to `对于零个 \`Slice\` 的 SPEC` after `check` found that
  the required grep pattern did not match the quoted identifier; no other
  sentence in the paragraph or file was changed.
- Ontology answer: this states an Action Contract clause that `plan` already
  decided in SPEC revision r4; it adds no concept, identity, relation,
  lifecycle, or invariant.

Left at `doing` as required; no other file besides the scoped skill and this
slice was touched.
