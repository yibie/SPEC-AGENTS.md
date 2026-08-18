# v4 Bootstrap 跨领域盲测：会议室预约

## 1. 实验目的

检验 Kernel Bootstrap Gate 是否能在不同 bounded context 中，让 Agent 在编码前沉淀稳定概念、关系、Invariant 和 Action Contract，并减少首轮行为遗漏。

本轮只比较 v4 control（不强制 Bootstrap）与 v4 treatment（强制 Bootstrap）。不把结果外推为 v3/v4 的统计优劣。

## 2. 固定条件

| 条件 | Control | Treatment |
|---|---|---|
| Base commit | `8a11f8f` | `8a11f8f` |
| Model | 新鲜 `gpt-5.6-luna`, medium | 新鲜 `gpt-5.6-luna`, medium |
| Worktree | `/private/tmp/spec-agents-room-v4-control` | `/private/tmp/spec-agents-room-v4-bootstrap` |
| Protocol | v4 draft without Bootstrap Gate | v4 draft with Bootstrap Gate |
| Brief | 本文件 | 本文件 |
| External validation | 同一浏览器矩阵 | 同一浏览器矩阵 |

两个 Agent 不读取对方 worktree。实现前不透露预期缺陷；验收矩阵在两边开始前固定。

## 3. 产品 Brief

实现一个无需安装、构建或网络服务的原生 HTML/CSS/JavaScript 会议室预约页面：

- 提供三个会议室供选择；
- 创建预约，字段为预约主题、预约人、日期、开始时间、结束时间和会议室；
- 编辑和取消预约；取消需要确认，并保留已取消记录；
- 展示预约列表，并明确区分有效与已取消；
- 刷新后保留预约、编辑结果和取消状态；
- 使用语义化 HTML、键盘可操作控件、可见焦点、原生表单控件和响应式布局；
- 预约主题和预约人必须按文本渲染，不能被解释为 HTML；
- 不做账户、权限、服务端、通知、重复预约或时区转换。

时间采用用户本地日期和时间。所有预约都属于单一日期；无需跨午夜预约。

## 4. 预注册行为矩阵

| ID | 场景 | 期望结果 |
|---|---|---|
| R1 | 页面加载 | 显示三个会议室、预约表单、列表和清晰的空状态 |
| R2 | 提交合法预约 | 预约出现在有效列表中，字段完整可见 |
| R3 | 结束时间早于或等于开始时间 | 提交被拒绝，显示字段附近错误，不创建记录 |
| R4 | 同一日期、同一会议室的时间重叠 | 提交或编辑被拒绝，保留原记录 |
| R5 | 同一会议室前一预约结束时间等于后一预约开始时间 | 允许创建，两个预约都保留 |
| R6 | 同一时间但不同会议室 | 允许创建 |
| R7 | 编辑预约 | 重新执行时间和冲突校验；合法编辑更新原记录，不产生重复记录 |
| R8 | 取消有效预约并确认 | 记录变为已取消，仍可见；该时段随后可被新预约占用 |
| R9 | 取消对话框按 Escape 或取消 | 原记录不变 |
| R10 | 刷新页面 | 有效/已取消状态和编辑内容保持；不出现重复记录 |
| R11 | 主题或预约人含 `<`、`>` 等文本 | 按原样显示为文字，不产生元素或脚本 |
| R12 | 键盘和移动视口 | 表单、列表操作、确认对话框可用；`390 × 844` 不出现横向溢出 |

R3–R8 是本领域的关系与生命周期边界；它们不是实现提示，control 和 treatment 必须从同一 Brief 自己建立语义。

## 5. 统一验证与判定

- 静态检查：脚本可解析、无外部依赖、无网络请求、用户文本使用安全 DOM API。
- 动态检查：真实 Chromium 逐项执行 R1–R12；控制台错误单独记录。
- 文档检查：treatment 必须在代码前有 K1；两边都记录 State/Evidence；行为 Evidence 必须映射预注册矩阵。
- 成本记录：记录 K1/State/Evidence 的行数与字节数，以及实现文件大小；不在结果出来后改变评价口径。
- 结果只允许三种：`promote`、`revise`、`reject`。本轮不执行 `AGENTS.md` 替换。

## 6. 后续演化实验（不在本轮执行）

若 Bootstrap 在本轮表现出稳定收益，下一轮再加入一个明确的需求变化，检查 Evidence 是否生成 Delta、Kernel v2 和迁移规则，而不是只改 State。

