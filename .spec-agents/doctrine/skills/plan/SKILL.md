---
name: plan
description: 在执行前质询并分类一项可能改变语义、架构边界或工作规模的请求。适用于新增、重命名、拆分、合并、废弃或重新定义概念、身份、关系、生命周期、不变量、Action Contract，或需要跨多个上下文推进的工作；语义已经确定且只是实现细节的修改可跳过。
---

# Plan

把“要不要改、改什么、改到哪里”为止先说清楚，再允许后续动作。

## 读取

1. 读取 `AGENTS.md`、`.spec-agents/doctrine/docs/WORKFLOW.md`、`CONTEXT.md`、`.spec-agents/state/STATUS.md`；
   项目有 `.spec-agents/state/KERNEL.md` 时一并读取。
2. 只有当前判断需要历史依据、风险分类或回归对比时，才读取 `.spec-agents/state/EVIDENCE.md` 或 `.spec-agents/archive/`。
3. 查代码、调用方、测试和配置来回答事实；不要把可以查到的事实丢给用户回答。

## 质询

按设计树分轮工作：

- 先确认需求、未改变的基线和“不改会怎样”。
- 只问当前前置条件已经确定的问题；每轮完整询问当前 frontier，再等待用户回答。
- 区分事实与决定：事实由 agent 查，取舍由用户确认。
- 继续到没有未决分支，不因一个看似合理的解释提前结束。
- `.spec-agents/state/STATUS.md` 已有活跃 SPEC 时，检查新工作的 scope 是否与它们相交。相交就在
  这一轮重新划分边界，不要留到执行时用隔离工作副本掩盖。
- 确认工作要写的文件各归哪个动作。被管项目中安装进来的 doctrine 不属于任何
  动作，需要改它说明这项工作属于上游仓库，不属于本项目。

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
- `plan-only`：输出边界明确的计划，等待执行授权。获得授权后：单上下文可完成的
  交给 `do`（`do` 的短路径接受已授权的 `plan-only`），跨上下文的交给 `capture`。
- `approve`：语义不变**且**当前上下文内可完成，交给 `do`。两个条件都要满足；
  语义不变但一个上下文完不成的工作走 `capture`——它需要的是可交接的契约，
  不是语义门。**大小不是判据**：Change Boundary 已经写明一个很小的 diff
  也可能是语义变化。这条路径不产生 SPEC 也不产生 Slice。
- `compatible revise`：明确一个兼容替代方案，保留旧不变量和数据契约。跨上下文的
  交给 `capture`，单上下文可完成的交给 `do`（`do` 的短路径接受它）。
- `breaking`：必须确定迁移方案，由 `capture` 写进 SPEC，不能伪装成兼容修改。
  **ADR 由 `learn` 在收尾时写**，和其它长期记录一样——此刻还没有任何东西被
  验证过，`learn` 的触发条件尚未满足（见 `docs/adr/0004`）。
- `reject` / `unresolved`：停止；只有用户需要长期记忆时才交给 `learn` 留痕。

## `approve` 必须交出什么

短路径不产生 SPEC 也不产生 Slice，所以 `plan` 必须在路由时口头交出两样东西，
否则 `do` 无从开始、`check` 无从比对：

- **保持不变的契约** —— `do` 不得扰动的不变量、接口或数据契约；
- **怎么算完** —— 一句可验证的验收，`check` 就对着它比。

两样都不是文件。默认不落盘：确认是口头的，痕迹在版本控制里。

只有当 `plan` 判断这次工作可能活过当前上下文时——改动较长、环境不确定、
中途交接会让下一个上下文失去范围——才在 `.spec-agents/state/STATUS.md` 记一条，含 scope、
那句验收和下一步许可动作，由 `learn` 在完成时移除。

这个条件是刻意的：每次都记，一个错别字修复也要写状态，就是往 ticket 病走；
永远不记，会话在 `do` 中途结束时下一个上下文就断了。

## 写入边界

- 共享理解确认前只读，不修改仓库。
- 首次 `START` 已经可以在缺失时建立只含 confirmed facts 的 `.spec-agents/state/KERNEL.md` K1；
  `plan` 不覆盖它，也不直接修改已有 Kernel。
- 不直接修改 `.spec-agents/doctrine/docs/`、`CONTEXT.md`、已有 `.spec-agents/state/KERNEL.md`、`docs/adr/` 或
  `docs/protocols/`。
- 语义变化的静态知识由 `learn` 在验证后提升。
- 规划结果交给下一个 skill，不建立第二套临时需求文档。

## Kernel Bootstrap

当 `.spec-agents/doctrine/START.md` 报告 `K1-bootstrap` 时，先检查 K1 是否只包含代码、测试、配置
或既有 durable record 直接确认的事实。用户确认只处理候选扩展、冲突和未知项；
不能因为这些未决项而跳过 K1。若 K1 不足以约束当前动作，路由到
`capture` 记录 Bootstrap SPEC，再由 `check`/`learn` 完成修订；不能直接进入
应用实现。

## 完成条件

说明概念和边界、保持不变的契约、兼容性分类、需要的 Action Contracts、验证方式和下一步；并明确本轮是否修改了文件。
