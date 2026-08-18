# Run Protocol

Run from the repository root:

```bash
python3 experiments/ontology-graph-pilot/run_pilot.py
```

The runner uses only the Python standard library, stores everything in memory,
prints the relevant state after each stage, and writes no files.

## Controlled sequence

1. Load the experimental object, relation, action, state, and Evidence
   vocabulary from the script/`ONTOLOGY.md` contract.
2. Prove that an unknown relation and a wrong domain/range pair are rejected.
3. Prove that `do` is rejected before `arrange`.
4. Execute the valid six-action chain.
5. Add the invariant-to-action constraint and its supporting Evidence.
6. Query the invariant's confirmed impact path and edge provenance.
7. Reject a proposed relation with new Evidence and verify it is not active.

A result is valid only if the output distinguishes actions from relations,
prints lifecycle changes, and reports the limits of an in-memory fixture.
