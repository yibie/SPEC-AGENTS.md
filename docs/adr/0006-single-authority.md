# ADR 0006: Make placement a checked property

status: accepted
date: 2026-08-24
scope: where a rule is allowed to live, and how the workflow verifies it
applies_when: arranging, executing, or verifying a change that touches a business rule
owner: project maintainer
source: E-20260824-008
verification: the three tells fire on each violation class from the reported incident

## Context

A managed project ran four consecutive batches through all six actions. Every
batch passed `plan`, `capture`, `arrange`, `do`, `check`, and `learn`, with unit
tests green and live replay verified. An independent reviewer found 15
multi-authority violations that had already diverged in behavior: one business
rule implemented in both Python and JavaScript returning different results for
the same input; one projection implemented fully in both a service and a store,
then drifting; derived state persisted twice; a store grown to 6000 lines of
business rules; a `TypeError` fallback left in production for a test stub.

Six gates passed and the result was wrong. No gate was skipped.

Three mechanisms in this repository explain the miss, and one of them was added
two days earlier.

The ontology-impact question asks whether a change added, altered, or retired a
concept, identity, relation, lifecycle, invariant, or Action Contract. A second
implementation of an existing rule adds none of these — the concept was already
in the Kernel. It answers "no". The question was written to catch a new concept;
it does not see a new site.

`check`'s contract axis asks whether code conforms to `KERNEL.md`. A duplicate
conforms to every concept, identity, relation, lifecycle, and invariant. It is
simply one more. Conformance checking is structurally blind to duplication.

`Architecture boundaries` in the Kernel template was one line — "a small number
of hard structural limits". Nothing said it records where a rule may live, so
nothing downstream could consult it.

The reporting project also observed what its own proposals omitted: the tests
were green because they sat at the same layer as the implementation. A test
co-located with an implementation cannot show the implementation is misplaced —
the test and the misplacement come from the same decision.

## Decision

`Architecture boundaries` becomes the authority map: for each rule that could
live in more than one place, the one module that owns it, named by path, with
any legitimate second site recorded and justified. This is the foundation; the
rest has nothing to check against without it.

Single authority constrains where a rule is decided, not what it decides. The
content of an authoritative rule stays revisable through `plan`.

Every slice declares `authority:`, or `n/a: <reason>`. `do` compares the target
site against the map before writing and returns to `plan` if it is not there.
`check`'s contract axis gains a named authority item with three tells. `check`
declares whether it ran in the context that executed `do`, and if so the
authority item requires positive evidence rather than absence of suspicion.

`docs/spec-agents/single-authority.md` records that the rule is not "never
duplicate", that divergence is the failure, and that a second site owes a
same-input equivalence test.

## Alternatives rejected

- **Make `authority:` conditional, like `writer:`.** Conditional returns the
  judgment "is this a business rule?" to whoever writes the slice, and that
  judgment is what failed in the incident. A forced answer is the interception.
- **Add placement as a fourth `check` axis.** Placement is a contract question —
  does the code sit where the Kernel says the rule lives — and the three tells
  are three symptoms of one condition. A fourth axis would dilute three that
  already work.
- **Mandate an independent `check`.** It is what actually found the 15
  violations, and it would make every small change expensive, including the
  short path added two days earlier. The blind spot is made visible instead:
  `check` declares its own independence and raises the bar on placement when it
  has none.
- **Forbid duplication outright.** Client-side validation beside server-side
  enforcement is legitimate and common. Forbidding it would push teams to route
  around the rule rather than record the second site.
- **Require batch-end independent review.** The reporting project's own
  proposal. `check` already runs per slice; batching it is a departure from the
  existing contract, not a gap in it.

## Consequences

Breaking. `arrange` may not emit a slice without `authority:`, and `do` may not
begin when the site is off the map. Closed slices are not back-filled, existing
Kernels are not required to add an authority map, and a re-scan reports its
absence as a gap.

The default mandatory read reaches exactly 400 lines, the ceiling set the day
before. The next addition to `AGENTS.md` or the workflow model must remove
something first.

This is the first external evidence in this sequence of changes. Everything
before it was this repository checking its own documents against each other. It
found a defect that self-consistency could not: the gates agreed with each other
and none of them measured placement.

The trial in the reporting project is still running and its result has not been
received. Nothing here is confirmed to work in the field yet.
