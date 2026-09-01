# Turn the six actions into gates

status: verified
revision: 2
context_refs: `AGENTS.md`, `.spec-agents/doctrine/bin/spec-agents`, `.spec-agents/doctrine/skills/`, `docs/adr/0006`

## Problem and goal

This repository holds 68 slices across 12 SPECs. Five SPECs have every slice
`done` while their own status is still `confirmed` or `revised`. Nothing has
ever detected this; the state is maintained by an agent remembering to edit a
field.

The number was arrived at on the fourth attempt. A hand-written grep reported
twelve, of which seven were false positives from a pattern that did not match a
variant field format. The first version of the checker reported sixty-two,
because it applied `authority:` to slices that ADR 0006 explicitly exempts. The
second reported twelve, because it resolved `spec_ref` only from the repository
root while seven older slices write it relative to the slice.

Three wrong counts in one afternoon, each confidently produced. That is a
stronger argument for the tool than any drift it found: the drift was small, and
the hand-counting was not reliable at all.

Four independent sources reached the same conclusion in three days, each from a
different direction. A skills collection whose 24 skills are all on-demand with
one router. A runtime where preconditions are functions it calls. An independent
review: "making a rule visible everywhere is not the same as making it
executable." And a CLI whose `AGENTS.md` is five lines, four of them pointers,
because the workflow lives in a binary that emits it on demand.

The answer here has been to compress prose — 586 lines to 399, and called a win.
The other four answers were all to stop putting it in prose.

Goal: give every action an entry point that can refuse.

## Decision and boundaries

### The CLI provides gates, not text

`skills/<action>/SKILL.md` remains the single authority for what an action means
and how to perform it. The CLI does not print it. A CLI that emitted the same
prose would be a second authority for one rule, which is the failure
`docs/spec-agents/single-authority.md` exists to prevent.

What the CLI adds is the part prose cannot do: it checks preconditions before
work starts and invariants before state changes, and it refuses with a reason.

```text
spec-agents status                    active SPECs, slice states, and any drift
spec-agents check-state [--all]       every invariant across .specs/, exit 1 on violation
spec-agents ready                     slices whose blocked_by are satisfied
spec-agents gate <action> [target]    verify an action may begin; refuse with the reason
spec-agents transition <slice> <state>  change state after checking the invariants for it
```

`gate` is the six actions' entry point. `spec-agents gate do <slice>` refuses
when the slice is not `ready`, when a `blocked_by` is unfinished, when `writer:`
is not `do`, or when `authority:` does not match the Kernel map. The agent then
reads `skills/do/SKILL.md` and performs the work. The gate says whether it may
begin; the skill says what to do.

### Invariants the tool enforces

Every one of these is already stated in doctrine and none was ever checked:

- a slice may not be `done` without `evidence_ref`;
- a slice may not be `doing` while a `blocked_by` is unfinished;
- a SPEC whose slices are all `done` is not `confirmed`;
- a slice carrying a file `do` does not own declares `writer:`;
- every slice declares `authority:`;
- `spec_ref` and `context_ref` resolve;
- `STATUS.md` names only SPECs that exist.

### `AGENTS.md` retreats

Once an agent can ask the tool what it may do, `AGENTS.md` stops explaining the
workflow and points at it. What stays is what must be true before any tool runs:
who owns what, the document authority order, and the safety boundary.

The retreat is conditional on the tool being present. `AGENTS.md` states that
when `spec-agents` is unavailable the skills are read directly and the gates are
checked by hand — the workflow degrades, it does not disappear.

### Bash, and no new dependency

The installer is bash and the payload is Markdown plus one shell script. A
managed project needs nothing installed. That is a real distribution advantage
over the tools this borrows from, one of which requires an OCaml toolchain.

Bash is a poor language for a state machine and this will show. The cost is
accepted because the alternative cost — every managed project installing a
runtime — is paid by more people more often.

### State stays in frontmatter

`transition` edits the field and validates the invariants for the target state.
Slice files do not move. Encoding state in the path would make `ls` a query and
make an inconsistent state unrepresentable, but it would also rewrite 68 file
locations and turn every transition into a rename, diluting the history of
files whose content is the record.

### The five existing drifts are repaired

Five SPEC statuses move to `verified` where every slice is `done`.

`spec_ref` is written two ways across the repository — repo-root-relative in
recent slices, slice-relative in older ones. Neither is wrong and the checker
accepts both, but `skills/arrange/SKILL.md` never said which to use. That is
recorded as a finding rather than repaired here; picking one is a change to the
slice format and belongs to its own `plan`.

## Model delta

No concept changes. The tool enforces invariants that already exist and adds no
rule of its own. `Action Contract` gains a machine-checkable half for the six
actions; the semantic half is unchanged.

## Compatibility

`breaking`. `AGENTS.md` stops carrying the workflow, and an agent that ignores
both the tool and the skills has less than before. Existing slices and SPECs
remain valid — the tool reports violations rather than rejecting the files.

`docs/adr/0007-workflow-cli.md` records the decision.

## Verification

- `spec-agents check-state` finds the five known drifts before repair and none
  after.
- Two checker defects found during construction are recorded: `authority:`
  applied outside ADR 0006's stated scope, and `spec_ref` resolved from only one
  of the two conventions in use.
- `spec-agents gate do <slice>` refuses each precondition violation, proven with
  fixtures rather than asserted.
- `spec-agents transition <slice> done` refuses without `evidence_ref`.
- `bash -n` passes; the installer smoke passes; `tests/doctrine-check.sh` passes.
- No CLI output duplicates skill prose — checked by comparing what the CLI
  prints against `skills/*/SKILL.md`.
- The mandatory read is smaller than 374 lines and the tool's absence is
  documented as a degraded mode, not a failure.

## Out of scope

- Printing skill prose from the CLI.
- Moving slice files, or changing the slice or SPEC format.
- Any language other than bash, and any new runtime dependency.
- Automating `learn`'s judgment, `plan`'s interrogation, or `check`'s three axes
  — those are reasoning, and a gate cannot perform them.

## Issue map

- `01-state-model.md`: frontmatter reader and the invariant set.
- `02-check-state.md`: `status`, `check-state`, `ready`.
- `03-gate.md`: `gate <action>` and its refusals.
- `04-transition.md`: `transition` with per-state invariants.
- `05-repair-drift.md`: the twelve existing violations.
- `06-agents-retreat.md`: `AGENTS.md` points at the tool.
- `07-learn-record.md`: ADR 0007, Evidence, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.
