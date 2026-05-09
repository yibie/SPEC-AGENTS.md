---
description: Migrate a legacy SPEC-AGENTS v2 project to the EDPP-based v3 structure
---

# /migrate-v3 — Migrate Legacy SPEC-AGENTS Projects

Use this command when a project already has the old static SPEC-AGENTS layout:

```text
.phrase/phases/
  phase-*/
    spec_*
    plan_*
    task_*
    change_*
    issue_*
```

The migration goal is not to convert every old file into a new format. The goal
is to archive historical detail, rebuild the active context, and promote only
decision-relevant material into v3.

## Target Structure

```text
.phrase/
  decision.md
  roadmap.md
  current.md
  evidence.md
  archive/
    legacy-v2/
```

## Steps

1. **Inventory legacy material.**
   List existing `.phrase/phases/`, old `spec_*`, `plan_*`, `task_*`,
   `change_*`, `issue_*`, `adr_*`, and `tech-refer_*` files.

2. **Create v3 files if missing.**
   Ensure these files exist:

   ```text
   .phrase/decision.md
   .phrase/roadmap.md
   .phrase/current.md
   .phrase/evidence.md
   .phrase/archive/
   ```

3. **Archive old phase material.**
   Move completed, stale, or legacy phase directories under:

   ```text
   .phrase/archive/legacy-v2/
   ```

   Do not delete old material during migration unless the user explicitly asks.

4. **Promote durable rules.**
   Extract long-lived constraints from old `adr_*`, `tech-refer_*`, and project
   notes into `.phrase/decision.md`, `.phrase/adr/`, or `.phrase/protocol/`.

5. **Compress roadmap.**
   Extract phase-level direction from old `plan_*` or phase indexes into
   `.phrase/roadmap.md`. Do not copy detailed task lists.

6. **Rebuild current context.**
   Extract only the active phase into `.phrase/current.md`:

   - goal
   - entry condition
   - scope
   - out of scope
   - acceptance gate
   - active task slice
   - verification plan
   - known blockers

7. **Promote evidence.**
   Extract only decision-relevant facts into `.phrase/evidence.md`:

   - unresolved blockers
   - verified results
   - failed assumptions
   - rejected paths
   - next phase recommendation

8. **Write cutover note.**
   Add an evidence entry named `v3 migration cutover` that records where old
   material was archived and which files now define active context.

9. **Verify default read path.**
   Confirm an agent can continue from only:

   ```text
   .phrase/decision.md
   .phrase/roadmap.md
   .phrase/current.md
   ```

## Migration Rules

- Do not migrate records mechanically.
- Do not preserve stale plans as current authority.
- Do not keep old `change_*` logs in the default read path.
- Do not pre-split future roadmap phases into tasks.
- Search the legacy archive only when current work needs historical context.

## Output

Report:

- archived legacy path
- new default context files
- evidence promoted
- active phase after migration
- remaining risks or missing rationale
