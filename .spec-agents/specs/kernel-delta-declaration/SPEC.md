# Declare the Kernel delta before the code

status: verified
revision: 2
kernel_delta:
  - revise: Model delta (SPEC section gains normative meaning)
  - revise: capture Action Contract (kernel_delta field, mandatory on new SPECs)
  - revise: learn Action Contract (promotion must match the declaration)
context_refs: `.spec-agents/doctrine/docs/WORKFLOW.md`, `.spec-agents/doctrine/skills/plan/SKILL.md`,
`.spec-agents/doctrine/skills/capture/SKILL.md`, `.spec-agents/doctrine/skills/learn/SKILL.md`, `.spec-agents/doctrine/bin/spec-agents`,
`.spec-agents/specs/kernel-maintenance/SPEC.md`

## Problem and goal

`Project Kernel --constrains--> SPEC | Action Contract | Code`
(`docs/spec-agents/WORKFLOW.md`, Stable Relations), yet the Kernel is written
only by `learn`, after the code. During every implementation window the
constraint runs backwards: code moves first and redefines the ontology de
facto, and the Kernel is stale until someone promotes. "The docs are always
behind" is this inversion observed daily.

The pieces of a fix already exist and do not connect:

- `plan`'s candidate record carries `kernel_status` and `kernel_promotion`
  fields (the candidate record in `skills/plan/SKILL.md`), so the impact
  analysis happens.
- The SPEC template carries a `## Model delta` heading (the SPEC minimal
  structure in `skills/capture/SKILL.md`) — its only occurrence; no prose anywhere
  defines what the section must contain or connects it to the kernel fields.
- `bin/spec-agents` never reads it: `grep -n "Model delta" bin/spec-agents`
  returns nothing.
- `skills/learn/SKILL.md` promotes Kernel changes "after `plan` confirms" but
  nothing requires the promoted content to match what the SPEC declared.
  Divergence is undetectable.

So a `plan` round fills `kernel_promotion`, and the value is read by nothing
downstream. This is the defect class already on record as E-20260821-006 —
`capture` is not required to cover every decision its `plan` round produced —
instantiated on the kernel fields.

The reverse direction is already repaired: `kernel-maintenance` (verified) gave
`check` the `semantic` finding that routes code-vs-Kernel drift to `plan`.
Detection after the fact exists; declaration before the fact does not.

Goal: the intended Kernel delta is declared in the SPEC before `do` starts, the
code is implemented against that declaration, and `learn` promotes exactly what
was declared — or the divergence goes back through `plan`. Ordering plus
checkability; neither alone.

## Unchanged contracts

- `learn` is the only writer of `KERNEL.md`, and the enacted Kernel contains
  only confirmed facts. This SPEC does not weaken that floor — it is the reason
  the proposal lives in the SPEC, not in the Kernel.
- The `kernel:` lifecycle line is unchanged: no `proposed` state is added. The
  proposal state is carried by the SPEC's own lifecycle — a confirmed SPEC's
  `Model delta` *is* the proposed Kernel delta (decided in the `plan` round of
  2026-08-28).
- One truth, one place: no `KERNEL-DELTA.md` or other second file.
- `check` stays read-only; `kernel-maintenance`'s `semantic` finding and
  routing are untouched.
- The six action names and their division of labour; the Change Boundary; the
  Doctrine/Instance split; `capture` owns the SPEC document.
- The CLI does not print skill prose (ADR 0007).
- In this repository, which has no `KERNEL.md`, the Kernel's counterpart is
  `docs/spec-agents/WORKFLOW.md` (the Knowledge Classes table already says so).

## Decision and boundaries

### `Model delta` gains its contract

For any SPEC whose Change crosses the Change Boundary, `## Model delta` is the
proposed Kernel delta: the concepts, identities, relations, lifecycle states,
invariants, or Action Contracts that will be added, revised, superseded, or
retired in the project's `KERNEL.md` (here: `WORKFLOW.md`) when the work
verifies. `do` implements against it; `learn` promotes it verbatim or stops.

