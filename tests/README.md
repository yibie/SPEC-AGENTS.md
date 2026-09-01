# Protocol Cost Tests

This folder contains lightweight comparison tests for SPEC-AGENTS workflow
overhead.

## Run

```bash
./tests/protocol-cost-comparison.sh
```

The script creates two temporary project fixtures for the same request:

- legacy v2 static SPEC layout
- v3 EDPP minimal-context layout

It then reports default read files, words, bytes, estimated tokens, and write
surfaces after implementation.

Use `--keep` to inspect generated fixtures:

```bash
./tests/protocol-cost-comparison.sh --keep
```

## What This Proves

This test does not prove that one model writes better code. It measures protocol
overhead: how much context and bookkeeping an agent must carry before and after
the same development slice.

## `doctrine-check.sh`

Checks this repository's own doctrine. Instance, not shipped. It enforces the
three things `STATUS.md` had been carrying as "depends on someone remembering":
the mandatory read stays at or under 400 lines, every `ADR NNNN` pointer
resolves, and no file cites a CHANGELOG heading that no longer exists. Each has
failed here at least once.

Run from the repository root:

```bash
tests/doctrine-check.sh
```

The shipped counterpart is `.spec-agents/doctrine/docs/check-kernel.sh`, which checks a
*managed project's* authority map and travels with the installer.

## `source-doctrine-cutover-check.sh`

Checks the source Doctrine's exact namespaced manifest, the selected-language
installed manifest, root adapter cleanliness, source-root and nested status
probes, source Markdown links, source refusal,
and Git's rename recognition using only a throwaway tree.

## `source-spec-cutover-check.sh`

Checks the source repository's canonical SPEC manifest and record counts,
machine-readable `spec_ref` and `blocked_by` resolution, current frontmatter
retired-path cleanliness, source-root and nested status/ready probes, all six
gates and transitions from both roots, check-state, and Git's recognition of
the complete SPEC tree move using throwaway fixtures outside the repository.

## `kernel-delta-check.sh`

Checks the `kernel_delta:` gate and `check-state` provenance seam with
throwaway fixtures outside the repository. It covers absent, empty, and
entry-list declarations, Model delta pointers, one-or-more-space indentation,
exact per-entry Kernel headings and boundary-safe SPEC citations, including
retirements and parenthetical entry names, in a project `KERNEL.md`.

Run from the repository root:

```bash
tests/kernel-delta-check.sh
```
