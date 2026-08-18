# Palantir Ontology 方法论研究：对 SPEC-AGENTS v3 的启示

**研究日期**：2026-08-15
**研究范围**：Palantir Ontology 的方法论与架构含义，以及它与当前
SPEC-AGENTS v3 的最小结合点。
**证据边界**：Palantir 官方资料适合证明其产品定义和设计方法，不足以独立证明
商业成效。本研究不把产品宣传中的效果声明当作已验证事实。

## 结论先行

Palantir 的 Ontology 不是“知识图谱 + 业务术语”，而是一个**可执行的决策模型**：

1. 什么东西存在、现在是什么状态；
2. 人或 Agent 根据什么数据与逻辑做决定；
3. 哪些动作可以改变状态和外部系统；
4. 谁能读取、判断、执行，以及必须满足什么约束；
5. 决定发生后，如何留下上下文并用结果校准下一次决定。

Palantir 将这五类问题压缩为四个贯穿维度：`Data + Logic + Action + Security`，
并以 `Language + Engine + Toolchain` 承载。其官方架构文档明确说 Ontology
不是薄的 semantic layer；对象、关系只是语义一侧，动作、函数、动态权限、事务写入、
同步、审计和开发工具共同构成操作一侧
（[The Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system)）。

因此，把它用于 SPEC-AGENTS 的正确方向不是引入图数据库，也不是把源文件和模块机械地
画成图，而是让 SPEC 成为软件系统的**决策本体 / 操作契约**：用领域对象包装架构的稳定
含义，用 Action 包装状态变化，用 Gate 与 Security 约束变化，再用 Evidence 形成反馈闭环。

## 1. Palantir 所说的 Ontology 到底是什么

### 1.1 它包含知识图谱的一侧，但不止于知识图谱

