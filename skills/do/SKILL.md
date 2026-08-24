---
name: do
description: 执行一个已经批准且未阻塞的工作切片，完成最小代码变更、测试和状态交接。适用于已有 SPEC 与 Slice 的实现，或 plan 直接 approve 的单上下文改动。
---

# Do

只执行当前允许的一个切片，不重新打开已经确认的设计。

## 开始前

先确定走的是哪一条路径，两条的前置条件不同。

### SPEC 路径（经过 `capture` 与 `arrange`）

读取 `AGENTS.md`、`docs/spec-agents/WORKFLOW.md`、`CONTEXT.md`、项目
`KERNEL.md`（若存在）、`STATUS.md`、相关 `SPEC.md`、一个目标 Slice 和必要的
Protocol、Runbook、Lesson。确认：

- Slice 状态是 `ready` 或已明确授权的 `doing`；
- 所有 `blocked_by` 已完成；
- SPEC 没有 `stale`；
- Slice 未声明 `writer:`，或声明的就是 `do`；
- Slice 的 `authority:` 与 Kernel 的 Architecture boundaries 对得上；
- 当前代码、测试和配置与任务范围一致。

### 短路径（`plan` 直接给出 `approve`）

这条路径上没有 SPEC 也没有 Slice。**不要为它创建一个** —— 那正是这套流程
拒绝的 ticket。读取 `AGENTS.md`、`docs/spec-agents/WORKFLOW.md`、
`CONTEXT.md`、项目 `KERNEL.md`（若存在）、`STATUS.md` 和必要的 Protocol、
Runbook、Lesson。确认：

- `plan` 给出的结果是 `approve`；
- 它交出的「保持不变的契约」和那句验收都已知；
- 工作仍然可以在当前上下文内完成。

执行中发现它不再是单上下文的工作，停下回到 `plan`，不要就地编一个 SPEC。

### 两条路径都适用：先对权威落点

动手前把这次要写的位置，对照项目 `KERNEL.md` 的 Architecture boundaries
（权威落点地图）。**目标位置不在图上就停下，回到 `plan`** —— 要么地图不全，
要么落点不对，两者都不是 `do` 能自己决定的。短路径上没有 Slice，就直接拿
打算落笔的模块去对。

`do` 从不修改这张图。在症状出现的那一层顺手加分支，是功能生效但生效在错误
位置的主要方式。

## 执行

1. 先追踪真实调用链和既有 seam，选择最小可行改动。
2. 对有分支、循环、解析、金钱或安全影响的逻辑，留下一个可运行的检查。
3. 保持 Action Contract、不变量和数据契约不变，除非 `plan` 已批准兼容修订。
4. 运行任务要求的测试、类型检查、静态检查或最小手工验证。
5. 只更新当前 Slice 的状态和验证摘要，供 `check`、`learn` 使用；短路径
   上没有 Slice 可更新，跳过这一步；保持
   `evidence_ref` 为空。
6. 不写根目录 Evidence，也不回写 Evidence ID。

如果仓库存在 `.jj/`，本地版本操作遵循 JJ：用 `jj new`/`jj edit` 开始上下文、
用 `jj describe` 记录意图、用 `jj status`/`jj diff` 检查。把当前 JJ Change
ID 写入 Slice 或交接摘要时，仍然以 SPEC 与 Slice 作为语义来源；不要用
`git add`、`git commit` 或 `git stash` 模拟 JJ。没有 `.jj/` 时才沿用项目现有
Git 工作流；不要在 `do` 中自动初始化或 push。

## 发现冲突时

发现新的概念、身份、关系、生命周期、不变量、接口或知识适用范围冲突时：

- 停止扩张实现；
- 保留可重现的事实和失败验证；
- 将 Slice 标为 `blocked` 或 `stale`；短路径上没有 Slice，直接回到 `plan`；
- 回到 `plan`，不直接修改 `KERNEL.md`、`CONTEXT.md`、ADR、Protocol、Runbook、Lesson 或 SPEC。

## 写入边界

`do` 写 `Code`，以及当前 Slice 的状态和验证摘要。除此之外都不写：

- `KERNEL.md`、`CONTEXT.md`、`STATUS.md`、`EVIDENCE.md` 和
  `docs/{adr,protocols,runbooks,lessons}/` 由 `learn` 写入；
- `.specs/<feature>/SPEC.md` 由 `capture` 写入，Slice 由 `arrange` 创建；
  `do` 在任何路径上都不创建 Slice；
- 被管项目中，安装进来的 doctrine（`AGENTS.md`、`START.md`、`UPGRADE.md`、
  `skills/`、`docs/spec-agents/`）任何动作都不写——本地修改会被下一次安装
  覆盖，要改就改上游。

产品是什么，`Code` 就是什么：在 SPEC-AGENTS 仓库自身，上面那五者就是它的
`Code`，`do` 写它们；在被管项目里它们是 doctrine。

切片声明了 `writer:` 且不是 `do` 时，`do` 不执行它，交回给该动作。

## 完成条件

代码只覆盖当前切片，任务验证已运行，Slice 状态和剩余 blocker 已记录（短路径上没有 Slice，把范围和验证结果口头交给 `check`），并把可复核的证据交给 `check`。
