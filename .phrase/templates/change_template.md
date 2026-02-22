# Change 模板（单行格式）

## 格式规范

```
changeNNN 日期:YYYY-MM-DD | 文件:<路径> | 操作:Add|Modify|Delete | 影响:<函数/模块> | 说明:<简述> | 关联:taskNNN
```

## 字段说明

| 字段 | 必填 | 说明 |
|-----|------|------|
| `日期:` | ✓ | 变更日期，格式 `YYYY-MM-DD` |
| `文件:` | ✓ | 变更的文件路径，如 `Core/WindowManager.swift` |
| `操作:` | ✓ | `Add`/`Modify`/`Delete`，新增/修改/删除 |
| `影响:` | ✓ | 受影响的函数、模块或行为 |
| `说明:` | ✓ | 变更内容的简述 |
| `关联:` | ✓ | 对应的 taskNNN |

## 可选追加字段

- `| 风险:<说明>` — 潜在风险或注意事项
- `| 回滚:<方案>` — 回滚方案简述

## 示例

### Phase 内 change 文件

```markdown
# Change Log - Phase: window-mgmt-20240206

## 2024-02-06
change003 日期:2024-02-06 | 文件:UI/StatusBar.swift | 操作:Modify | 影响:updateIndicatorColor() | 说明:优化指示器颜色对比度 | 关联:task003
change002 日期:2024-02-06 | 文件:Core/HotKey.swift | 操作:Modify | 影响:registerHotKey() | 说明:修复快捷键冲突检测逻辑 | 关联:task004 | 风险:可能影响其他快捷键注册
change001 日期:2024-02-06 | 文件:UI/StatusBar.swift | 操作:Add | 影响:showIndicator() | 说明:添加置顶状态指示器 | 关联:task001

## 2024-02-05
change000 日期:2024-02-05 | 文件:Core/WindowManager.swift | 操作:Add | 影响:pinWindow() | 说明:实现窗口置顶核心逻辑 | 关联:task001
```

### 全局 CHANGE.md 索引

```markdown
# CHANGE.md 全局索引

## 2024-02
- phase-window-mgmt-20240206: 窗口置顶功能
  - 主要变更: Core/WindowManager.swift, UI/StatusBar.swift
  - 详情: .phrase/phases/phase-window-mgmt-20240206/change_window_mgmt_20240206.md
```

## 快速上手

在 phase 的 `change_*` 文件中添加：

```markdown
change004 日期:YYYY-MM-DD | 文件: | 操作: | 影响: | 说明: | 关联:taskNNN
```
