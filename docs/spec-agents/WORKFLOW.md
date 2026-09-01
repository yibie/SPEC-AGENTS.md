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

项目接入 SPEC-AGENTS 的入口 Prompt：检查项目状态、生成可供用户确认的
StartReport、路由到 `UPGRADE`／安装／`plan`。不是第七个 action。

### Upgrade

An existing-project bootstrap entry that extracts user-approved candidate knowledge,
moves retired workflow material out of the active read path, replaces installed doctrine
through an explicit recoverable installer operation, and hands the project to a fresh START.
Upgrade does not translate old execution state into current state and is not a seventh action.

### ProjectState

Start classifies the active project as `modern`, `upgrade-needed`, `missing-entry`, or
`blocked`. `upgrade-needed` means retired SPEC-AGENTS workflow material is active or the
installed doctrine cannot safely establish the current entry contract. Source-generation
labels are evidence in the report, not runtime states and not selectors for separate migration engines.

### KernelStatus

Start 对项目 `KERNEL.md` 的状态标记：`present`、`K1-bootstrap`、`stale`、
`contradicted`、`kernel-unavailable`。与 ProjectState 分开，避免把「入口可用」
和「语义已建立」混成一个状态。

`stale` 和 `contradicted` 由 `start` 的 re-scan 产出——那是唯一会重新扫描
现实的动作，它不修改 `KERNEL.md`，也不自行路由（ADR 0005）。

### StartReport

Start 生成的、等待用户确认的项目认知候选记录。它必须区分 confirmed、inferred
和 unknown，并包含 Kernel 状态、建议路由、问题和用户决定。

### Doctrine

由安装器发出、在每个被管项目里内容相同的框架材料：`AGENTS.md`、`START.md`、
`UPGRADE.md`、`skills/`、`docs/spec-agents/`。不含任何单个仓库的实例事实
（ADR 0001）。

### Instance

某一个仓库自己的状态与知识：`STATUS.md`、`EVIDENCE.md`、`KERNEL.md`、根
`CONTEXT.md`、`.specs/`、`docs/{adr,protocols,runbooks,lessons}/`、`archive/`。
永不安装到另一个项目（ADR 0001）。

### Project Kernel

被接入项目的稳定语义层：概念、身份、关系、动作契约、生命周期、不变量和少量
架构边界。WORKFLOW 描述框架自身的工作流语义，`KERNEL.md` 描述被管项目的本体。
第一次 `start` 在有足够直接证据时建立 `K1`，后续必须受控演化。

### Plan

对 Change 的需求、未改变基线、兼容性、迁移和验证达成的确认结果。Plan 是进入后续动作的门，不是代码实现方案。

### SPEC

跨上下文工作的活的设计契约，持久保存在 `.specs/<feature>/SPEC.md`：已确认的
目标、边界、决定、Action Contracts 和验证入口。低于 CONTEXT、ADR 和 Protocol，
经 `plan` 控制修订。工作结束后留在原地（ADR 0003）。

对于跨过 Change Boundary 的 Change，SPEC 的 `## Model delta` 是拟议的 Kernel
delta：工作验证后，将在项目 `KERNEL.md`（本仓库为 `WORKFLOW.md`）中新增、修订、
取代或退役的概念、身份、关系、生命周期状态、不变量或 Action Contract。`do`
据此实现，`learn` 只按原样提升它。提议状态由 SPEC 自身的 lifecycle 承载；
`kernel:` 行不增加 `proposed` 状态。

没有 `kernel_delta:` frontmatter 字段的 SPEC 按 `kernel_delta: none` 读取。这是
有意保留的 legacy 默认值，不是未知状态；字段的动词为 `add | revise | supersede | retire`。

### Slice

一个新上下文可以完成、可以独立验证的工作单元，记录在 `.specs/<feature>/issues/`。Slice 不拥有本体定义，也不能绕过 Plan 修改长期规则；完成验证后可以带一个可选的 `evidence_ref` 指向 Evidence。

### Code

受 SPEC、Kernel 和 Action Contract 约束的产物，`do` 写的就是它。产品是什么
它就是什么：应用项目里是源码、测试和配置；SPEC-AGENTS 自身的产品是 doctrine，
所以那五者加 `bin/` 是本仓库的 `Code`。关于产品的知识在任何项目里都不是
`Code`（ADR 0004）。

