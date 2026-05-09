# SPEC-AGENTS v3：证据校准的 Agent 工作流

在处理任何请求之前，先识别用户意图，然后按最轻可行协议执行。

核心原则：

> 最小上下文，证据驱动阶段，验证后执行，只保留长期有价值的决策。

SPEC-AGENTS 不再要求读取和维护完整历史文档。默认只读取当前决策所需的最小上下文，并让上一阶段证据决定下一阶段计划。

---

## 1. 意图识别

### 🌱 启动 / 立项 / 模糊想法

触发条件：用户想开启新项目、新方向、新阶段，或只有模糊想法。

行动：
- 先读取 `.phrase/decision.md`、`.phrase/roadmap.md`、`.phrase/current.md`。
- 如果方向不清，扫描 `.phrase/modules/pr_faq.md` 的 YAML 元数据；匹配后再完整加载。
- 访谈目标是澄清当前 phase 的决策框架、证据规则、范围和验收门槛。
- 不要把远期工作拆成任务清单。

### 🔨 编码 / 重构 / 审查

触发条件：用户请求实现、修 Bug、重构、审查。

行动：
- 默认读取 `.phrase/decision.md`、`.phrase/roadmap.md`、`.phrase/current.md`。
- 只有当当前问题需要历史依据时，才读取 `.phrase/evidence.md` 或 `.phrase/archive/`。
- 执行当前 phase 的最小任务切片，验证后记录 evidence delta。
- 如需代码判断，可扫描 `.phrase/modules/linus_coding.md` 的 YAML 元数据；匹配后再完整加载。

### ✍️ 文案 / 营销 / 文档

触发条件：用户需要 README、发布说明、产品介绍、营销文案或文档改写。

行动：
- 扫描 `.phrase/modules/copywriting.md` 的 YAML 元数据；匹配后再完整加载。
- 输出仍要遵守当前 phase 的边界和证据规则。

### 🌐 浏览器 / 网页自动化 / 爬虫

触发条件：用户需要访问网页、抓取数据、截图、测试 Web UI 或填写表单。

行动：
- 扫描 `.phrase/modules/agent-browser.md` 的 YAML 元数据；匹配且依赖可用后再完整加载。
- 浏览器结果如果会改变后续判断，应写入 `.phrase/evidence.md`。

### 📋 默认任务执行

触发条件：用户给出明确任务。

行动：执行下方的 EDPP v3 工作流。

### 📝 会话收尾：`/done`

触发条件：用户输入 `/done` 或明确表示结束会话。

行动：
- 读取 `.phrase/commands/done.md`。
- 只记录实际发生的内容。
- 若本次会话产生会影响下一步的事实，优先更新 `.phrase/evidence.md`，不要只写会话流水账。

### 🚀 启动阶段：`/start-phase`

触发条件：用户输入 `/start-phase` 或明确表示要开启新阶段。

行动：
- 读取 `.phrase/commands/start-phase.md`。
- 用上一阶段 evidence 生成新的 `.phrase/current.md`。
- 只规划当前 phase，不预拆远期任务。

### 🔁 旧项目迁移：`/migrate-v3`

触发条件：项目已有旧版 `.phrase/phases/`、`spec_*`、`plan_*`、`task_*`、`change_*` 或 `issue_*` 流程。

行动：
- 读取 `.phrase/commands/migrate-v3.md`。
- 将旧材料归档到 `.phrase/archive/legacy-v2/`。
- 只把长期规则、当前 phase、未解决 blocker、验证结果和下一阶段建议提升到 v3 文件。
- 不做机械格式转换，不让旧文档继续成为默认上下文。

---

## 2. 默认读取规则

普通工作开始时只读：

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

读取 `.phrase/evidence.md` 的情况：

- 选择下一阶段
- 判断计划是否被新事实推翻
- 查 blocker / risk 的分类依据
- 验证 phase 是否可以关闭

读取 `.phrase/archive/` 的情况：

- 当前文件明确链接到某个归档项
- 回归问题需要历史对比
- 用户明确要求追溯旧上下文

不要默认加载完整历史。降低 token 消耗是协议目标之一。

---

## 3. 文件权威顺序

当文件冲突时，按以下顺序处理：

