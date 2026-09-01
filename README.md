# SPEC-AGENTS

SPEC-AGENTS v4 is an evidence-calibrated agent workflow with a stable semantic
model and a living, SPEC-local execution record.

See [`CHANGELOG.md`](CHANGELOG.md) for the v4.0.0 experiment record, design
rationale, measured limits, and release benefits.

The source repository keeps that research archive under
[`research/`](research/README.md). It is not part of the installer payload.

It combines static concepts and boundaries with dynamic evidence for AI coding
agents. The goal is to reduce stale context while keeping planning,
verification, and durable decisions reliable.

## Core Idea

The old workflow used a static doc-driven loop:

```text
spec -> plan -> task -> implementation -> change log
```

The current workflow uses a six-action loop:

```text
plan -> capture -> arrange -> do -> check -> learn
```

The agent reads the stable model first, then only the state and evidence needed
for the current decision.

## Features

- **Stable semantic model**: `.spec-agents/state/KERNEL.md` records the managed project's
  concepts, relations, lifecycles, invariants, and Action Contracts;
  `.spec-agents/doctrine/docs/WORKFLOW.md` records SPEC-AGENTS' own workflow semantics.
- **Evidence-driven decisions**: `.spec-agents/state/EVIDENCE.md` records only facts that change
  future decisions.
- **SPEC-local slices**: `.spec-agents/state/STATUS.md` coordinates the active slice instead of
  pre-splitting distant roadmap work.
- **Six action skills**: `plan`, `capture`, `arrange`, `do`, `check`, and
  `learn` are the project's own contracts.
- **Project knowledge beyond code**: `docs/adr/`, `docs/protocols/`,
  `docs/runbooks/`, and `docs/lessons/` preserve decisions, practices,
  operations, and experience.

## Installation

Clone and link the CLI:

```bash
git clone https://github.com/your-repo/SPEC-AGENTS.git
cd SPEC-AGENTS
chmod +x link_to_system.sh
./link_to_system.sh
```

The script creates `/usr/local/bin/spec-agents` and may ask for `sudo`. If a
global command is unnecessary, run
`./.spec-agents/doctrine/bin/spec-agents ...` directly from this checkout
instead.

Initialize a project:

```bash
cd ~/MyProject
spec-agents init        # Chinese AGENTS.md by default
spec-agents init en     # English AGENTS.md
```

The installer emits framework doctrine only:

```text
AGENTS.md                         thin project integration adapter
.spec-agents/
  doctrine/
    AGENTS.md START.md UPGRADE.md bin/spec-agents
    docs/README.md docs/WORKFLOW.md docs/*.md
    skills/{plan,capture,arrange,do,check,learn}/
```

Everything else belongs to your project and is created only when there is
something real to record: `.spec-agents/state/KERNEL.md` by the first
`.spec-agents/doctrine/START.md` scan from confirmed facts, state files by
`learn`, `.spec-agents/specs/<feature>/` by `capture` and `arrange`, and `docs/adr/`,
`docs/protocols/`, `docs/runbooks/`, `docs/lessons/` when knowledge is promoted
into them.

Two directories are easy to confuse. `.spec-agents/specs/` holds your confirmed work
contracts — a SPEC and its slices — and is durable, so keep it in version
control. `.spec-agents/scratch/` holds only one-shot reports awaiting your
confirmation, such as `.spec-agents/scratch/start/REPORT.md`; consider ignoring
it. `.spec-agents/archive/` holds retired workflow material. The installer writes
none of these Instance paths.

The installer never writes this repository's own state, Evidence, or runbooks
into your project. If your project already has a context entry point
such as `docs/HANDOFF.md`, keep it and delete or redirect the `CONTEXT.md`
skeleton rather than maintaining two.

For an existing project with retired SPEC-AGENTS state, do not install over it
first. Run the current upstream upgrade Prompt from this checkout:

```text
Read the current upstream .spec-agents/doctrine/UPGRADE.md and execute the upgrade review against <project>.
```

The Prompt produces an exact preservation manifest and stops for confirmation.
Only then does it bind the confirmed report, canonical target, absent backup,
and zero unresolved rows in `CUTOVER.tsv`. The recoverable
`replace-doctrine --cutover ...` operation validates that receipt before any
write, after which Upgrade archives approved retired state and runs a fresh
START. Candidate knowledge is reviewed against the new scan; old work status
is never inherited.

## Start a project

After installing the modern entry points, start with:

```text
Read .spec-agents/doctrine/START.md and execute the start review.
```

`.spec-agents/doctrine/START.md` reconstructs a bounded project picture and, for a modern project on
the first run, writes an absent `.spec-agents/state/KERNEL.md` version `K1` from confirmed
project facts before writing the review report. It waits for user confirmation about candidate
extensions, then routes a modern project to `plan`, an `upgrade-needed` project
to the current upstream `.spec-agents/doctrine/UPGRADE.md`, and a project missing modern entry points
to installation guidance. It never overwrites an existing Kernel, modifies
application code, or initializes JJ automatically.

## Quick Start

After installation, start a new or unfamiliar project with:

```text
Read .spec-agents/doctrine/START.md and execute the start review.
```

For an already bootstrapped project or an ordinary follow-up session, tell the
Agent:

```text
Read AGENTS.md, then follow it for this task.
```

For an ordinary small change, the Agent will normally use:

```text
plan -> do -> check -> learn
```

If the change spans several concepts or needs coordination, it uses the full
loop:

```text
plan -> capture -> arrange -> do -> check -> learn
```

`plan` may conclude that no change is needed. `capture` and `arrange` are not
required for a settled one-file fix.

## JJ Version Control

