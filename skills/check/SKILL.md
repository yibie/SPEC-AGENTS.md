---
name: check
description: 对已完成的变化做只读验收，检查它是否符合已确认契约、工程标准和引用完整性。适用于实现后验收、回归检查或用户要求审查变更时。适用于实现后验收、回归检查或用户要求审查变更时。
---

# Check

用证据判断“实现是否满足已经确认的契约”。默认只读，不在检查过程中改代码或重写计划。

## 独立性声明

开头写明：**本次 `check` 是否由执行 `do` 的同一上下文完成。**

同一上下文时，下面的「权威落点」一项需要正面举证 —— 点名落点、点名地图条目、
说明两者相符 —— 而不是「没看出问题」。选择落点的上下文去审自己选的落点，是在
复核自己的决定；真实事故中的 15 条违例是独立 reviewer 发现的，不是自审发现的。

不强制独立执行：强制会让每个小改动都变贵。这里只是把盲区变成显式的。

## 固定比较基点

确定一个比较基点。读取变更相关的 `docs/spec-agents/WORKFLOW.md`、
`CONTEXT.md`、项目 `KERNEL.md`、Protocol、Runbook、Lesson 和 `AGENTS.md`。
只读取与当前意图相关的知识记录，不要加载整个 `docs/`，也不要只凭 diff
猜意图。

比较基点按路径取：

- **SPEC 路径**：另读相关 `SPEC.md` 和目标 Slice，契约轴对着它们比。
- **短路径**（`plan` 直接 `approve`）：没有 SPEC 也没有 Slice，契约轴对着
  `plan` 交出的那句验收比，加上 `KERNEL.md`、Protocol 和 `AGENTS.md`。
  不要因为找不到 SPEC 就跳过契约轴，也不要为此创建 Slice。

三条轴在两条路径上都要跑。

## 三条检查轴

### 契约

- 目标、边界和 out-of-scope 是否符合 SPEC；
- 项目概念、身份、关系、生命周期和不变量是否符合 `KERNEL.md`；框架工作流
  语义是否符合 `docs/spec-agents/WORKFLOW.md` 与 `CONTEXT.md`；
- Action Contract 和稳定接口是否符合 Protocol；
- 相关代码实践、Runbook 前置条件和 Lesson 的 `applies_when` 是否满足；
- 旧行为是否仍被验证，新行为是否有明确证据。

**权威落点。** 符合 `KERNEL.md` 不等于落在对的位置：第二份实现完全符合每一条
概念、身份、关系、生命周期和不变量，它只是多了一个。本体影响必答对它也会答
「否」——它没新增任何概念，那条规则 Kernel 里早就有。所以要单独核：

- 这条规则已经有权威落点了，本次改动是不是在**第二个位置**又实现了一遍？
- 前端／客户端是不是复制了一份服务端已经强制的规则？
- 派生状态是不是被**持久化了两次**？

命中任何一条，产出 `semantic` 发现交回 `plan`：要么改回权威落点，要么经
`plan` 修 Kernel 的地图，不允许沉默分叉。允许存在的第二落点必须有同输入等价
测试，见 `docs/spec-agents/single-authority.md`。

注意单测全绿不构成反证：**与实现同层的测试无法证明实现在正确的层**，测试和
错误落点是同一个决定的两个结果。

### 工程

- 测试、类型、错误处理、安全、可访问性和仓库规范；
- 是否存在数据丢失、状态泄漏或未覆盖的调用方；
- 项目自己的 `docs/protocols/` 与编码约定。

在项目自身约定之上，叠加这份 smell 基线。它来自 Fowler 的 *Refactoring*，
是跨语言跨项目通用的判据，不是本框架发明的规则：

