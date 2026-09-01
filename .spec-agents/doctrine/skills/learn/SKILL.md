---
name: learn
description: 将已验证的观察记录为证据，并判断哪些学习应提升为长期上下文、稳定协议或 ADR。适用于 check 之后、失败假设、blocker、被拒绝或悬而未决的提案，或新事实可能改变后续判断时。
---

# Learn

把运行结果变成可复用的知识，但不把每次试错都升级成长期规则。

## 记录证据

只记录会影响后续判断的增量，追加到 `.spec-agents/state/EVIDENCE.md`：

```markdown
## <date> — <subject>

### Observation
### Interpretation
### Recommended next action
### Verification
### References
```

把观察、解释和建议分开；不要写会话流水账或重复 git diff。

在 `.jj/` 项目中，Evidence 的 References 可以记录可复核的 JJ Change ID、
bookmark 和 `jj diff`/`jj log` 结果；不要把 JJ Change 当作语义 Change，也不要
要求远端发布才能完成本地 `learn`。Git-only 项目继续记录其现有 commit/branch
证据。

如果来源 Slice 有 `evidence_ref`：先为本次结果分配稳定 Evidence ID，追加
`.spec-agents/state/EVIDENCE.md`，验证写入成功后，再把同一个 ID 回写 Slice。不要在验证前
预填链接；`learn` 是唯一写入者。

## 判断知识类别与提升层级

- 只影响当前任务：留在 Slice 或 SPEC，不提升；短路径上不留任何记录。
- 可复用但尚未成为规则的事实、失败假设或验证结果：追加 `.spec-agents/state/EVIDENCE.md`。
- 项目稳定概念、身份、关系、生命周期或不变量：经 `plan` 确认后更新项目
  `.spec-agents/state/KERNEL.md`；项目自己的词汇和权威边界更新 `CONTEXT.md`；只有 SPEC-AGENTS
  工作流自身的语义才更新 `.spec-agents/doctrine/docs/WORKFLOW.md`。
  Kernel 的写入内容必须等于该 SPEC 最近修订时声明的 `kernel_delta` 条目；每个提升
  条目的 provenance（`source:`）都必须引用该 SPEC。
- 稳定接口、状态转换或 Action Contract：经 `plan` 确认后更新 `docs/protocols/`。
- 稳定的开发、评审、测试或协作约定：经 `plan` 确认后更新
  `docs/protocols/`。
- 带前置条件、验证和恢复路径的重复操作：经 `plan` 确认后更新
  `docs/runbooks/`。
- 有明确适用范围的失败教训或重复模式：经 `plan` 确认后更新
  `docs/lessons/`；不要把 scoped lesson 直接写成全局不变量。
- 难以逆转、出乎预期且源于真实取舍的决定：创建 `docs/adr/` 中的 ADR。
- 活跃 SPEC、阻塞项或下一步改变：更新 `.spec-agents/state/STATUS.md`。SPEC 完成时把它从
  `.spec-agents/state/STATUS.md` 移除，结果留在 `.spec-agents/state/EVIDENCE.md`；不要在 `.spec-agents/state/STATUS.md` 里保留已关闭
  的工作段落。

每个提升后的记录都必须写明：

```text
status | scope | applies_when | source Evidence ID | verification
```

如果替代或冲突了旧知识，还要写 `supersedes` 或 `contradicts`。只把知识
放进“看起来合适”的目录，不算完成晋升。

## 收尾：写终态

`learn` 是唯一写终态的动作，两层用同一条规则：

- **一个 Slice** —— `check` 验证通过后，把 `evidence_ref` 和 `status: done`
  一起写入。两者必须同时写：只写状态而不留证据，正是这套流程要消灭的
  「完成了但没人说得清凭什么」。
- **一个 SPEC** —— 三条前置同时成立时写 `status: verified`：该 SPEC 的每个
  Slice 都已 `done`；本次结果的 Evidence 已追加；同一次动作里把它从
  `.spec-agents/state/STATUS.md` 移除。

对于零个 `Slice` 的 SPEC，第一条前置——每个 `Slice` 都已 `done`——替换为：
`Evidence` 记录点名该 SPEC 的 `issue map` 中每一项；若没有 `issue map`，则点名
其 `Verification` section 中的每个交付物，并说明这些内容已验证。第三条前置——同一
次动作里从 `.spec-agents/state/STATUS.md` 移除——由已经不在 `.spec-agents/state/STATUS.md` 中的 SPEC 满足；第二条不变。
任何一条前置都不按空集成立（vacuously true）来读取。

任何一条前置不成立就**停下、什么都不写、报出是哪一条不成立**。不要为了让
`spec-agents check-state` 变绿而先写状态——门禁变红时被测的那条记录恰恰是唯一
不该动的东西。

除 Slice 的 `status`/`evidence_ref` 和 SPEC 的 `status` 之外，`learn` 不写
`.spec-agents/specs/<feature>/` 里的任何内容。


## 安全边界

- 未验证的猜测不进入长期文档。
- 不因一次通过就宣称一般性改进；写清样本、成本、限制和浏览器/环境边界。
- 与现有不变量冲突时，先让 `plan` 产生 `revise` 或 `reject`，再修改静态模型。
- `check` 只验证；`learn` 是追加 Evidence、提升知识、回写 `evidence_ref`
  和写入 Slice 与 SPEC 终态的唯一动作。
- 第一次 `START` 在项目缺少 `.spec-agents/state/KERNEL.md` 时可以先写入只含 confirmed facts 的
  `K1`；这只是建立初始稳定地板，不是绕过 `plan` 修改既有 Kernel。K1 之后的
  任何语义演化仍由 `learn` 在验证后写入，并记录 `supersedes` 或
  `contradicts`。
- Runbook 和 Lesson 必须有适用条件；不能因为一次成功或一次失败就扩大
  适用范围。
- 不创建正式本体 schema、图数据库、生成器或同步基础设施，除非有已确认的 SPEC 和证据支持。
- 如果待提升内容与 SPEC 声明的 `kernel_delta` 条目不一致，必须停下、什么都不写、报告是哪一条发生分歧；
  回到 `plan` 并修订 SPEC，绝不能在提升时调整。

## 完成条件

证据已追加，提升或不提升的理由已写明，长期文档只在确认后更新，`.spec-agents/state/STATUS.md` 与最新事实一致（完成的 SPEC 已移除），剩余 blocker 和下一步可复核。