SPEC-AGENTS uses Jujutsu (JJ) as the default local version-control workflow
when a project contains `.jj/`. The workflow `Change` is a semantic proposal;
the version-control object is called a `JJ Change`.

```text
plan / SPEC / Slice → JJ Change → bookmark → Git remote
```

Use `jj status`, `jj log`, and `jj diff` to inspect; use `jj new`, `jj edit`, and
`jj describe` to work; use `jj undo` or `jj op log` to recover. Remote
publication is explicit and uses a bookmark with `jj git push`. Ordinary
`do`/`check` never push or create a remote bookmark.

Projects without `.jj/` keep their existing Git workflow. SPEC-AGENTS never
initializes JJ automatically. If the user chooses colocated JJ, follow the
[JJ project setup Runbook](.spec-agents/doctrine/docs/jj-project-setup.md) and then read the
[JJ Change Management Protocol](.spec-agents/doctrine/docs/jj-change-management.md).

## v2, v3, and v4

| Version | Core method | Where knowledge lives | Main boundary |
| --- | --- | --- | --- |
| v2 | Static SPEC document chain | `spec_*`, `plan_*`, `task_*`, `change_*`, and `issue_*` | Static abstractions are explicit, but context and maintenance costs are high, and old plans become noise. |
| v3 | EDPP, evidence-driven phases | `.phrase/decision.md`, `roadmap.md`, `current.md`, and `evidence.md` | Dynamic evolution is lighter, but phase knowledge is not reliably promoted into a durable semantic model. |
| v4 | Living SPEC: stable model plus dynamic evidence | Root semantic documents, `docs/adr/`, `docs/protocols/`, and verified Evidence | `plan` gates semantic changes and `learn` promotes verified knowledge; existing projects salvage candidate knowledge, reset retired state, and run a fresh START. |

v4 is therefore not a file rename or a compatibility wrapper around v2/v3. It
adds an explicit bridge from stable abstraction to dynamic state, evidence, and
code: durable principles stay fixed within their boundary while the current
work can evolve through a controlled decision.

## Design goals

v4 is organized around three outcomes:

1. **Combine ontology with SPEC.** The project names its concepts, identities,
   relations, lifecycles, invariants, and Action Contracts before asking an
   Agent to change code. This is a small semantic model, not a graph database
   or a formal ontology runtime.
2. **Make project knowledge iterative and traceable.** Current work can
   change, but
   a durable rule changes only through an explicit decision and a verified
   evidence path. Every promoted rule should be traceable back to the change,
   verification, and evidence that justified it.
3. **Prevent drift during long development.** The stable model constrains what
   an Agent may change; the current SPEC constrains the active slice; Action
   Contracts and verification expose deviations before they become new project
   assumptions.

## Ontology × SPEC

Ontology in v4 means the project's working answer to “what exists, how it is
related, what may change, and what must remain true.” SPEC is the living
contract that applies that model to one change. The connection is deliberately
small and human-reviewable:

```text
stable semantic model (Kernel)
          ↓ plan / capture
living SPEC → State → Slice → Code
                         ↓       ↓
                      do/check  Evidence
                         └── learn ──┐
                                     ↓
                         promote / revise / reject
                                     ↓
                         stable model or next work
```

| Layer | What it records | Normal home | Change rule |
| --- | --- | --- | --- |
| Kernel | Managed-project concepts, identities, relations, lifecycles, invariants, and Action Contracts | `.spec-agents/state/KERNEL.md`; workflow `.spec-agents/doctrine/docs/WORKFLOW.md` | The first Start may create confirmed-only K1; later semantic changes pass `plan` and require verified evidence. |
| SPEC | Confirmed goal, unchanged baseline, scope, decisions, contracts, and verification entry | `.spec-agents/specs/<feature>/SPEC.md` | It may evolve, but changing its goal, boundary, identity, relation, invariant, interface, or acceptance rule starts a new `plan`. |
| State | Active SPECs, slices, blockers, verification status, and next permitted action | `.spec-agents/state/STATUS.md` and local slice state | Changes with execution; it does not redefine the Kernel. |
| Evidence | Observation, interpretation, verification, failed assumption, and recommended next action | `.spec-agents/state/EVIDENCE.md` and local evidence | Written after `check`; only reusable knowledge is promoted. |
| Code | The artifact constrained by the contracts — whatever the product is made of | Source, tests, and runtime artifacts; in SPEC-AGENTS itself, the doctrine documents and `bin/` | `do` writes it; `check` proves or rejects the result. Knowledge *about* the product is not Code and belongs to `learn`. |

The first `.spec-agents/doctrine/START.md` run creates the project's `.spec-agents/state/KERNEL.md` when the bounded scan
finds stable facts. It has eight sections — Concepts, Identities, Relations,
Lifecycles, Action Contracts, Invariants, Architecture boundaries, and Source
evidence — one per element the Kernel records. Identity and lifecycle get their
own sections on purpose: an identity criterion filed under Concepts reads as a
concept, and a lifecycle written as prose invariants leaves the reader to
reassemble the state machine. Each Action Contract carries all five fields:
precondition, input, permitted effect, invariant, verification.

Every enacted entry carries `since:` — the Kernel version at which its current
meaning was set — and `source:` — the code path, Evidence, or decision that
admitted it. There is no per-entry version number and no changelog inside the
file: git already gives per-line history, while `source:` carries what git
cannot, namely which decision let the entry in.

`start` can be run again as a re-scan. It writes nothing to `.spec-agents/state/KERNEL.md` and
reports a `KernelStatus` plus the differences, because nothing else compares
the Kernel against reality — `check` uses the Kernel as the ruler, never as the
measured thing.

