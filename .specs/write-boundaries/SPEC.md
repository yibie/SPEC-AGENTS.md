# Write boundaries, reference integrity, and Kernel shape

status: verified
revision: 1
context_refs: `docs/spec-agents/WORKFLOW.md`, `AGENTS.md`, `START.md`, `skills/`

## Problem and goal

A real session in a managed project spent three rounds of user questions on this
workflow, and two of those rounds were resolving the framework's own ambiguity
rather than any project decision. Reviewing it against this repository surfaced
four defects, and a fifth was found by inspecting the Kernel that session
produced.

**`Code` is undefined.** It appears in four relations — `Slice --do--> Code`,
`Code --check--> Verification`, `Project Kernel --constrains--> Code`,
`KnowledgeItem --constrains--> Code` — and in `do`'s description and completion
condition, but it is not a Core Concept. In a project with source code this is
harmless. In a project whose product is documents it is the ambiguity itself:
writing `docs/spec-agents/WORKFLOW.md` reads equally as "editing the product's
source" and as "promoting knowledge", and the framework offers no way to tell
them apart. Both of this repository's changes on 2026-08-20 wrote durable
knowledge records inside `do` slices without anyone noticing.

**Half of doctrine is unprotected.** The `do` prohibition at
`docs/spec-agents/WORKFLOW.md` names `docs/spec-agents/` but not `AGENTS.md`,
`START.md`, `UPGRADE.md`, or `skills/`, although all five are installed by the
installer and identical in every managed project. The session that prompted
this SPEC had arranged a slice to edit `skills/{plan,learn,arrange}/SKILL.md`
inside a managed project — editing upstream doctrine locally, which the next
install silently reverts.

**Nothing verifies that a reference still resolves.** Protocols, Runbooks, and
Lessons are required to name a source Evidence and a verification path, but no
action checks that those still point at something. Five instances appeared in
one day across two projects: doctrine records citing an `EVIDENCE.md` that is
not installed; 18 `spec_ref` fields dangling after a directory move; an archive
header stating a path that had changed hours earlier; seven `context_ref`
values whose meaning silently changed; and a Runbook reference left dangling by
a deleted file.

**`arrange` cannot detect an unsatisfiable slice.** A slice was arranged whose
verification required editing a file that its own Scope and the SPEC's
out-of-scope section both forbade. Three constraints interlocked, and nothing
caught it until `check`.

**The Kernel template omits two of the seven elements its own concept defines.**
`docs/spec-agents/WORKFLOW.md` defines a Project Kernel as recording concepts,
identities, relations, action contracts, lifecycles, invariants, and a small
number of architecture boundaries. The template in `START.md` has `Concepts`,
`Relations`, `Actions and invariants`, `Architecture boundaries`, and
`Source evidence`. Identity and lifecycle have no home, and the merged
`Actions and invariants` heading names two of an Action Contract's five fields,
so input and verification are dropped. In the Kernel that session produced, an
identity criterion and a version counter are filed as Concepts, and a
three-state candidate lifecycle is dissolved into three prose invariants.

Goal: define `Code`, protect doctrine, verify references, make an unsatisfiable
slice detectable at `arrange`, and make the Kernel template match its own
definition.

## Unchanged contracts

- The six action names, their order, and the shortest-valid-path rule.
- `KERNEL.md → SPEC → Slice → EVIDENCE.md` layering.
- The Doctrine/Instance boundary and the installer payload.
- `learn` remains the only action that promotes knowledge.
- Existing Kernels are not forced to restructure.
- No new action, and no formal ontology tooling.

## Decision and boundaries

### `Code`, and self-hosting