### State

当前活跃的 SPEC、slice、阻塞项和下一步允许动作。State 描述“现在能做什么”，
不代替证据或设计决定，也不累积已完成工作的历史——那属于 Evidence。

### Evidence

可复核的观察、验证结果、失败假设和它们对后续判断的影响。Evidence 区分 observation、interpretation 和 recommended next action。

### KnowledgeItem

一条可复用、可审查、可演进的项目知识记录，必须有类别、适用范围、来源
Evidence 和验证方式。可以是 Semantic rule、Decision、Protocol、Runbook 或
Lesson，不等于某个固定文件。

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
Change --plan--> Plan --capture--> SPEC --arrange--> Slice* --do--> Code
Code --check--> Verification --learn--> Evidence
Slice --evidence_ref (optional, post-verification)--> Evidence
SPEC --learn when every Slice is done--> SPEC(verified)
Evidence --promote when durable--> Project Kernel | Context | Protocol | ADR

Start --inspects--> ProjectState;  --classifies--> KernelStatus
Start --produces--> StartReport --confirmed_by--> User
Start --routes--> UPGRADE | Install | Plan
Start --bootstraps_if_absent--> Project Kernel(K1)
StartReport --describes--> Project Kernel | KernelCandidate

Project Kernel --constrains--> SPEC | Action Contract | Code
Evidence --supports / challenges--> Project Kernel
Evidence --supports--> KnowledgeItem
KnowledgeItem --applies_to--> Scope | Action
KnowledgeItem --constrains--> Protocol | Runbook | Code
KnowledgeItem --verified_by--> Verification
KnowledgeItem --supersedes / contradicts--> KnowledgeItem

Workflow Change --materializes_as--> JJ Change(s)
JJ Change --described_by--> SPEC | Slice;  --published_as--> Bookmark
Bookmark --bridges_to--> Git remote
```

## Lifecycle

```text
work:    candidate → planned → captured → arranged → doing → checked → learned
                                              ↘ blocked / stale / rejected
spec:    draft → confirmed → in-progress → revised → verified → superseded
start:   unseen → inspected → kernel_bootstrapped → report_ready
                            → user_confirmed → handed_off   ↘ rejected / blocked
