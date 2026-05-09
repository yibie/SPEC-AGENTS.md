# SPEC-AGENTS.md

SPEC-AGENTS v3 is an evidence-calibrated agent workflow.

It combines Evidence-Driven Phase Planning (EDPP) with a minimal execution protocol for AI coding agents. The goal is to reduce token load and stale memory while keeping planning, verification, and decision records reliable.

## Core Idea

Old SPEC-AGENTS used a static doc-driven loop:

```text
spec -> plan -> task -> implementation -> change log
```

v3 uses a smaller evidence-driven loop:

```text
decision framework -> roadmap -> current phase
        -> discovery / implementation -> verification
        -> evidence delta -> next phase
```

The agent should read less, but read the right things.

## Features

- **Minimal Context**: default reads only `decision.md`, `roadmap.md`, and  `current.md`.
- **Evidence-Driven Phases**: the next phase is chosen from the previous phase's evidence.
- **Phase-Local Tasks**: tasks exist only for the active phase, not distant roadmap items.
- **Durable Decisions Only**: ADR/protocol files are used only for long-lived rules and contracts.
- **Intent Modules**: optional modules still support product interviews, coding judgment, copywriting, and browser automation.

## Installation

Clone and link the CLI:

```bash
git clone https://github.com/your-repo/SPEC-AGENTS.git
cd SPEC-AGENTS
chmod +x link_to_system.sh
./link_to_system.sh
```

Initialize a project:

```bash
cd ~/MyProject
spec-agents init        # Chinese AGENTS.md by default
spec-agents init en     # English AGENTS.md
```

The installer creates:

```text
AGENTS.md
.phrase/
  decision.md
  roadmap.md
  current.md
  evidence.md
  archive/
  adr/
  protocol/
  runbooks/
  modules/
  commands/
```

## Default Read Rule

At the start of ordinary work, the agent reads only:

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

It reads `.phrase/evidence.md` only when choosing the next phase, resolving a
plan conflict, checking blocker classification, or closing a phase.

It reads `.phrase/archive/` only when current files link to an archived item, a
regression needs historical comparison, or the user explicitly asks for old
context.

## File Authority

When documents disagree:

1. `decision.md`, `adr/`, and `protocol/` define durable rules.
2. Fresh evidence defines what is currently known.
3. `current.md` defines the active phase.
4. `roadmap.md` defines direction.
5. `archive/` is historical context only.

Fresh evidence updates the current plan. Durable rule changes require explicit
decision, ADR, or protocol updates.

## Workflow

1. Establish or read the decision framework.
2. Maintain roadmap at phase granularity.
3. Select the current phase from evidence.
4. Update `current.md` with scope, out-of-scope, acceptance gate, task slice,
   and verification plan.
5. Run discovery before broad implementation when the blocker shape is unknown.
6. Classify blockers before fixing them.
7. Implement only the measured slice.
8. Verify against the phase gate.
9. Record an evidence delta.
10. Update durable decisions only when needed.
11. Prepare the next phase and archive stale local context.

## Task Format

Tasks are phase-local. Use them only in `current.md` when they help coordinate
the active work:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

Do not pre-split future roadmap phases into tasks.

## Migration From v2

For existing projects:

1. Extract durable rules into `.phrase/decision.md`.
2. Convert future milestones into `.phrase/roadmap.md`.
3. Compress the active phase into `.phrase/current.md`.
4. Move decision-relevant observations into `.phrase/evidence.md`.
5. Move completed/stale `spec_*`, `plan_*`, `task_*`, `change_*`, and `issue_*`
   material into `.phrase/archive/`.
6. Stop maintaining mechanical per-file `change_*` logs.
7. Keep ADR/protocol files only for durable decisions and stable contracts.

You can ask the agent to run:

```text
/migrate-v3
```

The command archives legacy material under `.phrase/archive/legacy-v2/` and
promotes only decision-relevant context into the v3 files.

## Protocol Cost Comparison

Run the comparison benchmark:

```bash
./tests/protocol-cost-comparison.sh
```

The script creates the same development request in two temporary fixtures:

- legacy v2 static SPEC layout
- v3 EDPP minimal-context layout

It compares default read files, words, bytes, estimated tokens, and required
write surfaces after implementation. The benchmark measures protocol overhead,
not model intelligence or code quality.

## 中文说明

SPEC-AGENTS v3 是一个证据校准的 Agent 工作流。

它结合 EDPP（Evidence-Driven Phase Planning，证据驱动阶段规划）和一套最小执行协议，
帮助 AI coding agent 在少读上下文的前提下，仍然保留规划、验证和决策记录的可靠性。

## 为什么改变

这个变化的前提是：当前 LLM 模型的能力已经得到巨大提升。

过去，纯 SPEC 推动方式试图把需求、计划、任务、变更和问题都写成稳定文档，再要求
Agent 每次读取并严格执行。这在模型能力较弱时有价值，因为它用大量显式约束弥补模型的
理解和规划能力。

