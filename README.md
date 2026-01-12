# SPEC-AGENTS.md

## Overview

This project is inspired by Spec-kit, OpenSpec, and Stack Workflow. It combines the advantages of spec-driven development and phased development. With a small amount of configuration, it helps everyday developers, especially in “vibe coding” sessions, improve the accuracy of AI execution, reduce repeated copy-pasting into the AI, and still enjoy the stability and convenience of mature software engineering workflows.

## Features

- **Intent Recognition**: Automatically switches between PM, Coder, and Copywriter personas.
- **Zero Configuration**: Just one command to init.
- **Natural Language Interaction**: No complex JSON/YAML configs.
- **Production-Grade Workflow**: Enforces rigorous spec/plan/task lifecycles.
- **Project Memory**: AI remembers context across sessions.

## Installation (CLI)

Spec-AGENTS v2 provides a CLI tool for easy installation and management.

### 1. Download & Link

Clone the repository and link the binary to your system path:

```bash
git clone https://github.com/your-repo/SPEC-AGENTS.git
cd SPEC-AGENTS
chmod +x link_to_system.sh
./link_to_system.sh
```

Now you can use the `spec-agents` command globally.

### 2. Initialize in Your Project

Go to your project directory and run:

```bash
cd ~/MyProject
spec-agents init        # Install Chinese version (Default)
# OR
spec-agents init en     # Install English version
```

This will automatically create the `AGENTS.md` file and the `.phrase/` directory structure with all intelligent modules.

## Usage

### 1. Configure Your AI Tool

- **Cursor / Copilot**: Just ensure `AGENTS.md` is in the root.
- **Claude Code**: Add `@AGENTS.md` to your `CLAUDE.md`.
- **Gemini CLI**: Add `@AGENTS.md` to your `GEMINI.md`.

### 2. Start Chatting (Intent Routing)

Just talk to your AI. The system will automatically route your intent:

*   **"I have a new idea..."** $\rightarrow$ Triggers **PR/FAQ Module** (Product Manager Mode).
*   **"Implement this feature..."** $\rightarrow$ Triggers **Linus Coding Module** (Strict Engineering Mode).
*   **"Write a release note..."** $\rightarrow$ Triggers **Copywriting Module** (Marketing Mode).
*   **"Scrape this website..."** $\rightarrow$ Triggers **Browser Automation Module**.

## Principles

Similar to OpenSpec, SPEC-AGENTS.md splits development into multiple phases and standardizes a “doc-driven development” workflow:

1. First, write `spec_*`, `plan_*`, `task_*` and other docs in natural language under `.phrase/phases/`.  
2. Then, let the agent implement and verify tasks strictly according to those documents.  
3. Finally, write back to `task_*`, `change_*`, `spec_*`, `issue_*`, `adr_*`, so every change can be traced end-to-end.

When you place an `AGENTS.md` file in a project, any AI tool that supports this protocol will read the rules at the start of a session and treat them as “instructions for the developer assistant”:

- All requirements, interactions, and interface information come from docs, not ad-hoc chat messages.  
- Each conversation focuses on a single atomic `taskNNN`.  
- After each task is completed, the assistant records how it was verified and what it affected in the change docs.  

With this set of constraints, SPEC-AGENTS compresses the traditional spec / task / change / issue workflow into a lightweight text protocol, so individuals and small teams can enjoy mature software engineering practice even while “vibe coding”.

## Workflow (How It Works)

The diagram below shows a typical workflow for SPEC-AGENTS.md within a project:

```
┌────────────────────┐      Draft / update specs (write spec_/plan_ in natural language)
│ Specs & Plans      │
│ (.phrase/phases/   │
│  spec_/plan_ docs) │
└────────┬───────────┘
         │ define intent & scope
         ▼
┌────────────────────┐      Break down into atomic tasks (taskNNN)
│ Atomic taskNNN     │◀──── feedback loop ──────┐  refine task boundaries with the AI
└────────┬───────────┘                          │
         │ agreed task boundaries               │ both sides agree on scope & acceptance
         ▼                                      │
┌────────────────────┐                          │ Implement & verify (AI writes code + tests)
│ Implement & Verify │──────────────────────────┘
│ (AI writes code &  │
│  runs tests)       │
└────────┬───────────┘
         │ mark taskNNN done
         ▼
┌────────────────────┐      Archive changes & update docs
│ Archive & Update   │
│ (change_/spec_/    │
│  issue_/adr_)      │
└────────────────────┘
```