The file is deliberately small and human-readable; it is not a formal ontology
schema, graph database, generator, or second requirements document. `.spec-agents/doctrine/docs/WORKFLOW.md` remains the workflow model for
SPEC-AGENTS itself, and root `CONTEXT.md` belongs to the project.

## Knowledge evolution

Facts move through the system without pretending that every observation is a
new rule:

```text
change → plan → SPEC / State → code → check → Evidence
                                      ↓
                              learn and classify
                                      ↓
             local fact | blocker | promote | revise | reject
```

- A local implementation fact stays in the feature record.
- A verified project concept, identity, relation, lifecycle, or invariant may
  be promoted to the project's `.spec-agents/state/KERNEL.md`; the project's own vocabulary and
  authority boundaries belong in `CONTEXT.md`; workflow semantics belong in
  `.spec-agents/doctrine/docs/WORKFLOW.md`.
- A reusable interface or workflow boundary belongs in `docs/protocols/`.
- A hard-to-reverse trade-off belongs in `docs/adr/`.
- Current work state belongs in `.spec-agents/state/STATUS.md`; it is not silently promoted into
  the stable model.
- A rejected proposal remains visible in Evidence so the same path is not
  rediscovered as if it were new.

This gives each durable statement a path back to its source change and proof:

```text
concept / invariant → Action Contract → code → verification → Evidence
```

## Project knowledge beyond code

The project model covers more than source behavior:

| Knowledge | Example | Home |
| --- | --- | --- |
| Practice | coding style, review, testing, and collaboration conventions | `docs/protocols/` |
| Operation | deployment, release, rollback, incident response, and environment setup | `docs/runbooks/` |
| Lesson | a scoped failure mode, surprising result, or repeated review pattern | `docs/lessons/` |

These records use the same method as semantic knowledge. A record is not
durable merely because it was written; it needs `status`, `scope`,
`applies_when`, a source Evidence ID, and a verification path. A lesson remains
scoped unless `plan` confirms that it should become a project-wide Protocol or
invariant. The default context stays small: load the relevant record by intent,
not every file under `docs/`.

## Long-running development and drift control

The workflow is intentionally a constraint system for an Agent, not just a
filing convention:

1. Start from the authority order: `AGENTS.md`, the stable semantic model and
   protocols, fresh `.spec-agents/state/EVIDENCE.md`, the confirmed SPEC, then current state.
2. Keep the goal, unchanged baseline, out-of-scope boundary, and acceptance
   gate visible in the current SPEC.
3. Require every behavior change to map to an Action Contract, including its
   precondition, permitted effect, invariant, and verification.
4. If implementation discovers a semantic conflict, stop `do`; return to
   `plan` instead of silently changing the model or adding a feature bundle.
5. Use `reject` for an incompatible proposal. Use `revise` only with one named
   compatible alternative that preserves the existing data contract.
6. Finish with `check` and `learn`: record the first failing contract, remaining
   blocker, and next permitted action before claiming completion.

The result is not immutability. It is controlled change: the project can learn
without allowing the latest ticket, prompt, or implementation shortcut to
rewrite its identity and long-term goal.

## Experiment conclusions

The v4.0.0 design record contains nine v3/v4 and Kernel phases plus two focused
pilots: 11 documented rounds in that original release record. Later bounded
project-knowledge pilots are recorded separately in `E-20260817-004` and
`E-20260817-005`.
Most rounds were `n=1` per arm, so they are bounded protocol evidence, not a
statistical proof that one version or model is universally better.

- The initial v3/v4 Pomodoro comparison showed that neither workflow guaranteed
  behavioral verification; v4 classified knowledge more clearly but lacked a
  first Kernel-bootstrap gate.
- In the independent A/B run, both arms passed the same R1–R12 matrix. This does
  not establish a causal quality advantage for v4, but a small Kernel was cheap
  enough to provide a useful shared vocabulary.
- Compatible, conflicting, and cross-domain changes supported a bounded
  `Kernel -> State -> Evidence -> Code` trace: conflicts use `reject`, while a
  compatible change must name one `revise` alternative and preserve old
  invariants.
- The first-run Kernel bootstrap correction was exercised on the real `md-mode`
  project: Start created a confirmed-only `KERNEL.md` K1 before handoff to
  `plan`, while leaving application code and tests unchanged. This validates
  the initialization boundary, not general ontology quality.
- The JSONL pilot validated IDs, independent streams, and supersession, but did
  not reduce fixture bytes or rough tokens; Markdown remains the stable-document
  format.
- The ontology graph pilot made typed relations, actions, lifecycle gates, and
  provenance useful as an in-memory projection. It did not justify a graph
  database, RDF/OWL/SHACL stack, or generator yet.
- The project-knowledge promotion pilot promoted one verified workflow practice
  to a Protocol and one browser failure to a scoped Lesson. The follow-up
  routing trial caught three incomplete metadata records, then passed the
  shell Protocol, repeated installer Runbook, and scoped negative routing. It
  supports routing and repeatability, but does not establish model-quality
  gains or multi-Agent handoff behavior.

The current conclusion is a bounded protocol improvement, not a claim of
general superiority. Full records remain in [`research/`](research/README.md).

### CLI commands

```text
spec-agents init [cn|en] [--link]       # install into the current directory
spec-agents install <path> [cn|en] [--link]
spec-agents replace-doctrine <path> <backup-dir> --cutover <CUTOVER.tsv> [cn|en] [--link]
spec-agents --help
```

Copy mode is the default. `--link` keeps symbolic links to this SPEC-AGENTS
checkout, so source updates affect linked projects. Existing files are kept;
ordinary install does not overwrite a project's local decisions.

For an existing project, run the current upstream review before replacing
anything:

```text
Read the current upstream .spec-agents/doctrine/UPGRADE.md and execute the upgrade review against <project>.
```

