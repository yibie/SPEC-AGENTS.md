# CONTEXT

这是 SPEC-AGENTS 的稳定语义模型。它描述项目长期使用的词、关系和约束，不记录某个 feature 的实现细节。

## Core Concepts

### Change

用户提出的、可能改变行为、模型、架构边界或工作流程的候选差异。Change 先经过 `plan`，不能因为有了一个想法就直接进入代码。

### Plan

对 Change 的需求、未改变基线、兼容性、迁移和验证达成的确认结果。Plan 是进入后续动作的门，不是代码实现方案。

### SPEC

跨上下文工作使用的活的设计契约。SPEC 记录已经确认的目标、边界、决定、Action Contracts 和验证入口；它低于 CONTEXT、ADR 和 Protocol，允许经 `plan` 控制修订。

### Slice

一个新上下文可以完成、可以独立验证的工作单元，记录在 `.scratch/<feature>/issues/`。Slice 不拥有本体定义，也不能绕过 Plan 修改长期规则；完成验证后可以带一个可选的 `evidence_ref` 指向 Evidence。

### State

当前阶段、feature、slice、阻塞项和下一步允许动作。State 描述“现在能做什么”，不代替证据或设计决定。

### Evidence

可复核的观察、验证结果、失败假设和它们对后续判断的影响。Evidence 区分 observation、interpretation 和 recommended next action。

### Action Contract

对一个可观察动作的边界约定：前置条件、输入、允许效果、必须保持的不变量和验证方式。Action Contract 是连接静态模型与代码的最小接口。

### Phase

有入口条件、范围、验收门槛和结束建议的有限工作阶段。Phase 不预拆未来阶段的 issue。

## Stable Relations

```text
Change --plan--> Plan
Plan --capture--> SPEC
SPEC --arrange--> Slice*
Slice --do--> Code
Code --check--> Verification
Verification --learn--> Evidence
Slice --evidence_ref (optional, post-verification)--> Evidence
Evidence --promote when durable--> Context | Protocol | ADR
```

## Lifecycle

```text
candidate → planned → captured → arranged → doing → checked → learned
                                     ↘ blocked / stale / rejected
```

## Invariants

- 语义变化先经过 `plan`；未确认前不改长期文档或应用代码。
- `CONTEXT.md` 保存稳定概念、身份、关系、生命周期和不变量，不保存 feature 方案。
- SPEC 可以活着修订，但改变目标、边界、身份、关系、不变量、接口或验收标准必须重新经过 `plan`。
- `do` 不能静默改变 CONTEXT、ADR、Protocol 或 SPEC；发现冲突就停止并报告。
- Evidence 必须先于完成声明；一次通过不能证明一般性改进。
- `learn` 只提升经验证且会影响未来判断的知识。
- 正式本体 schema、图数据库、生成器和同步基础设施不属于默认模型。

## Change Boundary

新增、重命名、拆分、合并、废弃或重新定义概念、身份、关系、生命周期、不变量或 Action Contract，都是语义变化；即使代码 diff 很小，也必须走 `plan`。

## Legacy Upgrade Boundary

v2 静态 SPEC 和 v3 `.phrase` 都是历史输入状态，不是现代 workflow 的
兼容运行模式。新项目只使用 root documents 和六个 action skills；旧项目
先读取 `UPGRADE.md`，由 Agent 重建历史、扫描代码架构并请求用户确认，再
由六动作流程提炼语义和归档。升级不删除历史资料，也不把旧 task bundle
机械提升为当前模型或状态；安装器只提供入口，不执行语义迁移。
