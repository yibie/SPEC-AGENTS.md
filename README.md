# SPEC-AGENTS

SPEC-AGENTS v4 is an evidence-calibrated agent workflow with a stable semantic
model and a living, phase-local execution record.

See [`CHANGELOG.md`](CHANGELOG.md) for the v4.0.0 experiment record, design
rationale, measured limits, and release benefits.

The source repository keeps that research archive under
[`research/`](research/README.md). It is not part of the installer payload.

It combines static concepts and boundaries with dynamic evidence for AI coding
agents. The goal is to reduce stale context while keeping planning,
verification, and durable decisions reliable.

## Core Idea

The old workflow used a static doc-driven loop:

```text
spec -> plan -> task -> implementation -> change log
```

The current workflow uses a six-action loop:

```text
plan -> capture -> arrange -> do -> check -> learn
```

The agent reads the stable model first, then only the phase and evidence needed
for the current decision.

## Features

- **Stable semantic model**: `CONTEXT.md` records concepts, relations,
  lifecycles, invariants, and Action Contracts.
- **Evidence-driven phases**: `EVIDENCE.md` records only facts that change
  future decisions.
- **Phase-local tasks**: `STATUS.md` coordinates the active slice instead of
  pre-splitting distant roadmap work.
- **Six action skills**: `plan`, `capture`, `arrange`, `do`, `check`, and
  `learn` are the project's own contracts.
- **Durable boundaries**: `docs/adr/` and `docs/protocols/` hold long-lived
  decisions and stable interfaces.

## Installation

Clone and link the CLI:

```bash
git clone https://github.com/your-repo/SPEC-AGENTS.git
cd SPEC-AGENTS
chmod +x link_to_system.sh
./link_to_system.sh
```

The script creates `/usr/local/bin/spec-agents` and may ask for `sudo`. If a
global command is unnecessary, run `./bin/spec-agents ...` directly from this
checkout instead.

Initialize a project:

```bash
cd ~/MyProject
spec-agents init        # Chinese AGENTS.md by default
spec-agents init en     # English AGENTS.md
```

The modern installer creates:

```text
AGENTS.md
CONTEXT.md
ROADMAP.md
STATUS.md
EVIDENCE.md
UPGRADE.md
docs/
  adr/
  protocols/
archive/
skills/
  plan/ capture/ arrange/ do/ check/ learn/
```

For an existing v2 or v3 project, install the modern entry points first:

```bash
spec-agents install ../old-project cn
```

Then run the upgrade Prompt:

```text
Read UPGRADE.md and execute the upgrade review.
```

The Prompt reconstructs recent history, scans the code architecture, asks the
user to confirm the candidate project cognition, and only then archives the old
`.phrase/` tree. The installer itself does not move, delete, or summarize old
project material.

## Quick Start

After installation, begin a new project or session by telling the Agent:

```text
Read AGENTS.md, then follow it for this task.
```

For an ordinary small change, the Agent will normally use:

```text
plan -> do -> check -> learn
```

If the change spans several concepts or needs coordination, it uses the full
loop:

```text
plan -> capture -> arrange -> do -> check -> learn
```

`plan` may conclude that no change is needed. `capture` and `arrange` are not
required for a settled one-file fix.

### CLI commands

```text
spec-agents init [cn|en] [--link]       # install into the current directory
spec-agents install <path> [cn|en] [--link]
spec-agents --help
```

Copy mode is the default. `--link` keeps symbolic links to this SPEC-AGENTS
checkout, so source updates affect linked projects. Existing files are kept;
the installer does not overwrite a project's local decisions.

For a v2/v3 project, do not look for a migration subcommand. Install the modern
layout, then explicitly ask the Agent to run the review:

```text
Read UPGRADE.md and execute the upgrade review.
```

The review reports its reconstruction and architecture scan first, then waits
for the user's confirmation before changing root documents or archiving legacy
material.

## Default Read Rule

At the start of ordinary work, the agent reads:

```text
AGENTS.md
CONTEXT.md
STATUS.md
ROADMAP.md
```

It reads `EVIDENCE.md` when choosing a phase, checking a failed assumption,
classifying a blocker, or deciding whether a phase can close. It reads
`docs/adr/` and `docs/protocols/` only when the affected area points to them,
and `archive/` only for explicit historical or regression questions.

The old `.phrase/` tree is legacy context, not a second default source of
truth.

## File Authority

When documents disagree:

1. `AGENTS.md` defines workflow and safety rules.
2. `CONTEXT.md`, `docs/adr/`, and `docs/protocols/` define durable semantics.
3. Fresh, verified entries in `EVIDENCE.md` define current facts.
4. A confirmed `.scratch/<feature>/SPEC.md` defines the living feature
   contract.
5. `STATUS.md` defines current execution state.
6. `ROADMAP.md` defines phase direction.
7. `archive/` and `.phrase/` are historical context only.

Fresh evidence can challenge a durable rule, but the conflict must be routed
through `plan` and recorded before implementation silently changes the model.

## Workflow

1. `plan`: clarify need, unchanged baseline, concepts, compatibility, and the
   verification gate.
