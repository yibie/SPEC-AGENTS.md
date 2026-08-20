# WORKFLOW

这是 SPEC-AGENTS 工作流自身的稳定语义模型。它描述框架长期使用的词、关系和
约束，不记录某个 feature 的实现细节，也不描述被接入项目的领域。

这份文档属于 Doctrine：它在每个被管项目里内容相同，安装到
`docs/spec-agents/WORKFLOW.md`。被管项目自己的语义在 `KERNEL.md`，项目自己的
上下文和词汇在根 `CONTEXT.md`；两者都不由框架写入。

## Core Concepts

### Change

用户提出的、可能改变行为、模型、架构边界或工作流程的候选差异。Change 先经过 `plan`，不能因为有了一个想法就直接进入代码。

### JJ Change

Jujutsu 对一次本地版本状态的称呼。JJ Change 是版本控制对象，不是
SPEC-AGENTS 的语义 Change；文档中使用限定词 `JJ Change` 避免混淆。

### Start

项目接入 SPEC-AGENTS 的入口 Prompt。Start 负责检查项目状态、生成可供用户
确认的 StartReport，并把项目路由到 `UPGRADE`、安装入口或 `plan`；它不是第七个
action，也不直接实现应用变更。

### ProjectState

Start 对项目入口材料、legacy 痕迹、版本管理标记、近期历史和代码架构做出的
有证据边界的分类：`modern`、`legacy`、`mixed`、`missing-entry` 或 `blocked`。

### KernelStatus

Start 对项目 `KERNEL.md` 的状态标记：`present`、`K1-bootstrap`、`stale`、
`contradicted` 或 `kernel-unavailable`。KernelStatus 与 ProjectState 分开，
避免把“项目入口可用”和“项目语义已建立”混成一个状态。

### StartReport

Start 生成的、等待用户确认的项目认知候选记录。它必须区分 confirmed、inferred
和 unknown，并包含 Kernel 状态、建议路由、问题和用户决定。

### Doctrine

在每个被管项目里内容相同、由安装器发出的框架材料：`AGENTS.md`、`START.md`、
`UPGRADE.md`、`skills/` 和 `docs/spec-agents/`。Doctrine 不含任何仓库实例
事实——不出现某个仓库的阶段号、task 编号、Evidence ID、脚本路径、实验目录，
或任何只在源仓库里存在的路径。

### Instance

某一个仓库自己的状态与知识：`STATUS.md`、`ROADMAP.md`、`EVIDENCE.md`、
`KERNEL.md`、根 `CONTEXT.md`、`docs/adr/`、`docs/protocols/`、`docs/runbooks/`、
`docs/lessons/`、`archive/`。Instance 永远不被安装到另一个项目；把 Instance
当模板发出去会在目标项目里产生假的状态指针。

### Project Kernel

被接入项目的稳定语义层，记录该项目的概念、身份、关系、动作契约、生命周期、
不变量和少量架构边界。它与 `docs/spec-agents/WORKFLOW.md` 不同：WORKFLOW
描述 SPEC-AGENTS 自身的工作流语义，`KERNEL.md` 描述被管理项目的本体。第一次
`start` 扫描在有足够直接证据时建立 `K1`；后续修改必须受控演化。

### Plan

对 Change 的需求、未改变基线、兼容性、迁移和验证达成的确认结果。Plan 是进入后续动作的门，不是代码实现方案。

### SPEC

跨上下文工作使用的活的设计契约。SPEC 记录已经确认的目标、边界、决定、Action Contracts 和验证入口；它低于 CONTEXT、ADR 和 Protocol，允许经 `plan` 控制修订。

### Slice

一个新上下文可以完成、可以独立验证的工作单元，记录在 `.scratch/<feature>/issues/`。Slice 不拥有本体定义，也不能绕过 Plan 修改长期规则；完成验证后可以带一个可选的 `evidence_ref` 指向 Evidence。

### State

当前活跃的 SPEC、slice、阻塞项和下一步允许动作。State 描述“现在能做什么”，
不代替证据或设计决定，也不累积已完成工作的历史——那属于 Evidence。

### Evidence

