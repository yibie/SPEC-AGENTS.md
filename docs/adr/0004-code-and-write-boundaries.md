# ADR 0004: Define Code, protect doctrine, and verify references

status: accepted
date: 2026-08-20
scope: which action writes which file, what `check` verifies, and the shape of a project Kernel
applies_when: arranging a slice, executing one, verifying one, or bootstrapping a Kernel
owner: project maintainer
source: E-20260820-004
verification: the three-axis check applied to this change; installer smoke

## Context

A real session in a managed project spent three rounds of user questions on
this workflow. Two of those rounds resolved the framework's own ambiguity
rather than any project decision — the framework was charging the user for its
inconsistencies. Reviewing that session against this repository surfaced five
defects.

**`Code` was undefined.** It appeared in four relations and in `do`'s
description and completion condition, but was not a Core Concept. In a project
with source code that is harmless. In a project whose product is documents it
is the ambiguity itself: writing `docs/spec-agents/WORKFLOW.md` reads equally
as editing the product's source and as promoting knowledge. Both of this
repository's changes earlier the same day wrote ADRs inside `do` slices, and
neither `check` nor the author noticed, because two readings were available.

**Half of doctrine was unprotected.** The `do` prohibition named
`docs/spec-agents/` but not `AGENTS.md`, `START.md`, `UPGRADE.md`, or
`skills/`, although all five are installed and identical everywhere. The
session that prompted this ADR had arranged a slice to edit
`skills/{plan,learn,arrange}/SKILL.md` inside a managed project.

**Nothing verified that a reference still resolved.** Five breakages appeared
in one day across two projects: doctrine citing an `EVIDENCE.md` that is not
installed; 18 `spec_ref` fields dangling after a directory move; an archive
header naming a path that had changed hours earlier; seven `context_ref` values
whose meaning silently changed; and a Runbook reference orphaned by a deleted
file.

**`arrange` could not detect an unsatisfiable slice.** A slice was arranged
whose verification required editing a file that its own scope and the SPEC's
out-of-scope section both forbade. Nothing caught it until `check`.

**The Kernel template omitted two of the seven elements its own concept
defines.** The definition names concepts, identities, relations, action
contracts, lifecycles, invariants, and architecture boundaries. The template
had Concepts, Relations, Actions and invariants, Architecture boundaries, and
Source evidence. In the Kernel that session produced, an identity criterion and
a version counter are filed as Concepts, and a three-state lifecycle is
dissolved into three prose invariants. The merged `Actions and invariants`
heading named two of an Action Contract's five fields, and the other three were
absent.

## Decision

`Code` becomes a Core Concept: the artifact constrained by the SPEC, the
Kernel, and the Action Contracts. Whatever the product is made of is that
project's `Code`. In SPEC-AGENTS itself the product is doctrine, so the
doctrine documents and `bin/` are its `Code` and `do` writes them. Knowledge
*about* the product is never `Code`, in any project.

In a managed project, no action writes installed doctrine. This is stronger
than the previous "not silently" and is what makes a slice targeting `skills/`
refusable at `arrange`.

`check` gains a third axis: every reference the change touches must still
resolve. It sits in `check` and not in `learn` because three of the five
observed breakages were produced during `do`, where repair is cheap.

A slice whose scope contains a file `do` does not own declares `writer:`, and
every slice's verification must be reachable within its own scope.

The Kernel template becomes eight sections matching the definition one to one,
with each Action Contract carrying all five fields, and empty sections kept so
that a missing axis is visible.

## Alternatives rejected

- **Make `learn` the only writer of every durable document, with `do`
  producing drafts.** This was the route the managed-project session took, and
  it was the first proposal here. Rejected after the user pointed out that
  `do`'s object is `Code`, not the framework — the model already said
  `Slice --do--> Code`. The apparent four-way contradiction was an artifact of
  self-hosting, not a real conflict. Adopting the strict rule would also have
  forced every documentation edit through a `check` with nothing to verify.
- **Add `Code` without naming the self-hosting case.** Leaves the exact
  ambiguity that caused the problem, in the one repository where it bites.
- **List the five doctrine paths in the existing "not silently" prohibition.**
  Cheapest, but still permits a managed project to edit upstream files
  non-silently, which the next install reverts.
- **Put reference integrity in `learn`'s completion condition.** Too late:
  three of five breakages were produced in `do`, by which point the change has
  spread.
- **Require sub-fields inside the existing five Kernel sections instead of
  splitting them.** A missing sub-field is invisible; a missing section is not.
  Invisibility is the failure mode being fixed.

## Consequences

Breaking. `do`'s permitted effects narrow, `arrange` and `check` each gain a
completion condition, and the Kernel template changes shape. `UPGRADE.md` gains
a section that detects locally modified installed doctrine and reports it
against the upstream copy without reverting anything — a local edit may encode
a real need that belongs upstream.

Existing slices without `writer:` stay valid unless they touch a file `do` does
not own. Existing Kernels stay valid; `start` reports a missing `Identities` or
`Lifecycles` section as a gap, and restructuring for shape alone does not
advance the Kernel version.

The reference-integrity axis is a procedure with no automated enforcement. It
depends on whoever runs `check` actually running it. If it is skipped, the
failure is silent and looks exactly like the five breakages that motivated it.
