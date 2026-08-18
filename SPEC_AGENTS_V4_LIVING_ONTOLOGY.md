# SPEC-AGENTS v4：本体治理的 Living SPEC

> 状态：设计草案。Phase 4 直目录复验已让两个 Luna 落盘，但 treatment 在 R2 失败，仍无有效端到端样本；本文仍不替换现有 `AGENTS.md`。

## 1. 核心命题

SPEC 不是一组静态文档，也不是不断累积的工作日志。它是一个随证据演化、由稳定语义约束的决策系统。

```text
Living SPEC = Ontology Kernel + Operational State + Evolution Protocol
Agent Context = project(Living SPEC, current intent)
Software Architecture = realize(Ontology Kernel)
```

- **Ontology Kernel** 固定长期语义、原则和架构边界，但允许受控演化。
- **Operational State** 保存当前事实、阶段、证据和阻塞，持续变化。
- **Evolution Protocol** 决定动态事实何时足以改变稳定抽象。
- **Agent Context** 只是按当前意图生成的最小投影，不是新的事实来源。
- **Software Architecture** 是本体的工程实现，不与本体形成两套平行模型。

文件只是这个逻辑系统的存储适配器。文件名、目录和拆分方式可以改变，以上语义不得因此改变。

## 2. 目标与边界

### 目标

1. 让 Agent 同时看到长期方向与当前事实。
2. 让跨阶段形成的稳定抽象得到沉淀，而不是留在历史证据中。
3. 允许框架演化，但禁止实现过程静默改写长期原则。
4. 用最小上下文完成定向、执行、验证和学习。
5. 让软件模块、接口、动作、约束和权限都能追溯到同一套领域语义。

### 非目标

- 不构建通用知识图谱平台。
- 不要求把所有内容立即机器可读化。
- 不把每个代码类型、文件或临时任务提升为本体概念。
- 不为远期工作预建完整分类体系或自动化工具链。

## 3. 统一语言

| 术语 | 含义 |
|---|---|
| Kernel | 当前已生效、缓慢变化的稳定语义模型 |
| Actor | 作出决策或执行 Action 的人、Agent 或系统角色 |
| Decision | Actor 基于当前事实与约束必须作出的选择 |
| Concept | 对业务或系统具有长期身份的概念 |
| Capability | 系统为支持 Decision 而长期提供的能力 |
| Relation | 概念之间具有决策意义的关系、所有权或依赖 |
| Action | Actor 可以执行、会产生可观察效果的行为 |
| Invariant | 无论当前实现如何都必须成立的原则 |
| Contract | 模块或 Action 的输入、输出、守卫、效果和失败语义 |
| Policy | Actor 在什么条件下可以查看或执行什么 |
| State | 当前阶段成立、但可能随新事实改变的运行状态 |
| Evidence | 能支持、挑战或区分决策的可验证观察 |
| Delta | 对 Kernel 的显式修改提案 |
| Bootstrap Gate | 没有适用 Kernel 时，初始语义生效前必须通过的最小完整性检查 |
| Gate | 已有 Kernel 的 Delta 生效前必须通过的影响检查和验证条件 |
| View | 针对一个意图生成的最小上下文投影 |

判断一个术语是否应进入 Kernel，只问三个问题：

1. 它是否跨阶段仍保持同一含义？
2. 多个决策是否依赖它？
3. 如果误解它，是否会造成架构、行为、安全或产品错误？

三个问题都是否定时，它应留在 State 或 Evidence 中。

## 4. 三个逻辑模块

### 4.1 Ontology Kernel

Kernel 对 Agent 提供两种能力：

```text
lookup(intent) -> relevant concepts, actions, invariants, contracts, policies
version()      -> enacted kernel version
```

Kernel 隐藏具体文档布局。它必须保持短小、可导航，并只保存长期有效的语义。

Kernel 不接受直接写入。任何语义变化必须经过 Evolution Protocol。

如果 `lookup(intent)` 找不到适用 Kernel，Agent 必须进入 Kernel Bootstrap Gate。Kernel 缺失是初始化信号，不是跳过稳定语义的许可。

### 4.2 Operational State

State 对 Agent 提供三种能力：

```text
orient(intent)          -> current goal, scope, blockers, relevant pointers
record(outcome)         -> verified result or failure
record(evidence)        -> decision-relevant observation
```

State 保存当前阶段和近期事实，不承担永久记忆。过期状态应被压缩或归档。

### 4.3 Evolution Protocol

Evolution Protocol 是 Kernel 与 State 之间唯一合法的写桥：

```text
Evidence
  -> Delta Proposal
  -> Impact Check
  -> Gate
  -> Promote | Reject
```

它提供两种能力：

```text
propose(delta, evidence) -> candidate delta
decide(candidate)        -> promoted | rejected | needs-evidence
```

被拒绝的 Delta 应保留拒绝理由，防止同一路径被无证据地重复探索。

