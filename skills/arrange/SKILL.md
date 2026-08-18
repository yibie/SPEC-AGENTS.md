---
name: arrange
description: 将已确认的 SPEC 安排成可独立验证、带依赖关系的工作切片。适用于跨多个上下文的 feature、重构或迁移；不替代设计质询，也不创造未来阶段任务。
---

# Arrange

把一个设计安排成 agent 能逐个完成的纵向切片。

## 读取

读取当前 feature 的 `SPEC.md`、相关 `CONTEXT.md`、ADR、Protocol 和现有 issue。只查当前 phase 的范围；不要把 roadmap 的远期内容提前拆出来。

## 切片规则

- 一个 issue 对应一个新上下文可完成、可验证的结果。
- 优先使用跨层的 tracer slice，而不是按文件或技术层机械拆分。
- 明确 `blocked_by`；没有依赖的 issue 才能进入 `ready`。
- 每个切片都指向 SPEC、相关 Action Contract 和验收证据。
- 发现语义冲突时停止安排，回到 `plan`；不要在 issue 中偷偷改本体。

## 写入位置

```text
.scratch/<feature>/issues/NN-<slug>.md
```

最小模板：

```markdown
# <id> <goal>

status: ready | blocked | doing | done | stale
blocked_by:
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

每个 issue 都有可观察目标、边界、依赖、验收和验证方式；没有跨 issue 的隐含前置条件，也没有 roadmap 之外的工作。
