# SPEC-AGENTS Project Upgrade

status: revised
revision: 2
context_refs: `CONTEXT.md`, `AGENTS.md`, `ROADMAP.md`, `STATUS.md`

## Problem and goal

Many existing projects still use either the v2 static SPEC layout or the v3
`.phrase` layout. Keeping `.phrase` as an installable compatibility mode would
make the old architecture a permanent second entry point. Replace that mode
with an explicit upgrade path that moves old projects to the modern root
documents and six action skills.

## Unchanged contracts

- Fresh `init` and `install` create only the modern root layout.
- Existing project files are never deleted; old material remains recoverable in
  an archive.
- Installing into the SPEC-AGENTS source repository remains refused.
- `--link` remains available for modern installs and upgrades.
- Upgrade does not invent semantic decisions from an old task list.

## Decision and boundaries

Remove `--legacy` from the installer. Add an explicit command:

```text
spec-agents upgrade <path> [lang] [--link|-l]
```

The command auto-detects:

- v2: `.phrase/phases/` or legacy `spec_*`, `plan_*`, `task_*`, `change_*`, or
  `issue_*` material under `.phrase`;
- v3: `.phrase/decision.md`, `roadmap.md`, `current.md`, or `evidence.md`.

It installs the modern shell, archives the complete `.phrase` tree under a
timestamped `archive/legacy-v2/`, `archive/legacy-v3/`, or
`archive/legacy-mixed/` directory, and writes a `MIGRATION.md` handoff with the
source classification, archive path, direct mappings, and manual review list.

The upgrade is intentionally two-stage: the command performs safe mechanical
preparation; an agent then performs semantic extraction through the six-action
workflow. No old file remains in the active default context.

## Model delta

The installer boundary changes from `InstallMode = modern | legacy` to
`UpgradeSource = v2 | v3 | mixed`. Legacy is a historical input state, not a
runtime or installation mode.

## Action Contracts

- `init` and `install` accept modern options only. Passing `--legacy` fails with
  a message directing the user to `upgrade`.
- `upgrade` requires an existing target containing recognizable `.phrase`
  material and refuses an empty or already-modern target.
- `upgrade` refuses when modern state documents already exist, rather than
  overwriting current state.
- `upgrade` archives the source tree before reporting success and leaves a
  reproducible handoff in `MIGRATION.md`.
- A v3 source maps `decision → CONTEXT`, `roadmap → ROADMAP`, `current →
  STATUS`, `evidence → EVIDENCE`, `adr → docs/adr`, and `protocol →
  docs/protocols` for agent review; v2 phase records are reviewed from the
  archive instead of being mechanically promoted.

## Seams and verification

- Bash syntax and help output.
- Modern `init`/`install` no longer accept or emit `.phrase`.
- v2 upgrade fixture archives the phase bundle and emits handoff metadata.
- v3 upgrade fixture archives the four core files and emits mapping metadata.
- Mixed/unknown input and root-state conflicts fail without moving source data.
- Source-repository refusal and `--link` remain functional.
- Six skill discovery and validators remain unchanged.

## Compatibility and migration

This is a breaking CLI change for `--legacy`, but not a destructive project
change. Existing v2 and v3 projects continue to exist until explicitly
upgraded; the new CLI does not keep installing their old layout. Archived
material is read only for migration, regression comparison, or explicit history.

## Out of scope

- Automatic semantic summarization of v2 records.
- Deleting old project files.
- Formal ontology schemas, graph storage, generators, or synchronization.
- Migrating application code or experiment sandboxes.

## Issue map

- `01-installer-boundary.md`: remove legacy mode and add modern-only command
  parsing.
- `02-upgrade-preparation.md`: implement v2/v3 detection, archive, modern
  install, and migration handoff.
- `03-upgrade-verification.md`: run fixtures, docs checks, and record evidence.

## Revision notes

Revision 1 records the approved shift from permanent compatibility to explicit
upgrade for the two known legacy architectures.
Revision 2 records the verified `--legacy` rejection, v2/v3/mixed detection,
archive handoff, and safe conflict refusal.