`Code` becomes a Core Concept: the artifact constrained by the SPEC, the
Kernel, and the Action Contracts. In an application project it is source,
tests, and configuration. In SPEC-AGENTS itself the product is doctrine — so
`AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, `docs/spec-agents/`, and
`bin/` are this repository's `Code`, and `do` writes them.

Knowledge *about* the product is not `Code` in either case. `docs/adr/`,
`docs/protocols/`, `docs/runbooks/`, `docs/lessons/`, `KERNEL.md`,
`CONTEXT.md`, `STATUS.md`, and `EVIDENCE.md` are Instance knowledge, and
`learn` writes them — including in this repository.

### Doctrine is immutable in a managed project

New invariant: in a managed project, no action writes installed doctrine. A
local edit is reverted by the next install and is invisible to every other
project; changing it means changing it upstream. This is stronger than the
current "not silently", and it is what makes an arranged slice that targets
`skills/` detectable as invalid.

### Reference integrity is a `check` axis

`check` currently fixes a baseline and checks two axes: the confirmed contract,
and engineering standards. A third axis is added: every reference the change
touches — `source`, `spec_ref`, `context_ref`, `evidence_ref`, relative links,
and quoted paths — must still resolve. Placing it in `check` rather than in
`learn` matters: three of the five observed breakages were produced during
`do`, and `learn` is too late to catch them cheaply.

### `writer:` and reachability

A slice whose Scope contains a file that `do` does not own must declare
`writer:` in its frontmatter. The requirement is conditional, so existing
slices that touch only code remain valid.

`arrange` gains a completion condition: each slice's verification must be
reachable within that slice's own Scope. A verification that requires writing
outside the Scope is a split error, not an execution problem.

### Kernel template

The template in `START.md` becomes eight sections matching the concept
definition:

```markdown
## Concepts
## Identities
## Relations
## Lifecycles
## Action Contracts
## Invariants
## Architecture boundaries
## Source evidence
```

Each Action Contract carries its five fields: precondition, input, permitted
effect, invariant, verification. An empty section is left in place with a note
that the scan found nothing confirmed — an absent axis must be visible.

Existing Kernels are not forced to restructure. A `start` rescan reports a
missing Identities or Lifecycles section under the report's gaps, and the user
decides. Restructuring for format alone does not advance the Kernel version.

## Model delta

- New Core Concept `Code`, with the self-hosting case stated.
- New invariant: installed doctrine is not written by any action in a managed
  project.
- New invariant: a slice's verification is reachable within its own Scope.
- `check` gains a third axis.
- `Slice` gains a conditional `writer:` field.
- The Kernel's documented shape gains `Identities` and `Lifecycles`, and
  `Actions and invariants` splits into `Action Contracts` and `Invariants`.

## Action Contracts

`do`:

- precondition: the slice is ready, its `blocked_by` are done, and its Scope
  contains only files `do` owns, or the slice declares a different `writer:`.
- permitted effect: write `Code`; update the slice's own status and
  verification summary.
- invariant: never write installed doctrine in a managed project; never write
  Instance knowledge records; leave `evidence_ref` empty.
- verification: `check`, including the reference-integrity axis.

`arrange`:

- permitted effect: create slices under `.specs/<feature>/issues/`.
- invariant: every slice's verification is reachable within its Scope; a slice
  touching a file `do` does not own declares `writer:`.
- verification: read each slice's Verification against its own Scope.

`check`:

- permitted effect: read-only.
- invariant: three axes — confirmed contract, engineering standards, reference
  integrity.
- verification: every reference the change touches resolves.

## Compatibility

`breaking`. `do`'s permitted effects narrow, `arrange` and `check` each gain a
completion condition, and the Kernel template changes shape.

- `docs/adr/0004-code-and-write-boundaries.md` records the decision.
- `UPGRADE.md` gains a section: detect locally modified installed doctrine,
  report it against the upstream copy, and hand the decision to the user. Never
  revert automatically — a local edit may encode a real need that belongs
  upstream.
- Existing slices without `writer:` stay valid unless they touch a file `do`
  does not own.
- Existing Kernels stay valid; `start` reports missing sections as gaps.

### Ratification owed

`docs/adr/0001-framework-namespace-split.md`,
`docs/adr/0002-retire-phase.md`, and
`docs/adr/0003-split-work-and-scratch.md` were written inside `do` slices on
2026-08-20. Under this SPEC an ADR is Instance knowledge and belongs to
`learn`. `learn` reviews each one and either ratifies or rejects it
individually; a single blanket approval is not acceptable. Content is not
reverted — the decisions were confirmed by `plan` and verified by `check`; only
their authorship contract was wrong.

## Verification

- `Code` is defined, and every relation that names it resolves to the
  definition.
- No live file states the `do` prohibition as an incomplete enumeration: all
  five doctrine paths appear together.
- `skills/check/SKILL.md` names three axes, and the third is reference
  integrity.
- `skills/arrange/SKILL.md` requires reachability and conditional `writer:`.
- `START.md`'s template has eight sections and the five Action Contract fields.
- The three ADRs are individually ratified in `EVIDENCE.md`, each with its own
  line.
- Installer smoke passes, including the leakage assertion.
- Every reference touched by this change resolves — the new axis applied to
  itself.

## Out of scope

- Restructuring any existing Kernel, in this repository or elsewhere.
- Reverting the content of ADR 0001, 0002, or 0003.
- Migrating any managed project, or reverting locally modified doctrine.
- Adding tooling, schemas, or automated Kernel generation.
- Changing the six action names or their order.

## Issue map

- `01-define-code.md`: `Code` concept and the self-hosting case.
- `02-doctrine-immutable.md`: the invariant and the entry documents.
- `03-check-reference-integrity.md`: the third axis.
- `04-arrange-guardrails.md`: `writer:` and reachability.
- `05-kernel-template.md`: eight sections, five Action Contract fields.
- `06-learn-ratify-and-record.md`: ratify the three ADRs individually, ADR
  0004, the `UPGRADE.md` section, Evidence, `STATUS.md`. `writer: learn`.
