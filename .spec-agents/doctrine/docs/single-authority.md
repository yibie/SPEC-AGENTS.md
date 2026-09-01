# Single Authority

status: active
scope: any rule that could plausibly be implemented in more than one module, language, or layer
applies_when: introducing or modifying a business rule, a projection, a validation, or derived state
owner: project maintainer
source: upstream SPEC-AGENTS Evidence `E-20260824-008` (not an Evidence ID in this project)
verification: every rule that exists in two places has a same-input equivalence test; `check`'s authority item passes on the current diff

## What single authority means

Each rule has one module that owns it. That module is recorded in the project
Kernel's `Architecture boundaries` — the authority map — by path, on one fixed
line, with one of three states:

- `owned` — the project's semantic layer decides it.
- `source-backed` — a system of record owns it; the project writes through.
- `derived` — computed. It has no write path; persisting it is the defect.

`.spec-agents/doctrine/docs/check-kernel.sh` verifies the form of these entries and that
the paths exist. It does not verify that the map is complete or that its entries
are true — a map can be perfectly formed and wrong. That is what `check`'s
placement item is for.

Single authority constrains **where a rule is decided, not what it decides**.
The content of an authoritative rule stays freely revisable through `plan`.
Confusing the two turns single authority into frozen behavior, which is not the
goal and makes the map something to route around.

## The rule is not "never duplicate"

Some duplication is required. Client-side validation beside server-side
enforcement is the common case: the client copy exists for latency and feedback,
the server copy exists because the client cannot be trusted. Removing either one
is wrong.

**Divergence is the failure, not duplication.** A rule that exists in two places
and agrees is a cost. A rule that exists in two places and disagrees is a defect
that will surface as behavior no one can explain, because each site looks correct
in isolation.

## What a second site owes

A second site is legitimate only when all three hold:

1. the authority map records it, with the reason it is unavoidable;
2. one of the two is named as authoritative — the other is a copy, not a peer;
3. a **same-input equivalence test** exists, feeding identical inputs to both
   and asserting identical results.

The equivalence test is the only thing that makes duplication safe over time.
Without it, the two copies diverge on the first change that touches one and not
the other, and nothing fails until a user reports it.

This Protocol prescribes no test framework and no particular shape. Golden
fixtures shared by both implementations are the usual form. What matters is that
the same inputs reach both sites and the results are compared.

## Why green tests do not protect

A test written at the same layer as the implementation cannot show that the
layer is wrong. The test and the misplacement are two consequences of the same
decision, not independent of each other. A rule implemented in the wrong module,
with a unit test beside it, produces a green suite and a correct-looking commit.

This is why placement is checked by comparing against the authority map rather
than by running the tests, and why `check` asks about placement explicitly.

## Where it is enforced

- `arrange` — every slice declares `authority:`, or `n/a: <reason>`.
- `do` — compares the target site against the authority map before writing;
  if the map covers the rule and the site is elsewhere, it stops and returns
  to `plan`; if the map is absent or has no covering rule, it records a
  `semantic` finding and continues.
- `check` — the contract axis names the authority item, with three tells: a
  second site for a rule that already has one, a client reimplementing a
  server-enforced rule, and derived state persisted twice.
- `plan` — the only place the map itself changes.

A conflict between code and map is never resolved silently. Either the code
moves back to the authority, or the map is revised through `plan`.
