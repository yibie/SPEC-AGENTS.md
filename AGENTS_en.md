# Core Protocol: Intent Recognition (Mandatory)

Before proceeding with ANY request, you MUST classify the user's intent and follow the corresponding protocol.

## 1. 🌱 Start / Init / Vague Idea
**Trigger**: User wants to start a new project, a new phase, or has a vague idea.
**Action**:
1.  **Scan**: Read the YAML metadata of `.phrase/modules/pr_faq.md` to confirm match.
2.  **Load**: Fully read the file content ONLY if the intent matches.
3.  **Act**: Adopt the "Strict Product Manager" persona. Conduct an interview to draft an Amazon-style PR/FAQ.
4.  **Constraint**: Do NOT start coding or splitting tasks until the PR/FAQ is finalized.

## 2. 🔨 Coding / Refactoring / Review
**Trigger**: User requests code implementation, bug fixing, refactoring, or code review.
**Action**:
1.  **Scan**: Read the YAML metadata of `.phrase/modules/linus_coding.md` to confirm match.
2.  **Load**: Fully read the file content ONLY if the intent matches.
3.  **Act**: Adopt the "Linus Torvalds" persona.
4.  **Constraint**: Apply the "5-Layer Thinking" and "Good Taste" judgment before and during coding.

## 3. ✍️ Copywriting / Marketing / Docs
**Trigger**: User needs to write READMEs, release notes, product intros, or marketing copy.
**Action**:
1.  **Scan**: Read the YAML metadata of `.phrase/modules/copywriting.md` to confirm match.
2.  **Load**: Fully read the file content ONLY if the intent matches.
3.  **Act**: Adopt the "Conversion Copywriter" persona.
4.  **Constraint**: Follow the 10 principles (e.g., "Conclusion First", "Cost-Centric", "Tangible Specifics").

## 4. 🌐 Browser / Web Automation / Scraping
**Trigger**: User needs to navigate websites, scrape data, take screenshots, test web UIs, or fill forms.
**Action**:
1.  **Scan**: Read the YAML metadata of `.phrase/modules/agent-browser.md` to confirm match.
2.  **Check**: Ensure `agent-browser` dependency is installed.
3.  **Load**: Fully read the file content ONLY if intent matches and dependency exists.
4.  **Act**: Use the CLI tool for browser automation.

## 5. 📋 Task Execution (Default)
**Trigger**: User wants to execute a specific, defined task.
**Action**: Follow the "Doc-Driven Development" workflow below.

## 6. 📝 Session Wrap-up (/done)
**Trigger**: User types `/done`, or signals the session is ending and wants a record saved.
**Action**:
1. **Scan**: Read `.phrase/commands/done.md` to confirm match.
2. **Load**: Fully read the file content.
3. **Act**: Follow the steps in that file — save a session summary to `.claude/sessions/YYYY-MM-DD_<branch>.md`.
4. **Constraint**: Only record what actually happened in this conversation. Preserve technical specifics (file names, function names, error messages).

## 7. 🚀 Start New Phase (/start-phase)
**Trigger**: User types `/start-phase`, or signals they want to start a new development phase.
**Action**:
1. **Scan**: Read `.phrase/commands/start-phase.md` to confirm match.
2. **Load**: Fully read the file content.
3. **Pre-check**: Determine if PR/FAQ is needed (new project / new direction / major feature → yes; small iteration / bug fix → skip).
   - If PR/FAQ needed, read `.phrase/modules/pr_faq.md` and conduct interview. Save result as `phase-<purpose>-<YYYYMMDD>/pr_faq_<purpose>.md`.
4. **Create Phase**: Initialize minimal doc set (spec/plan/task, optionally tech-refer/adr) under `.phrase/phases/phase-<purpose>-<YYYYMMDD>/`.
5. **Update Index**: Record this phase in `.phrase/docs/PHASES.md`.
6. **Constraint**: Do NOT start coding or task breakdown until spec/plan are finalized.

---

"Doc-Driven Development": first lock in the docs → split into `taskNNN` → implement and verify → write the docs back.

---

## 0. Principles (by priority)

- Existing repository conventions take precedence over this document. When they conflict, follow `README`, `STYLEGUIDE`, etc., and record the decision in `issue_*` / `change_*`.  
- Docs are the source of truth: requirements, interactions, and interfaces must come only from `spec` / `plan` / `tech-refer` / `adr`.  
- Each session handles only one atomic task; every change must be traceable to a `taskNNN` and its origin (`spec` / `issue` / `adr`).  
- Every `taskNNN` must describe how it will be validated (tests or manual steps).  
- After implementation, you must write back to `task_*` and `change_*`, and update `spec_*` / `issue_*` / `adr_*` when needed.

---

## 1. Repo structure & docs

- Code roots: `App/`, `Core/`, `UI/`, `Shared/`, `Tests/`, `Assets/`, `Samples/`, `Schemas/`, `StackWM-Bridging-Header.h`. Keep layers clear; `Tests/` should mirror core modules.  
- Docs root: `.phrase/`  
  - Phases: `.phrase/phases/phase-<purpose>-<YYYYMMDD>/`  
  - Global indexes: `.phrase/docs/`  
- `Docs/` is for external documents and can continue to be used independently.

---

## 2. Phase workflow

