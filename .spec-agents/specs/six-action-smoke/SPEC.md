# Evidence Link Traceability

status: verified
revision: 1
context_refs: `CONTEXT.md`, `AGENTS.md`, `docs/protocols/evidence-links.md`

## Problem and goal

An issue can contain a verification summary, while the durable Evidence entry
that records the result is not explicitly linked back to that Slice. Add one
optional traceability link without changing existing issue validity or the
execution sequence.

## Unchanged contracts

- Existing issue files remain valid when `evidence_ref` is absent.
- `do` still executes one ready, unblocked Slice.
- `check` remains read-only and checks both contract and engineering axes.
- `learn` remains the only action that promotes verified knowledge.
- No application or experiment behavior changes.

## Decision and boundaries

Add an optional `evidence_ref` field to new issue files. Its value is a stable
Evidence ID such as `E-20260816-001`. `learn` writes the ID only after the
verification entry has been appended to `EVIDENCE.md`.

## Model delta

Add the optional relation:

```text
Slice --evidence_ref (optional, post-verification)--> Evidence
```

The relation is additive. It does not make evidence mandatory for historical
issues and does not permit `do` to write root Evidence.

## Action Contracts

- `arrange`: include an empty optional `evidence_ref` field in new issue files.
- `do`: leave the field empty while work is in progress and return verification
  facts to `check`.
- `check`: confirm the facts are sufficient for a learn entry.
- `learn`: append a stable Evidence ID, then write that ID back to the issue.

## Seams and verification

- Search all six skill documents and AGENTS for the field's writer.
- Validate every skill with `quick_validate.py`.
- Confirm `npx skills list --json` still discovers exactly six skills.
- Confirm old issue shapes remain accepted by the text templates.

## Compatibility and migration

No migration is required. Existing issues remain valid; only newly touched
issues may receive the optional link.

## Out of scope

- Multiple evidence IDs, automated link checking, database storage, or a schema.
- Rewriting historical issues or experiment artifacts.

## Issue map

- `01-model-and-template.md`: define the optional relation and issue field.
- `02-write-and-verify.md`: wire the writer and verify the full path.

## Revision notes

Revision 1 is the pre-edit compatible proposal approved for this smoke pass.