## Real-world Example

Here is a minimal natural-language dialogue that shows how SPEC-AGENTS.md works in a real session:

**1. User describes a request**
> User: I want to add a “Dark Mode” toggle to the project that can be switched via menu or shortcut. Please guide me through this once using the SPEC-AGENTS workflow.

**2. The AI goes back to the docs and locks in a task**
> AI: Sure. I won’t write code yet. According to `AGENTS.md`, I’ll first update the docs under the current phase:
> - In `plan_ui.md`, I’ll add this milestone: support dark-mode toggling.
> - In `task_ui.md`, I’ll add: `task003 [ ] Dark mode toggle (verification: manual toggle + UI refresh check)`.
> Once you confirm this task description and verification method, we’ll move on to implementation.

**3. Align task boundaries**
> User: That works. We don’t need persistence yet; as long as I can toggle it back and forth in the current session, that’s enough.
> AI: Got it. I’ll change the verification for `task003` to “manually toggle twice and confirm the UI updates correctly”, and leave persistence for a follow-up `task004`.

**4. AI implements and verifies**
> (AI performs coding and testing...)

**5. Write back to the docs and close the loop**
> AI: Implementation and verification are complete. Following `AGENTS.md`, I’ll write back to the docs:
> - Mark `task003` as `[x]`.
> - Add a record to `change_ui.md`.
> - Update `spec_ui.md` if needed.

---

## 中文说明

本项目受 Spec-kit、OpenSpec、Stack Workflow 启发而来，兼具「规范驱动开发」和「阶段性开发」的优势，通过简单的配置，让普通小白在氛围编程（Vibe Coding）时，提升 AI 执行任务的准确性，减少与 AI 重复输（chao）入（jia）的次数，同时享受成熟的软件开发流程的稳定、便利。

## 特点

- **意图识别**：自动在产品经理、Linus 风格程序员、文案专家之间切换。
- **零配置**：一行命令即可初始化。
- **自然语言沟通**：无需复杂的 JSON/YAML 配置。
- **成熟的开发流程**：强制执行严格的 Spec/Plan/Task 生命周期。
- **项目记忆**：AI 能够跨会话记住项目上下文。

## 安装 (CLI)

Spec-AGENTS v2 提供了一个 CLI 工具，方便一键安装。

### 1. 下载并连接

下载本仓库，并运行连接脚本（将工具注册到系统路径）：

```bash
git clone https://github.com/your-repo/SPEC-AGENTS.git
cd SPEC-AGENTS
chmod +x link_to_system.sh
./link_to_system.sh
```

现在你可以全局使用 `spec-agents` 命令了。

### 2. 在项目中初始化

进入你的新项目目录，运行：

```bash
cd ~/MyProject
spec-agents init        # 安装中文版（默认）
# 或
spec-agents init en     # 安装英文版
```

这会自动创建 `AGENTS.md` 和 `.phrase/` 目录结构（包含所有智能模块）。

## 用法

### 1. 配置 AI 工具

- **Cursor / Copilot**: 确保 `AGENTS.md` 在项目根目录即可。
- **Claude Code**: 在 `CLAUDE.md` 中添加 `@AGENTS.md`。
- **Gemini CLI**: 在 `GEMINI.md` 中添加 `@AGENTS.md`。

### 2. 意图路由（直接对话）

只需与 AI 自然对话，系统会自动路由你的意图：

*   **"我想做个新功能..."** $\rightarrow$ 触发 **PR/FAQ 模块**（产品经理模式）。
*   **"帮我写代码..."** $\rightarrow$ 触发 **Linus 编程模块**（严格工程模式）。
*   **"写个文案..."** $\rightarrow$ 触发 **文案模块**（营销模式）。
*   **"抓取这个网页..."** $\rightarrow$ 触发 **浏览器自动化模块**。

## 原理