The review extracts candidate knowledge, classifies every relevant path, and
waits for confirmation. Only then does it write a six-row CUTOVER receipt.
`replace-doctrine` requires that receipt and validates the confirmed report,
canonical target and backup, and zero unresolved rows before it backs up and
replaces the installer-owned allowlist. Doctrine replacement is not project
readiness: Upgrade must still retire the confirmed old state and complete a
fresh, user-accepted START instead of translating old state.

## Default Read Rule

At the start of ordinary work, the agent reads:

```text
AGENTS.md
.spec-agents/doctrine/docs/WORKFLOW.md
.spec-agents/state/STATUS.md
```

`.spec-agents/state/STATUS.md` is the project's own state. A fresh install does not have one:
`learn` creates it once there is real state to record. Its absence means no work
is recorded yet — it is not a missing file to reconstruct or invent.

It reads `CONTEXT.md` when the project has one; that file is the project's own
context, not a framework document. It reads `.spec-agents/state/EVIDENCE.md` when choosing what to
work on next, checking a failed assumption, classifying a blocker, or deciding
whether a SPEC can close. It reads the
relevant records in `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, and
`docs/lessons/` only when the affected intent points to them, and `.spec-agents/archive/`
only for explicit historical or regression questions. When present, the
project's `.spec-agents/state/KERNEL.md` is read with the default context because it is the
project's stable semantic boundary.

The old `.phrase/` tree is legacy context, not a second default source of
truth.

## File Authority

When documents disagree:

1. `AGENTS.md` defines workflow and safety rules.
2. `.spec-agents/doctrine/docs/` defines workflow semantics and framework practice.
3. `.spec-agents/state/KERNEL.md`, `CONTEXT.md`, `docs/adr/`, `docs/protocols/`,
   `docs/runbooks/`, and `docs/lessons/` define the project's own durable
   semantics, context, practices, operations, and lessons.
4. Fresh, verified entries in `.spec-agents/state/EVIDENCE.md` define current facts.
5. A confirmed `.spec-agents/specs/<feature>/SPEC.md` defines the living feature
   contract.
6. `.spec-agents/state/STATUS.md` defines current execution state.
7. `.spec-agents/archive/` and `.phrase/` are historical context only.

Fresh evidence can challenge a durable rule, but the conflict must be routed
through `plan` and recorded before implementation silently changes the model.

## Workflow

1. `plan`: clarify need, unchanged baseline, concepts, compatibility, and the
   verification gate.
2. `capture`: record a confirmed multi-context change in a living SPEC.
3. `arrange`: split that SPEC into independent, vertical slices only when
   coordination needs it.
4. `do`: execute one ready slice and update only its local status.
5. `check`: compare the result with the confirmed contract and engineering
   standards.
6. `learn`: append verified evidence and promote only reusable knowledge.

Use the shortest valid path. `no-change` stops after `plan`. `approve` goes
straight to `do` when semantics are unchanged **and** the work completes in the
current context — it creates no SPEC and no slice, so `plan` hands `do` the
contract that stays unchanged and one verifiable acceptance sentence. Anything
that cannot finish in one context uses all six actions.

## Slices and parallel work

`Slice` is the only execution unit. A slice lives at
`.spec-agents/specs/<feature>/issues/NN-<slug>.md` with a goal, scope, dependency,
acceptance, verification, status, and an optional `evidence_ref`. There is no
second task list, and the repository records no future intent.

`.spec-agents/state/STATUS.md` lists only the active SPECs, their blockers, and the next permitted
action. A finished SPEC is removed from it.

Several SPECs may be active at once. Their scopes must not overlap — that is a
`plan` responsibility, and isolating working copies does not fix it. Work that
must run at the same time gets its own working copy: `jj workspace add` in a
project with `.jj/`, `git worktree add` otherwise. See
[`parallel-work.md`](.spec-agents/doctrine/docs/parallel-work.md).

## Existing-project reset

Use the current upstream `.spec-agents/doctrine/UPGRADE.md`, not a possibly stale installed copy.
Preserve decision-relevant content as candidates, archive the approved old
records, recoverably replace doctrine, and run START again. Review candidates
against current code after START; recapture still-current intent as new work.
Do not copy an old KERNEL, STATUS, Evidence ID, SPEC revision, or Slice status
into the new workflow.

The old `.phrase/commands/` instructions are archived history, not a second
default workflow.

## Protocol Cost Comparison

Run the comparison benchmark:

```bash
./tests/protocol-cost-comparison.sh
```

The script creates temporary legacy v2 and v3 fixtures. Its numbers measure
historical protocol overhead, not model intelligence or code quality.

Current fixture result:

| Metric | v2 static SPEC | v3 EDPP | Saved |
| --- | ---: | ---: | ---: |
| Default read files | 8 | 3 | 62.5% |
| Default read words | 378 | 170 | 55.0% |
| Default read bytes | 2405 | 1160 | 51.8% |
| Estimated read tokens | 601 | 290 | 51.7% |
| Required write surfaces after implementation | 5 | 2 | 60.0% |

The benchmark remains a historical v3 comparison; it does not define the v4
default layout.

## 中文说明（当前 v4）

SPEC-AGENTS v4 将稳定的项目语义模型与当前工作的动态证据分开保存。
它不是要求 Agent 永远遵守一套不能修改的文档，而是在明确边界的前提下，
允许通过验证后的证据演进当前工作和后续规则。

当前工作流是六个动作：

```text
plan -> capture -> arrange -> do -> check -> learn
```

最短可行路径是：

```text
plan -> do -> check -> learn
```

如果 `plan` 判断没有必要改变，就停止；只有跨多个上下文、需要保留设计契约
或需要协调多个切片时，才使用 `capture` 和 `arrange`。

### JJ 版本管理

当项目存在 `.jj/` 时，SPEC-AGENTS 默认使用 Jujutsu（JJ）进行本地版本管理。
这里要区分两个概念：`Change` 是语义或行为变更提案，`JJ Change` 是 JJ 的
版本控制对象。

```text
plan / SPEC / Slice → JJ Change → bookmark → Git remote
```

使用 `jj status`、`jj log`、`jj diff` 查看状态，使用 `jj new`、`jj edit`、
`jj describe` 组织本地工作，使用 `jj undo`、`jj op log` 恢复本地操作。远端发布
必须得到明确授权，并通过 bookmark 和 `jj git push` 完成；普通 `do`/`check`
不会隐式 push 或创建远端 bookmark。

没有 `.jj/` 的项目继续使用原有 Git 工作流。SPEC-AGENTS 不会自动初始化 JJ；
用户明确选择 colocated JJ 后，再按照 [JJ 项目设置 Runbook](.spec-agents/doctrine/docs/jj-project-setup.md)
和 [JJ Change 管理 Protocol](.spec-agents/doctrine/docs/jj-change-management.md) 执行。

### v2、v3、v4 的区别

| 版本 | 核心方法 | 知识如何保存 | 主要边界 |
| --- | --- | --- | --- |
| v2 | 静态 SPEC 文档链 | `spec_*`、`plan_*`、`task_*`、`change_*`、`issue_*` | 静态抽象较完整，但读取和维护成本高，旧计划容易变成噪音。 |
| v3 | EDPP 证据驱动阶段 | `.phrase/decision.md`、`roadmap.md`、`current.md`、`evidence.md` | 动态演进更轻，但阶段知识没有稳定沉淀到对应的长期语义抽象。 |
| v4 | Living SPEC：稳定模型 + 动态证据 | 根目录语义文件、`docs/adr/`、`docs/protocols/` 与已验证 Evidence | 用 `plan` 控制语义变化，用 `learn` 提升已验证知识；已有项目先抢救候选知识、清理旧状态，再重新 START。 |

因此，v4 不是简单把 v2 或 v3 换一套文件名，而是补上“静态抽象—动态状态—
证据—代码”的演进桥接：大原则保持稳定，当前工作可以在明确边界内修改。

### 设计目标

v4 围绕三个结果设计：

1. **将本体论与 SPEC 结合。** 在要求 Agent 修改代码前，先明确项目中的概念、
   身份、关系、生命周期、不变量和 Action Contract。这是小型、可人工审查的
   语义模型，不是图数据库或正式本体运行时。
2. **让项目知识可迭代、可追踪。** 当前工作可以变化，但长期规则只能经过
   明确决策和验证证据改变；每条被提升的规则都应能追溯到产生它的变更、验证和
   Evidence。
3. **在长期开发中防止 Agent 偏离目标。** 稳定模型约束 Agent 能改什么，当前
   SPEC 约束当前切片，Action Contract 和验证则在偏离变成新假设前暴露它。

### 本体论 × SPEC

这里的“本体论”回答的是：项目中有什么、它们如何关联、什么动作可以改变它们、
哪些条件必须始终成立。SPEC 则把这套模型应用到一次具体变更中。两者之间保持
足够小，且可以由人审查：

```text
稳定语义模型（Kernel）
          ↓ plan / capture