### 4.4 Kernel Bootstrap Gate

Bootstrap 只处理没有适用 Kernel 的新系统或新 bounded context。已有 Kernel 的修改仍使用 Delta，不得借 Bootstrap 绕过演化闸门。

Bootstrap 输入是用户明确表达的意图、可观察结果和约束。它不是对整个领域建模，而是在第一次 `Act` 前建立当前 phase 必需的最小 Kernel Snapshot：

```text
scope:       这份 Snapshot 适用于什么决策边界
source:      哪些用户意图或权威输入定义了初始语义
concepts:    当前决策需要保持身份的概念
actions:     Actor 可以执行的行为
invariants:  行为前后都必须成立的原则
contracts:   每个 Action 的 guard / effect / observable outcome / verify
```

Bootstrap Gate 通过条件：

1. 当前 phase 的每个用户可观察结果都映射到一个 Action Contract。
2. 每个 Contract 都有可执行或可观察的验证场景。
3. 会造成产品、架构、安全或数据错误的假设已表达为 Invariant。
4. Snapshot 只覆盖当前决策所需语义，没有预建远期模型。
5. Snapshot 的来源可追溯到用户意图或其他明确权威输入。

通过后生成初始 Kernel 版本 `K1`。未通过时继续澄清或 discovery，不得开始实现。

## 5. 本体如何包装软件架构

本体不是架构图外面的一层说明文字。架构必须实现本体中的语义：

| 本体元素 | 软件工程落点 |
|---|---|
| Capability / Concept | 模块职责与稳定身份 |
| Relation | 所有权、依赖和数据流 |
| Action | 公共接口、命令或工作流入口 |
| Contract | 输入输出、守卫、效果、错误语义和测试 |
| Invariant | 架构约束、断言和验收门槛 |
| Policy | 授权、数据边界和审计规则 |
| Evidence | 测试、trace、benchmark、audit 或用户观察 |

架构设计遵守以下规则：

1. 模块边界围绕稳定职责和信息隐藏形成，而不是照搬当前目录。
2. Action 是跨越模块边界的主要动词；实现细节不得泄漏为公共契约。
3. Adapter 可以替换，但 Kernel 中的语义和 Contract 不得静默漂移。
4. 实现重构不自动产生 Kernel 新版本。
5. Concept、Action、Invariant、Contract 或 Policy 的语义变化必须产生 Delta。

## 6. Agent 执行协议

每个请求按以下最短闭环运行：

### 1. Orient

根据用户意图读取 Kernel View 与当前 State View。只有指针命中时才加载详细 Contract、Evidence 或历史。

若没有适用 Kernel，立即进入 Kernel Bootstrap Gate；不得把所有语义留给实现自行决定。

完成条件：能说清当前决策、适用约束、已知事实和未知项，且已有适用 Kernel 或明确进入 Bootstrap。

### 2. Frame

把工作表达为：

```text
Actor -> Decision -> Action -> Expected Outcome
             constrained by Invariant / Contract / Policy
```

若请求无法映射到已有 Action，不得假装它已经被规范覆盖；应先澄清，或提出最小 Delta。

新系统通过 Bootstrap 建立 Action。已有系统缺少 Action 时提出 Delta。无论哪条路径，每个当前 Action 都必须具备 `guard / effect / observable outcome / verify`。

完成条件：当前切片的每个可观察结果都能追溯到 Action Contract。

### 3. Act

只执行当前 State 中已测量、且符合 Kernel 的最小切片。相邻发现只记录，不顺手扩张。

完成条件：实现没有绕过 Action Contract，且没有在代码中引入未声明的长期语义。

### 4. Verify

逐项执行 Contract 中的 `verify`，并把结果映射回对应的 observable outcome。未经验证的输出只能标记为假设或观察。

语法、类型和静态文件检查只能证明产物可解析或存在；只要 Contract 描述了运行时行为，它们就不能单独关闭验证 gate。

完成条件：每个当前 Action Contract 都有通过、失败或 blocked 的 Evidence；不存在以较弱检查替代行为证明的条目。

### 5. Learn

记录会改变后续决策的 Evidence，并更新 State。普通流水账不进入长期上下文。

### 6. Evolve（按需）

只有 Evidence 持续挑战现有语义，或暴露缺失的长期抽象时，才提出 Delta。一次异常默认留在 State，不立即改 Kernel。

### 7. Close

完成前检查：结果已按 Contract 验证、剩余 blocker 已分类、下一步由新 Evidence 推导；若存在语义冲突，已有 Delta 或明确拒绝理由。

State 中声明的 acceptance gate 与 Evidence 中实际执行的验证必须逐项对应。缺项时 phase 保持 open。

## 7. Kernel 演化闸门

本节只处理已有 Kernel 的变化。没有适用 Kernel 时使用 Bootstrap Gate 建立 `K1`。

