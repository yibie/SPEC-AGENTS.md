---
name: learn
description: 将已验证的观察记录为证据，并判断哪些学习应提升为长期上下文、稳定协议或 ADR。适用于 check 之后、阶段结束、失败假设或新事实可能改变后续判断时。
---

# Learn

把运行结果变成可复用的知识，但不把每次试错都升级成长期规则。

## 记录证据

只记录会影响后续判断的增量，追加到 `EVIDENCE.md`：

```markdown
## <date> — <subject>

### Observation
### Interpretation
### Recommended next action
### Verification
### References
```

把观察、解释和建议分开；不要写会话流水账或重复 git diff。

如果来源 issue 有 `evidence_ref`：先为本次结果分配稳定 Evidence ID，追加
`EVIDENCE.md`，验证写入成功后，再把同一个 ID 回写 issue。不要在验证前
预填链接；`learn` 是唯一写入者。

## 判断提升层级

- 只影响当前任务：留在 issue/SPEC，不提升。
- 可复用的事实、失败假设或验证结果：追加 `EVIDENCE.md`。
- 稳定概念、身份、关系、生命周期或不变量：经 `plan` 确认后更新 `CONTEXT.md`。
- 稳定接口、状态转换或 Action Contract：经 `plan` 确认后更新 `docs/protocols/`。
- 难以逆转、出乎预期且源于真实取舍的决定：创建 `docs/adr/` 中的 ADR。
- 当前阶段状态、阻塞项或下一步改变：更新 `STATUS.md`；阶段方向改变才更新 `ROADMAP.md`。

## 安全边界

- 未验证的猜测不进入长期文档。
- 不因一次通过就宣称一般性改进；写清样本、成本、限制和浏览器/环境边界。
- 与现有不变量冲突时，先让 `plan` 产生 `revise` 或 `reject`，再修改静态模型。
- 不创建正式本体 schema、图数据库、生成器或同步基础设施，除非另开 phase 并有证据支持。

## 完成条件

证据已追加，提升或不提升的理由已写明，长期文档只在确认后更新，`STATUS.md`/`ROADMAP.md` 与最新事实一致，剩余 blocker 和下一步可复核。
