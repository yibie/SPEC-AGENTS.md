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
