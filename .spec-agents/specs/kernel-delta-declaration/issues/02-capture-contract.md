# 02 `capture` writes the declaration and refuses to drop it

status: done
blocked_by: 01
writer: do
authority: `.spec-agents/doctrine/skills/capture/SKILL.md` — the capture contract owns the SPEC document's required content
spec_ref: `.spec-agents/specs/kernel-delta-declaration/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260829-018`

## Goal

Every SPEC `capture` creates carries a machine-readable `kernel_delta:` field,
and the omission that lost a decision in E-20260821-006 becomes a refusal for
the kernel fields.

## Scope

- `skills/capture/SKILL.md`

## Acceptance

- the SPEC minimal structure's frontmatter carries `kernel_delta:` with the
  format defined: the explicit value `none`, or a list of `<verb>: <entry>`
  lines with verbs `add | revise | supersede | retire`, entries naming Kernel
  items, not files;
- prose defines `## Model delta` by citing the `WORKFLOW.md` rule from slice
  01, not by restating it;
- the field is mandatory on every SPEC `capture` creates; `none` is a legal
  explicit answer; absence is defined as the legacy default only;
- `capture`'s completion condition refuses to finish when the confirmed `plan`
  outcome carried `kernel_promotion` other than `none` and the delta is empty;
- no other section of the template changes.

## Verification

`grep -n "kernel_delta" skills/capture/SKILL.md` returns a hit (zero before
this slice). `tests/doctrine-check.sh` passes.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- Exact text added to `skills/capture/SKILL.md` in the SPEC template:
  `kernel_delta: none`; the commented list form uses the real example:
  `- revise: Model delta (SPEC section gains normative meaning)`,
  `- revise: capture Action Contract (kernel_delta field, mandatory on new SPECs)`,
  and `- revise: learn Action Contract (promotion must match the declaration)`.
- Exact text added after the template: 每个由 `capture` 创建的 SPEC 都必须显式带有
  `kernel_delta:`；`none` 是合法的明确答案。字段缺失只作为 legacy 默认，不是新 SPEC
  的省略写法。关于 `## Model delta` 的含义以及缺失字段的读取方式，见
  `docs/spec-agents/WORKFLOW.md` 的 `SPEC` 定义。列表的动词限于
  `add | revise | supersede | retire`，每个 `<entry>` 命名 Kernel 条目（概念、关系、生命周期
  状态、不变量或 Action Contract），不命名文件。
- Exact completion refusal: 若已确认的 `plan` 结果记录了 `kernel_promotion` 且不为
  `none`，而 `kernel_delta` 为空或为 `none`，`capture` 必须停下、报告并不得完成，
  以防止重现 E-20260821-006 的决定丢失。
- Verification: `bin/spec-agents gate do
  .specs/kernel-delta-declaration/issues/02-capture-contract.md` passed;
  `grep -n "kernel_delta" skills/capture/SKILL.md` returned hits at lines 38,
  39, 41, 60, and 82; `tests/doctrine-check.sh` passed at 389/400 with all
  ADR pointers resolving and no stale CHANGELOG citation; `bin/spec-agents
  check-state` exited 0; the transition to `doing` passed and `evidence_ref`
  remains empty.
- Diff scope: `git diff skills/capture/SKILL.md` showed one pre-existing
  spec-lifecycle hunk (the `verified` status and paragraph) plus this slice's
  template, explanatory paragraph, and completion-refusal hunks. No other
  section was changed.
- Ontology answer: yes. This enacts the SPEC's declared entry `revise: capture
  Action Contract`; it adds nothing undeclared and changes no other concept,
  relation, lifecycle, or invariant.

Left at `doing` as required; no other file besides the scoped skill and this
slice was touched.

- Post-check correction: the paragraph now points to `docs/spec-agents/WORKFLOW.md` 的
  `SPEC` 定义 for `## Model delta`, absent-field reading, and Kernel item scope, while
  retaining capture’s mandatory field, explicit `none`, verb set, entry naming, and refusal.
