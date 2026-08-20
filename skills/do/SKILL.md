---
name: do
description: 执行一个已经批准且未阻塞的工作切片，完成最小代码变更、测试和状态交接。适用于已有 SPEC/issue 的实现，或语义已经确定的小型修改。
---

# Do

只执行当前允许的一个切片，不重新打开已经确认的设计。

## 开始前

读取 `AGENTS.md`、`docs/spec-agents/WORKFLOW.md`、`CONTEXT.md`、项目 `KERNEL.md`（若存在）、`STATUS.md`、相关 `SPEC.md`、一个目标 issue 和必要的 Protocol、Runbook、Lesson。确认：

- issue 状态是 `ready` 或已明确授权的 `doing`；
- 所有 `blocked_by` 已完成；
- SPEC 没有 `stale`；
- 当前代码、测试和配置与任务范围一致。

## 执行

1. 先追踪真实调用链和既有 seam，选择最小可行改动。
2. 对有分支、循环、解析、金钱或安全影响的逻辑，留下一个可运行的检查。
3. 保持 Action Contract、不变量和数据契约不变，除非 `plan` 已批准兼容修订。
4. 运行任务要求的测试、类型检查、静态检查或最小手工验证。
5. 只更新当前 issue 的状态和验证摘要，供 `check`、`learn` 使用；保持
   `evidence_ref` 为空。
6. 不写根目录 Evidence，也不回写 Evidence ID。

如果仓库存在 `.jj/`，本地版本操作遵循 JJ：用 `jj new`/`jj edit` 开始上下文、
用 `jj describe` 记录意图、用 `jj status`/`jj diff` 检查。把当前 JJ Change
ID 写入 issue 或交接摘要时，仍然以 SPEC/issue 作为语义来源；不要用
`git add`、`git commit` 或 `git stash` 模拟 JJ。没有 `.jj/` 时才沿用项目现有
Git 工作流；不要在 `do` 中自动初始化或 push。

## 发现冲突时

发现新的概念、身份、关系、生命周期、不变量、接口或知识适用范围冲突时：

- 停止扩张实现；
- 保留可重现的事实和失败验证；
- 将 issue 标为 `blocked` 或 `stale`；
- 回到 `plan`，不直接修改 `KERNEL.md`、`docs/spec-agents/`、`CONTEXT.md`、ADR、Protocol、Runbook、Lesson 或 SPEC。

## 完成条件

代码只覆盖当前切片，任务验证已运行，issue 状态和剩余 blocker 已记录，并把可复核的证据交给 `check`。