活的 SPEC → State → Slice → Code
                         ↓       ↓
                      do/check  Evidence
                         └── learn ──┐
                                     ↓
                         promote / revise / reject
                                     ↓
                         稳定模型或下一项工作
```

| 层 | 记录什么 | 通常存放位置 | 变更规则 |
| --- | --- | --- | --- |
| Kernel | 被管理项目的概念、身份、关系、生命周期、不变量和 Action Contract | 项目 `.spec-agents/state/KERNEL.md`；框架 `.spec-agents/doctrine/docs/WORKFLOW.md` | 首次 `start` 可从 confirmed facts 建立 K1；后续语义变化必须先经过 `plan` 并有验证证据。 |
| SPEC | 已确认的目标、未改变基线、范围、决定、契约和验证入口 | `.spec-agents/specs/<feature>/SPEC.md` | 可以修订，但改变目标、边界、身份、关系、不变量、接口或验收标准时必须重新 `plan`。 |
| State | 活跃的 SPEC、切片、阻塞项、验证状态和下一步许可动作 | `.spec-agents/state/STATUS.md` 与本地 Slice 状态 | 随执行变化，但不能重新定义 Kernel。 |
| Evidence | observation、interpretation、验证结果、失败假设和下一步建议 | `.spec-agents/state/EVIDENCE.md` 与 feature evidence | 在 `check` 后写入；只有可复用知识才能提升。 |
| Code | 受契约约束的实现和可观察行为 | 源码、测试和运行产物 | `do` 修改代码，`check` 证明或否定结果。 |

第一次 `.spec-agents/doctrine/START.md` 扫描在项目缺少 `.spec-agents/state/KERNEL.md` 时建立只含 confirmed facts 的 K1。
候选、冲突和 unknown 留在 Start Report，不能混入 enacted Kernel。

它有八个小节 —— Concepts、Identities、Relations、Lifecycles、Action
Contracts、Invariants、Architecture boundaries、Source evidence —— 与 Kernel
记录的每一项一一对应。身份和生命周期单独成节是有意的：身份判据写进 Concepts
就读成了一个概念，生命周期写成散文不变量就要读者自己拼回状态机。每条 Action
Contract 带全五个字段：前置条件、输入、允许效果、不变量、验证方式。

每条 enacted 记录带 `since:`（这条含义是在哪个 Kernel 版本定下的）和
`source:`（准入它的代码路径、Evidence 或决定）。不设逐项版本号，也不在文件内
维护 changelog —— git 已经给了逐行历史，而 `source:` 携带 git 给不了的东西：
是哪个决定让它进来的。

`start` 可以作为 re-scan 重跑。它不写 `.spec-agents/state/KERNEL.md`，只产出 `KernelStatus` 和
差异报告 —— 因为没有别的动作会拿 Kernel 与现实反向比对，`check` 只把 Kernel
当尺子，从不当被测物。

这个文件是项目本体的最小稳定层，不是图数据库、正式 schema 或第二套需求文档。

### 知识如何迭代

不是每个观察都自动变成长期规则，知识按以下路径流动：

```text
变更 → plan → SPEC / State → code → check → Evidence
                                      ↓
                              learn 并分类
                                      ↓
             局部事实 | blocker | promote | revise | reject
