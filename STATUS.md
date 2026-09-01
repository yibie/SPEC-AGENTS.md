# STATUS

One SPEC is active.

### authority-order

spec: `.specs/authority-order/SPEC.md`
scope: the Document authority and owner-table sections in `AGENTS.md` and `AGENTS_en.md`; `docs/spec-agents/single-authority.md`, `docs/spec-agents/knowledge-promotion.md`, `docs/adr/0011-authority-order.md`
slices: not yet arranged
blockers: none — `kernel-delta-declaration` closed (`E-20260829-020`)
next: `arrange`

Accepted when both `AGENTS` files list `skills/` in the Document authority
order with byte-identical blocks, `single-authority.md`'s `do` bullet states
both cases, and a superseding record names ADR 0006's Consequences paragraph.

The last completed work made the Kernel delta a declaration that `capture`
writes, `do` implements against, `learn` promotes verbatim, and the gates read
(`E-20260829-020`). Its contract is at `.specs/kernel-delta-declaration/SPEC.md`
and its result is in `EVIDENCE.md`; neither is state, and neither belongs here.

Two more SPECs are `confirmed` and waiting, in this order:
`reference-existence`, `evidence-reproducibility`.

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

`spec_ref` is written two ways across `.specs/` — relative to the repository
root in recent slices, relative to the slice in older ones. The checker accepts
both because `skills/arrange/SKILL.md` never said which to use. Choosing one
changes the slice format and needs its own `plan`.

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

`spec-agents ready` reports the wrong slices. `blocker_unfinished` does not
declare `f` or `d` as local, so its inner glob overwrites the loop variable of
`cmd_ready`, which calls it directly; `ready` then prints each blocker's path
instead of the slice it unblocked. Two further defects sit in the same command:
it lists slices whose status is `blocked`, which `gate do` then refuses, and
`blocked_by` names slice prefixes inside one feature, so a slice blocked by
another SPEC is reported runnable. The leak is a plain bug; the other two carry
choices and need their own `plan` (`E-20260828-012`).

`gate arrange` accepts only `confirmed|revised`, while `capture`'s status set
now has six values. Same defect class as the one `spec-lifecycle` repaired —
a copy of the vocabulary inside the CLI — and not confirmed in that `plan`
round. Needs its own `plan` (`E-20260829-015`).

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

The mandatory read is under its 400-line ceiling;
`tests/doctrine-check.sh` reports the live count and fails when it goes over,
so the number is not repeated here. Nothing runs that check:
there is no CI and no hook, so it depends on someone remembering to run it —
the same failure class it was written to remove, moved one level up. Wiring it
to an execution point needs its own `plan`.

Three items from `mattpocock/skills` are unexamined, each needing its own
`plan`: `implement`'s continuation loop, an external issue tracker for slices,
and per-axis sub-agents with a word cap.

`capture` does not require a SPEC to cover every decision its `plan` round
produced, and nothing downstream can detect the omission — `arrange` and `check`
both compare against the SPEC, not against the round. One decision was already
lost this way (`E-20260821-006`). This needs its own `plan`.