| Smell | 判据与处置 |
| --- | --- |
| Mysterious Name | 名字讲不清它是什么；改名，改不动就说明设计需要重想 |
| Duplicated Code | 同一段逻辑出现多处；抽出可复用形式 |
| Feature Envy | 一个方法主要在动别的对象的数据；把方法搬过去 |
| Data Clumps | 几个字段总是一起出现；打包成一个类型 |
| Primitive Obsession | 用基本类型冒充领域概念；建立类型 |
| Repeated Switches | 同一组条件分支反复出现；换成多态或映射表 |
| Shotgun Surgery | 一次改动散落到很多文件；把它们合并到一处 |
| Divergent Change | 一个文件为互不相关的原因被反复修改；按职责拆开 |
| Speculative Generality | 为想象中的需求做的抽象；SPEC 没要求就删掉 |
| Message Chains | `a.b().c().d()` 式的长导航；用一个方法封装 |
| Middle Man | 一个类大部分方法只是转发；直接调真正的目标 |
| Refused Bequest | 子类用不上继承来的大部分东西；改用组合 |

不是每条都对每次改动适用。只报当前 diff 里真实出现的，并给出位置和处置；
不要把这张表当检查清单逐条打勾。

### 引用完整性

本次改动触及的每一条引用都必须仍能解析：

- 知识记录的 `source` 与 `verification`；
- Slice 的 `spec_ref`、`context_ref`、`evidence_ref`；
- Markdown 相对链接与散文中引用的文件路径、行号锚点；
- 被移动、重命名、删除或拆分的文件所留下的指向。

明确属于历史记述的引用记为历史，不修补——它在写下时是对的，改掉就是伪造
记录。无法判断是历史还是断裂时，报告给用户，不要自行选择。

这一轴放在 `check` 而不是 `learn`，因为断裂大多在 `do` 段产生；等到 `learn`
才发现，改动已经铺开。

### 版本控制比较基点

- In a JJ repository, use `jj status`, `jj log`, and `jj diff` as the local
  comparison basis; inspect the current JJ Change and any explicitly named
  bookmark.
- In a Git-only repository, use the existing Git comparison basis without
  pretending that it has JJ change semantics.
- A check never creates a bookmark, pushes, or initializes JJ.

## 输出

每个发现包含位置、影响、复现或证据、建议动作、严重度和**路由目的地**。
四种类型，路由目的地写在类型里，不靠读的人推断：

| 类型 | 含义 | 路由到 |
| --- | --- | --- |
| `blocker` | 违反不变量、数据契约或安全边界 | `do` |
| `required` | SPEC/验收未满足 | `do` |
| `suggestion` | 不影响当前契约的改进 | `do` |
| `semantic` | 本次改动动了本体，或代码与 Kernel 不一致 | **`plan`** |

`semantic` 只陈述观察到了什么、它关系到 Kernel 的哪一条，然后停。
**`check` 不裁决**：它绝不判定是代码错还是 Kernel 陈旧。那是 `plan` 的事，
在 `check` 里判掉就绕过了「Kernel 的演化必须经 `plan`」这道门——而绕过它
正是本体悄悄漂移的方式。

没有发现时明确写出检查基点、运行过的验证和剩余风险。需要改代码时把动作交回
`do`；`semantic` 交回 `plan`；不要在 `check` 中顺手修复，也不要在 `check` 中
修改 `KERNEL.md`。

## 本体影响（每次必答）

三轴之后，写下这个问题的答案：

> 本次改动是否新增、改变或废止了**概念、身份、关系、生命周期、不变量或
> Action Contract**？

六类逐一过。特别注意「新增」——引入一个 Kernel 里**本来没有**的概念不违反
任何不变量，三条检查轴都不会响，这是本体遗漏的主要方式。

答「否」也要写下来。不写不等于没有，只等于没人问过；而没人问过正是当前的
失败模式。答「是」就产出一个 `semantic` 发现，由 `plan` 决定 Kernel 是否
修订。

如果 Slice 有可选的 `evidence_ref`，只判断当前事实是否足以进入
`learn`；不要填写或修改该字段。

对于 `Kernel Bootstrap`，额外检查：K1 的每条 enacted 记录都有直接来源，
候选/unknown 没有混入稳定层，且 K1 足以约束当前 Action Contract。发现缺口时
返回 `plan` 或修订 SPEC，不把猜测写入 Kernel。

## 完成条件

独立性已声明，三条检查轴都有结论（含权威落点一项），本体影响问题已写下答案（含答「否」的情形），验证命令和
结果可复核，所有 `blocker`/`required` 已关闭或记录，`semantic` 发现已交回
`plan`，且明确是否可以进入 `learn`。
