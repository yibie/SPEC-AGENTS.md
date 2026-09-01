# ADR 0009: Declare the Kernel delta before the code

status: accepted
date: 2026-08-29
scope: when and where a semantic change to the project Kernel is declared, and what binds implementation and promotion to that declaration
applies_when: capturing a SPEC whose Change crosses the Change Boundary, entering `do` on its slices, or promoting its result to `KERNEL.md`
owner: project maintainer
source: E-20260829-017, E-20260829-018, E-20260829-019, E-20260829-020
verification: `tests/kernel-delta-check.sh` passes all seventeen cases; `grep -n kernel_delta skills/{capture,learn}/SKILL.md` returns hits; `check-state` clean on this repository

## Context

`Project Kernel --constrains--> SPEC | Action Contract | Code`, yet the Kernel
is written only by `learn`, after the code. During every implementation
window the constraint runs backwards: code moves first and redefines the
ontology de facto, and the Kernel is stale until someone promotes. "The docs
are always behind" is that inversion, observed daily.

The pieces of a fix existed and did not connect. `plan`'s candidate record
carried `kernel_status` and `kernel_promotion`; the SPEC template carried a
`## Model delta` heading that no prose defined; `bin/spec-agents` never read
it; `learn` promoted "after `plan` confirms" with nothing requiring the
promoted content to match what the SPEC said. A `plan` round could fill
`kernel_promotion` and nothing downstream would read it — the loss already on
record as E-20260821-006, instantiated on the kernel fields.

Detection after the fact already existed: `kernel-maintenance` gave `check` a
`semantic` finding for code-vs-Kernel drift. Declaration before the fact did
not.

## Decision

For a Change crossing the Change Boundary, the SPEC's `## Model delta` is the
proposed Kernel delta — the entries to be added, revised, superseded, or
retired in the project's `KERNEL.md` (in this repository, `docs/spec-agents/WORKFLOW.md`) when
the work verifies. `do` implements against it; `learn` promotes exactly it.

The SPEC frontmatter carries a machine-readable `kernel_delta:` field: the
explicit `none`, or a list of `<verb>: <entry>` lines with verbs
`add | revise | supersede | retire`, entries naming Kernel items, not files.
The field is the gate's input; the section is the human's. One rule decided
in the field, explained in the section.

**The default is named.** A SPEC without the field reads as
`kernel_delta: none` — a deliberate legacy default, not an unknown. Zero
back-fill across the existing SPECs here and every managed project's stock;
`capture` makes the field mandatory on every SPEC it creates from now on, and
refuses to finish when the confirmed `plan` outcome carried `kernel_promotion`
other than `none` and the delta is empty.

**`learn` promotes the declaration, not the drift.** The written Kernel
change must equal the SPEC's declared entries as last revised; each promoted
entry's `source:` cites the SPEC. Divergence: stop, write nothing, report
which entry; the route back is `plan` and a SPEC revision.

**The gates read the field.** `gate do` refuses a SPEC that declares entries
without a non-empty `## Model delta`, and a present-but-empty field; an absent
field passes unchanged. `check-state`, in a project with `KERNEL.md`, resolves
every entry of a `verified` SPEC: for `add`, `revise` and `supersede`, a
record whose `source:` cites the SPEC as a whole token; for `retire`, the
record's absence — a retired entry has nothing left to carry a citation, and
the Kernel carries no changelog (ADR 0005), so its provenance is the SPEC and
the Evidence.

The proposal state lives in the SPEC's own lifecycle. The `kernel:` line is
unchanged.

## Alternatives rejected

- **A `proposed` state on the `kernel:` lifecycle line.** Puts unconfirmed
  content into the file whose floor is "confirmed facts only", and splits one
  proposal across two lifecycles. The SPEC lifecycle already carries
  `confirmed → in-progress → verified`; a confirmed SPEC's Model delta *is*
  the proposal.
- **A separate `KERNEL-DELTA.md`.** A second file for one truth — the failure
  `docs/spec-agents/single-authority.md` exists to prevent, and one more file to drift.
- **Parsing the Model delta prose.** The gate would then enforce a prose
  format; the field exists so the gate has a structure to check and the
  section stays human.
- **A retired tombstone record in the Kernel.** Provenance for `retire`
  would live in the file, but it is a changelog by another name, and the
  Kernel would accumulate dead entries.
- **Skipping `retire` entries in `check-state`.** A retirement never carried
  out would pass.
- **Mechanical detection of Change Boundary crossing.** Whether a Change is
  semantic is `plan`'s judgment; the gate checks structure only.

## Consequences

Breaking. `gate do` gains a refusal, `capture` a mandatory field, `learn` a
promotion precondition. Existing SPECs and managed-project stock are
unaffected by the default.

The first SPEC to carry the field was this one, and the first slice checked
against a declared delta was its own slice 01: the reviewer matched the change
to a named entry instead of judging the diff. That is the mechanism,
observed once, on itself.

`check-state`'s resolution check is text-level provenance, not semantic
equality; whether the promoted content *means* what the entry declares is
still `learn`'s and `check`'s judgment. The general E-20260821-006 repair —
`capture` covering every decision of a `plan` round — remains open; this
closes the kernel-field instance only.
