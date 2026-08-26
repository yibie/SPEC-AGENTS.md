# STATUS

No SPEC is active.

The last completed work made the authority map checkable and shipped the first
executable in the payload (`E-20260825-010`). Its contract is at
`.specs/checkable-authority/SPEC.md` and its result is in `EVIDENCE.md`; neither
is state, and neither belongs here.

## What this file is

`STATUS.md` answers one question: what is being worked on right now. It lists
the active SPECs, their blockers, their verification state, and the next
permitted action.

When a SPEC finishes, `learn` removes it from this file. Its result is already
in `EVIDENCE.md` and its contract stays at `.specs/<feature>/SPEC.md`. This
file never accumulates closed sections — that is what turned the previous phase
model into three parallel history ledgers.

The repository records no future intent. Direction is decided in conversation
and becomes durable only when it becomes a confirmed SPEC.

Use this shape per active SPEC:

```text
### <feature>

spec: `.specs/<feature>/SPEC.md`
scope: <files or area — must not intersect another active SPEC>
slices: <n> total, <n> done
blockers: <none, or what is blocking>
next: <the next permitted action>
```

Several SPECs may be active at once. Their scopes must not intersect, and work
that runs at the same time needs its own working copy — see
[the parallel-work Protocol](docs/spec-agents/parallel-work.md).

## Blockers

None recorded.

## Next permitted action

One follow-up is open, not started:

Run `UPGRADE.md` against one real project installed before today's changes. It
now carries four migration sections — pre-split layout, phase-shaped layout,
SPECs under `.scratch/`, and locally modified doctrine — and none of them has
been run against a real project. Record where each classification step is wrong
before relying on it.

`docs/runbooks/installer-smoke.md` is prose. The smoke test has been hand-written
into a session scratch directory every time it ran, and cleared between sessions;
one verification claim was made against a script that no longer existed. It needs
its own `plan`.

`gura105/operational-ontology` names the four implementation choices it makes
visible, including what a missing policy defaults to. That discipline was not
borrowed and has no home yet — Kernel section, Protocol, or neither.

The reference-integrity axis added to `check` has no automated enforcement. If
a sixth reference breakage appears, the next step is a check that fails on an
unresolvable reference, not another rule.

The `plan-only`, `reject`, and `unresolved` routes have not been walked against
their own contracts. The `approve` route was documented for months and could
not be executed; the same defect class would look identical on those three.

Walking a route — tracing each `plan` outcome against the preconditions that
must accept it — found a defect that reading the same files did not. That walk
is in no action's contract. It belongs somewhere.

Whether an independent review should run at a fixed cadence, rather than when
someone thinks to ask, is now an open question with one data point behind it.

The reporting project's trial is still running and has not reported back.
Nothing in `E-20260824-008` is confirmed to work in the field. When the result
arrives, check whether `authority:` was answered honestly or filled with `n/a`
under the same time pressure that produced the original defect.

The mandatory read is now exactly 400 lines, at the ceiling. The next addition
must remove something first. Nothing prevents it from growing past 400 again, and no check
fails on it. If it does, the answer is a failing check on the line count.

Three items from `mattpocock/skills` are unexamined, each needing its own
`plan`: `implement`'s continuation loop, an external issue tracker for slices,
and per-axis sub-agents with a word cap.

`capture` does not require a SPEC to cover every decision its `plan` round
produced, and nothing downstream can detect the omission — `arrange` and `check`
both compare against the SPEC, not against the round. One decision was already
lost this way (`E-20260821-006`). This needs its own `plan`.