### SPEC frontmatter gains a machine-readable `kernel_delta:` field

Either the explicit answer `none`, or a list of `<verb>: <entry>` lines with
verbs `add | revise | supersede | retire`. The field is the gate's input; the
`Model delta` section is the human's. One rule decided in the field, explained
in the section.

### The default is named

A SPEC without the field is legacy and is read as `kernel_delta: none`. This is
a deliberate, visible default (the discipline noted from
`gura105/operational-ontology`, applied to this field): zero back-fill across
the twenty-three existing SPECs and all managed-project stock, and `capture`'s
contract makes the field mandatory on every SPEC it creates from now on.

### `capture` must materialize the plan round's kernel fields

When the `plan` round recorded `kernel_promotion` other than `none`, `capture`
may not finish with an empty `kernel_delta` — the omission that lost a decision
in E-20260821-006 becomes a refusal instead of a silence, for this field.

### `learn` promotes the declaration, not the drift

At promotion, the `KERNEL.md` change must equal the SPEC's declared entries as
last revised. Each promoted entry's provenance cites the SPEC. Implementation
that falsifies the declaration routes through `plan` and a SPEC revision before
any promotion; nothing is silently adjusted at the end.

## Model delta

| | before | after |
| --- | --- | --- |
| `## Model delta` | template heading, no contract | the proposed Kernel delta of a Change-Boundary SPEC |
| SPEC frontmatter | no kernel field | `kernel_delta: none \| <verb>: <entry> list`, mandatory on new SPECs |
| absent field | undefined | read as `none`; named legacy default |
| `capture` finish | may drop plan's kernel fields | refuses when `kernel_promotion` ≠ none and delta is empty |
| `learn` Kernel write | match with declaration unchecked | must equal declared entries; provenance cites the SPEC |
| `gate do` | ignores kernel declaration | refuses structural inconsistency (entries without a Model delta section) |
| kernel lifecycle | unchanged | unchanged — proposal state lives in the SPEC lifecycle |

## Action Contracts

- **`plan`** — unchanged fields; its handoff to `capture` includes the kernel
  fields it already records.
- **`capture`** — new: writes `kernel_delta:` on every SPEC it creates;
  `none` is a legal explicit answer. Refuses to finish when the confirmed
  `plan` outcome carried `kernel_promotion` ≠ none and the delta is empty.
  Entry verbs are `add | revise | supersede | retire`; entries name Kernel
  items, not files.
- **`do`** — implements against the declared delta. Discovering mid-slice that
  the declaration is wrong stops the slice and routes to `plan`; the SPEC
  revision marks affected slices `stale` (existing mechanics, now with a
  declared object to be wrong about).
- **`learn`** — new precondition on Kernel promotion: the written change equals
  the SPEC's declared entries; each entry's provenance cites the SPEC. Any
  divergence: stop, write nothing, report which entry diverged.
- **`spec-agents gate do`** — refuses when the slice's SPEC declares
  `kernel_delta` entries but has no non-empty `## Model delta` section; refuses
  a present-but-empty field. Absent field passes. When entries exist, the ok
  output points at the SPEC's Model delta (a pointer, not prose).
- **`spec-agents check-state`** — in a project with `KERNEL.md`: a `verified`
  SPEC with delta entries must resolve each entry to Kernel provenance citing
  that SPEC. For `add`, `revise` and `supersede` that is a record whose
  `source:` cites the SPEC. For `retire` it is the record's absence: a retired
  entry has no Kernel record to carry a citation, and the Kernel carries no
  changelog (ADR 0005), so the retirement's provenance is the SPEC that
  declared it and the Evidence that verified it (r2). Skipped where no
  `KERNEL.md` exists (this repository verifies via fixtures instead).

## Seams and verification

