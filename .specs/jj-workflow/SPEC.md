# JJ as the default version-control workflow

status: verified
revision: 1
context_refs: `CONTEXT.md`, `AGENTS.md`, `AGENTS_en.md`, `UPGRADE.md`

## Problem and goal

SPEC-AGENTS currently describes the six actions without a version-control
contract. Local work therefore defaults implicitly to Git, even though the
user wants Jujutsu (JJ) to be the normal local change model. Add a small,
explicit JJ layer without changing the six actions or initializing repositories
behind the user's back.

## Unchanged contracts

- `plan → capture → arrange → do → check → learn` remains the only action loop.
- `Change` continues to mean a proposed semantic or behavioral difference in
  the SPEC-AGENTS model.
- Existing project cognition, legacy v2/v3 upgrade gates, and user dirty work
  remain preserved.
- Git remains a supported remote interoperability layer and fallback for a
  project that has not enabled JJ.
- No application code, formal ontology schema, graph database, or automatic
  repository initialization is added.

## Decision and boundaries

- JJ is the default local version-control model when `.jj/` exists or the
  project has explicitly opted into JJ.
- The JJ version-control object is called `JJ Change` in SPEC-AGENTS documents
  to distinguish it from the workflow concept `Change`.
- Local inspection uses `jj status`, `jj log`, and `jj diff`; local work uses
  `jj new`, `jj describe`, `jj edit`, `jj undo`, and `jj op log`.
- Remote collaboration uses bookmarks and `jj git fetch`/`jj git push`; Git is
  the bridge, not the local action vocabulary.
- A project without `.jj/` is not initialized automatically. An explicit
  setup Runbook may use `jj git init --colocate` after the user chooses it.

## Model delta

```text
Workflow Change --materializes_as--> JJ Change(s)
JJ Change --described_by--> Slice / SPEC reference
JJ Change --published_as--> Bookmark
Bookmark --bridges_to--> Git remote
```

The existing `Change` concept is not renamed. A single Slice may produce one or
more JJ Changes; the SPEC and issue remain the semantic source of truth.

## Action Contracts

### Start local work

- Precondition: the repository has `.jj/`, or the user has explicitly enabled
  JJ in the project.
- Effect: start or edit a JJ Change without a staging area or stash.
- Invariant: the Slice/SPEC remains the source of intent and acceptance.
- Verification: `jj status`, `jj log`, and `jj diff` show the expected change.

### Publish work

- Precondition: the user authorizes remote publication and a bookmark is
  explicitly selected.
- Effect: create/update a bookmark and publish through `jj git push`.
- Invariant: no implicit push, branch creation, or remote mutation during
  ordinary `do`/`check`.
- Verification: inspect the bookmark and remote result after the push.

### Recover local history

- Precondition: a local JJ operation or change needs correction.
- Effect: use `jj undo`, `jj op log`, or `jj op restore` to recover.
- Invariant: recovery does not rewrite a published change silently.
- Verification: `jj log` and `jj diff` match the intended state.

## Compatibility and migration

This is a compatible workflow refinement. Existing Git-only projects continue
to work using the documented fallback. Projects may opt into colocated JJ with
the setup Runbook; the installer does not run that command automatically.
Existing Git commits and remote branches remain usable through JJ's Git bridge.

## Verification

- Static reference scan: no default local operation instructs `git add`,
  `git commit`, `git stash`, `git branch`, or `git checkout` in a JJ path.
- Temporary colocated repository: create a JJ Change, describe it, inspect it,
  create a bookmark, and verify the recovery command surface.
- Documentation checks: Markdown links/metadata, shell syntax, and the local
  installer smoke Runbook.
- Confirm the current SPEC-AGENTS repository remains without `.jj/` and is not
  initialized by this change.

## Out of scope

- Automatic `.jj` initialization in `spec-agents init` or `install`.
- Rewriting existing Git history or migrating every project immediately.
- Requiring all remote hosts to expose native JJ servers.
- Multi-Agent branch/bookmark orchestration.
- Formal ontology tooling or graph storage.

## Issue map

- 01 — define JJ model and agent routing — done
- 02 — publish user Protocol, Runbook, and guide updates — done
- 03 — validate a temporary JJ repository and record evidence — done

## Revision notes

- v1: user-confirmed default JJ local workflow with explicit Git bridge and no
  automatic initialization.