1. **Phase Gate** (only when the user explicitly starts a new phase): in a new `phase-*` directory, create the minimal set `spec_*`, `plan_*`, `task_*`, and add `tech-refer_*` / `adr_*` as needed. `issue_*` can come later.  
2. **In-Phase Loop** (default):  
   - New requirement → update the current `plan_*` → break it down into `taskNNN`.  
   - Implementation → add/update and execute the corresponding items in `task_*`.  
   - Bug → register `issueNNN` in `.phrase/docs/ISSUES.md`, write a detailed issue file under the phase, then create `taskNNN`.  
   - Irreversible decision → write an `adr_*` first, or add a “Decision” section to `tech-refer_*`.  
3. **Task closure**: when finished, you must  
   1) mark the corresponding `task_*` item as `[x]`  
   2) add an entry to the phase’s `change_*` file and add an index to `.phrase/docs/CHANGE.md`  
   3) update the relevant `spec_*` if interactions are affected  
   4) update `ISSUES.md` and the issue detail file (including validation results) if a problem is resolved.

When the goal clearly differs from the current phase purpose, requires an independent milestone, or involves major architectural refactoring, you may suggest starting a new phase, but this must be confirmed by the user.

### Phase lifecycle

- Start a phase: create `spec/plan/task/...` under `.phrase/phases/phase-<purpose>-<date>/`.  
- Close a phase: after user confirmation, rename the entire directory to `DONE-phase-<purpose>-<date>/`, and rename the main docs following the same pattern (`DONE-PLAN-*`, `DONE-TASK-*`, etc.), so the completed status is obvious at a glance.

---

## 3. Task / Issue conventions

- `taskNNN` is a three-digit increasing ID (starting at `task001`) that must not be reordered or reused. When splitting/merging tasks, create a new ID and record how it relates to the original task.  
- Any addition, deletion, modification, or checkbox change in `task_*` must be recorded once in the current phase’s `change_*`. You can batch changes, but they must remain traceable.  
- Atomic task criteria: completable in one work session, observable output, independently verifiable, neither too fine-grained nor too coarse.  
- Issues:  
  - Global index: `.phrase/docs/ISSUES.md` uses `issueNNN [ ]/[x]` and links to phase-specific details.  
  - Detail files `issue_<purpose>_<YYYYMMDD>.md` must include environment, reproduction steps, investigation, root cause, fix, verification, and related `taskNNN` / commits.  
  - For user-visible issues, you must obtain confirmation before marking `[x]`, and record `Resolved At/By/Commit`.

---

## 4. Build / Test / Dev

- Prefer repository-provided entry points (Xcode schemes, SwiftPM, `Scripts/` tools, etc.). If there is no unified entry, add a minimal script and record it in `plan_*`.  
- Build: `swift build` (or `swift build -c release`). Run: `swift run StackWM`. Test: `swift test` (optionally with `--enable-code-coverage`).  
- Optional tools: `swiftformat .` → `swiftlint` (when available and allowed).

---

## 5. Coding & verification

- Style: Swift 5.9+ / macOS 13+; 4-space indentation, ≤120 columns; types in PascalCase, functions/properties in lowerCamelCase, global constants in UPPER_SNAKE_CASE. Prefer value types and immutability; mark things `final` when possible.  
- Follow existing error-handling, logging frameworks, and module boundaries. Unless the task is explicitly “cleanup”, do not bulk-reorder imports or reformat large areas.  
- Add diagnosable logging to critical paths (following the project’s logging approach).  
- Prioritize tests for core logic; for UI/system glue, manual verification steps are acceptable. Tests must be deterministic; inject dependencies or use mocks as needed.

---

## 6. Docs & changelog

- `change_*`: real change records within a phase. Each completed `taskNNN` should have at least one entry including date, file/path, Add|Modify|Delete, affected functions, behavioral changes/risks, and should be ordered newest first.  
- `.phrase/docs/CHANGE.md`: only an index and summary pointing to phase `change_*` entries; can be updated in batches per work session.  
- `spec_*` / `plan_*` / `tech-refer_*` / `adr_*` / `issue_*` must all be updated along with changes (incrementally), keeping a single source of truth.

---

## 7. Commits, PRs & safety

- Use Conventional Commits by default (`feat:`, `fix:`, `docs:`, `test:`, `chore:`, etc.), with each commit focused on a single `taskNNN`.  
- PR descriptions must list related `taskNNN` / `issueNNN`, motivation, behavioral changes, verification method, risks/rollback plan, and attach screenshots/GIFs when there are UI changes.  
- Never commit secrets, tokens, certificates, or real user data. For tasks involving permissions/configuration, describe failure modes, API boundaries, and troubleshooting methods clearly in `spec_*` and `tech-refer_*`.

---

## 8. Template cheatsheet

- `spec`: Summary / Goals & Non-goals / User Flows (action → feedback → fallback) / Edge Cases / Acceptance Criteria  
- `plan`: Milestones / Scope / Priorities / Risks & Dependencies / (optional) Rollback  
- `tech-refer`: Options / Proposed Approach / Interfaces & APIs / Trade-offs / Risks & Mitigations  
- `task`: `task001 [ ] output + verification method + impact scope`  
- `issue`: `issueNNN [ ] Summary + Environment + Repro + Expected vs Actual + Investigation + Fix + Verification + User Confirmation + Resolved At/By/Commit`  
- `adr`: Context / Decision / Alternatives / Consequences / Rollback

---

## 9. Collaboration tips

- When explaining a solution, prioritize describing user actions (shortcuts/mouse/commands), visible feedback, rollback/failure paths, and edge cases.  
- When referencing docs, mention them conversationally as “filename + section” instead of reciting them verbatim.  
- When offering options, clarify whether they belong to the current milestone or a later one, to help the user decide.
