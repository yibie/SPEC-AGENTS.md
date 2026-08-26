# SPEC-AGENTS Start Review

Use this entry prompt when a project is new to SPEC-AGENTS, when its current
cognition is missing or stale, or when the user says `start` / `/start`.

Run it with:

```text
Read START.md and execute the start review.
```

`start` is a bootstrap entry, not a seventh action. Its job is to inspect,
record the first stable project Kernel, report what remains uncertain, and hand
the project to `plan`. The normal loop remains:

```text
plan → capture → arrange → do → check → learn
```

## 1. Read the minimum available context

Read `AGENTS.md`, `docs/spec-agents/WORKFLOW.md`, `CONTEXT.md`, and
`STATUS.md` when they exist.
Read `KERNEL.md` when it exists; it is the project's semantic model, not a
replacement for `docs/spec-agents/WORKFLOW.md`.
Read `EVIDENCE.md` only when the current state or a failed assumption needs it.
Read `UPGRADE.md` when legacy markers are present. Do not load the entire
history tree by default.

Missing `KERNEL.md` is a bootstrap condition, not permission to skip the
project's stable semantics. If the code exposes enough directly confirmed
concepts, relations, actions, or invariants, create the first `KERNEL.md`
before writing the report. Do not invent unknowns and do not overwrite an
existing Kernel.

## 2. Classify the project state

Use this routing order:

| State | Evidence | Route |
| --- | --- | --- |
| `legacy` | v2/v3 markers such as `.phrase/`, `spec_*`, `plan_*`, or `task_*` | `UPGRADE.md` |
| `mixed` | legacy markers and modern root documents both exist | `UPGRADE.md` with the conflict called out |
| `modern` | modern root documents exist and no legacy markers are active | `plan` after the Kernel bootstrap/report |
| `missing-entry` | `START.md` exists but modern root documents are missing | installation guidance, then rerun `start` |
| `blocked` | state or ownership cannot be established safely | stop at the report and ask the user |

Do not use a filename alone as proof of project behavior. Record the paths and
the facts they support.

Also record the version-control marker without changing it:

- `.jj/`: JJ is the local version-control interface;
- `.git/` without `.jj/`: preserve the Git-only workflow;
- neither: record that version history is unknown;
- never run `jj git init --colocate`, create a bookmark, or push during `start`.

Record the Kernel marker separately:

- existing `KERNEL.md`: this is a **re-scan** — see below;
- absent `KERNEL.md` with stable code facts: create `KERNEL.md` version `K1`;
- absent `KERNEL.md` without stable facts: report `kernel-unavailable` and stop;
- never replace an existing Kernel during `start`.

### Re-scan

`start` may be run again on a project that already has a Kernel, and should be
when the Kernel may no longer describe the system. Nothing else scans reality:
`check` compares code against the Kernel and never the reverse, so without a
re-scan a Kernel can drift for months while every check passes.

A re-scan writes nothing to `KERNEL.md` — not a section, not a field, not a
provenance line. `KERNEL.md` is byte-identical afterwards. It writes only
`.scratch/start/REPORT.md`, and it produces a `KernelStatus`:

- `present` — the scan agrees with every enacted entry;
- `stale` — entries the scan can no longer support, or that the code has moved
  past;
- `contradicted` — the code directly contradicts an enacted entry.

The difference report lists three things: entries the scan no longer supports,
concepts and contracts the code has that the Kernel does not, and entries
missing `since:` or `source:`.

The re-scan routes nothing itself. It hands the differences to the user, who
decides what goes to `plan`. Kernel evolution passes `plan` — a scan is not a
decision.

## 3. Reconstruct a bounded project picture

Inspect only the area relevant to the current project entry. Record findings
as `confirmed`, `inferred`, or `unknown`:

- recent project history and current work;
- entry points, modules, packages, storage and external boundaries;
- concepts, identities, relations, lifecycle states, and invariants visible in
  the code;
- current coding, testing, operational, and recovery conventions when they
  are observable;
- dirty work, blockers, and facts that require user confirmation.

Do not refactor, format, add dependencies, or fix unrelated findings. The
initial Kernel is limited to stable facts directly supported by the scan; it
does not include inferred or unknown claims.

## 4. Bootstrap the Kernel and write the report

When `KERNEL.md` is absent and the scan has enough confirmed facts, create it
with this minimum shape:

```markdown
# Project Kernel

status: enacted
version: K1
scope: <project>
source: START scan (<paths>)
verified_at: <date>
confidence: confirmed-only

## Concepts
## Identities
## Relations
## Lifecycles
## Action Contracts
## Invariants
## Architecture boundaries
## Source evidence
```

The eight sections correspond one to one with what a Project Kernel records.
Keep them distinct:

- **Concepts** — what kinds of things exist. Not "how you tell two apart".
- **Identities** — what makes one instance that instance: the authoritative
  key, its parts, and what is *not* authoritative. An identity criterion filed
  under Concepts reads as a concept and stops constraining anything.
- **Relations** — typed edges between concepts.
- **Lifecycles** — the states a thing moves through and the transitions that
  are allowed. A lifecycle dissolved into prose invariants leaves the reader to
  reassemble the state machine.
