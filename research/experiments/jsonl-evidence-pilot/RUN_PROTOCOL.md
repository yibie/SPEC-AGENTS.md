# Run Protocol

Run from the repository root:

```bash
python3 research/experiments/jsonl-evidence-pilot/run_pilot.py
```

The runner reads `agent-a.jsonl`, `agent-b.jsonl`, and `baseline.md`. It does
not write files, use the network, install dependencies, or touch root project
documents.

## Scenarios

| ID | Scenario | Expected result |
| --- | --- | --- |
| J1 | Parse two independent streams | All records parse and IDs are unique |
| J2 | Merge streams | Records sort by timestamp while both source streams remain represented |
| J3 | Select `jsonl-pilot` | The unrelated phase record is excluded |
| J4 | Supersede a claim | The old record remains in history but is absent from the active view |
| J5 | Review cost | JSONL and Markdown bytes/words/rough tokens are reported as fixture-specific evidence |

The result must state what this fixture can and cannot establish. In
particular, a size difference is not a tokenizer benchmark, and passing merge
logic is not proof of safe concurrent filesystem writes.
