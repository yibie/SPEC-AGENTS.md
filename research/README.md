# Research Archive

This directory contains the design research and controlled experiments behind
SPEC-AGENTS v4. It is repository history, not an installation payload.

## Layout

- `ontology/` — ontology, Palantir, and SPEC-fusion research plus the prototype.
- `experiments/` — experiment briefs, fixtures, protocols, and result reports.
- `history/` — earlier system-model and EDPP notes retained for comparison.

## Reading rule

Do not load this directory by default. Read a specific record only when the
current decision points to it or the user asks for historical context.

## Installer boundary

`bin/spec-agents` copies an explicit allowlist of root documents, `docs/`,
`archive/`, and `skills/`. It does not copy `research/`, so initialized user
projects do not receive this research archive.