- **Action Contracts** — one per observable action, each with all five fields:
  precondition, input, permitted effect, invariant, verification. A heading
  that names only some of the fields is why the others go missing.
- **Invariants** — what must hold regardless of action.
- **Architecture boundaries** — the authority map. For each rule that could
  plausibly live in more than one place, the one module that owns it, named by
  path. Where a second site is unavoidable, record that it exists and why. An
  entry names a path, not an aspiration.

  Single authority constrains **where a rule is decided, not what it decides**.
  The content of an authoritative rule stays freely revisable through `plan`;
  collapsing those two turns single authority into frozen behavior and makes
  the map an obstacle instead of a tool.

  Each entry is one fixed line, so a script can read this section:

  ```markdown
  ## Architecture boundaries

  - <rule name> — authority: `<path/to/module>` | owned
  - <rule name> — authority: `<path/to/module>` | source-backed
    second site: `<path>` (<why it is unavoidable>; equivalence test: `<path>`)
  - <rule name> — authority: `<path/to/module>` | derived
  ```

  The state after the pipe says who decides:

  - `owned` — this project's semantic layer decides it; nothing outside supplies
    it.
  - `source-backed` — a system of record owns it. The project may read and write
    through, but the source governs.
  - `derived` — computed from other state. **It has no write path**, and
    persisting it anywhere is the defect. A `derived` entry never carries a
    second site.

  `derived` has to be written down. In a running system, derived state is
  protected by absence — nothing declares it writable, so nothing can write it.
  A prose map has no such mechanism: absence there means nobody thought about
  it. Stating it converts a silent omission into a stated prohibition.

  This is a fixed line inside a Markdown document, not a schema. The Kernel is
  still written and read by people, and no other section gains machine-required
  structure. `docs/spec-agents/check-kernel.sh` reads this section and nothing
  else.

  An existing Kernel is not required to back-fill this section. A re-scan
  reports a missing or thin authority map as a gap.
- **Source evidence** — the code paths, tests, and records each claim rests on.

Every enacted entry carries its own provenance:

```markdown
### <entry name>

since: K1
source: `<path/to/file.py:NNN>`; `E-YYYYMMDD-NNN`

<what this entry states>
```

`since:` is the Kernel version at which this entry's *current meaning* was set.
It points into the file's version sequence; it is not a second version counter.
A revision that only re-anchors `source` leaves every `since:` untouched, which
correctly reads as "the file was revised, no meaning changed".

`source:` names what admitted the entry: a code path, a test, an Evidence ID, or
an ADR. This is the field that matters, because every Kernel change passes
`plan` — `source:` is where that decision stays visible.

There is no per-entry version number and no changelog inside the file. Git
already gives per-line history through `git log -L` and `git blame`; a changelog
would duplicate it and rot. What git cannot give is which decision admitted an
entry, and that is what `source:` carries.

An existing Kernel is not required to back-fill these fields. A re-scan reports
entries missing provenance as a gap.

Only facts directly confirmed by code, configuration, tests, or existing
durable project records belong in the enacted sections. Candidate meanings,
conflicts, and unknowns stay in `REPORT.md` until the user decides how to
handle them.

Keep an empty section rather than deleting it, with one line saying the scan
found nothing confirmed for it. A missing axis must be visible: an absent
`Identities` or `Lifecycles` section reads as "this project has none", which is
almost never true.

When `KERNEL.md` already exists, do not restructure it. Report a missing
`Identities` or `Lifecycles` section under the report's gaps and let the user
decide. Restructuring for shape alone does not advance the Kernel version — a
version records a change in what the project means, not in how it is laid
out.

Create or update `.scratch/start/REPORT.md` with:

```markdown
# Start Review

## Project state
## Version-control state
## Recent history
## Current architecture
## Kernel bootstrap
## Candidate project cognition
## Existing knowledge and gaps
## Conflicts and unknowns
## Proposed route
## Questions for the user
## User decision
```

Before confirmation, the only project-specific writes allowed are the report
and a new `KERNEL.md` created by the bounded bootstrap above. Do not overwrite
an existing Kernel, change application code, dependencies, configuration,
repository history, or legacy files. Ask the user to confirm, revise, or reject
the candidate additions and route; the confirmed K1 remains the project's
initial stable floor.

## 5. Continue only after confirmation

Record the user's decision in the report, then follow exactly one route:

- `modern`: enter `plan` to review or extend K1 before the first requested
  change. Do not jump directly to `do`.
- `legacy` or `mixed`: read and execute `UPGRADE.md`. Do not create a second
  migration process in the Start prompt; preserve the bootstrapped K1 while
  the upgrade reconciles legacy knowledge.
- `missing-entry`: ask the user to run `spec-agents init/install`, then rerun
  `start`; preserve a newly created K1 if the scan had enough confirmed facts.
- `blocked`: keep the report, state the blocker, and wait for user direction.

`start` is complete only when `.scratch/start/REPORT.md` contains the state,
Kernel status/version, evidence, user decision, selected route, and next
permitted action. On a re-scan it must also contain the difference report, and
`KERNEL.md` must be unchanged. A project with enough stable facts must also have an enacted
`KERNEL.md` version `K1`; this does not claim that the project is fully
migrated or that application work is complete.
