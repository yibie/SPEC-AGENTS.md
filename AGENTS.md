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
**行动**：遵循下方的"文档驱动开发"工作流。

## 6. 📝 会话收尾（/done）
**触发条件**：用户输入 `/done`，或明确表示本次会话结束、想保存记录。
**行动**：
1. **扫描**：读取 `.phrase/commands/done.md` 确认匹配。
2. **加载**：完整读取该文件内容。
3. **执行**：按文件中的步骤，将本次会话摘要保存为 `.claude/sessions/YYYY-MM-DD_<branch>.md`。
4. **约束**：只记录本次对话中实际发生的内容，不捏造；保留技术细节（文件名、函数名、错误信息）。

## 7. 🚀 启动新阶段（/start-phase）
**触发条件**：用户输入 `/start-phase`，或明确表示要开启新的开发阶段。
**行动**：
1. **扫描**：读取 `.phrase/commands/start-phase.md` 确认匹配。
2. **加载**：完整读取该文件内容。
3. **前置检查**：判断是否需要先完成 PR/FAQ（新项目/新方向/重大功能 → 需要；小迭代/Bug修复 → 可跳过）。
   - 如需 PR/FAQ，读取 `.phrase/modules/pr_faq.md` 并执行访谈流程，完成后保存为 `phase-<purpose>-<YYYYMMDD>/pr_faq_<purpose>.md`。
4. **创建 Phase**：在 `.phrase/phases/phase-<purpose>-<YYYYMMDD>/` 下初始化最小文档集（spec/plan/task，必要时补 tech-refer/adr）。
5. **更新索引**：在 `.phrase/docs/PHASES.md` 中记录本次新阶段。
6. **约束**：在 spec/plan 确定之前，禁止开始编码或拆解任务细节。

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

### Task 格式（BDD 风格，单行格式以节省 token）
```
taskNNN [状态] 场景:<一句话描述> | Given:<前置条件> | When:<触发动作> | Then:<期望结果> | 验证:<测试方式>
```

| 字段 | 必填 | 说明 |
|-----|------|------|
| `场景:` | ✓ | 用户视角的一句话描述，回答"谁在什么情况下做什么" |
| `Given:` | ✓ | 前置状态/数据，多个条件用 `+` 连接 |
| `When:` | ✓ | 用户操作、触发事件或系统动作 |
| `Then:` | ✓ | 可观察的结果/反馈，多个结果用 `+` 连接 |
| `验证:` | ✓ | 验证方式：手动测试/单元测试/UI测试/截图对比等 |

**可选追加字段**（放在行尾）：`| 备注:<说明>` `| 优先级:P0/P1/P2` `| 依赖:taskNNN`

**示例：**
```markdown
task001 [ ] 场景:用户通过快捷键置顶窗口 | Given:用户正在使用某应用窗口 | When:按下 Cmd+Ctrl+T | Then:窗口保持在最前端+菜单栏显示置顶指示器 | 验证:手动测试+截图对比
task002 [x] 场景:用户取消窗口置顶 | Given:窗口已处于置顶状态 | When:再次按下 Cmd+Ctrl+T | Then:窗口恢复正常层级+指示器消失 | 验证:手动测试
task003 [ ] 场景:重启后恢复置顶状态 | Given:用户之前将窗口A置顶并退出应用 | When:重新启动应用 | Then:窗口A自动恢复置顶状态 | 验证:单元测试 | 依赖:task001
```

### Task 管理规范
- `taskNNN` 为三位递增 ID（`task001` 起），不可重排或复用；拆分/合并需创建新 ID 并在原任务注明流向。
- 任何对 `task_*` 的增删改/勾选都要在当前 phase `change_*` 记录一次，可批量合并但必须可追溯。
- 原子任务标准：一次工作会话可完成、产出可观察、可独立验证，既不过细也不过粗。

### Issue 格式（单行）
```
issueNNN [状态] 标题:<一句话描述> | 模块:<受影响组件> | 优先级:P0/P1/P2 | 关联:taskNNN | 解决:<commit/日期>
```

