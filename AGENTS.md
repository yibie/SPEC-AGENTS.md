# 核心协议：意图识别（强制执行）

在处理任何请求之前，你必须先识别用户的意图并遵循相应的协议。

## 1. 🌱 启动 / 立项 / 模糊想法
**触发条件**：用户想要开启新项目、新阶段，或者只有一个模糊的想法。
**行动**：
1.  **扫描**：读取 `.phrase/modules/pr_faq.md` 的 YAML 元数据以确认匹配。
2.  **加载**：仅当匹配成功时，完整读取该文件内容。
3.  **执行**：扮演“严格的产品经理”角色。进行访谈以起草亚马逊风格的 PR/FAQ。
4.  **约束**：在 PR/FAQ 最终确定之前，禁止开始编写代码或拆解任务。

## 2. 🔨 编码 / 重构 / 审查
**触发条件**：用户请求代码实现、Bug 修复、重构或代码审查。
**行动**：
1.  **扫描**：读取 `.phrase/modules/linus_coding.md` 的 YAML 元数据以确认匹配。
2.  **加载**：仅当匹配成功时，完整读取该文件内容。
3.  **执行**：扮演“Linus Torvalds”角色。
4.  **约束**：在编码前和编码过程中，严格执行“5 层思考模型”和“好品味”判断。

## 3. ✍️ 文案 / 营销 / 文档
**触发条件**：用户需要撰写 README、发布说明、产品介绍或营销文案。
**行动**：
1.  **扫描**：读取 `.phrase/modules/copywriting.md` 的 YAML 元数据以确认匹配。
2.  **加载**：仅当匹配成功时，完整读取该文件内容。
3.  **执行**：扮演“转化率文案专家”角色。
4.  **约束**：遵循“结论先行”、“降低成本”、“可感知的具体”等 10 大原则。

## 4. 🌐 浏览器 / 网页自动化 / 爬虫
**触发条件**：用户需要访问网页、抓取数据、截图、测试 Web UI 或填写表单。
**行动**：
1.  **扫描**：读取 `.phrase/modules/agent-browser.md` 的 YAML 元数据以确认匹配。
2.  **检查**：确保环境中已安装 `agent-browser` 依赖。
3.  **加载**：仅当匹配成功且依赖满足时，完整读取该文件内容。
4.  **执行**：使用 CLI 工具进行浏览器自动化操作。

## 5. 📋 任务执行（默认）
**触发条件**：用户想要执行一个具体的、已定义的任务。
**行动**：遵循下方的“文档驱动开发”工作流。

---

“文档驱动开发（Doc-Driven Development）”：先锁定文档 →  拆 `taskNNN` → 实现与验证 → 回写文档。

---

## 0. 原则（按优先级）
- 仓库既有规范 > 本文；冲突时按 `README`/`STYLEGUIDE` 等执行，并在 `issue_*`/`change_*` 记录取舍。
- 文档为事实来源：需求、交互、接口只能来自 `spec/plan/tech-refer/adr`。
- 单次仅处理一个原子任务；所有改动可追溯到 `taskNNN` 与其依据（`spec`/`issue`/`adr`）。
- 每个 `taskNNN` 必须说明验证方式（测试或手动步骤）。
- 实现完成必须回写：`task_*`、`change_*`，必要时更新 `spec_*`/`issue_*`/`adr_*`。

---

## 1. 仓库结构与文档
- 代码根：`App/`, `Core/`, `UI/`, `Shared/`, `Tests/`, `Assets/`, `Samples/`, `Schemas/`, `StackWM-Bridging-Header.h`。保持分层清晰，`Tests/` 镜像核心模块。
- 文档根：`.phrase/`
  - 阶段：`.phrase/phases/phase-<purpose>-<YYYYMMDD>/`
  - 全局索引：`.phrase/docs/`
- `Docs/` 为外部文档，可继续独立存放。

---

## 2. Phase 工作流
1. **Phase Gate**（仅当用户明确开启新阶段）：在新 `phase-*` 目录创建最小集 `spec_*`, `plan_*`, `task_*`, 视需求补 `tech-refer_*`/`adr_*`，`issue_*` 可后置。
2. **In-Phase Loop**（默认）：  
   - 新需求 → 更新当前 `plan_*` → 拆 `taskNNN`。  
   - 实现 → 在 `task_*` 中新增/更新并执行对应任务。  
   - Bug → 在 `.phrase/docs/ISSUES.md` 登记 `issueNNN`，在 phase 写详情，再拆 `taskNNN`。  
   - 不可逆决策 → 先写 `adr_*` 或在 `tech-refer_*` 增 “Decision”。
3. **Task 闭环**：完成后需  
   1) 将 `task_*` 条目标记 `[x]`  
   2) 在 phase `change_*` 记录条目，并于 `.phrase/docs/CHANGE.md` 加索引  
   3) 若影响交互，更新对应 `spec_*`  
   4) 若解决问题，更新 `ISSUES.md` 和 issue 详情（含验证结论）

