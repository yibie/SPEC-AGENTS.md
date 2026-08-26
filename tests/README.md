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

The shipped counterpart is `docs/spec-agents/check-kernel.sh`, which checks a
*managed project's* authority map and travels with the installer.
