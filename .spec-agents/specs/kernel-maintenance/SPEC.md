# Kernel maintenance: detection, provenance, re-scan

status: verified
revision: 1
context_refs: `.spec-agents/doctrine/docs/WORKFLOW.md`, `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/skills/check`, `.spec-agents/doctrine/skills/learn`

## Problem and goal

The Kernel is read by five actions and written by one, and every one of those
relationships is one-directional. Code must conform to the Kernel; nothing ever
asks whether the Kernel still conforms to the code. A project running for
months can have a K1 that no longer describes its system, and every `check`
will pass — because `check` uses the Kernel as the ruler, never as the measured
thing.

The process gate is not the problem. Three documents already state that any
Kernel evolution passes `plan`: `docs/spec-agents/WORKFLOW.md`,
`skills/learn/SKILL.md`, and `AGENTS.md`. The gate is intact.

What is broken is the route to it. `check`'s findings are `blocker`,
`required`, and `suggestion`, and all three return to `do`. A conflict between
code and the Kernel can only be filed as `blocker` — "violates an invariant" —
which sends it back to change the code. A finding cannot leave `check` in the
direction of `plan`. The gate is reachable in principle and unreachable in
practice.

The capture path has the same shape. `skills/learn/SKILL.md` says that a
verified project concept, identity, relation, lifecycle, or invariant is
promoted to `KERNEL.md` after `plan` confirms it, so the path exists. But
nothing detects that a change touched the ontology. `check`'s contract axis
asks the reverse question — does the code conform to the Kernel — and `do`
stops only when it happens to notice a conflict. A change that introduces a
concept the Kernel does not contain violates nothing and is silently invisible.

Separately, the Kernel's provenance is entirely file-level: `version`,
`source`, `verified_at`, and `confidence` sit in the frontmatter and nothing is
recorded per item. Reading a Kernel, you cannot tell which entry is new, which
has been stable since K1, or which `plan` round admitted it.

Goal: make ontology drift detectable, make each Kernel entry say where it came
from, and give the Kernel a re-scan that reports without rewriting.

## Unchanged contracts

- Every Kernel change passes `plan`. No action writes `KERNEL.md` without it,
  and `learn` remains the only writer.
- The eight-section Kernel shape from `docs/adr/0004`.
- The six action names, their order, and the two execution paths.
- `check` stays read-only.
- The first `START.md` scan still creates K1 from confirmed facts only, and
  still never overwrites an existing Kernel.

## Decision and boundaries

### `check` gets a fourth finding that routes to `plan`

`blocker`, `required`, and `suggestion` return to `do`. A fourth, `semantic`,
returns to `plan`. The routing destination is part of the finding type, so it
does not depend on the reader inferring it.

`check` does not adjudicate. It never decides whether the code or the Kernel is
wrong — that is `plan`'s job, and deciding it inside `check` would bypass the
gate. A `semantic` finding states what was observed and which Kernel entry it
bears on, and stops.

### `check` asks one question every time

After the three axes, `check` answers, in writing:

> Did this change add, alter, or retire a concept, identity, relation,
> lifecycle, invariant, or Action Contract?

All six categories are considered, and a "no" is recorded rather than omitted.
An unrecorded answer decays into silence, and silence is the current failure.
A "yes" produces a `semantic` finding.

This one question implements both halves: the ontology-capture requirement, and
the route to the gate that already exists.

### Per-item provenance

Each enacted Kernel entry carries two fields:

```text
since: K2          the Kernel version at which this entry's current meaning was set
source: E-… / ADR-…   the Evidence or decision that admitted it
```

No per-item version counter and no in-file changelog. Version numbers stay at
file level. Git already provides per-line history through `git log -L` and
`git blame`; an in-file changelog would duplicate what git gives and rot, while
carrying nothing git does not. What git cannot give is which `plan` round and
which Evidence admitted an entry — that is what `source:` carries, and it is
what the process gate makes load-bearing.

