# JSONL Evidence Ledger Pilot — Results

## Verification

The runner passed all five scenarios:

| Scenario | Result |
| --- | --- |
| J1: parse two streams and validate IDs | pass; 2 streams, 8 records, unique IDs |
| J2: merge streams | pass; deterministic timestamp order |
| J3: select one phase | pass; 7 `jsonl-pilot` records, `E-004` excluded |
| J4: supersede a claim | pass; `E-001` remains in history and is absent from the 6-record active view |
| J5: report review cost | pass; JSONL and Markdown measurements printed with limits |

Command:

```bash
python3 experiments/jsonl-evidence-pilot/run_pilot.py
```

## Fixture measurements

| View | JSONL | Markdown |
| --- | ---: | ---: |
| Full bytes | 1,740 | 1,649 |
| Full words | 85 | 198 |
| Full rough tokens (`bytes / 4`) | 435 | 413 |
| Scoped bytes | 1,532 | 1,425 |
| Scoped words | 75 | 170 |
| Scoped rough tokens (`bytes / 4`) | 383 | 357 |

These are one small fixture, not a tokenizer benchmark. JSONL used fewer
whitespace-delimited words but more bytes and rough tokens because field names,
quotes, and punctuation are repeated on every line.

## Interpretation

- Stable IDs, independent streams, phase selection, and supersession are a
  natural fit for JSONL records.
- JSONL did not automatically reduce context cost in this fixture.
- The runner merged in memory; it did not prove safe concurrent filesystem
  appends or conflict resolution.
- Human review quality was not measured by a token count.

## Decision

**Do not change the production document layout.** Keep `AGENTS.md`,
`CONTEXT.md`, `ROADMAP.md`, `STATUS.md`, and ADR/Protocol documents in Markdown.

**Keep JSONL as a candidate for a dynamic evidence or task ledger only.** A
future adoption would require a separate plan that defines one canonical source,
selective query/projection behavior, and concurrent-write/merge verification.
Do not create a second independently editable `EVIDENCE` source based on this
pilot.

## Remaining question

If record volume or multi-Agent writes become a real bottleneck, run a second
bounded experiment for concurrent append, duplicate IDs, and generated human
views. This pilot alone does not justify that infrastructure.