W3C 的 OWL 2 以 classes、properties、individuals 和 data values 表达具有形式语义的
本体，这是知识表示的典型范围
（[OWL 2 Overview](https://www.w3.org/TR/owl-overview/)）。Palantir 也有对应的语义原语：

- Object types：现实世界的实体或事件；
- Properties：对象的事实或状态；
- Link types：对象之间有业务含义的关系；
- Interfaces：多个对象类型共享的形状和能力。

但 Palantir 还把“动词”纳入同一模型：

- Action types：人或 Agent 可以提交的业务动作；
- Functions / automations：计算、推理和复杂状态变换；
- Submission criteria / permissions：动作何时允许、谁可以执行；
- Writeback / side effects：把决定同步到实际业务系统；
- Action log：把决定、当时状态、操作者和影响对象重新变成可分析的数据。

官方用 **semantics + kinetics** 区分这两侧：数据对象是 nouns，Action 是 verbs；只有二者
结合才能表达决策，而不仅是描述数据
（[The Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system)）。

### 1.2 四个决策维度

Palantir 将每个 operational decision 分成四部分
（[Why create an Ontology?](https://www.palantir.com/docs/foundry/ontology/why-ontology)）：

| 维度 | 它回答的问题 | 典型构件 |
| --- | --- | --- |
| Data | 当前世界是什么样？决定依据是什么？ | objects、properties、links、实时/历史数据 |
| Logic | 如何判断、计算、预测或比较选项？ | rules、functions、models、LLM/optimization |
| Action | 决定怎样改变数字状态和现实系统？ | action types、transactions、writeback、webhooks |
| Security | 谁在什么条件下可以看到、判断和执行？ | permissions、submission criteria、审计、审批 |

Security 不是外围的登录鉴权。它同时约束 Data、Logic 和 Action：同一个人可能能看工单，
能运行模拟，却不能真正下采购单；Agent 也必须继承用户或项目的权限范围。Action 的
submission criteria 还能结合当前用户、参数和执行上下文，在提交时验证，并给出失败原因
（[Submission criteria](https://www.palantir.com/docs/foundry/action-types/submission-criteria)）。

### 1.3 三个系统层次

| 层次 | 职责 | 对软件架构的含义 |
| --- | --- | --- |
| Language | 定义对象、关系、动作、逻辑和权限语义 | 稳定的领域语言与操作契约 |
| Engine | 实现查询、订阅、事务、批处理、流、CDC 与同步 | 契约背后的运行时和一致性机制 |
| Toolchain | 构建、测试、审查、发布并把 Ontology 当作 backend | 面向应用、人和 Agent 的开发界面 |

这个三层结构解释了为什么 Ontology 不能等同于 schema 或图：Language 负责“意味着什么”，
Engine 负责“如何可靠发生”，Toolchain 负责“如何安全演进和消费”。

## 2. Palantir 的方法论闭环

Palantir 并不是先建一套企业级万能本体，再寻找使用场景。其公开方法更接近下面的闭环。

### 2.1 从有结果指标的 use case 开始

Use case 被定义为面向一组用户、在有限时间内交付能力的工作，不是“接入系统 X”或
“应用技术 Y”。入口问题是：谁的工作会改善，以及用什么指标判断成功
（[Use case lifecycle](https://www.palantir.com/docs/foundry/use-case-life-cycle/overview)）。

这一步阻止本体建设退化为没有用户和结果的分类学工程。

### 2.2 先写决策句，再选技术构件

Palantir 推荐用一个很紧凑的语法提炼功能需求：

```text
[User Type] [Interface] [Decision] [Decision Inputs] [Action]
```

它迫使需求同时说明谁做决定、在哪里做、根据什么、最终改变什么，同时保留实现方式的
弹性
（[Distilling functional requirements](https://www.palantir.com/docs/foundry/use-case-life-cycle/distilling-functional-requirements)）。

### 2.3 模型现实，而不是镜像来源系统

对象应代表现实中的领域实体、事件与过程，而不是数据库表、API response、Spreadsheet
tab 或部门自己的副本。顺序是“理解领域 → 设计对象模型 → 映射数据”，不是反过来。
Palantir 当前公开的优先原则是：

1. Domain-driven design；
2. DRY，但以 rule of three 触发；
3. 核心模型 open for extension, closed for modification；
4. 通过 interface 组合能力，避免深继承。

详见
[Ontology design: Best practices](https://www.palantir.com/docs/foundry/ontology/ontology-best-practices)。
这意味着 Ontology 在架构上应当是来源系统之上的稳定 façade，而不是把实现耦合重新暴露
给消费者。

### 2.4 同时画对象模型和生命周期

从决策句中提取四类设计材料：

- Object model：核心、派生、use-case 对象及其关系；
- Lifecycle diagram：对象状态以及使状态迁移的 Actions；
- Enrichments：决定所需的规则、聚合、模型或人工标签；
- Interface expectations：不同用户意图对应的交互方式。

对象模型表达 nouns，生命周期表达 verbs；二者缺一，都会把真实工作流切断
（[Solution design](https://www.palantir.com/docs/foundry/use-case-life-cycle/solution-design)）。

### 2.5 把 Ontology 当作 use-case API

Palantir 明确把 Ontology 描述为 use case API：它为界面和 Agent 提供稳定对象、关系、
函数与动作，同时隐藏 pipeline 和来源系统细节
（[Use case lifecycle](https://www.palantir.com/docs/foundry/use-case-life-cycle/overview)）。

这不是说 Ontology 取代软件架构。吞吐、延迟、故障恢复、部署、事务边界和外部系统适配
仍由实现架构承担；Ontology 规定这些实现对业务世界暴露出的稳定含义和合法操作。

### 2.6 把决定及其上下文重新变成数据

Action log 会为一次 Action submission 记录动作类型及版本、时间、操作者、参数、影响对象，
还可以保存决定发生时没有被修改但与动机有关的上下文。这样系统不只知道“状态变了”，
还可以分析“在什么情境下、为什么、由谁通过什么动作改变”
（[Action log](https://www.palantir.com/docs/foundry/action-types/action-log)）。

这一步让 Ontology 成为学习回路，而不是静态模型。

### 2.7 像生产代码一样演进本体

Ontology 资源可以在隔离 branch 上修改和测试，经 checks、review 和 approval 后合并；
usage metrics 用来判断 breaking change 的影响面
（[Branching the ontology](https://www.palantir.com/docs/foundry/ontologies/branching-ontology)、
[Viewing usage](https://www.palantir.com/docs/foundry/ontology-manager/view-usage)）。

Palantir 同时强调增量演进：先建立数据资产、实际可用的对象模型、初始界面与 guided
decision-making，再扩展模型驱动的反馈和自动化
（[Sequencing development](https://www.palantir.com/docs/foundry/use-case-life-cycle/sequencing-development)）。

## 3. “用本体包装软件架构”的准确含义

```text
用户结果 / 可测量 use case
          ↓
决策句：Actor + Interface + Decision + Inputs + Action
          ↓
本体契约：Objects + Relations + Logic + Actions + Security
          ↓
实现架构：services + data + models + UI + integrations
          ↓
运行证据：decision/action context + outcome
          └──────────────→ 校准下一次决定与模型
```

这里的“包装”有三层含义：

1. **语义隔离**：代码模块、表和 API 是 backing implementation；领域对象和动作是稳定
   contract。实现可替换，业务含义不随之漂移。
2. **变化隔离**：消费者通过合法 Action 改变状态，不直接拼凑底层写操作。Action 声明
   前置条件、逻辑、权限、效果和审计上下文。
3. **决策隔离**：架构选择不直接从需求句跳到技术栈；先明确真实对象、决策、输入、动作
   和约束，再让架构承担这些语义。

不应做的事情：

- 把 repository、folder、file、class 全部升格为本体对象；
- 先建设“完整企业本体”，再寻找能用它的问题；
- 用新的 YAML/JSON registry 重复代码、文档和 git 已经知道的事实；
- 只建 nouns/links，却不定义 Actions、权限、验证与结果回流；
- 把 Ontology 当成 OWL、RDF 或 graph database 的同义词。

## 4. 与 SPEC-AGENTS v3 的映射

当前 SPEC-AGENTS 已经具有 Palantir 方法中的一半以上，不需要推倒重来。

| Palantir 构件 | SPEC-AGENTS 当前对应物 | 当前缺口 | 最小演进方向 |
| --- | --- | --- | --- |
| Use case / outcome | `current.md` 的 Goal、Scope、Acceptance Gate | 未必说清 Actor、Decision、Action | 给当前 phase 增加一条决策句 |
| Data / current world | `current.md` + fresh `evidence.md` | 事实与所影响的决策关系主要靠阅读推断 | evidence delta 显式指向被支持/推翻的 decision 或 gate |
| Logic | `decision.md` 的 evidence rules、authority、phase gates | 规则多为 prose，合法状态迁移不完全显式 | 将关键 gate 写成可检查 predicate |
| Action | task execution、`/start-phase`、`/done` | 动作的前置条件、效果、授权写面未统一 | 只为高影响动作定义 action contract |
| Security | 提交与安全规则、工具权限、用户批准 | 尚未成为每个 Action 的横切维度 | action contract 同时声明权限和 side-effect boundary |
| Action log | `evidence.md` 的 evidence delta | 已接近，但不是所有记录都指出触发它的动作 | 保持压缩日志，只补 action/context/outcome 关联 |
| Stable ontology/API | `decision.md`、ADR、protocol | 领域对象与架构构件之间没有显式稳定映射 | 仅在跨 phase 稳定时建立 domain-to-architecture contract |
| Branch/review | git、verification、durable decision update | 本体级 breaking-change 影响检查未明确 | 改长期对象/Action/contract 时检查消费者与 evidence |

### 已经很强的部分

SPEC-AGENTS 的 authority order、evidence-driven phase selection、phase gate 和 durable
decision promotion，本质上已经是一个小型 decision engine。`evidence.md` 也已经选择了比
完整 Action Log 更节制的策略：只保留会改变后续判断的事实。这一点不应被“本体化”破坏。

### 真正缺失的部分

当前模型主要描述“Agent 如何推进工作”，但没有统一表达“这个软件能力服务谁的哪个决定，
决定依据什么，最后允许改变什么”。因此架构仍可能直接从 Goal 跳到组件设计，中间缺少
Palantir 所说的 decision-centric semantic/kinetic contract。

## 5. 建议的最小结合：Decision Ontology Overlay

先不新增默认读取文件，也不引入图数据库或机器可读 schema。只在当前 phase brief 中试验
一段可选的决策契约：

```markdown
## Decision Workflow

Actor: <谁或什么 Agent>
Interface: <在哪里获得上下文并作出决定>
Decision: <要作出的判断或选择>
Inputs: <允许作为依据的数据、模型和 evidence>
Action: <决定后允许改变的对象或外部状态>
Guard: <权限、前置条件、失败条件和需人工复核的边界>
Outcome: <如何判断这次决定有效>
```

只有当当前 phase 确实改变稳定领域模型或架构边界时，再附一个很短的 delta：

```markdown
## Ontology Delta

Objects/relations: <新增或改变的领域概念及关系>
Actions/invariants: <合法变化及不可破坏的约束>
Architecture mapping: <由哪些现有构件实现，不重复文件级清单>
```

这个 overlay 的目的不是多写两段文档，而是暴露四类常见遗漏：没有明确决策人、没有说明
决策输入、Action 没有安全边界、架构组件没有稳定领域含义。没有这些遗漏时，不需要写
Ontology Delta。

## 6. 建议的单一验证切片

用现有 `/start-phase` 工作流做一次 prototype，而不是全仓迁移：

- Objects：`Phase`、`Evidence`、`Decision`、`Gate`、`Blocker`；
- Action：`StartPhase`；
- Logic：authority order、entry condition、evidence selection、acceptance gate；
- Security：哪些文件可自动更新，哪些 durable decision 需要显式确认；
- Log：产生了什么 phase、基于哪些 evidence、拒绝了哪些候选路径。

Acceptance gate：

1. 两个独立执行者从同一上下文能识别相同的合法下一动作和缺失 evidence；
2. 未满足 gate 时不能把 phase 标为完成；
3. durable boundary 的变化一定落到 decision/ADR/protocol，而不是藏在实现里；
4. 默认读取集合仍是三个文件，token 成本不因 prototype 增长；
5. prototype 暴露的歧义多于它新增的维护成本，否则拒绝该路径。

在这个切片通过前，不应设计全局对象目录、ontology DSL、graph storage、代码生成器或新的
文件树。它们只有在重复的手工歧义已经被 evidence 证明时才有存在理由。

## 7. 当前判断与待验证问题

**当前判断**：Palantir 方法最值得 SPEC-AGENTS 吸收的不是 graph，而是四件事：

- decision-first 的需求语法；
- nouns 与 verbs 同时建模；
- Security 与 Action 同层设计；
- 决定及结果重新成为下一轮证据。

**仍待验证**：

- SPEC 用户最痛的是理解架构、修改架构，还是让 Agent 安全执行？三者需要不同的本体粒度。
- Decision Workflow 是否真的减少歧义，还是只是重述现有 Goal/Scope/Gate？
- 哪些领域概念能跨 phase 保持稳定，足以进入 protocol；哪些只应留在 current？
- Markdown 能否承担足够的一致性检查；何时才需要机器可读表示？

这些问题必须由一个实际 phase 的 prototype 回答，不能靠继续扩写方法论文档回答。

## 一手资料索引

- [Why create an Ontology?](https://www.palantir.com/docs/foundry/ontology/why-ontology)
- [The Ontology system](https://www.palantir.com/docs/foundry/architecture-center/ontology-system)
- [Ontology overview](https://www.palantir.com/docs/foundry/ontology/overview)
- [Ontology design: Best practices](https://www.palantir.com/docs/foundry/ontology/ontology-best-practices)
- [Ontology design: Structural guidance](https://www.palantir.com/docs/foundry/ontology/ontology-structural-guidance)
- [Use case lifecycle](https://www.palantir.com/docs/foundry/use-case-life-cycle/overview)
- [Distilling functional requirements](https://www.palantir.com/docs/foundry/use-case-life-cycle/distilling-functional-requirements)
- [Solution design](https://www.palantir.com/docs/foundry/use-case-life-cycle/solution-design)
- [Sequencing development](https://www.palantir.com/docs/foundry/use-case-life-cycle/sequencing-development)
- [Submission criteria](https://www.palantir.com/docs/foundry/action-types/submission-criteria)
- [Action log](https://www.palantir.com/docs/foundry/action-types/action-log)
- [Branching the ontology](https://www.palantir.com/docs/foundry/ontologies/branching-ontology)
- [Viewing usage](https://www.palantir.com/docs/foundry/ontology-manager/view-usage)
- [OWL 2 Web Ontology Language Overview](https://www.w3.org/TR/owl-overview/)