与 OpenSpec 类似，SPEC-AGENTS.md 将开发分为不同的阶段，并约定「文档驱动开发」的工作流：先在 `.phrase/phases/` 中用自然语言写好 `spec_*` / `plan_*` / `task_*` 等文档，再由代理按任务执行实现与验证，最后回写 `task_*` / `change_*` / `spec_*` / `issue_*` / `adr_*`，形成可追溯的闭环。

当你在项目中放置 `AGENTS.md` 后，支持该协议的 AI 工具会在会话开始时读取其中规则，把它视为“开发助理使用说明”：  
- 所有需求与接口信息只以文档为准，而不是零散对话；  
- 每次对话只处理一个 `taskNNN` 原子任务；  
- 每个任务完成后，都在变更文档中登记验证方式和影响范围。  

通过这一套约束，SPEC-AGENTS.md 把传统团队里的 spec / task / change / issue 流程，压缩成一个轻量的文本协议，让个人或小团队也能在「氛围编程」状态下享受成熟的软件工程体验。

## 工作流程（How It Works）

下面是 SPEC-AGENTS.md 协议在一个项目中的典型工作流示意图：

```
┌────────────────────┐      起草 / 更新规范（用自然语言写 spec_/plan_）
│ Specs & Plans      │
│ (.phrase/phases/   │
│  spec_/plan_ docs) │
└────────┬───────────┘
         │ define intent & scope                用自然语言描述意图与范围
         ▼
┌────────────────────┐      拆分为原子任务（taskNNN）
│ Atomic taskNNN     │◀──── feedback loop ──────┐  和 AI 来回调整任务边界
└────────┬───────────┘                          │
         │ agreed task boundaries               │ 双方确认每个任务的范围与验收
         ▼                                      │
┌────────────────────┐                          │ 实现与验证（AI 写代码 + 测试）
│ Implement & Verify │──────────────────────────┘
│ (AI writes code &  │
│  runs tests)       │
└────────┬───────────┘
         │ mark taskNNN done                    标记任务完成
         ▼
┌────────────────────┐      归档变更并更新文档
│ Archive & Update   │
│ (change_/spec_/    │
│  issue_/adr_)      │
└────────────────────┘
```

用一句话概括就是：

1. 与 LLM 确定进入新的开发阶段，在 `.phrase/phases/` 里用自然语言起草或更新规范和计划（spec_/plan_）；  
2. 和 AI 一起把需求拆成若干原子 `taskNNN`，来回修改直到双方对范围和验收标准达成一致；  
3. 按照这些文档驱动实现和验证，每次对话聚焦一个任务；  
4. 完成后回写 `task_*` / `change_*` / `spec_*` / `issue_*`，让所有改动都能从代码追溯回最初的文字意图。

## 实际案例

下面是一个极简的自然对话示例，展示 SPEC-AGENTS.md 在真实会话中的使用方式：

**1. 用户提出需求**
> 用户：我想给项目加一个「深色模式」开关，用菜单或快捷键切换就行。

**2. AI 回到文档，先锁定任务**
> AI：好，我先不直接写代码，而是根据 `AGENTS.md` 先更新当前 phase 下的文档：
> - 在 `plan_ui.md` 补充本次里程碑：支持深色模式切换；
> - 在 `task_ui.md` 中新增：`task003 [ ] 深色模式开关（验证：手动切换 + 界面刷新检查）`。
> 等你确认这个任务描述和验证方式，我们再进入实现。

**3. 对齐任务边界**
> 用户：可以，先不做持久化，只要当前会话能来回切换就够了。
> AI：好的，我会把 `task003` 的验证方式改成「手动切换两次，确认 UI 正确刷新」，持久化部分留到后续的 `task004`。

**4. AI 执行实现与验证**
> （AI 内部在 App/UI 层添加代码，并手动/自动运行验证...）

**5. 回写文档，完成闭环**
> AI：代码和验证已经完成，我会按照 `AGENTS.md` 的要求回写文档：
> - 在 `task_ui.md` 中将 `task003` 勾选为 `[x]`；
> - 在 `change_ui.md` 增加变更记录；
> - 如有必要，补充 `spec_ui.md`。
