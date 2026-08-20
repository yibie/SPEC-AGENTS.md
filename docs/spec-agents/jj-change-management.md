# JJ Change Management

status: active
scope: local version control for projects with `.jj/`
applies_when: a task starts, inspects, describes, recovers, or publishes work in a JJ-enabled project
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260817-006` (not an Evidence ID in this project)
verification: run the [JJ project setup Runbook](jj-project-setup.md) in a disposable colocated repository

## Vocabulary

`Change` means a proposed semantic or behavioral difference in SPEC-AGENTS.
`JJ Change` means a Jujutsu version-control object. A Slice or SPEC supplies
intent; a JJ Change records the local file state that implements it.

## Local work

When `.jj/` exists:

```text
jj status → jj log → jj diff → jj new / jj edit → jj describe
```

Use `jj undo` or `jj op log` for local recovery. There is no staging area or
stash. Keep issue/SPEC acceptance as the source of semantic intent and do not
push or create a remote bookmark during ordinary `do` or `check`.

## Remote work

Publishing is an explicit user-authorized action:

```text
jj bookmark create <name> -r @
jj git fetch
jj git push --bookmark <name>
```

The Git remote is an interoperability bridge. A remote Git host does not make
Git's local branch/staging vocabulary the default for a JJ-enabled project.

## Git-only projects

If `.jj/` is absent, preserve the project's existing Git workflow. Do not run
`jj git init --colocate` automatically; use the setup Runbook only after the
user explicitly chooses JJ. This Protocol does not require a native JJ server.
