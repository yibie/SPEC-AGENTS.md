# Modern Installer Layout

status: revised
revision: 2
context_refs: `CONTEXT.md`, `AGENTS.md`, `ROADMAP.md`, `STATUS.md`

## Problem and goal

`bin/spec-agents` still installs the old `.phrase` v3 tree even though the
repository's default workflow now uses root documents and six action skills.
Make the modern layout the default for new installs while preserving an
explicit legacy path.

## Unchanged contracts

- Existing source files and user-project files are never deleted by the
  installer.
- `--link` remains supported.
- Installing into the source repository remains refused.
- The legacy `.phrase` layout remains available with `--legacy`.

## Decision and boundaries

Use two installer modes:

- modern (default): copy or link root documents, `docs/`, `archive/`, and
  `skills/`.
- legacy (`--legacy`): retain the existing `.phrase` and Claude command copy
  behavior.

## Model delta

The installer now has an explicit `InstallMode` choice. Modern mode is the
default for new projects; legacy mode is an opt-in compatibility boundary.

## Action Contracts

- `init` and `install` accept `--legacy` in addition to `--link`.
- Modern mode emits the six skill directories and root documents.
- Legacy mode emits the existing `.phrase` files and directories.
- Neither mode deletes files from the target.

## Verification

- `bash -n bin/spec-agents`.
- Modern temporary install assertions.
- Legacy temporary install assertions.
- `--link` temporary install assertion.
- Source-repository refusal assertion.
- English guidance and README contain no modern-default contradiction.

## Out of scope

- Automatic migration of an existing target.
- Deleting `.phrase` from any target.
- Rewriting the historical benchmark.

## Issue map

- `01-modern-and-legacy-mode.md`: implement installer modes and smoke test.
- `02-guidance-and-docs.md`: update English guidance and README install text.

## Revision notes

Revision 1 was the compatible installer proposal approved for Phase 12.
Revision 2 records the verified modern default, explicit legacy mode, and
English/README guidance update. No target migration or deletion was added.
