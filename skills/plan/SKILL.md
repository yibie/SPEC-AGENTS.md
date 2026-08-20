---
name: plan
description: 在执行前质询并分类一项可能改变语义、架构边界或工作规模的请求。适用于新增、重命名、拆分、合并、废弃或重新定义概念、身份、关系、生命周期、不变量、Action Contract，或需要跨多个上下文推进的工作；语义已经确定且只是实现细节的修改可跳过。
---

# Plan

把“要不要改、改什么、改到哪里”为止先说清楚，再允许后续动作。

## 读取

1. 读取 `AGENTS.md`、`docs/spec-agents/WORKFLOW.md`、`CONTEXT.md`、`STATUS.md`；
   项目有 `KERNEL.md` 时一并读取。
2. 只有当前判断需要历史依据、风险分类或回归对比时，才读取 `EVIDENCE.md` 或 `archive/`。
3. 查代码、调用方、测试和配置来回答事实；不要把可以查到的事实丢给用户回答。

## 质询

按设计树分轮工作：

- 先确认需求、未改变的基线和“不改会怎样”。
- 只问当前前置条件已经确定的问题；每轮完整询问当前 frontier，再等待用户回答。
- 区分事实与决定：事实由 agent 查，取舍由用户确认。
- 继续到没有未决分支，不因一个看似合理的解释提前结束。
- `STATUS.md` 已有活跃 SPEC 时，检查新工作的 scope 是否与它们相交。相交就在
  这一轮重新划分边界，不要留到执行时用隔离工作副本掩盖。

保持一份候选记录：

```text
kind: add | refine | rename | split | merge | retire | plan-only
need:
unchanged_baseline:
old_definition:
new_definition:
knowledge_class: semantic | decision | protocol | runbook | lesson | state
scope:
applies_when:
identity_and_relations:
lifecycle_and_invariants:
action_contracts:
kernel_status: absent | K1-bootstrap | enacted | stale | contradicted
kernel_promotion: bootstrap | revise | supersede | none
compatibility: no-change | compatible | breaking | unresolved
mapping_and_migration:
verification:
decision: no-change | revise | approve | reject | unresolved
```

## 路由

用户确认共享理解后，只选择一个结果：

- `no-change`：停止，不创建 SPEC、不改代码。
- `plan-only`：输出边界明确的计划，等待执行授权。
- `approve`：语义不变，直接交给 `do`，并验证原有契约。
- `compatible revise`：明确一个兼容替代方案，保留旧不变量和数据契约，交给 `capture` 或 `do`。
- `breaking`：先记录迁移方案和 ADR，不能伪装成兼容修改。
- `reject` / `unresolved`：停止；只有用户需要长期记忆时才交给 `learn` 留痕。

## 写入边界

- 共享理解确认前只读，不修改仓库。
- 首次 `START` 已经可以在缺失时建立只含 confirmed facts 的 `KERNEL.md` K1；
  `plan` 不覆盖它，也不直接修改已有 Kernel。
- 不直接修改 `docs/spec-agents/`、`CONTEXT.md`、已有 `KERNEL.md`、`docs/adr/` 或
  `docs/protocols/`。
- 语义变化的静态知识由 `learn` 在验证后提升。
- 规划结果交给下一个 skill，不建立第二套临时需求文档。

## Kernel Bootstrap

当 `START.md` 报告 `K1-bootstrap` 时，先检查 K1 是否只包含代码、测试、配置
或既有 durable record 直接确认的事实。用户确认只处理候选扩展、冲突和未知项；
不能因为这些未决项而跳过 K1。若 K1 不足以约束当前动作，路由到
`capture` 记录 Bootstrap SPEC，再由 `check`/`learn` 完成修订；不能直接进入
应用实现。

## 完成条件

说明概念和边界、保持不变的契约、兼容性分类、需要的 Action Contracts、验证方式和下一步；并明确本轮是否修改了文件。
