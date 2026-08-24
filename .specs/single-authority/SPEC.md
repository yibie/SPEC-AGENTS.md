# Single authority: make placement checkable

status: verified
revision: 1
context_refs: `docs/spec-agents/WORKFLOW.md`, `START.md`, `skills/{arrange,do,check}`

## Problem and goal

A managed project ran four consecutive batches through the full six actions.
Every batch passed `plan`, `capture`, `arrange`, `do`, `check`, and `learn`,
with unit tests green and live replay verified. An independent reviewer at the
end found 15 multi-authority violations that had already diverged in behavior:
the same business rule implemented once in Python and once in JavaScript,
returning different results for the same input; the same projection implemented
fully in both a service and a store, then drifting; derived state persisted
twice; a store grown into a 6000-line dumping ground for business rules; a
`TypeError` fallback branch left in production to accommodate a test stub.

**Six gates passed and the result was wrong.** No gate was skipped. The gates
did not measure the thing that mattered.

Three places in this repository explain why.

The ontology-impact question added to `check` two days earlier asks whether the
change added, altered, or retired a concept, identity, relation, lifecycle,
invariant, or Action Contract. A second implementation of an existing rule adds
none of them — the concept was already in the Kernel. The answer is "no" and
`check` passes. The question was written to catch a *new concept*; it does not
see a *new site*.

`check`'s contract axis asks whether the code conforms to `KERNEL.md`. A
duplicate implementation conforms perfectly to every concept, identity,
relation, lifecycle, and invariant. It is simply one more of them. Conformance
checking is structurally blind to duplication.

`## Architecture boundaries` in the Kernel template is defined as "a small
number of hard structural limits" — one line. Nothing says it records where a
rule is allowed to live, so nothing downstream can consult it for placement.

The reporting project also observed something absent from its own proposals:
the unit tests were green because they were written at the same layer as the
implementation. **A test co-located with an implementation cannot show that the
implementation is in the wrong place** — the test and the misplacement are
consequences of the same decision, not independent of each other.

Goal: make "where does this rule live" a question the workflow asks before,
during, and after execution.

## Unchanged contracts

- The six action names, order, routes, and the two execution paths.
- The eight Kernel sections and per-entry `since:`/`source:`.
- The three `check` axes, four finding types, and the ontology-impact question
  — this SPEC adds to them, and removes nothing.
- `learn` remains the only promoter; `plan` remains the only gate on Kernel
  change.
- Existing Kernels are not required to back-fill.

## Decision and boundaries

### `## Architecture boundaries` becomes the authority map

This is the foundation; the rest has nothing to check against without it.

The section records, for each rule that could plausibly live in more than one
place, the **one module that owns it** — and, where a second site is
unavoidable, that it exists and why. It is not a list of aspirations. An entry
names a path.

Single authority constrains **where a rule is decided, not what it decides**.
The content of an authoritative rule remains freely revisable through `plan`.
Collapsing those two is how "single authority" turns into "frozen behavior",
which no one wants and which would make the map an obstacle rather than a tool.

Existing Kernels are not required to back-fill. A `start` re-scan reports a
missing or thin `Architecture boundaries` section as a gap.

### `authority:` on every slice

Every slice declares `authority:` — the module that owns the rule this slice
touches. A slice that neither introduces nor modifies a business rule writes
`n/a: <reason>`.

Required rather than conditional, deliberately. Making it conditional returns
the judgment "is this a business rule?" to whoever writes the slice, and in the
reported incident that judgment is exactly what went wrong. A forced answer is
the interception; `n/a` with a stated reason is a real answer, an omitted field
is not.

Closed slices are historical records and are not back-filled.

### `do` checks the map before writing

Before execution, `do` compares the slice's `authority:` against the Kernel's
authority map. If the intended site is not on the map, `do` stops and returns to
`plan` — either the map is incomplete, or the site is wrong, and neither is
`do`'s decision to make.

This is the preventive half. The incident's implementations were placed at the
layer where the symptom appeared, under pressure to fix fast with live evidence,
and the placement was never questioned because nothing asked.

### `check` verifies placement explicitly

The contract axis gains a named authority check with the three tells the
incident produced:

- new logic appearing at a second site for a rule that already has one;
- a client reimplementing a rule the server enforces;
- derived state persisted in more than one place.

Placed inside the contract axis rather than as a fourth axis: it is a contract
question — does the code sit where the Kernel says this rule lives — and the
three tells are three symptoms of one condition, not three separate concerns.

### `check` declares its independence

`check` states at the top whether it was performed by the context that executed
`do`. When it was, the authority check requires positive evidence rather than
absence of suspicion: name the site, name the map entry, show they match.

The 15 violations were found by an independent reviewer, not by self-review. A
context that chose a placement is structurally poor at auditing that placement —
it is checking its own decision. Independence is not mandated, because mandating
it would make every small change expensive; the blind spot is made visible
instead.

### Protocol: single authority and equivalence

New doctrine record `docs/spec-agents/single-authority.md`, covering what single
authority means, when a second site is legitimate, and what is owed when one
exists.

The rule is not "never duplicate". Some duplication is required — client-side
validation beside server-side enforcement is the common case. The rule is: **a
rule that exists in two places must carry a same-input equivalence test proving
they do not diverge.** Divergence, not duplication, is the failure; the incident
had both, and the divergence is what broke behavior.

The Protocol also records why green tests did not protect: tests written at the
implementation's own layer cannot detect that the layer is wrong.

## Model delta

- `Architecture boundaries` gains a definition: the authority map.
- `Slice` gains a required `authority:` field.
- `do` gains a precondition; `check` gains a named contract sub-check and a
  self-declaration.
- No new concept. Single authority is a property of the existing Kernel, made
  explicit and checkable.

## Compatibility

`breaking`. `arrange` may no longer emit a slice without `authority:`, and `do`
may no longer begin when the site is off the map.

- `docs/adr/0006-single-authority.md` records the decision.
- Closed slices are not back-filled; existing Kernels are not required to add
  an authority map, and a re-scan reports its absence as a gap.
- No managed project is migrated.

## Verification

- `START.md` defines `Architecture boundaries` as the authority map, states
  that an entry names a path, and states that single authority constrains where
  a rule is decided and not what it decides.
- `skills/arrange/SKILL.md` lists `authority:` as required and defines the
  `n/a: <reason>` form.
- `skills/do/SKILL.md` states the map comparison and the return to `plan`.
- `skills/check/SKILL.md` contains the named authority check with all three
  tells, and the independence declaration.
- `docs/spec-agents/single-authority.md` carries full Protocol metadata and
  states the equivalence requirement and the co-located-test finding.
- Every slice of this SPEC carries `authority:`.
- The three `check` axes, the ontology-impact question, installer smoke, and
  the ≤400-line default context all still hold.

## Out of scope

- Mandating independent `check`.
- Migrating any managed project, or back-filling any Kernel or closed slice.
- Prescribing a test framework or a specific equivalence-test shape.
- Forbidding duplication.

## Issue map

- `01-authority-map.md`: redefine `Architecture boundaries` in the Kernel
  template.
- `02-slice-authority.md`: the required `authority:` field.
- `03-do-map-check.md`: the `do` precondition.
- `04-check-authority.md`: the named contract sub-check and the independence
  declaration.
- `05-protocol.md`: `docs/spec-agents/single-authority.md`.
- `06-learn-record.md`: ADR 0006, Evidence, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.
