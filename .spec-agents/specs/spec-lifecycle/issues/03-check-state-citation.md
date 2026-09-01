# 03 Make both refusals cite rules that exist

status: done
blocked_by: 02
writer: do
authority: `.spec-agents/doctrine/bin/spec-agents` — the CLI owns enforcement, not the rule
spec_ref: `.spec-agents/specs/spec-lifecycle/SPEC.md`
context_ref: `.spec-agents/doctrine/docs/WORKFLOW.md`
evidence_ref: `E-20260829-013`

## Goal

The two refusals that enforce a terminal state name the documents that now state
it. Their logic does not change.

## Scope

- `bin/spec-agents`

## Acceptance

- the refusal for "every slice is done but SPEC status is `<st>`" names the
  Lifecycle line and `skills/learn/SKILL.md`, in the form the other refusals
  use;
- the `done requires evidence_ref` refusal names `skills/learn/SKILL.md` as well
  as the action, so a reader can reach the rule rather than only its owner;
- both assertions keep their existing logic: the SPEC assertion still fires only
  when a SPEC has at least one slice and all are `done`; the slice assertion
  still requires `evidence_ref` and `authority`;
- no skill prose is reproduced in the CLI (ADR 0007);
- `bash -n bin/spec-agents` passes.

## Verification

A fixture SPEC with every slice `done` and status `confirmed` produces the SPEC
violation; a fixture slice transitioned to `done` without `evidence_ref` is
refused. Every document named in either message resolves. `check-state` exits 0
on this repository.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `bin/spec-agents` — updated the check-state `evidence_ref` refusal to cite
  `learn` and `skills/learn/SKILL.md`; updated the SPEC terminal-state refusal
  to cite `docs/spec-agents/WORKFLOW.md: Lifecycle/spec` and
  `skills/learn/SKILL.md`; updated the transition refusal to cite `learn` and
  `skills/learn/SKILL.md`. The SPEC and slice assertions' logic is unchanged,
  and no skill prose was added to the CLI.
- Exact messages:
  `status done without evidence_ref (learn; skills/learn/SKILL.md)`;
  `every slice is done but SPEC status is '$st' (docs/spec-agents/WORKFLOW.md:
  Lifecycle/spec; skills/learn/SKILL.md)`;
  `❌ refused: done requires evidence_ref (learn; skills/learn/SKILL.md).`
- Verification: `bin/spec-agents gate do
  .specs/spec-lifecycle/issues/03-check-state-citation.md` passed;
  `bash -n bin/spec-agents` passed; the temporary fixture's confirmed SPEC
  emitted the SPEC violation and exited 1; its slice without `evidence_ref`
  was refused on transition with the cited message and exited 1; both cited
  document paths exist; repository `bin/spec-agents check-state` exited 0;
  `tests/doctrine-check.sh` passed at 379/400.
- Ontology answer: no. This change added, altered, or retired no concept,
  identity, relation, lifecycle, invariant, or Action Contract.

Left at `doing` as required; `evidence_ref` remains empty for `learn`.
