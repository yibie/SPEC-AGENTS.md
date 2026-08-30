# 03 `learn` promotes the declaration, not the drift

status: done
blocked_by: 01
writer: do
authority: `skills/learn/SKILL.md` — the learn contract owns Kernel promotion preconditions
spec_ref: `.specs/kernel-delta-declaration/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260829-018`

## Goal

Kernel promotion gains the precondition that makes the declaration binding:
what `learn` writes equals what the SPEC declared, or nothing is written.

## Scope

- `skills/learn/SKILL.md`

## Acceptance

- Kernel promotion (in this repository: the `WORKFLOW.md` counterpart) requires
  that the written change equal the SPEC's declared `kernel_delta` entries as
  last revised;
- each promoted entry's provenance cites the SPEC;
- on divergence: stop, write nothing, report which entry diverged; the route
  back is `plan` and a SPEC revision, never a silent adjustment at promotion;
- the existing rule that Kernel evolution passes `plan` is cited, not
  restated;
- `learn`'s other promotion targets (`CONTEXT.md`, protocols, runbooks,
  lessons, ADRs) are untouched.

## Verification

`grep -n "kernel_delta" skills/learn/SKILL.md` returns a hit. The divergence
behaviour is stated as stop-and-report, in the safety-boundary section.
`tests/doctrine-check.sh` passes.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- Exact promotion text added to `skills/learn/SKILL.md`:
  Kernel 的写入内容必须等于该 SPEC 最近修订时声明的 `kernel_delta` 条目；每个提升
  条目的 provenance（`source:`）都必须引用该 SPEC。
- Exact safety-boundary text added:
  如果待提升内容与 SPEC 声明的 `kernel_delta` 条目不一致，必须停下、什么都不写、报告是哪一条发生分歧；
  回到 `plan` 并修订 SPEC，绝不能在提升时调整。
- Verification: `bin/spec-agents gate do
  .specs/kernel-delta-declaration/issues/03-learn-promotion-match.md` passed;
  `grep -n "kernel_delta" skills/learn/SKILL.md` exited 0 with hits in the
  promotion rule at line 42 and safety boundary at line 104;
  `tests/doctrine-check.sh` passed at 389/400 with all ADR pointers resolving
  and no stale CHANGELOG citation; `bin/spec-agents check-state` exited 0;
  diff check passed; the transition to `doing` passed and `evidence_ref`
  remains empty.
- Diff scope: `git diff skills/learn/SKILL.md` showed the older spec-lifecycle
  hunks for 收尾：写终态 and one existing 安全边界 bullet; this slice added
  only the promotion-match and divergence clauses. No other promotion target
  or section was changed.
- Ontology answer: yes. This enacts the SPEC's declared entry `revise: learn
  Action Contract`; it adds nothing undeclared and changes no other concept,
  relation, lifecycle, or invariant.

Left at `doing` as required; no other file besides the scoped skill and this
slice was touched.