1. `.phrase/decision.md`、`.phrase/adr/`、`.phrase/protocol/`
2. 新鲜 evidence
3. `.phrase/current.md`
4. `.phrase/roadmap.md`
5. `.phrase/archive/`

如果新 evidence 和当前 phase 冲突，更新 `current.md`。如果新 evidence 挑战长期边界，显式更新 `decision.md`、ADR 或 protocol，不要在实现里偷偷改变规则。

---

## 4. EDPP v3 工作流

1. **确认决策框架。**
   明确证据规则、长期边界、验证标准和 phase gate。

2. **维护 roadmap。**
   roadmap 只写阶段方向、状态、入口条件和验收门槛，不写远期实现细节。

3. **从 evidence 选择当前 phase。**
   依据上一阶段结果决定下一步，不因为旧计划写过就继续执行。

4. **更新 current phase brief。**
   `current.md` 必须说明目标、范围、out of scope、验收门槛、当前任务切片、验证方式和已知 blocker。

5. **不确定时先 discovery。**
   用最小实验、trace、prototype、benchmark、audit、用户测试或 harness 暴露真实阻塞。

6. **先分类 blocker，再实现。**
   按项目语境分类：本地修复、共享机制、工作流边界、平台差异、产品歧义、运营依赖、数据质量等。

7. **只执行当前测量过的切片。**
   不顺手扩张到相邻问题。无关发现写入 evidence，留给后续 phase。

8. **验证。**
   运行 phase gate 要求的证明；影响面大时补更广验证。

9. **记录 evidence delta。**
   只记录会影响后续判断的事实：验证结果、失败假设、剩余 blocker、拒绝路径、下一阶段建议。

10. **必要时更新长期决策。**
    只有长期规则或边界变化时，才更新 `decision.md`、ADR 或 protocol。

11. **准备下一阶段。**
    用最新 evidence 更新 roadmap/current。过期 phase-local 细节进入 archive。

---

## 5. 最小文件结构

```text
.phrase/
  decision.md
  roadmap.md
  current.md
  evidence.md
  archive/

  adr/          # 可选：长期决策
  protocol/     # 可选：稳定接口和边界
  runbooks/     # 可选：重复手工流程
  modules/      # 可选：意图模块
  commands/     # 可选：命令说明
```

### `decision.md`

长期原则、证据规则、稳定边界、验证标准、phase gate、需要 ADR/protocol 的条件、不要重复探索的拒绝路径。

### `roadmap.md`

阶段级方向。只写 phase goal、status、entry condition、acceptance gate 和 major out-of-scope。

### `current.md`

默认上下文。只保留当前 phase 所需内容，必须短到每次会话都能读。

### `evidence.md`

证据增量。不是流水账，不是完整 changelog。区分 observation、interpretation、recommended next action。

### `archive/`

旧 phase、旧 spec、旧 task、历史 notes。默认不读。

---

## 6. 任务规则

任务只服务当前 phase。不要为 roadmap 里的远期阶段预拆任务。

推荐格式：

```text
taskNNN [ ] goal:<可观察结果> | scope:<文件或区域> | verify:<证明方式>
```

如果任务执行中暴露出不同 blocker 类型，停止扩张实现，更新 evidence，再决定是否改 phase。

---

## 7. 完成条件

声称 phase 或任务完成前，必须满足：

- acceptance gate 已检查
- verification evidence 存在
- 剩余 blocker 已记录
- 下一阶段建议已写入
- 如长期规则变化，已更新 decision/ADR/protocol
- 过期 local context 已归档或标记 stale

---

## 8. 提交与安全

- 提交信息说明为什么改、验证了什么、剩余风险是什么。
- 不要求每个提交绑定 `taskNNN`，但必须能追溯到当前 phase 和 evidence。
- 禁止提交密钥、token、证书、真实用户数据。
- 对权限、配置、外部 API、数据迁移等风险，必须在 `current.md` 或 `decision.md` 中写清边界和验证方式。

---

## 9. 协作表达

- 解释方案时先说当前 phase、证据、下一步。
- 引用文档时说文件名和小节，不复述整篇。
- 提供选项时说明它属于当前 phase、后续 phase，还是长期决策。
