# SPEC-AGENTS v3 / v4 番茄钟对照实验

## 1. 实验问题

在相同模型、基础代码、产品需求和工程约束下，v3 与 v4 是否会产生不同的：

- 产品正确性；
- 稳定抽象沉淀；
- 动态证据质量；
- 上下文和文档维护行为。

本实验只有一次样本，结果用于发现协议问题，不用于宣称某个版本统计上更优。

## 2. 控制条件

| 条件 | v3 | v4 |
|---|---|---|
| Base commit | `8a11f8f` | `8a11f8f` |
| Model | `gpt-5.6-luna`, medium | `gpt-5.6-luna`, medium |
| Worktree | `/private/tmp/spec-agents-pomodoro-v3` | `/private/tmp/spec-agents-pomodoro-v4` |
| Branch | `experiment/pomodoro-v3` | `experiment/pomodoro-v4` |
| Product brief | 相同 | 相同 |
| UI / engineering constraints | 相同 | 相同 |
| Working protocol | v3 `AGENTS.md` | v4 Living Ontology draft |

两个 Agent 不得读取对方 worktree。最终验收由同一个外部 Agent 使用同一套浏览器流程完成。

## 3. 共同需求

- 原生 HTML、CSS、JavaScript，无安装、构建或网络依赖。
- 专注 25 分钟、短休息 5 分钟、长休息 15 分钟。
- 切换模式、开始、暂停、重置和结束提示。
- 任务添加、编辑、完成/恢复、删除和选择当前任务。
- 任务、完成状态和当前任务通过 `localStorage` 持久化。
- 响应式、语义化、键盘可用；删除使用原生 `dialog`。
- 时间戳计时，避免简单递减漂移。

## 4. 执行观察

第一轮和第二轮中，两个 Luna 都尝试一次性提交大补丁，补丁在落盘前被中止。两个 worktree 均保持零变更。

在对双方施加相同的执行修正——拆成三个小补丁——之后，两边都完成实现。这个问题属于共同工具执行变量，不用于比较 v3 与 v4。

产物大小：

| 产物 | v3 | v4 |
|---|---:|---:|
| 应用文件 | 3 | 3 |
| 应用总字节 | 6,544 | 5,822 |
| SPEC 文件变化 | 修改 2 个 v3 文件 | 新建 3 个 `.spec` 文件 |

代码体积差异很小，不构成方法优劣证据。

## 5. 产品验收

验收使用真实 Chromium，桌面逻辑检查与 `390 × 844` 移动视口。两个应用都只有相同的 `favicon.ico` 404，没有 JavaScript 控制台错误。

| 行为 | v3 | v4 |
|---|---|---|
| 页面加载与响应式布局 | 通过 | 通过 |
| 三种模式与时长 | 通过 | 通过 |
| 开始计时 | 通过 | 通过 |
| 暂停保持剩余时间 | 通过 | **失败：立即恢复完整时长** |
| 暂停状态反馈 | 通过：显示“已暂停” | **失败：仍显示“进行中”** |
| 重置 | 通过 | 通过 |
| 结束提示 | 通过，显示 `00:00` | 部分通过：提示结束，但立即显示完整时长 |
| 添加非空任务 | 通过 | 通过 |
| 编辑任务 | 通过 | 通过 |
| 完成 / 恢复 | 通过 | 通过 |
| 选择当前任务 | 通过 | 通过 |
| 删除确认 | 通过 | 通过 |
| 刷新后任务状态持久化 | 通过 | 通过 |
| JavaScript 语法检查 | 通过 | 通过 |

### 共同与次要问题

- v3 的计时文本变化时，`aria-label` 没有同步更新；视觉值与可访问名称会暂时不一致。
- v3 在计时自然结束后直接再次开始，会继续从零结束；需要重置或切换模式。
- 两边的删除 `dialog` 在可访问树中都没有名称；v4 虽有标题，但没有把标题关联为 dialog 名称。
- 两边最初都只运行了语法检查。语法通过不能证明计时状态机正确。

## 6. 协议产物

### v3

v3 Luna 修改：

- `.phrase/current.md`
- `.phrase/evidence.md`

观察：

- 两个文件被整体缩减，原有结构和模板说明被覆盖，而不是保留结构并更新当前内容。
- `current.md` 没有完整保留 v3 所要求的 out-of-scope、acceptance gate、active task slice 等字段。
- `evidence.md` 记录了语法检查，并把真实交互检查列为下一步，因此 phase 实际尚未达到完成门槛。
- Luna 自述只读取了 `AGENTS.md`，并称 `.phrase/` 当时不存在；这与 worktree 初始状态不符。初始 commit 中这些文件存在。
- 没有沉淀任何新的长期抽象。

结论：v3 本次产品实现相对更正确，但协议遵循和文档保护较差。不能把产品结果直接归功于 v3。

### v4

v4 Luna 创建：

- `.spec/adapter.md`
- `.spec/state.md`
- `.spec/evidence.md`

观察：

- 它正确地没有读取 legacy v3 文档，并区分了 Adapter、State 与 Evidence。
- 它没有创建 Kernel、Contract 或 Delta。
- 它认为本次只是实现，没有值得进入 Kernel 的长期语义。
- `state.md` 提到核心操作应手工检查，但 `evidence.md` 只记录语法与静态文件检查。
- 实际浏览器验证随后发现了暂停状态机缺陷。

结论：v4 带来了更清晰的知识分类，但**没有自动产生静态抽象沉淀**。当前协议没有充分说明：一个没有既有 Kernel 的新系统，第一次 Kernel 从哪里来。

## 7. 解释