但在今天，这种方式已经显得不合时宜：

- 写入成本高：每次开发都要维护 `spec_*`、`plan_*`、`task_*`、`change_*`、
  `issue_*` 等记录，很多内容只是重复 git diff 已经表达的信息。
- 读取成本高：Agent 每次为了“遵守流程”加载大量历史文档，更快消耗宝贵的上下文空间。
- token 消耗高：静态文档越多，越容易把 token 花在旧计划和机械记录上，而不是当前判断。
- 旧计划容易变成噪音：一旦新证据推翻旧假设，过期 SPEC 仍然可能被误读为当前事实。

因此，v3 不再要求把每一行实现意图都提前写进 SPEC。新的流程更适合现在的模型：

> 向 AI 说明边界，而不是说明每一行函数如何修改；每一轮开发后，用测试和证据证明之前开发无误。

这个流程尤其适合多智能体共同合作。多个 Agent 不需要共享庞大的历史文档，只需要共享稳定边界、
当前 phase、验证标准和最新 evidence，就能更容易并行工作、交接结果和校准下一步。

## 核心想法

旧版强调静态文档闭环：

```text
spec -> plan -> task -> implementation -> change log
```

新版改为证据校准的阶段循环：

```text
decision framework -> roadmap -> current phase
        -> discovery / implementation -> verification
        -> evidence delta -> next phase
```

核心目标不是记录更多，而是让 Agent 默认读取更少、更准的上下文。

## 功能特点

- **最小上下文**：默认只读取 `decision.md`、`roadmap.md` 和 `current.md`。
- **证据驱动阶段**：下一阶段由上一阶段 evidence 决定，而不是由旧计划惯性推进。
- **阶段内任务**：任务只服务当前 phase，不为远期 roadmap 预拆任务。
- **长期决策才持久化**：ADR/protocol 只记录会长期影响项目边界的规则和契约。
- **意图模块仍保留**：产品访谈、代码判断、文案、浏览器自动化等模块仍可按需加载。

## 默认读取规则

默认上下文：

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

只有在选择下一阶段、解决计划冲突、检查 blocker 分类或关闭 phase 时，才读取
`.phrase/evidence.md`。

只有当当前文件明确链接、回归问题需要历史对比，或用户明确要求追溯旧上下文时，才读取
`.phrase/archive/`。

## 文件权威顺序

当文档互相冲突时，按以下顺序判断：

1. `decision.md`、`adr/` 和 `protocol/` 定义长期规则。
2. 最新 evidence 定义当前已知事实。
3. `current.md` 定义当前 phase。
4. `roadmap.md` 定义阶段方向。
5. `archive/` 只是历史上下文。

如果新 evidence 推翻当前计划，就更新 `current.md`。如果新 evidence 改变长期边界，
就显式更新 `decision.md`、ADR 或 protocol。

## 工作流

1. 建立或读取决策框架。
2. 只在 phase 粒度维护 roadmap。
3. 根据 evidence 选择当前 phase。
4. 用目标、范围、非目标、验收门槛、任务切片和验证计划更新 `current.md`。
5. 阻塞形态不清楚时，先 discovery，不急着实现。
6. 先分类 blocker，再修复。
7. 只执行当前被测量过的切片。
8. 按 phase gate 验证。
9. 记录 evidence delta。
10. 只有长期规则变化时，才更新 durable decision。
11. 准备下一阶段，并把过期上下文归档。

## 任务格式

任务是 phase-local 的，只在 `current.md` 中用于协调当前工作：

```text
taskNNN [ ] goal:<可观察结果> | scope:<文件或区域> | verify:<证明方式>
```

不要为远期 roadmap 阶段预拆任务。

## 从 v2 迁移

已有项目迁移时：

1. 把长期规则提取到 `.phrase/decision.md`。
2. 把未来方向压缩到 `.phrase/roadmap.md`。
3. 把当前阶段压缩到 `.phrase/current.md`。
4. 把会影响后续判断的事实移到 `.phrase/evidence.md`。
5. 把完成或过期的 `spec_*`、`plan_*`、`task_*`、`change_*`、`issue_*`
   移到 `.phrase/archive/`。
6. 停止维护机械的逐文件 `change_*` 日志。
7. ADR/protocol 只保留长期决策和稳定契约。

## 协议成本对比测试

运行：

```bash
./tests/protocol-cost-comparison.sh
```

这个脚本会用同一个开发需求生成两套临时 fixture：

- 旧版 v2 静态 SPEC 布局
- v3 EDPP 最小上下文布局

然后对比默认读取文件数、字数、字节数、估算 token，以及实现后需要维护的写入面。
这个测试衡量的是协议开销，不是模型智力或代码质量。

一句话：

> 最小上下文，证据驱动阶段，验证后执行，只保留长期有价值的决策。