## 7. 本轮执行结果

### 协议与产物

- Control 的 fresh Luna 直接实现了固定 Brief，未创建 K1，也未预先写 Action Contract；`.spec/control-evidence.md` 记录了 control 的 State/Evidence。
- Treatment 的 fresh Luna 在任何应用文件前创建 K1。初始 K1 为 177 行 / 7,946 字节，被 Gate 判定过厚；删除 `Persist`/`Render` 实现动作并压缩 Contract 后，K1 为 78 行 / 4,819 字节，Gate 通过。
- Treatment Luna 在 Gate 通过后连续两次实现回合没有落盘应用文件。为完成同一行为矩阵，root 按已通过 K1 恢复创建 treatment 应用；该偏差已写入 treatment `.spec/evidence.md`。

### R1–R12 矩阵

| 场景 | Control | Treatment |
|---|---|---|
| R1 页面、三房间、空状态 | 通过 | 通过 |
| R2 合法创建 | **部分失败：记录后空状态仍显示** | 通过 |
| R3 非法时间 | 通过 | 通过 |
| R4 同房间重叠 | 通过 | 通过 |
| R5 相邻预约 | 通过 | 通过 |
| R6 不同房间同时间 | 通过 | 通过 |
| R7 编辑与冲突回滚 | 通过 | 通过 |
| R8 取消、保留记录、释放时段 | 通过 | 通过 |
| R9 Escape/取消按钮 | 通过 | 通过 |
| R10 刷新持久化 | 通过 | 通过 |
| R11 文本安全 | 通过 | 通过 |
| R12 键盘与 `390 × 844` | 通过 | 通过 |

两边均通过 `node --check`、无网络调用或危险 HTML 注入；真实 Chromium 无 JavaScript 控制台消息，只有静态服务器请求可见的可选 `favicon.ico` 404。

### 成本与限制

- Control 的 `.spec` 记录为 43 行 / 2,973 字节；treatment 的 `.spec` 为 184 行 / 9,657 字节，其中 K1 本身 78 行 / 4,819 字节。
- Control 应用文件为 208 行 / 18,109 字节；treatment 恢复实现为 313 行 / 17,068 字节。由于实现者不同，代码体积不能用于协议优劣比较。
- Control 的空状态缺陷说明可观察 UI 状态仍会遗漏；treatment 的全通过说明 K1 覆盖的关系与生命周期边界可作为实现检查表，但不能说明它造成了该差异。
- Treatment 的实现恢复破坏了“同一 fresh Luna 从 K1 到代码”的纯 A/B 条件；本轮不能作为 Bootstrap 的因果或推广证据。

## 8. Delta 决定

**Decision**: `revise / inconclusive`

保留 Kernel Bootstrap Gate 和“Contract 必须在代码前存在”的方向，但暂不将 Delta 标记为 `promoted`，也不替换 `AGENTS.md`。需要下一轮重新保证 treatment Luna 在 Gate 通过后完成实现，再判断 R2 的差异是否可重复；不要把本轮的 root recovery 结果归因于 Bootstrap。

下一轮可以继续使用另一个 bounded context，或先用同一 protocol 做一次执行可靠性复验；只有获得纯 treatment 样本后，才进入 Kernel v2 演化实验。

## 9. Phase 3 纯 treatment 执行可靠性复验

为修复上一轮 treatment 的 root recovery 偏差，创建了新的隔离 worktree
`/private/tmp/spec-agents-room-v4-bootstrap-repeat`，并让两个顺序执行的
fresh `gpt-5.6-luna`（medium）只完成阶段 1：读取本 Brief/protocol、创建
`.spec/kernel.md` 与 `.spec/state.md`，然后暂停等待 Gate 审计。

两次尝试在有界状态窗口内均未落盘 K1、State、应用文件、测试或 commit；
它们没有进入可审计状态，随后被中止。root 没有补写代码，也没有启动静态或
浏览器验证。因此本轮没有新的 K1 质量、同一 Luna 实现、成本或 R1–R12 证据。

## 10. Phase 3 Delta 决定

**Decision**: `revise / inconclusive`

保留 Kernel Bootstrap Gate 的方向，但当前 treatment handoff 缺少可证明的
执行可靠性。下一次尝试前应加入有限 liveness checkpoint 和显式 artifact
acknowledgement；在获得一个纯 K1-to-code 样本前，不进入 Kernel v2，也不替换
`AGENTS.md`。
