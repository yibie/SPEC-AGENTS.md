# ADR 0007: Give the six actions a gate

status: accepted
date: 2026-08-26
scope: how an action's preconditions are enforced
applies_when: beginning any action, or changing a slice's state
owner: project maintainer
source: E-20260826-011
verification: each refusal proven against a fixture; `check-state` clean on this repository

## Context

Four independent sources reached the same conclusion within three days, each
from a different direction.

`mattpocock/skills` has 24 skills and none of them is mandatory reading; one
router dispatches and the rest load on demand. `gura105/operational-ontology`
makes preconditions functions a runtime calls, so a violation cannot be written
rather than being discouraged. An independent review of this repository's
doctrine concluded: "making a rule visible everywhere is not the same as making
it executable." `logseq/spec_dev_tool` has a five-line `AGENTS.md`, four lines
of which are pointers, because the workflow lives in a binary that emits it on
demand — and it encodes a document's lifecycle in its directory path, so a
transition is a validated file move rather than an edited word.

The answer here had been to compress prose: 586 lines of mandatory reading down
to 399, and counted as progress. The other four answers were all to stop putting
it in prose.

The measured case was weaker than expected and more instructive. Five SPECs in
this repository had every slice `done` while their own status said otherwise.
Reaching that number took four attempts: a hand-written grep reported twelve,
seven of them false positives from a pattern that missed a field variant; the
first checker reported sixty-two, having applied `authority:` to slices ADR 0006
exempts; the second reported twelve, resolving `spec_ref` from only one of the
two conventions in use here. Three confident wrong counts in one afternoon.

The drift was small. The hand-counting was not reliable at all.

## Decision

Each of the six actions gains a gate: `spec-agents gate <action> [target]`
checks the preconditions that can be checked and refuses with the reason and the
document that states it. `transition` changes a slice's state only after
verifying the invariants for the target state. `check-state` sweeps every
invariant across `.specs/`. `status` and `ready` report.

**The CLI does not print skill prose.** `skills/<action>/SKILL.md` remains the
single authority for what an action means. A tool that emitted the same text
would be a second authority for one rule, which is the failure
`docs/spec-agents/single-authority.md` exists to prevent. The gate says whether
an action may begin; the skill says what to do.

`AGENTS.md` points at the tool and the skills instead of explaining the
workflow. When the tool is unavailable the skills are read directly and the
gates are checked by hand: the workflow degrades, it does not disappear.

Written in bash, adding no dependency. The installer is bash and the payload is
Markdown plus two shell scripts; a managed project installs nothing. One of the
tools this borrows from requires an OCaml toolchain. Bash is a poor language for
a state machine and that cost is accepted, because the alternative is paid by
every managed project rather than by this one.

State stays in frontmatter. `transition` edits the field.

## Alternatives rejected

- **Encode state in the directory path**, as `logseq/spec_dev_tool` does. It
  makes an inconsistent state unrepresentable and `ls` a query, which is
  genuinely better. Rejected because it relocates 68 files and turns every
  transition into a rename, diluting the history of files whose content is the
  record. Worth revisiting if transitions ever outnumber edits.
- **A compiled binary.** Better to write and to test; requires publishing build
  artifacts where `git clone` plus one bash script suffices today.
- **Python.** Present on the platforms in use and far easier for frontmatter,
  but it makes the installer bilingual and adds a version surface.
- **The CLI prints the skill prose**, matching `spec-dev-tool --help`. It works
  there because the tool is the only delivery path; here the skills already load
  on demand, so printing them again creates the second authority this framework
  spent a week eliminating.
- **More standalone check scripts instead of a CLI.** Catches drift but cannot
  perform a transition or refuse an action before it starts.

## Consequences

Breaking. `AGENTS.md` no longer carries the workflow, and an agent that ignores
both the tool and the skills has less to work from than before.

A gate can only check what is mechanical. `plan`'s interrogation, `check`'s
three axes, and `learn`'s judgment are reasoning, and no precondition reaches
them. The gates cover status, dependency, writer, authority presence, and
evidence linkage — the parts that were being got wrong by hand, and nothing
more.

Two defects were found in the checker itself during construction, both of the
same shape as the defects it was written to catch: a rule applied outside the
scope its own ADR declared, and a convention enforced in only one of the two
forms actually in use. A checker is not exempt from the failures it checks for.
