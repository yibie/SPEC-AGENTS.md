# Issue 模板（单行格式）

## 索引格式（用于 ISSUES.md 和 phase 索引）

```
issueNNN [状态] 标题:<一句话描述> | 模块:<受影响组件> | 优先级:P0/P1/P2 | 关联:taskNNN | 解决:<commit/日期>
```

## 字段说明

| 字段 | 必填 | 说明 |
|-----|------|------|
| `标题:` | ✓ | 问题的一句话简述 |
| `模块:` | ✓ | 受影响的组件/模块，如 `UI/快捷键` `Core/状态管理` |
| `优先级:` | ✓ | P0=阻塞/崩溃，P1=功能缺陷，P2=优化建议 |
| `关联:` | - | 关联的 taskNNN，解决后回填 |
| `解决:` | - | 解决时的 commit hash 或日期，标记 `[x]` 后填写 |

## 示例

```markdown
# ISSUES.md 全局索引

## 2024-02
issue001 [x] 标题:置顶快捷键在多显示器下失效 | 模块:UI/快捷键 | 优先级:P0 | 关联:task005 | 解决:a1b2c3d | 详情:.phrase/phases/phase-window-mgmt-20240206/issue_hotkey_display_20240206.md
issue002 [ ] 标题:重启后偶尔丢失置顶状态 | 模块:Core/状态持久化 | 优先级:P1 | 关联:task003 | 详情:.phrase/phases/phase-window-mgmt-20240206/issue_state_loss_20240206.md
issue003 [ ] 标题:状态指示器颜色不够明显 | 模块:UI/视觉 | 优先级:P2 | 详情:.phrase/phases/phase-window-mgmt-20240206/issue_indicator_color_20240206.md
```

## 详情文件格式

创建 phase 内的 `issue_<简述>_<YYYYMMDD>.md` 记录完整信息：

```markdown
# issue002: 重启后偶尔丢失置顶状态

## 环境
- 版本: v1.2.0
- 系统: macOS 14.2
- 复现率: 约 30%

## 复现步骤
1. 将窗口 A 置顶
2. 退出应用
3. 重新启动
4. 观察窗口 A 状态

## 预期 vs 实际
- 预期: 窗口 A 保持置顶
- 实际: 偶尔丢失置顶状态

## 调查
- 根因: 状态保存时机问题，应用退出时状态未 flush 到磁盘
- 相关代码: `Core/StateManager.swift:saveState()`

## 修复
- 方案: 添加 `applicationWillTerminate` 钩子强制保存
- 提交: abc123

## 验证
- [x] 复现 10 次，全部成功保持置顶

## 用户确认
- 确认人: @username
- 确认时间: 2024-02-07
```

## 快速上手

在 ISSUES.md 中添加索引：

```markdown
issue004 [ ] 标题: | 模块: | 优先级: | 关联:
```