kernel:  absent → bootstrapped(K1) → enacted → revised(Kn) → superseded / rejected
knowledge: candidate → observed → verified → adopted → superseded / rejected
```

`verified` 是 SPEC 完成工作后的终态，由 `learn` 在收尾时写入；它的前置条件在
`skills/learn/SKILL.md`，不在这里复述。`superseded` 是另一条出口——被另一份
SPEC 取代——两者不是同义词。

只重锚 `source`、enacted 语义零变化的修订仍是一次 `revised(Kn)`，此时每条
记录的 `since:` 不变。每条记录带自己的 `since:` 与 `source:`；版本号只在文件
级，不逐项计数，不在文件内维护 changelog（ADR 0005）。

`stale` 与 `contradicted` 由 `start` 的 re-scan 产出，或由 `check` 的
`semantic` 发现引出；两者都不修改 `KERNEL.md`，只交给 `plan`。

## Invariants

- 语义变化先经过 `plan`；第一次 `start` 建立缺失的 confirmed-only `K1` 是
  初始化例外，不能用来修改已有长期语义。
- 项目 `KERNEL.md` 保存项目语义；本文件只保存 SPEC-AGENTS 工作流语义；根
  `CONTEXT.md` 归项目所有（ADR 0001）。
- SPEC 可以活着修订，但改变目标、边界、身份、关系、不变量、接口或验收标准必须重新经过 `plan`。
- 可以同时有多个活跃 SPEC，但 scope 必须不相交；相交回 `plan` 重新划分，
  隔离工作副本不解决范围冲突（ADR 0002）。
- 两件工作需要同时占用工作副本时必须隔离：`jj workspace add`，或
  `git worktree add`。串行切换不需要。
- `.specs/` 是被跟踪的长期工作契约，只由项目工作写入，安装器不碰；
  `docs/spec-agents/` 归属相反。引用时写完整路径。`.scratch/` 只放等确认的
  一次性报告；建议项目忽略它，但框架不写项目的 `.gitignore`（ADR 0003）。
- `STATUS.md` 只记录活跃 SPEC、阻塞项和下一步；完成即移除，不保存已关闭的
  段落（ADR 0002）。
- 被管项目中，任何动作都不写安装进来的 doctrine（`AGENTS.md`、`START.md`、
  `UPGRADE.md`、`skills/`、`docs/spec-agents/`）；要改就改上游。SPEC-AGENTS
  自身是例外——那五者是它的 `Code`（ADR 0004）。
- `do` 只写 `Code` 与当前切片的状态；`KERNEL.md`、`CONTEXT.md`、`STATUS.md`、
  `EVIDENCE.md`、ADR、Protocol、Runbook、Lesson 由 `learn` 写入，SPEC 由
  `capture` 写入。发现语义冲突就停止回到 `plan`（ADR 0004）。
- 切片的 Scope 含 `do` 不拥有的文件时必须声明 `writer:`；切片的验收必须在
  它自己的 Scope 内可达，越界是拆分错误（ADR 0004）。
- Evidence 必须先于完成声明；一次通过不能证明一般性改进。
- `learn` 只提升经验证且会影响未来判断的知识。
- Protocol、Runbook 和 Lesson 必须写明 `status`、`scope`、`applies_when`、
  来源 Evidence 和验证方式；未验证的建议留在 Evidence。
- `check` 只验证，三轴：已确认契约、工程标准、引用完整性。本次改动触及的每
  一条引用都必须仍能解析；属于历史记述的记为历史，不修补（ADR 0004）。
- `learn` 是提升知识的唯一动作；知识冲突时标记 `revise`、`superseded` 或
  `rejected`，不能静默覆盖旧记录。
- 在存在 `.jj/` 的项目中，JJ 是默认的本地版本控制接口；本地操作使用
  `jj status/log/diff/new/describe/edit/undo`，不使用 Git 的 staging、stash
  或 branch 词汇。
- 远端发布通过 bookmark 和 `jj git fetch/push` 连接 Git remote；普通
  `do`/`check` 不得隐式 push 或创建远端 bookmark。
- 没有 `.jj/` 的项目不自动初始化；启用 colocated JJ 必须经过用户明确选择
  和 setup Runbook。
- 第一次 `start` 在 `KERNEL.md` 缺失且有直接确认事实时建立 `K1`，只写
  confirmed 内容。其余情况 `start` 在用户确认前只能写
  `.scratch/start/REPORT.md`。
- `start` 不是第七个 action；确认后的现代项目必须进入 `plan`；
  `upgrade-needed` 项目进入 `UPGRADE.md`，清场后重新 START，不继承旧工作状态。
- `StartReport` 必须区分 confirmed、inferred 和 unknown；未确认的候选认知
  不能进入 `KERNEL.md` 的 enacted sections 或默认上下文。
- 已有 `KERNEL.md` 时，`start` 只能报告冲突或陈旧，不得静默覆盖；首次 K1
  建立后，Kernel 的后续演化必须经过 `plan`、验证和 `learn`。
- 安装器只发出 Doctrine，用显式白名单而非目录枚举（ADR 0001）。
- 从 `templates/` 发出的文件在任何模式下都是拷贝，包括 `--link`；软链会让
  被管项目写回源仓库。
- 正式本体 schema、图数据库、生成器和同步基础设施不属于默认模型。

## Change Boundary

新增、重命名、拆分、合并、废弃或重新定义概念、身份、关系、生命周期、不变量、
Action Contract，或改变 Protocol、Runbook、Lesson 的适用范围、约束效果和验收
方式，都是语义变化；即使代码 diff 很小，也必须走 `plan`。
语义变化必须在 `do` 开始前于 SPEC 的 `## Model delta` / `kernel_delta:` 中声明。

## Upgrade Boundary

Retired workflow material is historical input, never a compatibility runtime and never a source of current
execution state. Upgrade first produces an exact preservation manifest and stops for user confirmation.
Confirmation writes a cutover receipt that binds the canonical target and backup to the confirmed report hash
and records zero unresolved rows; doctrine replacement refuses before any write unless that receipt matches the
invocation and report. Confirmed cutover keeps an immutable copy of the approved report, keeps retired material
recoverable, removes it from the active read path, replaces only installer-owned doctrine, and ends at a fresh START.
Preserved knowledge remains candidate until the current project and the user confirm it; active intent is planned and captured again. Application code and unclassified project-owned documents do not change.