| 字段 | 必填 | 说明 |
|-----|------|------|
| `标题:` | ✓ | 问题的一句话简述 |
| `模块:` | ✓ | 受影响的组件/模块，如 `UI/快捷键` `Core/状态管理` |
| `优先级:` | ✓ | P0=阻塞/崩溃，P1=功能缺陷，P2=优化建议 |
| `关联:` | - | 关联的 taskNNN，解决后回填 |
| `解决:` | - | 解决时的 commit hash 或日期，标记 `[x]` 后填写 |

**示例：**
```markdown
issue001 [x] 标题:置顶快捷键在多显示器下失效 | 模块:UI/快捷键 | 优先级:P0 | 关联:task005 | 解决:a1b2c3d
issue002 [ ] 标题:重启后偶尔丢失置顶状态 | 模块:Core/状态持久化 | 优先级:P1 | 关联:task003
issue003 [ ] 标题:状态指示器颜色不够明显 | 模块:UI/视觉 | 优先级:P2
```

**详细记录：** 单行格式仅用于索引。详细的环境、复现、根因、修复过程记录在 phase 内的 `issue_<purpose>_<YYYYMMDD>.md` 文件中。

---

### Change 格式（单行）
```
changeNNN 日期:YYYY-MM-DD | 文件:<路径> | 操作:Add\|Modify\|Delete | 影响:<函数/模块> | 说明:<简述> | 关联:taskNNN
```

| 字段 | 必填 | 说明 |
|-----|------|------|
| `日期:` | ✓ | 变更日期，格式 `YYYY-MM-DD` |
| `文件:` | ✓ | 变更的文件路径，如 `Core/WindowManager.swift` |
| `操作:` | ✓ | `Add`/`Modify`/`Delete`，新增/修改/删除 |
| `影响:` | ✓ | 受影响的函数、模块或行为 |
| `说明:` | ✓ | 变更内容的简述 |
| `关联:` | ✓ | 对应的 taskNNN |

**示例：**
```markdown
change001 日期:2024-02-06 | 文件:UI/StatusBar.swift | 操作:Add | 影响:showIndicator() | 说明:添加置顶状态指示器 | 关联:task001
change002 日期:2024-02-06 | 文件:Core/HotKey.swift | 操作:Modify | 影响:registerHotKey() | 说明:修复快捷键冲突检测逻辑 | 关联:task004
```

**全局索引：** `.phrase/docs/CHANGE.md` 按 phase 分组，仅保留最近的变更索引，详细变更列表保留在各 phase 的 `change_*` 文件中。

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
- `change_*`：phase 内的真实变更记录，使用**单行格式**；每个完成的 `taskNNN` 至少一条，按时间倒序排列。
- `.phrase/docs/CHANGE.md`：仅索引与摘要，指向对应 phase `change_*` 条目；可按工作会话批量更新。
- `spec_*`/`plan_*`/`tech-refer_*`/`adr_*`/`issue_*` 均需随变更回写（增量即可），保持单一事实来源。

### 单行格式速查
| 文档 | 格式 |
|-----|------|
| `task_*` | `taskNNN [状态] 场景:... \| Given:... \| When:... \| Then:... \| 验证:...` |
| `issue_*` | `issueNNN [状态] 标题:... \| 模块:... \| 优先级:... \| 关联:... \| 解决:...` |
| `change_*` | `changeNNN 日期:... \| 文件:... \| 操作:... \| 影响:... \| 说明:... \| 关联:...` |

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
- `task`: `task001 [ ] 场景:用户做什么 | Given:前置状态 | When:触发动作 | Then:期望结果 | 验证:测试方式`
- `issue`: `issue001 [ ] 标题:问题简述 | 模块:组件 | 优先级:P0/P1/P2 | 关联:taskNNN | 解决:commit`
- `change`: `change001 日期:YYYY-MM-DD | 文件:路径 | 操作:Add|Modify|Delete | 影响:函数 | 说明:简述 | 关联:taskNNN`
- `adr`: Context / Decision / Alternatives / Consequences / Rollback

---

## 9. 协作表达提示
- 解释方案时优先描述用户操作（快捷键/鼠标/命令）、可见反馈、撤销/失败路径、边界情况。
- 引用文档时用“文件名 + 小节”口语化说明，不逐字背诵。
- 提供可选方案时说明它们属于当前还是后续里程碑，帮助用户决策。