2. `capture`: record a confirmed multi-context change in a living SPEC.
3. `arrange`: split that SPEC into independent, vertical slices only when
   coordination needs it.
4. `do`: execute one ready slice and update only its local status.
5. `check`: compare the result with the confirmed contract and engineering
   standards.
6. `learn`: append verified evidence and promote only reusable knowledge.

Use the shortest valid path: no-change stops after `plan`; a settled small
change may go directly to `do`; multi-context work uses all six actions.

## Task Format

Tasks are phase-local. Use them only when they help coordinate the active work:

```text
taskNNN [ ] goal:<observable result> | scope:<files or area> | verify:<proof>
```

Do not pre-split future roadmap phases into tasks.

## Migration From v2/v3

For an existing project, install the modern entry points and read `UPGRADE.md`.
Use a `plan` pass to decide what should be promoted. Keep only durable rules in `CONTEXT.md` or
`docs/adr/`, stable interfaces in `docs/protocols/`, current state in
`STATUS.md`, and decision-relevant facts in `EVIDENCE.md`. Archive obsolete
material instead of mechanically copying it into the default context.

The old `.phrase/commands/` instructions are archived history, not a second
default workflow.

## Protocol Cost Comparison

Run the comparison benchmark:

```bash
./tests/protocol-cost-comparison.sh
```

The script creates temporary legacy v2 and v3 fixtures. Its numbers measure
historical protocol overhead, not model intelligence or code quality.

Current fixture result:

| Metric | v2 static SPEC | v3 EDPP | Saved |
| --- | ---: | ---: | ---: |
| Default read files | 8 | 3 | 62.5% |
| Default read words | 378 | 170 | 55.0% |
| Default read bytes | 2405 | 1160 | 51.8% |
| Estimated read tokens | 601 | 290 | 51.7% |
| Required write surfaces after implementation | 5 | 2 | 60.0% |

The benchmark remains a historical v3 comparison; it does not define the v4
default layout.

## 中文说明（当前 v4）

SPEC-AGENTS v4 将稳定的项目语义模型与当前阶段的动态证据分开保存。
它不是要求 Agent 永远遵守一套不能修改的文档，而是在明确边界的前提下，
允许通过验证后的证据演进当前阶段和后续规则。

当前工作流是六个动作：

```text
plan -> capture -> arrange -> do -> check -> learn
```

最短可行路径是：

```text
plan -> do -> check -> learn
```

如果 `plan` 判断没有必要改变，就停止；只有跨多个上下文、需要保留设计契约
或需要协调多个切片时，才使用 `capture` 和 `arrange`。

### 当前项目文件

普通任务默认读取：

```text
AGENTS.md
CONTEXT.md
STATUS.md
ROADMAP.md
```

只有在选择下一阶段、检查失败假设、分类 blocker 或判断阶段是否可以关闭时，
才读取 `EVIDENCE.md`。长期决策和稳定接口分别放在 `docs/adr/` 与
`docs/protocols/`；`archive/` 只用于明确的历史或回归问题。

### 研究归档与安装边界

源码仓库中的设计研究和实验记录统一放在
[`research/`](research/README.md)：

- `research/ontology/`：本体论、Palantir 方法和 SPEC 融合研究；
- `research/experiments/`：实验 Brief、fixture、运行协议和结果；
- `research/history/`：旧版系统模型与 v3 EDPP 资料。

这些内容是仓库研究档案，不是用户项目的默认上下文，也不会被
`bin/spec-agents` 安装到用户项目。安装器只提供运行时所需的根文件、
`docs/`、`archive/` 和六个 action skills。

### v2/v3 项目升级

旧项目先安装新版入口，再让 Agent 读取 `UPGRADE.md` 并执行升级审查：

```text
Read UPGRADE.md and execute the upgrade review.
```

升级由 Agent 重建近期历史、扫描代码架构并请求用户确认；安装器不会自动
移动、删除或总结旧项目材料。

## 中文说明（历史 v3 参考）

以下内容保留旧版 v3 的背景说明。出现 `.phrase/` 的地方仅描述 legacy
兼容或历史 benchmark，不是当前新项目的默认入口。

### v3 背景

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

## 默认读取规则（v3 历史）

默认上下文（v3 历史）：

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

## 从 v2 迁移（历史 v3 记录）

以下步骤只记录旧版 v3 的做法，不是当前迁移指引。现在的 v2/v3 项目应先
安装新版入口，再执行 `Read UPGRADE.md and execute the upgrade review.`；
不要手动把遗留内容移动到 `.phrase/archive/`。

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

当前 fixture 的结果：

| 指标 | v2 静态 SPEC | v3 EDPP | 节省 |
| --- | ---: | ---: | ---: |
| 默认读取文件数 | 8 | 3 | 62.5% |
| 默认读取字数 | 378 | 170 | 55.0% |
| 默认读取字节数 | 2405 | 1160 | 51.8% |
| 估算读取 token | 601 | 290 | 51.7% |
| 实现后需要维护的写入面 | 5 | 2 | 60.0% |

一句话：

> 最小上下文，证据驱动阶段，验证后执行，只保留长期有价值的决策。
