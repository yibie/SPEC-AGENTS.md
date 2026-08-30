# Put skills in the authority order and settle what it decides

status: confirmed
revision: 1
context_refs: `AGENTS.md`, `AGENTS_en.md`, `docs/spec-agents/single-authority.md`, `docs/spec-agents/knowledge-promotion.md`, `skills/do/SKILL.md`, `skills/learn/SKILL.md`, `docs/adr/0006`

## Problem and goal

`AGENTS.md`'s Document authority section orders eight sources for use when they
conflict. `skills/` is not among them. The same file says each action's read
list, write boundary, and completion condition live in
`skills/<action>/SKILL.md` — the real contract is unranked.

The omission is not academic. Two live contradictions currently resolve against
the contract `AGENTS.md` itself calls real.

**The authority map.** `docs/spec-agents/single-authority.md`, under "Where it
is enforced", says `do` "compares the target site against the authority map
before writing; a site not on the map stops and returns to `plan`".
`docs/adr/0006` states the same collapse in its Consequences: "`do` may not
begin when the site is off the map". `skills/do/SKILL.md:46-53` gives two cases
instead of one — a rule on the map whose target site is elsewhere stops, but a
missing map or an entry that covers nothing explicitly does **not** stop: record
the intended site, emit a `semantic` finding for `plan`, and continue. The skill
states its reason: existing Kernels are not required to back-fill the map, a
hard stop would freeze compliant projects, and a rule that stops work gets
routed around. The two-case version is the considered one, and the written order
gives the collapse the higher rank.

**Who may write the workflow model.** `skills/learn/SKILL.md:41` sends workflow
semantics to `docs/spec-agents/WORKFLOW.md`, and
`docs/spec-agents/knowledge-promotion.md:20` routes "Workflow semantic rule"
there while `:42` names `learn` the only promoter. `AGENTS.md`'s owner table
says `docs/spec-agents/` is written by "the installer only — no action writes
these". The self-reference exemption two lines below names `do`, not `learn`,
and the routing holds in managed projects too.

Goal: rank `skills/`, and settle both contradictions on the strength of that
rank rather than on which document a reader happens to open first.

## Unchanged contracts

- Every other position in the resolution order.
- `do` never modifies the authority map; `plan` is the only place it changes.
- `learn` remains the only action that promotes knowledge.
- Fresh evidence may challenge a durable rule but never silently overrides it.
- No published record is edited in place. A correction to an accepted ADR is
  made by a superseding record written by `learn`.

## Decision and boundaries

### The order gains one position

```text
AGENTS.md → skills/ → docs/spec-agents/ → KERNEL.md → CONTEXT.md and
docs/{adr,protocols,runbooks,lessons}/ → fresh verified EVIDENCE.md →
a confirmed .specs/<feature>/SPEC.md → STATUS.md → archive/ and legacy .phrase/
```

`skills/` sits directly below `AGENTS.md` because `AGENTS.md` already delegates
each action's contract there. A Protocol describes what the model is; a skill
describes what an action must do. When they disagree about an action, the
action's own contract governs.

### The authority-map conflict resolves to the skill

By the new rank this follows rather than being decided separately.
`docs/spec-agents/single-authority.md`'s `do` bullet is corrected to state both
cases exactly as `skills/do/SKILL.md:46-53` does.

`docs/adr/0006` is **not** edited. Its Consequences paragraph was accurate when
written. `learn` writes a superseding record naming that paragraph.

### `learn` may write the workflow model upstream only

In the SPEC-AGENTS repository the doctrine files are the product, so `learn` may
write `docs/spec-agents/WORKFLOW.md` there. In a managed project it may not: the
next install overwrites the file, so the write is lost rather than merely
disallowed, and the change belongs upstream (ADR 0001).

`knowledge-promotion.md:20` gains that qualifier. The owner table's first row
names the exception instead of claiming no action writes the directory.

## Model delta

| | before | after |
| --- | --- | --- |
| authority order | eight positions, `skills/` absent | nine; `skills/` second |
| `do` off-map behaviour | Protocol and ADR say stop; skill says two cases | two cases, in both places |
| `learn` → `WORKFLOW.md` | routed by one document, forbidden by another | allowed upstream, forbidden in managed projects |

## Action Contracts

- **`do`** — unchanged behaviour. Its two-case rule becomes the only statement
  of that rule.
- **`learn`** — may write `docs/spec-agents/WORKFLOW.md` in this repository
  only. Elsewhere unchanged.
- **`plan`** — unchanged; still the only place the authority map changes.
- No gate or CLI behaviour changes.

## Seams and verification

- `AGENTS.md` and `AGENTS_en.md` both list `skills/` in the Document authority
  order, and the two blocks are byte-identical.
- `single-authority.md`'s `do` bullet states both cases and no longer contains
  an unqualified "a site not on the map stops".
- A new record under `docs/adr/` carries `supersedes:` naming ADR 0006's
  Consequences paragraph, and `docs/adr/0006-single-authority.md` is unchanged.
- `knowledge-promotion.md:20` carries the upstream-only qualifier, and the owner
  table's first row names the exception.
- `tests/doctrine-check.sh` passes; the mandatory read stays at or under 400
  lines. Adding a position to the order costs one line, so a removal may be
  needed first.

## Compatibility and migration

**Compatible.** No data contract, interface, or invariant changes. The change
names which of two already-contradictory rules wins; nothing that was
self-consistent becomes inconsistent.

- Managed projects installed before this change keep working. A project that
  followed the Protocol's stricter reading was stopping more often than
  required, never less.
- No slice, SPEC, or Kernel is back-filled.
- Existing `semantic` findings raised under the old wording remain valid.

## Out of scope

- Whether the resolution order should become a table keyed by question type
  rather than a single chain. It was raised in the same `plan` round and not
  chosen; it needs its own `plan`.
- The SPEC lifecycle and terminal state — `.specs/spec-lifecycle/SPEC.md`. This
  SPEC is sequenced after it; their scopes intersect at `skills/`.
- `CONTEXT.md` reference guards and CLI shipping —
  `.specs/reference-existence/SPEC.md`, sequenced after this one.
- Editing ADR 0006 or any accepted record in place.

## Issue map

- `01-authority-order.md`: insert `skills/` into the Document authority order in
  `AGENTS.md` and `AGENTS_en.md`.
- `02-single-authority-two-cases.md`: correct the `do` bullet in
  `docs/spec-agents/single-authority.md`.
- `03-learn-workflow-scope.md`: upstream-only qualifier in
  `knowledge-promotion.md`; owner-table exception in both `AGENTS` files.
- `04-learn-record.md`: superseding ADR, Evidence, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.

## Revision notes

- **r1** — created from the `plan` round of 2026-08-27. Routed
  `compatible revise`. The rank of `skills/`, the upstream-only scope for
  `learn`, and the decision that the map conflict follows from the rank rather
  than being adjudicated separately were all settled in that round.
