# Make the approve short path executable

status: verified
revision: 1
context_refs: `.spec-agents/doctrine/docs/WORKFLOW.md`, `AGENTS.md`, `.spec-agents/doctrine/skills/plan`, `.spec-agents/doctrine/skills/do`, `.spec-agents/doctrine/skills/check`

## Problem and goal

`AGENTS.md` documents three routes out of `plan`, and one of them cannot be
executed as written.

`skills/plan` routes `approve` with "语义不变，直接交给 `do`" and produces no
artifact. `skills/do` then requires "一个目标 issue", an issue status of
`ready`, and a SPEC that is not `stale`. `skills/check` lists the issue as a
required input to its comparison baseline. On the `approve` path there is no
SPEC and no issue, so none of those preconditions can hold.

An agent on this path has two options and both are bad. Ignore `do`'s contract,
or invent an issue for a small change — which manufactures exactly the artifact
this framework is built to resist. `ticket` appears five times in the doctrine
and every one is adversarial: "Never let a ticket silently redefine the model."
The second option looks more compliant, so it is the more likely one.

A second inconsistency sits on the same route. `AGENTS.md` calls it "settled
small change"; `skills/plan` calls it `approve`, defined as "语义不变". Those
are different tests. A semantically neutral large refactor passes the second
and fails the first, and it is precisely the case where having no artifact
hurts most.

Goal: give the short path a contract that can be satisfied, without giving it a
ticket.

## Unchanged contracts

- The six action names, their order, and the three routes out of `plan`.
- The `Slice` concept and its fields.
- The SPEC path: `capture → arrange → do → check → learn` is untouched.
- The Doctrine/Instance boundary, the write boundaries, and the three-axis
  `check`.
- `learn` is already path-agnostic and does not change.

## Decision and boundaries

### `approve` gets a two-part test

`approve` requires both: the change leaves semantics unchanged, **and** it can
be completed within the current context. A semantically neutral change that
cannot be finished in one context goes to `capture`, because what it needs is a
handoffable contract, not a semantic gate.

`AGENTS.md`'s "settled small change" is restated to match. Size is not the
test — "small" cannot be judged objectively, and the Change Boundary already
says a small diff can still be a semantic change.

### `approve` must output two things

Routing to `do` with nothing is what broke the path. `approve` now carries:

- **the contract that stays unchanged** — the invariant, interface, or data
  contract `do` must not disturb;
- **how it is done** — one verifiable acceptance sentence that `check` can
  compare against.

Both are stated to the user at routing time. Neither is a file.

### The carrier is conditional

Default: no artifact. The confirmation is verbal, the trace is in version
control, and nothing is filed.

When `plan` judges that the work may outlive the current context — a long
change, an uncertain environment, anything a handoff would strand — it records
one entry in `STATUS.md` with scope, the acceptance sentence, and the next
permitted action. `learn` removes it when the work closes.

The condition is deliberate. Always filing turns every typo fix into a ticket;
never filing strands the next context when a session ends mid-change.

### `do` and `check` branch on the path

`do`'s preconditions split: the SPEC path keeps the issue checks; the short
path confirms that `plan` returned `approve`, that the unchanged contract and
acceptance sentence are known, and that the work is still single-context. If it
stops being single-context during execution, `do` returns to `plan` rather than
inventing a SPEC.

`check`'s comparison baseline splits the same way. On the short path the
contract axis compares against the acceptance sentence plus `KERNEL.md`,
Protocol, and `AGENTS.md`. The engineering and reference-integrity axes are
unchanged.

Neither action creates an issue on the short path. `arrange` remains the only
creator of slices.

### Terminology

`Slice` is the concept; `issues/` is where one is filed. Prose across the six
skills uses "issue" 26 times against 15 for `Slice`, and `do`'s entire
precondition block is written in the filename. Converge: the concept is written
`Slice`, and a file is referred to by its full path. Without this, the repaired
preconditions would still be phrased in the drifted term.

## Model delta

- `Plan`'s definition gains the two-part `approve` test and the two required
  outputs.
- No new concept. `Slice` is unchanged; only prose that drifted to `issue` is
  corrected.
- `State` gains an explicit note that a short-path entry is conditional and
  removed on completion.

## Action Contracts

`plan`, routing `approve`:

- precondition: semantics unchanged, and the work completes in one context.
- permitted effect: state the unchanged contract and one verifiable acceptance
  sentence; optionally add one `STATUS.md` entry when the work may outlive the
  context.
- invariant: never create a SPEC or a slice on this route.
- verification: `do` can begin without reading a file that does not exist.

`do`, short path:

- precondition: `plan` returned `approve`; the unchanged contract and the
  acceptance sentence are known.
- permitted effect: write `Code`.
- invariant: create no issue; if the work stops being single-context, stop and
  return to `plan`.
- verification: `check` against the acceptance sentence.

`check`, short path:

- precondition: the acceptance sentence is known.
- invariant: all three axes still run; the contract axis compares against the
  acceptance sentence, `KERNEL.md`, Protocol, and `AGENTS.md`.

## Compatibility

`compatible`. The SPEC path is unchanged in every respect. The short path moves
from unsatisfiable to executable, which cannot break existing work. `approve`
gains two required outputs — a narrowing that only affects a route nobody could
correctly execute before.

No migration is needed, and no ADR: this repairs a contract to match the
documented model rather than changing the model. The reasoning is recorded in
`EVIDENCE.md`.

## Verification

- `skills/do` and `skills/check` each state preconditions for both paths, and
  neither demands a file the short path does not create.
- `skills/plan` states the two-part `approve` test and both required outputs.
- `AGENTS.md` and `AGENTS_en.md` describe the route with the same test as
  `skills/plan`.
- No skill refers to the concept as "issue"; `Slice` is used for the concept
  and full paths for files.
- The three-axis check applied to this change: every reference resolves.
- Installer smoke passes.

## Out of scope

- Changing the three routes, the six actions, or the `Slice` concept.
- Adding any artifact to the short path beyond the conditional `STATUS.md`
  entry.
- Renaming the `issues/` directory.
- Revisiting the write boundaries or the Kernel template.

## Issue map

- `01-approve-contract.md`: the two-part test and the two outputs in
  `skills/plan`, plus the conditional `STATUS.md` entry.
- `02-do-and-check-paths.md`: branch the preconditions in `skills/do` and
  `skills/check`.
- `03-entry-documents.md`: `AGENTS.md`, `AGENTS_en.md`, `README.md`.
- `04-terminology.md`: converge `Slice` versus `issue` across the six skills.
- `05-learn-record.md`: Evidence and `STATUS.md`. `writer: learn`.