```

- 局部实现事实留在 feature 记录中。
- 已验证的项目概念、身份、关系、生命周期或不变量，才可以提升到项目的
  `.spec-agents/state/KERNEL.md`；项目自己的词汇和权威边界提升到 `CONTEXT.md`；只有 SPEC-AGENTS
  自身的工作流语义才提升到 `.spec-agents/doctrine/docs/WORKFLOW.md`。
- 可复用的接口或工作流边界放入 `docs/protocols/`。
- 难以逆转的取舍放入 `docs/adr/`。
- 当前工作状态放入 `.spec-agents/state/STATUS.md`，不能偷偷提升为稳定模型。
- 被拒绝的方案保留在 Evidence 中，避免未来被当作新想法重复探索。

因此，稳定陈述都应能沿着下面的路径回到它的来源和证明：

```text
概念 / 不变量 → Action Contract → code → verification → Evidence
```

### 项目知识不止代码

项目模型还要管理代码之外的知识：

| 知识类型 | 示例 | 归属 |
| --- | --- | --- |
| Practice | 代码风格、评审、测试和协作约定 | `docs/protocols/` |
| Operation | 部署、发布、回滚、故障处理和环境设置 | `docs/runbooks/` |
| Lesson | 有范围的失败模式、意外结果或反复出现的评审问题 | `docs/lessons/` |

这些记录使用和语义知识相同的方法。写进文件不等于已经成为长期规则；每条记录
都应有 `status`、`scope`、`applies_when`、来源 Evidence ID 和验证路径。Lesson
默认只在自己的范围内生效，只有经过 `plan` 确认后，才能提升为全项目 Protocol
或不变量。默认上下文仍保持最小，只按任务意图加载相关记录，不读取整个 `docs/`。

### 长期开发中的防漂移

这套流程不是文件归档习惯，而是给 Agent 设置的约束系统：

1. 按权威顺序开始：`AGENTS.md`、稳定语义模型和协议、最新 `.spec-agents/state/EVIDENCE.md`、
   已确认的 SPEC，最后才是当前 State。
2. 在当前 SPEC 中持续保留目标、未改变基线、范围外内容和验收门槛。
3. 每个行为变化都必须对应 Action Contract，写清前置条件、允许效果、不变量和
   验证方式。
4. 实现中发现语义冲突时停止 `do`，回到 `plan`，不能偷偷改变模型或顺手加入一组
   未确认的功能。
5. 不兼容的提议走 `reject`；兼容变化只有在提出一个具体的 `revise` 方案并保持
   原有数据契约时才继续。
6. 用 `check` 和 `learn` 收尾：在声称完成前记录首个失败契约、剩余 blocker 和
   下一步许可动作。

这不是让项目不可变，而是让变化受控：项目可以学习，但最新 ticket、prompt 或
实现捷径不能悄悄改写项目身份和长期目标。

### 实验结论（简要）

v4.0.0 的原始设计记录包含 9 个 v3/v4 与 Kernel 阶段、2 个专项 pilot，合计
11 轮文档化实验；后续的项目知识晋升与路由 pilot 分别记录在
`E-20260817-004` 和 `E-20260817-005`。
这些轮次多数是 `n=1`，不是统计学意义上的普遍性证明。结论是：

- 初始 v3/v4 Pomodoro 对比显示：两种流程都不能自动保证行为验证；v4 改善了知识分类，但缺少 Kernel 的首次建立门槛。
- 独立 A/B 中两边都通过同一套 R1–R12，不能据此声称 v4 产出质量有因果优势；不过小型 Kernel 的成本可接受，并确实提供了稳定语义词汇。
- 兼容修改、冲突修改和跨领域修改均支持有限的
  `Kernel -> State -> Evidence -> Code` 追踪：冲突走 `reject`，兼容变化必须提出一个明确的 `revise` 方案，并保持旧不变量。
- 首次 Kernel 建立修正已在真实 `md-mode` 项目上执行：`start` 在交给 `plan` 之前
  创建了只含 confirmed facts 的 `KERNEL.md` K1，同时没有修改应用源码和测试。
  这证明了初始化边界，不证明本体质量的普遍提升。
- JSONL pilot 验证了 ID、独立流和 supersession，但没有降低该 fixture 的字节数或粗略 token；稳定文档继续使用 Markdown。
- Ontology graph pilot 证明类型关系、动作、生命周期和 provenance 适合作为内存投影；目前没有足够证据引入图数据库、RDF/OWL/SHACL 或生成器。
- Project knowledge 晋升 pilot 将一条已验证的工作流约定提升为 Protocol，将一个浏览器失败提升为有范围的 Lesson。后续路由 trial 先捕获并修复 3 条缺少元数据的知识记录，再通过 shell Protocol、重复 installer Runbook 和有范围的负向路由；它支持路由与可重复性，但没有证明模型质量提升或 multi-Agent 交接效果。

所以，v4 当前得到的是一个有实验边界的协议改进，而不是“某个版本普遍优于另一个版本”的结论。完整记录见 [`research/`](research/README.md)。

### 当前项目文件

普通任务默认读取：

```text
AGENTS.md
.spec-agents/doctrine/docs/WORKFLOW.md
.spec-agents/state/STATUS.md
```

`.spec-agents/state/STATUS.md` 属于项目自己。新装的项目没有它：`learn` 在有真实状态要记时创建。
它缺失说明这个项目还没有记录过工作，不是需要补齐或凭空重建的文件。

`.spec-agents/state/STATUS.md` 只列活跃的 SPEC、阻塞项和下一步；SPEC 完成即移除，结果留在
`.spec-agents/state/EVIDENCE.md`。仓库不记录未来意图。可以同时有多个活跃 SPEC，但它们的 scope
必须不相交；需要同时执行时用 `jj workspace add` 或 `git worktree add` 隔离，
见 [`parallel-work.md`](.spec-agents/doctrine/docs/parallel-work.md)。

`.spec-agents/doctrine/` 是框架 doctrine，在每个被管项目里内容相同，只由安装器写入。
其余文件都属于项目自己。

如果项目已有 `.spec-agents/state/KERNEL.md`，它也属于默认上下文；它记录项目本体，不替代
`.spec-agents/doctrine/docs/WORKFLOW.md`。根 `CONTEXT.md` 归项目所有——安装器不创建
骨架；项目如果已有别的上下文入口（例如 `docs/HANDOFF.md`），
就用那个，不要维护两套。

只有在选择下一步做什么、检查失败假设、分类 blocker 或判断某个 SPEC 是否
可以关闭时，才读取 `.spec-agents/state/EVIDENCE.md`。长期决策、稳定实践、运行手册和经验教训分别按需读取
`docs/adr/`、`docs/protocols/`、`docs/runbooks/` 和 `docs/lessons/`；`.spec-agents/archive/`
只用于明确的历史或回归问题。

### 研究归档与安装边界

源码仓库中的设计研究和实验记录统一放在
[`research/`](research/README.md)：

- `research/ontology/`：本体论、Palantir 方法和 SPEC 融合研究；
- `research/experiments/`：实验 Brief、fixture、运行协议和结果；
- `research/history/`：旧版系统模型与 v3 EDPP 资料。

这些内容是仓库研究档案，不是用户项目的默认上下文，也不会被
`.spec-agents/doctrine/bin/spec-agents` 安装到用户项目。安装器只发出 doctrine：根 `AGENTS.md` 适配器和
`.spec-agents/doctrine/` 下的 `AGENTS.md`、`START.md`、`UPGRADE.md`、CLI、文档与六个 action skills。
项目自己的工作契约在 `.spec-agents/specs/<feature>/`（长期，纳入版本控制），一次性报告在
`.spec-agents/scratch/`（建议忽略），状态在 `.spec-agents/state/`，归档在 `.spec-agents/archive/`。
安装器不写这些 Instance 路径，也不创建 `CONTEXT.md`。本仓库自己的
`docs/adr/`、`docs/protocols/`、`docs/runbooks/`、`docs/lessons/`
属于 Instance，永远不会安装到别的项目。

### 已有项目重启

不要先把新版覆盖安装到旧项目。让 Agent 从当前 SPEC-AGENTS 源码读取最新
`.spec-agents/doctrine/UPGRADE.md`，以旧项目为目标执行审查：

```text
Read the current upstream .spec-agents/doctrine/UPGRADE.md and execute the upgrade review against <project>.
```

升级先列出值得保留的候选知识和每条旧记录的去向；得到确认后写入绑定报告哈希、
规范化项目路径、备份路径和零 unresolved 项的 `CUTOVER.tsv`。只有回执校验通过，
`replace-doctrine` 才会备份并替换 doctrine；这时项目还不能说 ready，仍需归档旧
状态并重新执行一次经用户确认的干净 START。旧的 doing/done、Phase、STATUS、
SPEC 和 Slice 状态都不继承；仍然有效的需求重新进入 `plan`/`capture`。

### start 启动入口

安装新版入口后，项目可以先执行：

```text
Read .spec-agents/doctrine/START.md and execute the start review.
```

`.spec-agents/doctrine/START.md` 会检查项目状态、版本管理标记、近期历史和代码架构，生成
`.spec-agents/scratch/start/REPORT.md`，并等待用户确认。现代项目确认后进入 `plan`；
`upgrade-needed` 项目转交当前上游 `.spec-agents/doctrine/UPGRADE.md`；缺少现代入口的项目只得到安装指引。
它不会自动修改应用代码、覆盖项目认知或初始化 JJ。

## 中文说明（历史 v3 参考）

以下内容保留旧版 v3 的背景说明。出现 `.phrase/` 的地方仅描述 legacy
兼容或历史 benchmark，不是当前新项目的默认入口。

### v3 背景

SPEC-AGENTS v3 是一个证据校准的 Agent 工作流。

它结合 EDPP（Evidence-Driven Phase Planning，证据驱动阶段规划）和一套最小执行协议，
帮助 AI coding agent 在少读上下文的前提下，仍然保留规划、验证和决策记录的可靠性。

## 为什么改变

这个变化的前提是：当前 LLM 模型的能力已经得到巨大提升。

过去，纯 SPEC 推动方式试图把需求、计划、任务、变更和问题都写成稳定文档，再要求
Agent 每次读取并严格执行。这在模型能力较弱时有价值，因为它用大量显式约束弥补模型的
理解和规划能力。

但在今天，这种方式已经显得不合时宜：

- 写入成本高：每次开发都要维护 `spec_*`、`plan_*`、`task_*`、`change_*`、
  `issue_*` 等记录，很多内容只是重复 git diff 已经表达的信息。
- 读取成本高：Agent 每次为了“遵守流程”加载大量历史文档，更快消耗宝贵的上下文空间。
- token 消耗高：静态文档越多，越容易把 token 花在旧计划和机械记录上，而不是当前判断。
- 旧计划容易变成噪音：一旦新证据推翻旧假设，过期 SPEC 仍然可能被误读为当前事实。

因此，v3 不再要求把每一行实现意图都提前写进 SPEC。新的流程更适合现在的模型：

> 向 AI 说明边界，而不是说明每一行函数如何修改；每一轮开发后，用测试和证据证明之前开发无误。

这个流程尤其适合多智能体共同合作。多个 Agent 不需要共享庞大的历史文档，只需要共享稳定边界、
当前 phase、验证标准和最新 evidence，就能更容易并行工作、交接结果和校准下一步。

## 核心想法

旧版强调静态文档闭环：

```text
spec -> plan -> task -> implementation -> change log
```

新版改为证据校准的阶段循环：

```text
decision framework -> roadmap -> current phase
        -> discovery / implementation -> verification
        -> evidence delta -> next phase
