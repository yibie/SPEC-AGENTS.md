# Parallel Work

status: active
scope: projects with more than one active SPEC
applies_when: a second SPEC becomes active, or two pieces of work must run at the same time
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260820-002` (not an Evidence ID in this project)
verification: `jj workspace list` or `git worktree list` shows one working copy per concurrently executing SPEC, and the active SPECs' scopes do not intersect

## Two different problems

Parallel work fails in two ways that look similar and have different fixes.

**Scope conflict** — two active SPECs claim the same files, module, or
contract. This is a `plan` failure. Isolating working copies does not fix it;
it hides the collision until merge, when it is more expensive and the reason
for each edit has been forgotten. When scopes intersect, return to `plan` and
redraw the boundary, or make one SPEC wait.

**Execution interference** — two pieces of work need the working copy at the
same time: a build and an edit, a long regression and a fix, two agents. This
is a version-control problem and isolation is the fix.

Non-overlapping scope is the precondition for parallel work. Isolation is a
convenience for concurrent execution. Isolation is never permission to run
overlapping SPECs at once.

## When isolation is required

Required when two pieces of work must occupy a working copy simultaneously:

- a build or test run that takes long enough that you want to keep editing;
- two agents operating on the same repository;
- writing a fix while a regression suite runs on the previous state;
- comparing two implementations side by side.

Not required when you switch between SPECs serially. In a project with `.jj/`
this is safe without any stash: there is no staging area, the working copy is
snapshotted automatically, and `jj new` / `jj edit` move between changes
without losing work. Creating a workspace for serial switching only costs disk
and attention.

In a Git-only project, serial switching still needs the project's normal
discipline for uncommitted work. That is a reason to prefer a worktree sooner
than in JJ, not a reason to require one always.

## JJ projects

```bash
jj workspace add ../<name>      # new working copy, same repo
jj workspace list               # each appears as <name>@ in jj log
jj workspace root
jj workspace forget <name>      # stop tracking it
jj workspace update-stale       # repair a workspace left behind by other work
```

Each workspace has its own working-copy commit and its own sparse patterns.
Removing a workspace is `jj workspace forget` followed by deleting the
directory; forgetting does not delete the changes, which remain in the repo.

The version-control rules do not change inside a workspace: publish only with
explicit authorization, through a bookmark and `jj git push`. Never run
`jj git init --colocate` to create a workspace, and never create one during
`start`.

## Git-only projects

```bash
git worktree add ../<name> <branch>
git worktree list
git worktree remove ../<name>
```

Do not initialize JJ in order to get workspaces. A Git-only project stays on
its existing Git workflow unless the user explicitly opts in.

## Cleanup

An abandoned workspace or worktree is a stale second opinion about the state of
the project. Remove it when its SPEC closes. If one is found unexplained,
report it rather than deleting it — it may hold unmerged work.
