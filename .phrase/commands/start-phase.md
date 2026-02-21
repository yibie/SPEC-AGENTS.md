---
description: Start a new development phase (creates spec/plan/task docs under .phrase/phases/)
---

# /start-phase — 启动新开发阶段

在启动任何新的开发阶段之前，必须先完成 PR/FAQ 文档（如果是项目初期或重大方向变化），然后创建新的 phase 目录并初始化最小文档集。

## 前置检查

在执行本命令之前，先判断是否需要 PR/FAQ：

1. **需要 PR/FAQ 的情况**：
   - 项目刚启动（`.phrase/` 目录为空或只有模板）
   - 要开启的阶段涉及产品方向重大变化、新功能模块、或全新子系统
   - 用户明确提到"新想法"、"新方向"、"立项"等词汇

2. **可跳过 PR/FAQ 的情况**：
   - 已有明确的 spec/plan，只是阶段性推进
   - Bug 修复或优化类任务（已有需求基础）
   - 小范围迭代

3. **触发 PR/FAQ 流程**：
   - 如果判断需要 PR/FAQ，则提示用户："检测到这是一个新方向/新项目。根据 AGENTS.md 协议，需要先完成 PR/FAQ 文档。现在开始访谈模式？"
   - 用户确认后，读取 `.phrase/modules/pr_faq.md` 并严格执行其中的工作流。
   - PR/FAQ 完成后，将其保存为 `.phrase/phases/phase-<purpose>-<YYYYMMDD>/pr_faq_<purpose>.md`

## 执行步骤

一旦前置条件满足（PR/FAQ 已有或已完成），执行以下操作：

### 1. 确定 phase 参数

- **purpose**：阶段目的的简短关键词（如 `window-pinning`, `auth-system`, `ui-redesign`）
- **date**：当前日期 `YYYYMMDD`（使用 `date +"%Y%m%d"`）

与用户确认 purpose 词汇，确保简洁、语义清晰。

### 2. 创建 phase 目录

```bash
mkdir -p .phrase/phases/phase-<purpose>-<YYYYMMDD>
```

### 3. 初始化最小文档集

根据 AGENTS.md 协议，phase 启动时必须创建以下文件：

#### `spec_<purpose>_<YYYYMMDD>.md`

从 PR/FAQ（如有）或用户描述中提取，包含：
- Summary（摘要）
- Goals & Non-goals（目标与非目标）
- User Flows（用户操作流程：操作 → 反馈 → 回退）
- Edge Cases（边界情况）
- Acceptance Criteria（验收标准）

#### `plan_<purpose>_<YYYYMMDD>.md`

包含：
- Milestones（里程碑）
- Scope（范围）
- Priorities（优先级）
- Risks & Dependencies（风险与依赖）
- (可选) Rollback（回滚方案）

#### `task_<purpose>_<YYYYMMDD>.md`

初始为空或包含一个示例任务（使用 BDD 单行格式）：
```markdown
# Task List - Phase: <purpose>-<YYYYMMDD>

task001 [ ] 场景: | Given: | When: | Then: | 验证:
```

#### (可选) `tech-refer_<purpose>_<YYYYMMDD>.md`

如果涉及技术选型或架构决策，补充此文件：
- Options（备选方案）
- Proposed Approach（建议方案）
- Interfaces & APIs（接口与 API）
- Trade-offs（取舍）
- Risks & Mitigations（风险与缓解措施）

#### (可选) `adr_<purpose>_<YYYYMMDD>.md`

架构决策记录，格式：
- Context（背景）
- Decision（决策）
- Alternatives（备选方案）
- Consequences（后果）
- Rollback（回滚方案）

`issue_*.md` 和 `change_*.md` 在阶段推进时按需创建。

### 4. 更新全局索引

在 `.phrase/docs/` 下创建或更新：

- **PHASES.md**（如不存在则创建）：记录所有 phase 的索引
  ```markdown
  # Phases Index

  ## Active Phases
  - `phase-<purpose>-<YYYYMMDD>` — <一句话描述>

  ## Completed Phases
  - `DONE-phase-<old-purpose>-<date>` — <一句话描述> (completed on YYYY-MM-DD)
  ```

### 5. 确认输出

打印以下信息：
```
✅ Phase created: phase-<purpose>-<YYYYMMDD>
📂 Location: .phrase/phases/phase-<purpose>-<YYYYMMDD>/
📄 Files initialized:
   - spec_<purpose>_<YYYYMMDD>.md
   - plan_<purpose>_<YYYYMMDD>.md
   - task_<purpose>_<YYYYMMDD>.md
   (optional: tech-refer_*, adr_*)
📝 Next steps:
   1. Review and refine spec/plan docs
   2. Break down plan into taskNNN (BDD format)
   3. Start implementation
```

## 约束

- **文档优先**：禁止在 spec/plan 确定之前开始编码或拆解任务细节。
- **单一事实来源**：所有需求、接口、交互信息只能来自这些文档，不能依赖对话记录。
- **可追溯性**：每个 phase 都必须能追溯回最初的 PR/FAQ 或需求来源。
- **原子性**：一个 phase 聚焦一个清晰的目标；如果范围过大，建议拆成多个 phase。

## 示例对话流程

```
User: /start-phase
AI: 好的。请问本次阶段的目的是什么？（用 2-3 个关键词概括，如 "window-pinning", "dark-mode", "auth-refactor"）

User: window-pinning

AI: 检测到这是一个新功能模块。根据 AGENTS.md 协议，需要先完成 PR/FAQ 文档。现在开始访谈模式吗？

User: 是的

AI: [进入 PR/FAQ 访谈模式...]
AI: [PR/FAQ 完成后] ✅ PR/FAQ 已保存为 .phrase/phases/phase-window-pinning-20260218/pr_faq_window-pinning.md
AI: 现在开始创建 phase 文档集...
AI: ✅ Phase created: phase-window-pinning-20260218
    📂 Location: .phrase/phases/phase-window-pinning-20260218/
    📄 Files initialized:
       - spec_window-pinning_20260218.md
       - plan_window-pinning_20260218.md
       - task_window-pinning_20260218.md
    📝 Next steps:
       1. Review spec/plan
       2. Break down into taskNNN
       3. Start implementation
```

## 与 PR/FAQ 模块的关系

- `/start-phase` 是启动阶段的**入口命令**，负责判断和编排流程。
- `.phrase/modules/pr_faq.md` 是**访谈引擎**，负责引导用户完成 PR/FAQ 文档。
- 两者配合使用：`/start-phase` 检测到需要 PR/FAQ → 调用 pr_faq 模块 → 完成后创建 phase。