可复核的观察、验证结果、失败假设和它们对后续判断的影响。Evidence 区分 observation、interpretation 和 recommended next action。

### KnowledgeItem

一条可复用、可审查、可演进的项目知识记录。KnowledgeItem 必须有类别、适用
范围、来源 Evidence 和验证方式；它可以是 Semantic rule、Decision、Protocol、
Runbook 或 Lesson，不等于某个固定文件。

### Action Contract

对一个可观察动作的边界约定：前置条件、输入、允许效果、必须保持的不变量和验证方式。Action Contract 是连接静态模型与代码的最小接口。

## Knowledge Classes

项目知识不只描述代码或领域对象。所有可复用知识都必须有适用范围、来源和
验证路径，但按职责分开保存：

| Class | Meaning | Durable home |
| --- | --- | --- |
| Semantic rule | 概念、身份、关系、生命周期和不变量 | 项目 `KERNEL.md`；框架工作流为 `docs/spec-agents/WORKFLOW.md` |
| Decision | 难以逆转的边界或取舍 | `docs/adr/` |
| Protocol | 稳定的开发、评审、测试和协作约定 | `docs/protocols/` |
| Runbook | 带前置条件、验证和恢复路径的重复操作 | `docs/runbooks/` |
| Lesson | 从已验证失败或重复模式提炼的有范围经验 | `docs/lessons/` |

`EVIDENCE.md` 保存尚未提升的动态事实；`STATUS.md` 保存当前活跃的工作。仓库
不记录未来意图：方向在对话中决定，成为工作时固化为 SPEC。Knowledge Class 是
路由和审查词汇，不是要求引入正式本体 schema 或图数据库。

## Stable Relations

```text
Change --plan--> Plan
Plan --capture--> SPEC
SPEC --arrange--> Slice*
Slice --do--> Code
Code --check--> Verification
Verification --learn--> Evidence
Slice --evidence_ref (optional, post-verification)--> Evidence
Evidence --promote when durable--> Project Kernel | Context | Protocol | ADR
```

Project Kernel relations:

```text
Start --bootstraps_if_absent--> Project Kernel(K1)
StartReport --describes--> Project Kernel | KernelCandidate
Project Kernel --constrains--> SPEC | Action Contract | Code
Evidence --supports / challenges--> Project Kernel
```

Project knowledge relations:

```text
Evidence --supports--> KnowledgeItem
KnowledgeItem --applies_to--> Scope | Action
KnowledgeItem --constrains--> Protocol | Runbook | Code
KnowledgeItem --verified_by--> Verification
KnowledgeItem --supersedes / contradicts--> KnowledgeItem
```

Version-control relations:

```text
Workflow Change --materializes_as--> JJ Change(s)
JJ Change --described_by--> SPEC | Slice
JJ Change --published_as--> Bookmark
Bookmark --bridges_to--> Git remote
```

Start relations:

```text
Start --inspects--> ProjectState
Start --classifies--> KernelStatus
Start --produces--> StartReport
StartReport --confirmed_by--> User
Start --routes--> UPGRADE | Install | Plan
```

## Lifecycle

```text
candidate → planned → captured → arranged → doing → checked → learned
                                     ↘ blocked / stale / rejected
```

Start lifecycle:

```text
unseen → inspected → kernel_bootstrapped → report_ready → user_confirmed → handed_off
                              ↘ rejected / blocked
```

Kernel lifecycle:

```text
absent → bootstrapped(K1) → enacted → revised(Kn) → superseded / rejected
```

## Knowledge Lifecycle

```text
candidate → observed → verified → adopted → superseded / rejected
```

## Invariants

- 语义变化先经过 `plan`；第一次 `start` 建立缺失的 confirmed-only `K1` 是
  初始化例外，不能用来修改已有长期语义。
- 项目 `KERNEL.md` 保存项目稳定概念、身份、关系、生命周期和不变量；
  `docs/spec-agents/WORKFLOW.md` 只保存 SPEC-AGENTS 工作流语义，不保存
  feature 方案；根 `CONTEXT.md` 归被管项目所有，框架不写入。
