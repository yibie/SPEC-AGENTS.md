# 04 Classify the three SPECs that have no slices

status: done
blocked_by: 02, 06
writer: learn
authority: n/a: classifies existing records; introduces and modifies no rule
spec_ref: `.specs/spec-lifecycle/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260829-014`

## Goal

Three SPECs sit at `confirmed` with zero slices and are invisible to
`check-state`, whose assertion fires only when a SPEC has at least one slice.
Each gets a decision instead of remaining unclassified by default.

## Scope

- `.specs/jsonl-evidence-pilot/SPEC.md`
- `.specs/ontology-graph-pilot/SPEC.md`
- `.specs/upgrade-prompt/SPEC.md`

## Acceptance

- each of the three is classified as genuinely open or as finished and
  mis-stated, with the evidence the classification rests on named;
- a SPEC found finished is set to `verified` under slice 02's preconditions; if
  a precondition is unmet, it is left alone and the gap is reported;
- a SPEC found genuinely open is left at `confirmed` and the reason recorded;
- only the `status:` field is written; no other content of these SPECs changes;
- no slice is created for any of them here.

## Verification

`spec-agents status` shows a deliberate state for each of the three. For any set
to `verified`, the three preconditions are demonstrable from the repository.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

**Classification.** All three are finished and mis-stated; none is genuinely
open.

- `.specs/jsonl-evidence-pilot/SPEC.md` — its issue map names one bounded
  slice: fixture, runner, and result report. All three exist under
  `research/experiments/jsonl-evidence-pilot/`, and `E-20260817-002` records
  the run passing J1–J5 and the recommendation the SPEC asked for. A clean
  rerun of `run_pilot.py` on 2026-08-29 passes J1–J5 again; the JSONL figures
  match the record exactly, the Markdown fixture figures do not (full
  1,567 bytes / 392 rough tokens against the recorded 1,649 / 413; scoped
  1,353 / 339 against 1,425 / 357). The conclusion — JSONL costs more bytes
  and rough tokens than the Markdown equivalent — holds on both sets. Found by
  the independent `check`; recorded for `learn` as a corrective Evidence note,
  not a rewrite of `E-20260817-002`.
- `.specs/ontology-graph-pilot/SPEC.md` — same shape. Runner and reports exist
  under `research/experiments/ontology-graph-pilot/`, `run_pilot.py` passes
  every check on rerun, and `E-20260817-003` records the original run.
- `.specs/upgrade-prompt/SPEC.md` — its deliverable is root `UPGRADE.md`, which
  exists; `bin/spec-agents` refuses `--legacy` and has no `upgrade` command,
  which is the SPEC's stated Action Contract; `E-20260817-001` records the
  Prompt-first boundary.

Why they sat at `confirmed`: all three predate `.specs/` (moved from
`.scratch/` in `9b3ccd7`) and predate any rule naming who writes a SPEC's
terminal state; `check-state` never asked, because its assertion fires only
for a SPEC with at least one slice.

**Write withheld; gap reported.** A first pass set all three to `verified`,
reading `learn`'s first precondition — every slice of the SPEC is `done` — as
vacuously true for a SPEC with no slices, and its third — the SPEC is removed
from `STATUS.md` in the same act — as satisfied by the SPEC already being
absent. The independent `check` raised a `semantic` finding: neither reading
is in `skills/learn/SKILL.md` 收尾 or in the SPEC's Action Contract, so the
write would extend `learn`'s contract silently while this slice declares
`authority: n/a`. The vacuous reading also fails to distinguish "nothing left
to do" from "nothing was ever done": `authority-order` is `confirmed` with zero
slices and nothing finished, and the first precondition reads identically for
it. The three statuses were reverted to `confirmed` — the state they had
before this slice — and the acceptance clause "if a precondition is unmet, it
is left alone and the gap is reported" applies.

Routed to `plan` as `semantic`: what does `verified` require of a SPEC that
has no slices? One concrete alternative for `plan`: the first precondition is
replaced, for a zero-slice SPEC, by "the Evidence record names each item of
the SPEC's issue map as verified", and an absent `STATUS.md` entry satisfies
the third. Deciding it is not this slice's to do.

Verification: `spec-agents status` shows the three at `confirmed 0/0`;
`spec-agents check-state` exits 0; `git diff` on the three SPECs is empty.

Ontology question: the classification itself changes nothing. The withdrawn
write would have changed an Action Contract, which is why it was withdrawn.

Left at `doing`. Closes with a `plan` decision on the zero-slice case, in
either direction.

**Second pass, under r4.** `plan` decided the zero-slice case on 2026-08-29
(SPEC r4) and slice 06 put it in `skills/learn/SKILL.md` 收尾. The three
preconditions, checked per SPEC under that rule:

1. `E-20260829-013` names each item of `jsonl-evidence-pilot`'s and
   `ontology-graph-pilot`'s issue maps, and each deliverable of
   `upgrade-prompt`'s Verification section, and states each was verified on
   2026-08-29 — the replacement for "every slice `done`".
2. The Evidence record is appended (`E-20260829-013`).
3. None of the three is in `STATUS.md`; an already-absent entry satisfies the
   third.

All three set to `verified`. Only the `status:` line of each changed; no slice
created. `spec-agents status` shows `verified 0/0` for all three;
`check-state` exits 0.

The first pass above is left as written: it is the record of how the gap was
found, and rewriting it would remove the finding.

**Correction after the second-pass `check`.** `E-20260829-013` had not named
all four bullets of `upgrade-prompt`'s Verification section. That SPEC was
returned to `confirmed`, each bullet was reproduced and recorded in
`E-20260829-014`, and only then was it set to `verified` again. The other two
SPECs were unaffected.
