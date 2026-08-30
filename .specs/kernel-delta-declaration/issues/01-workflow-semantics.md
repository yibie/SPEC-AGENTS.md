# 01 Define the proposed Kernel delta in the workflow model

status: done
blocked_by:
writer: do
authority: `docs/spec-agents/WORKFLOW.md` — the workflow model owns Model delta's meaning
spec_ref: `.specs/kernel-delta-declaration/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260829-017`

External blocker, not expressible in `blocked_by` (its contract comment in
`bin/spec-agents` says it names slice number prefixes inside the same
feature): the active SPEC
`spec-lifecycle` is editing `docs/spec-agents/WORKFLOW.md` right now (its
slice 01 is `doing`) and its scope covers this file. Do not start until
`spec-lifecycle` reaches `verified` and its `STATUS.md` entry is removed.
The same wait is recorded in `STATUS.md`.

## Goal

`WORKFLOW.md` states, in one place, what a SPEC's `Model delta` is and what an
absent `kernel_delta:` field means.

## Scope

- `docs/spec-agents/WORKFLOW.md`

## Acceptance

- the model states that for a Change crossing the Change Boundary, the SPEC's
  `## Model delta` is the proposed Kernel delta — the entries that will be
  added, revised, superseded, or retired in the project's `KERNEL.md` (in this
  repository: `WORKFLOW.md` itself) when the work verifies;
- the proposal state is carried by the SPEC lifecycle; the `kernel:` lifecycle
  line is unchanged and gains no `proposed` state;
- the absent-field default is named: a SPEC without `kernel_delta:` reads as
  `none`;
- the Change Boundary section cross-references the declaration, so a reader who
  learns "this is a semantic change" learns where it must be declared;
- no other entity's lifecycle or relations change;
- the mandatory read stays at or under 400 lines, removing something first if
  the addition would exceed it.

## Verification

`tests/doctrine-check.sh` passes. A reader can answer "where is a Kernel change
declared before it is implemented, and what does a missing declaration mean"
from `WORKFLOW.md` alone.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- External blocker: cleared. `spec-lifecycle` is verified and its `STATUS.md`
  entry is gone; the blocker paragraph remains unchanged.
- Exact text added to `docs/spec-agents/WORKFLOW.md` under `### SPEC`:
  对于跨过 Change Boundary 的 Change，SPEC 的 `## Model delta` 是拟议的 Kernel
  delta：工作验证后，将在项目 `KERNEL.md`（本仓库为 `WORKFLOW.md`）中新增、修订、
  取代或退役的概念、身份、关系、生命周期状态、不变量或 Action Contract。`do`
  据此实现，`learn` 只按原样提升它。提议状态由 SPEC 自身的 lifecycle 承载；
  `kernel:` 行不增加 `proposed` 状态。

  没有 `kernel_delta:` frontmatter 字段的 SPEC 按 `kernel_delta: none` 读取。这是
  有意保留的 legacy 默认值，不是未知状态；字段的动词为 `add | revise | supersede | retire`。
- Exact text added under `## Change Boundary`: 语义变化必须在 `do` 开始前于 SPEC
  的 `## Model delta` / `kernel_delta:` 中声明。
- Verification: `bin/spec-agents gate do
  .specs/kernel-delta-declaration/issues/01-workflow-semantics.md` passed;
  `tests/doctrine-check.sh` passed at 389/400 with all ADR pointers resolving
  and no stale CHANGELOG citation; `bin/spec-agents check-state` exited 0;
  `grep -n "kernel_delta\|Model delta" docs/spec-agents/WORKFLOW.md` showed
  lines 73, 79, and 238; the transition to `doing` passed and `evidence_ref`
  remains empty.
- Diff scope: `git diff docs/spec-agents/WORKFLOW.md` showed the six pre-existing
  spec-lifecycle insertions in Stable Relations/Lifecycle and prose; this slice
  added only the `### SPEC` declaration/default and the Change Boundary sentence.
  No lines were removed or reworded, so no tightening was needed.
- Ontology answer: yes. This adds meaning to the `Model delta` section and names
  the `kernel_delta:` default exactly as the SPEC declares; it changes no other
  concept, relation, lifecycle, or invariant.

Left at `doing` as required; no other file besides the scoped workflow and this
slice was touched.