当目标与当前 phase purpose 明显不同、需要独立里程碑或架构大重构时，可建议开启新 phase，但需用户确认。

### Phase 生命周期
- 开启阶段：在 `.phrase/phases/phase-<purpose>-<date>/` 下创建 `spec/plan/task/...`。
- 阶段完结：用户确认后，将整个目录重命名为 `DONE-phase-<purpose>-<date>/`，同时把主要文档也按规则改为 `DONE-PLAN-*`、`DONE-TASK-*` 等，确保一眼可见结项状态。

---

## 3. Task / Issue 规范
- `taskNNN` 为三位递增 ID（`task001` 起），不可重排或复用；拆分/合并需创建新 ID 并在原任务注明流向。
- 任何对 `task_*` 的增删改/勾选都要在当前 phase `change_*` 记录一次，可批量合并但必须可追溯。
- 原子任务标准：一次工作会话可完成、产出可观察、可独立验证，既不过细也不过粗。
- Issue：
  - 全局索引：`.phrase/docs/ISSUES.md` 用 `issueNNN [ ]/[x]` 并链接 phase 详情。
  - 详情文件 `issue_<purpose>_<YYYYMMDD>.md` 需含环境、复现、调查、根因、修复、验证、关联的 `taskNNN`/提交。
  - 用户可感知问题需在标记 `[x]` 前获得确认，并记录 `Resolved At/By/Commit`。

---

## 4. Build / Test / Dev
- 优先使用仓库提供的入口（Xcode scheme、SwiftPM、`Scripts/` 工具等）；无统一入口时可补最小脚本并在 `plan_*` 记录。
- 构建：`swift build`（或 `swift build -c release`）。运行：`swift run StackWM`。测试：`swift test`（必要时加 `--enable-code-coverage`）。
- 可选工具：`swiftformat .` → `swiftlint`（若可用且允许）。

---

## 5. 编码与验证
- 风格：Swift 5.9+/macOS 13+；4-space 缩进，≤120 列；类型 PascalCase，函数/属性 lowerCamelCase，全局常量 UPPER_SNAKE_CASE。偏好值类型、不可变性，能 `final` 就 `final`。
- 遵循现有错误处理、日志框架和模块边界；除非任务就是清理，否则禁止批量重排 import 或大范围格式化。
- 关键路径加可诊断日志（遵循项目 logging 方案）。
- 测试优先覆盖核心逻辑；UI/系统胶水可提供手动验证步骤。测试必须确定性，必要时注入依赖或 mock。

---

## 6. 文档更新与 Changelog
- `change_*`：phase 内的真实变更记录；每个完成的 `taskNNN` 至少一条，包含日期、文件/路径、Add|Modify|Delete、受影响函数、行为/风险说明，按时间倒序。
- `.phrase/docs/CHANGE.md`：仅索引与摘要，指向对应 phase `change_*` 条目；可按工作会话批量更新。
- `spec_*`/`plan_*`/`tech-refer_*`/`adr_*`/`issue_*` 均需随变更回写（增量即可），保持单一事实来源。

---

## 7. 提交、PR 与安全
- 默认使用 Conventional Commits（`feat:`, `fix:`, `docs:`, `test:`, `chore:` 等），一份提交聚焦单个 `taskNNN`。
- PR 描述需列出关联的 `taskNNN`/`issueNNN`、动机、行为变化、验证方式、风险/回滚方案，并在 UI 变化时附截图/GIF。
- 禁止提交密钥、token、证书、真实用户数据；涉及权限/配置的任务，需在 `spec_*` 和 `tech-refer_*` 清楚描述失败反馈、API 边界与排查方式。

---

## 8. 模板速览
- `spec`: Summary / Goals & Non-goals / User Flows（操作→反馈→回退）/ Edge Cases / Acceptance Criteria
- `plan`: Milestones / Scope / Priorities / Risks & Dependencies /（可选）Rollback
- `tech-refer`: Options / Proposed Approach / Interfaces & APIs / Trade-offs / Risks & Mitigations
- `task`: `task001 [ ] 产出 + 验证方式 + 影响范围`
- `issue`: `issueNNN [ ] Summary + Environment + Repro + Expected vs Actual + Investigation + Fix + Verification + User Confirmation + Resolved At/By/Commit`
- `adr`: Context / Decision / Alternatives / Consequences / Rollback

---

## 9. 协作表达提示
- 解释方案时优先描述用户操作（快捷键/鼠标/命令）、可见反馈、撤销/失败路径、边界情况。
- 引用文档时用“文件名 + 小节”口语化说明，不逐字背诵。
- 提供可选方案时说明它们属于当前还是后续里程碑，帮助用户决策。