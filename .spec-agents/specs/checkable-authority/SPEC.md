# Make the authority map checkable

status: verified
revision: 1
context_refs: `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/docs/single-authority.md`, `docs/adr/0006`

## Problem and goal

Nothing reads `KERNEL.md`. Not `bin/spec-agents`, not `tests/`, not any Runbook.
The authority map, `authority:` on slices, per-entry `since:`/`source:`, and the
eight-section shape were all added within the last two days and every one of
them is enforced only by an agent choosing to honor a sentence.

An independent review said it plainly the day before:

> making a rule visible everywhere is not the same as making it executable

`gura105/operational-ontology` shows what the executable version looks like for
the same idea. Its objects, links, and actions are near-isomorphic to this
Kernel's Concepts, Relations, and Action Contracts. The difference is that its
preconditions are functions a runtime calls and its authority is declared in
`owned` / `source` keys the runtime enforces. Divergence there is structurally
impossible rather than procedurally discouraged.

That project also makes a distinction this Kernel lacks. It separates
ontology-owned state, which exists only in the semantic layer, from
source-backed state, which a system of record governs. Derived state simply has
no write path. In the field report that produced ADR 0006, one of the fifteen
violations was derived state persisted twice — a failure the current map cannot
express, because the map only records which module owns a rule.

Goal: give the map a form a script can read, add the missing authority states,
and ship a check that fails.

## Unchanged contracts

- The Kernel stays human-written, human-readable Markdown. It does not become a
  schema, a graph database, or a generated artifact; the invariant at
  `docs/spec-agents/WORKFLOW.md` forbidding those is untouched.
- The eight sections, `since:`/`source:`, and every rule from ADR 0006.
- Existing Kernels are not required to back-fill, and a missing map is still a
  gap reported by re-scan rather than a failure.
- `check`'s three axes, the placement item, and its three tells.

## Decision and boundaries

### The map entry gets one fixed line

```markdown
## Architecture boundaries

- <rule name> — authority: `<path>` | <owned|source-backed|derived>
  second site: `<path>` (<why unavoidable>; equivalence test: `<path>`)
```

One rule per entry, the authority path in backticks, one of three states after
the pipe. The optional second-site line keeps its existing form.

This is a fixed line inside a Markdown document, not a schema. The Kernel is
still written and read by people; a script can now also read this one section.
That distinction is what keeps the standing invariant intact — the surrounding
document gains no machine-required structure.

### Three authority states

- `owned` — this project's semantic layer decides it; nothing outside supplies
  it.
- `source-backed` — a system of record owns it; the project may read and write
  through, but the source governs.
- `derived` — computed from other state. **It has no write path**, and
  persisting it anywhere is the defect.

`derived` is the one that pays for itself. In a runtime, derived state is
protected by absence: it is not declared writable, so nothing can write it. A
prose map has no such mechanism — absence there means nobody thought about it.
Marking it explicitly converts a silent omission into a stated prohibition, and
gives the "derived state persisted twice" tell something to check against.

### A checker ships with the doctrine

`docs/spec-agents/check-kernel.sh` becomes part of the installed payload. This
is the first executable in a payload that has been documents only, and the
change is deliberate: a check that must read a project's Kernel has to run where
that Kernel is.

It verifies, and fails on:

- every `Architecture boundaries` entry matching the fixed line form;
- every authority path existing in the repository;
- every `derived` entry having no `second site:` line, and no equivalence test
  — a derived rule with a second site is a contradiction;
- every `second site:` line naming an equivalence test path that exists.

It does not verify that the map is complete or correct. A map can be perfectly
formed and wrong. The check removes a class of silent breakage; it does not
replace `check`'s placement item, and the Protocol says so.

Absent `KERNEL.md` or absent `Architecture boundaries` exits successfully with a
notice, because ADR 0006 promised existing Kernels need not back-fill.

### This repository gets its own checker

`tests/doctrine-check.sh` covers what this repository can check about itself,
and it covers the three procedures that `STATUS.md` has been carrying as
"depends on someone remembering":

- the mandatory read is at or under 400 lines;
- every `ADR NNNN` pointer in the doctrine resolves to a file;
- no live file references a CHANGELOG version that no longer exists.

This is Instance, not doctrine: it checks this repository's own product.

## Model delta

- `Architecture boundaries` entries gain a fixed form and an authority state.
- No new concept. `owned` / `source-backed` / `derived` are properties of an
  existing map entry.
- The installed payload gains a file class it did not have.

## Compatibility

`compatible`. A Kernel with no map, or with prose entries, is not failed — the
checker skips what it cannot parse and says so, and the re-scan still reports a
missing map as a gap. No project is migrated. The installer's file list grows by
one.

No ADR. This implements ADR 0006's map rather than deciding anything new; the
payload-composition change is recorded in Evidence.

## Verification

- `START.md` shows the fixed line form with the three states and states that
  `derived` has no write path.
- `bash -n` passes on both scripts.
- `check-kernel.sh` fails on a malformed entry, a non-existent path, a `derived`
  entry with a second site, and a missing equivalence test — each proven with a
  fixture, not asserted.
- `check-kernel.sh` exits 0 with a notice when `KERNEL.md` or the section is
  absent.
- `tests/doctrine-check.sh` passes on this repository and fails when the
  mandatory read is padded past 400 lines.
- The installer ships `check-kernel.sh` with its executable bit intact.
- Installer smoke passes, including the leakage assertion, with an executable in
  the payload.

## Out of scope

- Making the rest of the Kernel machine-readable.
- Checking that the map is complete or that its entries are true.
- Borrowing `operational-ontology`'s runtime, MCP surface, or write-back model.
- The "declared implementation choices" list — deferred to its own `plan`.

## Issue map

- `01-map-form.md`: the fixed line and the three states in `START.md`.
- `02-check-kernel.md`: the doctrine checker.
- `03-payload.md`: ship it, with the executable bit and the smoke assertions.
- `04-doctrine-check.md`: this repository's own checker.
- `05-learn-record.md`: Evidence, `STATUS.md`, `CHANGELOG.md`. `writer: learn`.