- `grep -n "kernel_delta" skills/capture/SKILL.md` returns a hit (zero today).
- Fixture: SPEC with `kernel_delta` entries and no `Model delta` content →
  `gate do` refuses, naming `skills/capture/SKILL.md`.
- Fixture: SPEC without the field → `gate do` passes (legacy default honored).
- Fixture: promotion whose content diverges from the declared entries →
  `learn`'s precondition reports the diverging entry and writes nothing.
- `docs/spec-agents/WORKFLOW.md` names the Model delta semantics and the
  absent-field default in one place.
- `spec-agents check-state` exits 0 across all SPECs; `tests/doctrine-check.sh`
  passes; the mandatory read stays at or under 400 lines.

## Compatibility and migration

**Breaking.** `gate do` gains a refusal it did not have, `capture` gains a
mandatory field, and `learn` gains a promotion precondition.

- **Existing SPECs (23 here, plus managed-project stock)** — absent field reads
  as `none`; zero back-fill, no data change, `gate do` behavior on them is
  unchanged.
- **Managed projects without `KERNEL.md`** — `check-state`'s new resolution
  check is skipped; everything else is additive.
- **This repository** — the Kernel counterpart is `WORKFLOW.md`; this SPEC's
  own frontmatter carries the field, exercising the format once before any
  tool reads it.
- **No closed work is revisited.**

## Out of scope

- A `proposed` state on the `kernel:` lifecycle line — decided against.
- A separate delta file — decided against.
- Mechanical detection of Change Boundary crossing. The gate checks structure;
  whether a Change is semantic remains `plan`'s judgment, carried by
  `capture`'s contract.
- The general E-20260821-006 repair — `capture` covering *every* decision of a
  `plan` round. This SPEC closes the kernel-field instance only; the general
  case still needs its own `plan` (STATUS.md already lists it).
- `ontology-graph-pilot` — separate confirmed SPEC, untouched.
- Arranging slices before `spec-lifecycle` closes: this SPEC's scope
  (`WORKFLOW.md`, `skills/{capture,learn}`, `bin/spec-agents`) intersects that
  active SPEC's scope, so execution is sequenced after it (decided in the
  `plan` round; recorded as a blocker in `STATUS.md`).

## Issue map

Proposed for `arrange` once the blocker clears; not yet slices.

- `01-workflow-semantics.md`: `WORKFLOW.md` — Model delta as proposed Kernel
  delta, the absent-field default, cross-reference from the Change Boundary.
- `02-capture-contract.md`: `kernel_delta:` field format, mandatory-on-new,
  refusal when plan's `kernel_promotion` ≠ none and delta empty.
- `03-learn-promotion-match.md`: promotion-equals-declaration precondition and
  per-entry SPEC provenance.
- `04-cli-checks.md`: `gate do` structural refusals, `check-state` resolution
  check, fixtures for all three seams.
- `05-learn-record.md`: Evidence, ADR, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.

## Revision notes

- **r1** — created from the `plan` round of 2026-08-28. Routed `breaking`.
  Four decisions confirmed in that round: sequence after `spec-lifecycle`
  (capture now, execute later); frontmatter field plus Model delta prose,
  no prose-parsing and no second file; absent field reads as `none` with
  `capture` making the field mandatory on new SPECs; no `proposed` state on
  the kernel lifecycle — the SPEC lifecycle carries the proposal.
- **r2** — compatible revision, decided in `plan` on 2026-08-29 after an
  independent `check` of slice 04 found the `check-state` contract undefined
  for `retire` entries: a retired entry has no record to cite the SPEC. Chosen:
  absence is the resolution; provenance stays in the SPEC and Evidence.
  Rejected: a retired tombstone record in the Kernel (a changelog by another
  name, against ADR 0005), and skipping `retire` entries (a retirement that was
  never carried out would pass). No Kernel entry is added — the CLI's contracts
  are Instance (ADR 0007) and live in this SPEC, not in `WORKFLOW.md`.