本次最重要的发现不是 v3 页面胜过 v4 页面，而是：

> 如果 v4 只规定 Kernel 如何演化，却不规定 Kernel 如何初始化，Agent 可以把所有产品语义都降级为实现细节。

番茄钟需求至少包含以下稳定语义：

- Concepts：`TimerMode`、`Task`、`CurrentTask`。
- Actions：`SwitchMode`、`Start`、`Pause`、`Reset`、`CompleteTimer`、`AddTask`、`EditTask`、`CompleteTask`、`DeleteTask`、`SelectTask`。
- Invariants：暂停不得改变剩余时间；重置恢复当前模式初始时长；结束状态对应零剩余时间；当前任务必须引用仍存在的任务。
- Contracts：每个 Action 的 guard、effect、observable outcome 与验证场景。

v4 没有表达这些 Contract，最终也恰好在 `Pause` 与 `CompleteTimer` 上出现错误。这是有意义的相关证据，但单次实验还不能证明因果。

## 8. Candidate v4 Delta

**Status**: `verified-for-observed-failure / retained-in-draft`

用户同意把该 Delta 纳入 v4 草案，并用新的 Luna 重跑相同 brief。复测支持保留该 Delta，但还不足以替换当前入口。

**Change**:

1. 增加 **Kernel Bootstrap Gate**：新系统或新 bounded context 没有适用 Kernel 时，必须在首次 `Act` 前从用户可观察需求生成最小 Kernel Snapshot。
2. 最小 Snapshot 只包含当前 phase 必需的 Concept、Action、Invariant 和 Contract，不要求完整领域模型。
3. `Verify` 必须逐项证明 Action Contract；语法检查只能证明可解析，不能关闭行为 gate。
4. State 声明的验收方式必须与 Evidence 实际记录的证明一致。

**Impact**:

- v4 的 `Orient`、`Frame`、`Verify` 和首次验证门槛。
- 新项目的默认上下文会略增，但只增加当前用例所需的稳定语义。

**Migration**:

- 已有有效 Kernel 的项目不受影响。
- 没有 Kernel 的项目在下一次真实 phase 启动时生成最小 Snapshot，不做全历史转换。

**Verification**:

- 用新的 Luna 和相同番茄钟 brief 重跑 v4。
- 在实现前检查是否形成 `Pause`、`Reset`、`CompleteTimer` Contract。
- 在实现后检查行为测试是否覆盖这些 Contract。

## 9. 第二轮：Bootstrap 复测

复测使用同一 base commit `8a11f8f`、相同 brief 和新的 `gpt-5.6-luna`，worktree 为 `/private/tmp/spec-agents-pomodoro-v4-bootstrap`。

### 实现前门禁

- Luna 在任何应用文件出现前创建了 `.spec/kernel.md` K1 和 `.spec/state.md`。
- 初稿把 timer/mode 也纳入持久化，`start` 没有明确暂停后从保存值恢复，`finish` 没有要求 `00:00` 保持可见。
- Bootstrap Gate 因此未通过；Luna 在仍未写代码时修订 K1，删除范围扩张，并补齐 `Pause`、`Start`、`Finish` Contract。
- K1 通过后才允许实现。这个顺序由 worktree 文件状态检查确认。

### 相同行为复验

| 行为 | 第一轮 v4 | Bootstrap v4 |
|---|---|---|
| 暂停保持剩余时间 | 失败：恢复完整时长 | 通过：暂停值保持，恢复后继续递减 |
| 暂停状态反馈 | 失败：仍显示“进行中” | 通过：显示“已暂停” |
| 结束状态 | 部分通过：立即恢复完整时长 | 通过：稳定显示 `00:00` 和“已结束” |
| 重置与三种时长 | 通过 | 通过 |
| 任务增改、完成、选择、删除、刷新持久化 | 通过 | 通过 |
| 文本安全、键盘、dialog 名称、移动布局 | 有缺项 | 通过 |

真实 Chromium 逐项执行了 K1 Contract。localStorage 只保存任务和当前任务；控制台没有 JavaScript 错误。自动化工具无法完成独立的 `file://` 直开证明，因此没有把本地 HTTP 结果冒充为该项证据。

### 成本与限制

- K1 为 46 行 / 3,243 字节；全部 `.spec` 上下文为 99 行 / 7,011 字节。第一轮 v4 的三个 `.spec` 文件只有 669 字节，因此 Bootstrap 带来了约 6.3 KB 的明确上下文成本。
- 新应用为 236 行 / 11,800 字节；体积增长混合了更完整的行为、可访问性和可读格式，不能单独归因于协议。
- 外部门禁审阅者知道第一轮缺陷，所以本轮不是盲测。单个番茄钟样本只能证明该 Delta 覆盖了已观察到的失败模式，不能证明跨领域有效。

### Delta 决定

保留 Kernel Bootstrap Gate 与 Contract-based Verification 在 v4 草案中，状态为 `verified-for-observed-failure`。下一步应换一个领域做盲测；在此之前不替换 `AGENTS.md`，也不建设 schema、图数据库或生成器。

## 10. 当前结论

- v3 在本次产品行为上更完整，但没有沉淀稳定抽象，并违反了自己的默认读取与文件维护要求。
- v4 第一稿的文档分类更接近 Living SPEC，但缺少 Kernel bootstrap，因而没有实现本次设计的核心价值。
- Bootstrap 复测在写代码前暴露并修复了第一轮对应的 Contract 缺口，复验行为全部通过。
- 当前证据支持把 Delta 保留在 v4 草案中，不支持直接替换现有 `AGENTS.md`。