`since:` is a pointer into the file's version sequence, not a parallel counter.
A revision that changes only provenance bumps the file version while every
entry keeps its old `since:`, which correctly reads as "the file was revised,
no meaning changed".

Existing Kernels are not required to back-fill. A `start` re-scan reports
missing per-item provenance as a gap.

### `start` is re-runnable as a re-scan

`start` may be run again on a project that already has a Kernel. On that run it
writes nothing to `KERNEL.md`. It produces a `KernelStatus` — `present`,
`stale`, or `contradicted` — and a difference report listing entries the scan
no longer supports, entries the code has that the Kernel does not, and entries
with missing provenance. The user decides what to route to `plan`.

`KernelStatus` already defines `stale` and `contradicted`
(`docs/spec-agents/WORKFLOW.md`), and `skills/plan/SKILL.md` already has a
`kernel_status:` field with those values. Nothing produced them. The re-scan is
what produces them.

### Kernel lifecycle: provenance re-anchoring

A revision that only re-anchors `source` — enacted meaning unchanged — is still
a revision and advances the file version. This decision was made in the `plan`
round for `.specs/write-boundaries/SPEC.md` and was lost before that SPEC was
written; it lands here.

## Model delta

- `check` gains a fourth finding type whose routing destination is `plan`.
- `check` gains a required question covering the six ontology categories.
- The Kernel's documented shape gains per-entry `since:` and `source:`.
- `start` gains a re-scan mode that reports and does not write.
- The Kernel lifecycle states that provenance re-anchoring is a revision.
- No new concept, and no change to who may write `KERNEL.md`.

## Action Contracts

`check`:

- permitted effect: read-only; emit findings.
- invariant: a `semantic` finding routes to `plan` and never to `do`; `check`
  never decides whether the code or the Kernel is wrong; the six-category
  question is answered in writing on every run.
- verification: the output names a routing destination for every finding.

`start`, re-scan:

- precondition: `KERNEL.md` exists.
- permitted effect: write `.scratch/start/REPORT.md` only.
- invariant: `KERNEL.md` is not modified, not even to add provenance.
- verification: the Kernel file is byte-identical after the run.

## Compatibility

`compatible`. Existing Kernels stay valid without per-item provenance and are
reported as a gap rather than failed. Existing checks become stricter, which
cannot invalidate past work. The `plan` gate is unchanged.

`docs/adr/0005-kernel-drift-detection.md` records the decision despite the
compatible classification: establishing `check` as the place ontology drift is
detected is hard to reverse, which is the ADR test in
`skills/learn/SKILL.md`, not the compatibility class.

## Verification

- `skills/check/SKILL.md` defines four finding types and states the routing
  destination of each.
- The six-category question appears in `skills/check/SKILL.md` and is marked as
  answered on every run, including when the answer is no.
- `START.md` documents the re-scan, and states that `KERNEL.md` is not written
  during it.
- `START.md`'s Kernel template shows `since:` and `source:` on an entry.
- `docs/spec-agents/WORKFLOW.md`'s Kernel lifecycle states that provenance
  re-anchoring is a revision.
- No document implies that `check` decides a Kernel conflict.
- The three-axis check applied to this change; installer smoke passes.

## Out of scope

- Changing who may write `KERNEL.md`, or the `plan` gate.
- Back-filling provenance into any existing Kernel.
- Adding a direction marker to Evidence entries — the detection mechanism is in
  `check`, and a second marker in `learn` would duplicate it.
- Automating the re-scan, or scheduling it.
- Restructuring the eight Kernel sections again.

## Issue map

- `01-semantic-finding.md`: the fourth finding type and its routing.
- `02-capture-question.md`: the six-category question in `check`.
- `03-kernel-provenance.md`: per-entry `since:` and `source:` in the template.
- `04-start-rescan.md`: the re-scan mode and its write boundary.
- `05-lifecycle-provenance.md`: the lifecycle rule lost from the previous SPEC.
- `06-learn-record.md`: ADR 0005, Evidence, `STATUS.md`, `CHANGELOG.md`.
  `writer: learn`.
