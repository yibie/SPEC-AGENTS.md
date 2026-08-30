---
name: arrange
description: 将已确认的 SPEC 安排成可独立验证、带依赖关系的工作切片。适用于跨多个上下文的 feature、重构或迁移；不替代设计质询，也不为尚未确认的工作预拆切片。
---

# Arrange

把一个设计安排成 agent 能逐个完成的纵向切片。

## 读取

读取当前 feature 的 `SPEC.md`、项目 `KERNEL.md`（若存在）、相关 `docs/spec-agents/WORKFLOW.md`、`CONTEXT.md`、ADR、Protocol、Runbook、Lesson 和现有 Slice。只查已确认 SPEC 的范围；不要把尚未确认的想法提前拆成切片。

## 切片规则

- 一个 Slice 对应一个新上下文可完成、可验证的结果。
- 优先使用跨层的 tracer slice，而不是按文件或技术层机械拆分。
- 明确 `blocked_by`；没有依赖的 Slice 才能进入 `ready`。
- 每个切片都指向 SPEC、相关 Action Contract 和验收证据。
- 切片的验收必须在它自己的 Scope 内可达。验收要求写 Scope 之外的文件，是
  拆分错误，回到 `plan` 重新划分边界，不要留给 `do` 去撞。
- 每个切片必须写 `authority:`——本切片所碰业务规则的唯一权威模块，按 Kernel
  的 Architecture boundaries 填。既不引入也不修改业务规则时写
  `n/a: <理由>`；**字段缺失不是有效答案**。做成必填而非条件必填是有意的：
  它强制这个判断被写下来、可复核，而不是默默不做。
  但要清楚它保证什么——**它保证有一个答案，不保证答案是对的**。`n/a` 仍然把
  「这算不算业务规则」的分类交回写切片的人，而 `arrange` 只读意图、读不到
  diff，核不了这个分类。核它的地方是 `check`。
- Scope 含 `do` 不拥有的文件时，frontmatter 必须写 `writer:`。`do` 拥有
  `Code`；`learn` 拥有 `KERNEL.md`、`CONTEXT.md`、`STATUS.md`、`EVIDENCE.md`
  和 `docs/{adr,protocols,runbooks,lessons}/`；`capture` 拥有 SPEC 文档，
  而 Slice 与 SPEC 的终态由 `learn` 在收尾写入。
- 被管项目中，安装进来的 doctrine 不属于任何动作，不能出现在任何切片的
  Scope 里；需要改它就去改上游。
- 发现语义冲突时停止安排，回到 `plan`；不要在 Slice 中偷偷改本体。

## 写入位置

```text
.specs/<feature>/issues/NN-<slug>.md
```

最小模板：

```markdown
# <id> <goal>

status: ready | blocked | doing | done | stale
blocked_by:
writer:            # Scope 含 do 不拥有的文件时必填
authority:         # 必填：本切片所碰规则的唯一权威模块，或 `n/a: <理由>`
spec_ref:
context_ref:
evidence_ref:

## Goal
## Scope
## Acceptance
## Verification
## Evidence
```

先向用户展示切片数量和依赖边，再写入文件；用户未确认拆分时只输出草案。`evidence_ref` 保持为空，直到 `learn` 完成验证记录。

## 完成条件

每个 Slice 都有可观察目标、边界、依赖、验收、验证方式和 `authority:`；每个 Slice 的验收在它自己的 Scope 内可达，越界写入的已声明 `writer:`；没有跨 Slice 的隐含前置条件。
