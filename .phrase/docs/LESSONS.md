# LESSONS.md — Spec-AGENTS 扩展经验与设计决策

本文件记录 Spec-AGENTS 自身在演进过程中积累的经验、踩过的坑、以及关键设计决策。
每条 lesson 对应一次实际遭遇或扩展，附上做法与背后的理由。

---

## lesson001 — 2026-02-18 | /done 会话记录命令

**背景**：每次 Claude Code 会话结束后，讨论内容、决策和后续事项容易丢失，导致下次会话需要重新建立上下文。

**决策**：
- 新增 `.phrase/commands/` 目录，专门存放可安装到 `.claude/commands/` 的命令文件。
- 新增 `done.md` 命令：触发后将本次会话的摘要、讨论、决策、问题与后续事项保存为 `.claude/sessions/YYYY-MM-DD_<branch>.md`。
- 修改 `bin/spec-agents`：`init` / `install` 时自动将 `.phrase/commands/` 里的所有文件同步到目标项目的 `.claude/commands/`，确保命令随 spec-agents 安装自动生效。
- 在 `AGENTS.md` 中以 "## 6. 📝 会话收尾" 注册为第六个意图，引用 `.phrase/commands/done.md`，与其他模块风格一致（Scan → Load → Act）。

**取舍**：
- 命令文件放在 `.phrase/commands/` 而非 `.phrase/modules/`，是因为两者语义不同：modules 是 AI 角色/流程模块，commands 是直接安装给工具使用的指令文件。
- 会话记录保存在 `.claude/sessions/`（项目内），而非全局目录，便于和 git 历史对齐，也方便团队共享上下文。

**验证**：`spec-agents init` 后，目标项目的 `.claude/commands/done.md` 存在；在 Claude Code 中输入 `/done` 可触发会话摘要写入。

---

## lesson002 — 2026-02-18 | /start-phase 阶段启动命令

**背景**：用户在启动新的开发阶段时，经常忘记先完成 PR/FAQ 或跳过关键文档（spec/plan），直接进入编码，导致后续需求不清、返工频繁。

**决策**：
- 新增 `.phrase/commands/start-phase.md` 命令：作为 phase 启动的**统一入口**，强制执行以下流程：
  1. **前置检查**：判断是否需要先完成 PR/FAQ（新项目/重大功能 → 需要；小迭代/Bug修复 → 可跳过）。
  2. **PR/FAQ 引擎**：如需 PR/FAQ，调用 `.phrase/modules/pr_faq.md` 模块，完成后保存为 `phase-<purpose>-<YYYYMMDD>/pr_faq_<purpose>.md`。
  3. **创建 Phase 目录**：在 `.phrase/phases/phase-<purpose>-<YYYYMMDD>/` 下初始化最小文档集（spec/plan/task，必要时补 tech-refer/adr）。
  4. **更新全局索引**：在 `.phrase/docs/PHASES.md` 中记录新阶段。
- 在 `AGENTS.md` 中以 "## 7. 🚀 启动新阶段" 注册为第七个意图，引用 `.phrase/commands/start-phase.md`。

**取舍**：
- `/start-phase` 命令放在 `.phrase/commands/` 而非直接写入 AGENTS.md，是为了保持指令可独立更新、可复用。
- PR/FAQ 不强制要求所有阶段都完成，而是由命令内部逻辑判断（新方向/重大功能 → 需要；小迭代 → 可跳过），在严格性和灵活性之间取得平衡。
- phase 目录命名为 `phase-<purpose>-<YYYYMMDD>`，用日期做唯一标识，避免同一目的多次迭代时冲突。

**与 lesson001 的关联**：
- `/start-phase` 是"开局"命令，`/done` 是"收尾"命令，两者配合使用，形成完整的会话生命周期管理。

**验证**：
- 用户输入 `/start-phase` → AI 提示输入 purpose → 判断是否需要 PR/FAQ → 创建 phase 目录 → 初始化 spec/plan/task 文件 → 更新 PHASES.md。
- 阶段创建后，所有后续任务都应引用该 phase 下的文档，而非对话记录。

