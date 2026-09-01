# Runbook: opt into JJ for a project

status: active
scope: explicit setup and recovery of a colocated JJ repository
applies_when: the user chooses to make JJ the local version-control interface for a Git project
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260817-006` (not an Evidence ID in this project)
verification: complete the disposable repository checks below without touching the source project

## Preconditions

- The user explicitly approved JJ for this project.
- `jj` and `git` are installed.
- The project has a recoverable Git repository or a disposable test directory.
- Do not run setup in a user's active project until the target path is
  confirmed; use `/tmp` for this smoke test.

## Disposable setup

```bash
TARGET_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-jj.XXXXXX")"
trap 'rm -rf "$TARGET_ROOT"' EXIT

mkdir "$TARGET_ROOT/repo"
cd "$TARGET_ROOT/repo"
git init
printf 'seed\n' > README.md
git add README.md
git commit -m 'test: seed disposable repository'
jj git init --colocate
```

The `git add`/`git commit` lines are fixture preparation before JJ is enabled;
they are not the SPEC-AGENTS workflow for the resulting JJ repository.

## Verify the JJ workflow

```bash
printf 'change\n' >> README.md
jj status
jj describe -m 'test: describe JJ change'
jj log -r @
jj diff
jj new
jj undo
jj log -r @
```

The commands must show a current JJ Change, its description, a diff, and a
recoverable operation. No remote bookmark or push is required for this local
smoke test.

## Recovery and real-project setup

For a real project, stop after confirming the target and run
`jj git init --colocate` explicitly. If a local JJ operation needs recovery,
use `jj undo`, inspect `jj op log`, and use `jj op restore <operation-id>` only
after selecting the exact operation. Never delete `.git` or rewrite a
published change as part of setup.