```

核心目标不是记录更多，而是让 Agent 默认读取更少、更准的上下文。

## 功能特点

- **最小上下文**：默认只读取 `decision.md`、`roadmap.md` 和 `current.md`。
- **证据驱动阶段**：下一阶段由上一阶段 evidence 决定，而不是由旧计划惯性推进。
- **阶段内任务**：任务只服务当前 phase，不为远期 roadmap 预拆任务。
- **长期决策才持久化**：ADR/protocol 只记录会长期影响项目边界的规则和契约。
- **意图模块仍保留**：产品访谈、代码判断、文案、浏览器自动化等模块仍可按需加载。

## 默认读取规则（v3 历史）

默认上下文（v3 历史）：

```text
.phrase/decision.md
.phrase/roadmap.md
.phrase/current.md
```

只有在选择下一阶段、解决计划冲突、检查 blocker 分类或关闭 phase 时，才读取
`.phrase/evidence.md`。

只有当当前文件明确链接、回归问题需要历史对比，或用户明确要求追溯旧上下文时，才读取
`.phrase/archive/`。

## 文件权威顺序

当文档互相冲突时，按以下顺序判断：

1. `decision.md`、`adr/` 和 `protocol/` 定义长期规则。
2. 最新 evidence 定义当前已知事实。
3. `current.md` 定义当前 phase。
4. `roadmap.md` 定义阶段方向。
5. `archive/` 只是历史上下文。

如果新 evidence 推翻当前计划，就更新 `current.md`。如果新 evidence 改变长期边界，
就显式更新 `decision.md`、ADR 或 protocol。

## 工作流

1. 建立或读取决策框架。
2. 只在 phase 粒度维护 roadmap。
3. 根据 evidence 选择当前 phase。
4. 用目标、范围、非目标、验收门槛、任务切片和验证计划更新 `current.md`。
5. 阻塞形态不清楚时，先 discovery，不急着实现。
6. 先分类 blocker，再修复。
7. 只执行当前被测量过的切片。
8. 按 phase gate 验证。
9. 记录 evidence delta。
10. 只有长期规则变化时，才更新 durable decision。
11. 准备下一阶段，并把过期上下文归档。

## 任务格式

任务是 phase-local 的，只在 `current.md` 中用于协调当前工作：

```text
taskNNN [ ] goal:<可观察结果> | scope:<文件或区域> | verify:<证明方式>
```

不要为远期 roadmap 阶段预拆任务。

## 从 v2 迁移（历史 v3 记录）

以下步骤只记录旧版 v3 的做法，不是当前迁移指引。现在的已有项目应执行
`Read the current upstream .spec-agents/doctrine/UPGRADE.md and execute the upgrade review against
<project>.`；不要先覆盖安装，也不要手动把遗留内容移动到
`.phrase/archive/`。

已有项目迁移时：

1. 把长期规则提取到 `.phrase/decision.md`。
2. 把未来方向压缩到 `.phrase/roadmap.md`。
3. 把当前阶段压缩到 `.phrase/current.md`。
4. 把会影响后续判断的事实移到 `.phrase/evidence.md`。
5. 把完成或过期的 `spec_*`、`plan_*`、`task_*`、`change_*`、`issue_*`
   移到 `.phrase/archive/`。
6. 停止维护机械的逐文件 `change_*` 日志。
7. ADR/protocol 只保留长期决策和稳定契约。

## 协议成本对比测试

运行：

```bash
./tests/protocol-cost-comparison.sh
```

这个脚本会用同一个开发需求生成两套临时 fixture：

- 旧版 v2 静态 SPEC 布局
- v3 EDPP 最小上下文布局

然后对比默认读取文件数、字数、字节数、估算 token，以及实现后需要维护的写入面。
这个测试衡量的是协议开销，不是模型智力或代码质量。

当前 fixture 的结果：

| 指标 | v2 静态 SPEC | v3 EDPP | 节省 |
| --- | ---: | ---: | ---: |
| 默认读取文件数 | 8 | 3 | 62.5% |
| 默认读取字数 | 378 | 170 | 55.0% |
| 默认读取字节数 | 2405 | 1160 | 51.8% |
| 估算读取 token | 601 | 290 | 51.7% |
| 实现后需要维护的写入面 | 5 | 2 | 60.0% |

一句话：

> 最小上下文，证据驱动阶段，验证后执行，只保留长期有价值的决策。