Delta 至少包含：

```text
change:       要改变的 Concept / Relation / Action / Invariant / Contract / Policy
evidence:     为什么现在必须改变
impact:       受影响的模块、动作、视图、数据和权限
migration:    已有实现或状态如何继续成立
verification: 如何证明新模型优于或修复旧模型
decision:     promote | reject | needs-evidence
```

Delta 的状态只有：

```text
proposed -> impact-checked -> verified -> promoted
                                    \-> rejected
```

闸门规则：

- 没有 Evidence，不得 promoted。
- 没有影响检查，不得 promoted。
- 无法说明迁移或兼容边界，不得 promoted。
- 仅改变实现、不改变长期语义时，不创建 Delta。
- 新 Evidence 可以暂停明显不安全的 Action，但不能静默重写 Kernel。
- promoted 后递增 Kernel 语义版本，并归档 Delta；rejected 后记录拒绝依据。

快速归类：

- 当前目标、范围、blocker 或实现变化：更新 State。
- 新观察或验证结果：记录 Evidence。
- 长期语义、行为契约或政策变化：提出 Delta。
- 文件名、排版或存储变化：只修改 Adapter。

## 8. 权威与冲突

权威顺序是：

1. 已生效的 Kernel 与 Contract
2. 新鲜且已验证的事实
3. 当前 State
4. 方向性假设与派生 View
5. Archive

View 永远不是权威来源。若新 Evidence 与 Kernel 冲突：

1. 先停止依赖该冲突点的高风险行为；
2. 把 Evidence 记录为对 Kernel 的 challenge；
3. 通过 Delta 和 Gate 决定改变 Kernel、限制适用范围，还是拒绝该解释。

这使 Kernel 既不会被一次异常击穿，也不会因“长期原则”之名拒绝真实世界。

## 9. 最小上下文投影

Agent 默认只需要：

```text
Router + relevant Kernel View + current State View
```

新系统在 Bootstrap Gate 通过前读取 Candidate Kernel Snapshot；通过后它成为 relevant Kernel View。

其余内容通过条件指针加载：

- 执行具体 Action 时读取对应 Contract。
- 判断模型是否失效时读取相关 Evidence。
- 处理未决语义变化时读取 active Delta。
- 只有回归或明确追溯时读取 Archive。

每个 View 必须标明来源与 Kernel 版本。View 可以重建，不应产生只能存在于 View 中的新规则。

## 10. Markdown 参考适配器

以下只是最小默认映射，不是 v4 的逻辑契约：

```text
AGENTS.md              # 意图路由、执行协议、上下文指针
.spec/
  kernel.md            # 稳定语义与索引；默认读取
  state.md             # 当前方向、阶段、事实与 blocker；默认读取
  evidence.md          # 决策相关证据；按需读取
  delta.md             # 仅在存在 active Delta 时出现
  contracts/           # 需要独立治理的详细 Contract；按需读取
  archive/             # 已关闭状态和历史 Delta；默认不读
```

新系统必须在首次实现前生成最小 `kernel.md` 或等价 Adapter。空缺意味着 Bootstrap 尚未完成。

与 v3 相比，这个映射有意取消独立 `roadmap.md` 和 `decision.md` 的逻辑特权：

- 长期有效的决策进入 Kernel 或 Contract。
- 当前方向和阶段假设进入 State。
- 决策理由由 Evidence 与归档 Delta 保留。

如果未来证明另一种存储方式更省上下文，只替换适配器，不修改 Living SPEC 的逻辑模型。

## 11. 从 v3 迁移

迁移不是格式转换，只提升仍然有效的内容：

| v3 内容 | v4 去向 |
|---|---|
| 长期原则、稳定边界 | Kernel |
| protocol / 稳定 ADR | Contract 或 Kernel |
| roadmap / current | State |
| 决策相关 observation | Evidence |
| 未决的长期冲突 | active Delta |
| 旧 phase、task、notes | Archive 或丢弃 |

旧文件是迁移来源，不是 v4 的设计边界。未被提升的旧内容不具有默认权威。

## 12. 首次验证门槛

在替换现有入口前，必须用一个真实 phase 证明：

1. 没有既有 Kernel 时，Agent 在 `Act` 前生成并通过最小 Bootstrap Snapshot。
2. Agent 只读 Router、Kernel View 和 State View 就能正确开始工作。
3. 每个当前 Action Contract 都有与其 observable outcome 对应的行为 Evidence。
4. 语法检查不会被用来替代运行时行为验证。
5. 重复 Evidence 能通过 Delta 沉淀为稳定抽象。
6. 单次异常不会污染 Kernel。
7. 一次实现重构不会制造伪语义版本。
8. 一次真实 Kernel 变化能追溯 Evidence、影响、验证和迁移结果。

在这些证据出现前，不构建 schema、图数据库、生成器或一致性检查器。
