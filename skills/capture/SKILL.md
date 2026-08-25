---
name: capture
description: 将已经确认的多上下文设计记录成可交接、可受控修订的 SPEC。适用于工作需要跨会话、跨 agent 或需要保留设计决定时；不要用它替用户重新做决定。
---

# Capture

把已确认的共识写成一个活的设计契约。

## 前置条件

- `plan` 已结束并得到 `approve`、`compatible revise`、`breaking`，或明确的
  `plan-only` 执行授权。`breaking` 时，SPEC 必须包含迁移方案；ADR 不在这里写，
  由 `learn` 收尾时写。
- 设计需要跨多个上下文，或必须交给之后的 agent 继续。
- `docs/spec-agents/WORKFLOW.md`、`CONTEXT.md`、项目 `KERNEL.md`（若存在）、
  相关 ADR、Protocol、Runbook 和
  Lesson 已被读取；冲突回到 `plan`。

## 写入位置

创建或更新：

```text
.specs/<feature>/SPEC.md
```

不要在根目录再创建第二份 SPEC。目录不存在时按需创建；不要预建未来 feature 的文件。

## SPEC 最小结构

```markdown
# <feature>

status: draft | confirmed | in-progress | revised | superseded
revision: <number>
context_refs:

## Problem and goal
## Unchanged contracts
## Decision and boundaries
## Model delta
## Action Contracts
## Seams and verification
## Compatibility and migration
## Out of scope
## Issue map
## Revision notes
```

记录“已经决定的 what/why/where”，不要把新的取舍藏进 SPEC。实现细节只写到能让后续切片保持一致的程度。

当 SPEC 是 `Kernel Bootstrap` 时，记录 K1 已确认的概念、关系、动作契约和
不变量，以及待确认的扩展；不要把 K1 复制成第二份长期真相。验证通过后由
`learn` 更新项目 `KERNEL.md`。

## 修订

- 文字澄清、链接和验证补充可以直接修订。
- 改变目标、边界、身份、关系、不变量、接口或验收标准，必须重新经过 `plan`。
- 修订时保留 revision、原因、受影响的 CONTEXT/Protocol、兼容性、迁移和验证。
- 受影响的 Slice 标为 `stale`；不要让旧 Slice 继续执行。

## 完成条件

SPEC 状态、未改变的契约、边界、Action Contracts、验证入口和 out-of-scope 齐全，并能让一个新上下文不依赖本次对话继续工作。