- SPEC 可以活着修订，但改变目标、边界、身份、关系、不变量、接口或验收标准必须重新经过 `plan`。
- 可以同时有多个活跃 SPEC，但它们的 scope 必须不相交。发现相交就回到 `plan`
  重新划分，不能靠隔离工作副本掩盖——隔离解决执行干扰，不解决范围冲突。
- 两件工作需要同时占用工作副本时（并发构建或测试、多个 agent、一边写代码
  一边跑回归），必须先隔离：有 `.jj/` 用 `jj workspace add`，否则用
  `git worktree add`。串行地在 SPEC 之间切换不需要隔离。
- `STATUS.md` 只记录活跃的 SPEC、阻塞项和下一步；SPEC 完成即从中移除，结果
  留在 `EVIDENCE.md`。它不保存已关闭的工作段落，也不是第二份历史账本。
- `do` 不能静默改变 `KERNEL.md`、`CONTEXT.md`、`docs/spec-agents/`、ADR、
  Protocol、Runbook、Lesson 或 SPEC；发现冲突就停止并报告。
- Evidence 必须先于完成声明；一次通过不能证明一般性改进。
- `learn` 只提升经验证且会影响未来判断的知识。
- Protocol、Runbook 和 Lesson 必须写明 `status`、`scope`、`applies_when`、
  来源 Evidence 和验证方式；未验证的建议留在 Evidence。
- `check` 只验证，`learn` 是提升和写入长期知识的唯一动作；知识冲突时标记
  `revise`、`superseded` 或 `rejected`，不能静默覆盖旧记录。
- 在存在 `.jj/` 的项目中，JJ 是默认的本地版本控制接口；本地操作使用
  `jj status/log/diff/new/describe/edit/undo`，不使用 Git 的 staging、stash
  或 branch 词汇。
- 远端发布通过 bookmark 和 `jj git fetch/push` 连接 Git remote；普通
  `do`/`check` 不得隐式 push 或创建远端 bookmark。
- 没有 `.jj/` 的项目不自动初始化；启用 colocated JJ 必须经过用户明确选择
  和 setup Runbook。
- 第一次 `start` 在 `KERNEL.md` 缺失且扫描得到直接确认事实时，可以建立项目
  `KERNEL.md` 的 `K1`；只写 confirmed 内容，不覆盖已有 Kernel。除此之外，
  `start` 在用户确认前只能写 `.scratch/start/REPORT.md`，不能修改应用代码、
  依赖、配置、legacy 文件或版本历史。
- `start` 不是第七个 action；确认后的现代项目必须进入 `plan`，legacy/mixed
  项目必须路由到 `UPGRADE.md`，不能绕过六动作或复制迁移流程。
- `StartReport` 必须区分 confirmed、inferred 和 unknown；未确认的候选认知
  不能进入 `KERNEL.md` 的 enacted sections 或默认上下文。
- 已有 `KERNEL.md` 时，`start` 只能报告冲突或陈旧，不得静默覆盖；首次 K1
  建立后，Kernel 的后续演化必须经过 `plan`、验证和 `learn`。
- 安装器只发出 Doctrine，且使用显式白名单而不是目录枚举；任何 Instance
  文件进入安装载荷都是缺陷，不是配置问题。
- 从 `templates/` 发出的文件在任何模式下都是拷贝，包括 `--link`；软链会让
  被管项目写回源仓库。
- 正式本体 schema、图数据库、生成器和同步基础设施不属于默认模型。

## Change Boundary

新增、重命名、拆分、合并、废弃或重新定义概念、身份、关系、生命周期、不变量、
Action Contract，或改变 Protocol、Runbook、Lesson 的适用范围、约束效果和验收
方式，都是语义变化；即使代码 diff 很小，也必须走 `plan`。

## Legacy Upgrade Boundary

v2 静态 SPEC 和 v3 `.phrase` 都是历史输入状态，不是现代 workflow 的
兼容运行模式。新项目只使用 root documents 和六个 action skills；旧项目
先读取 `UPGRADE.md`，由 Agent 重建历史、扫描代码架构并请求用户确认，再
由六动作流程提炼语义和归档。升级不删除历史资料，也不把旧 task bundle
机械提升为当前模型或状态；安装器只提供入口，不执行语义迁移。
