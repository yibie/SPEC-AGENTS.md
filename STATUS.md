# STATUS

No SPEC is active.

The last completed work was the retirement of `Phase` and `ROADMAP.md`
(`E-20260820-002`). Its contract is at `.scratch/retire-phase/SPEC.md` and its
result is in `EVIDENCE.md`; neither is state, and neither belongs here.

## What this file is

`STATUS.md` answers one question: what is being worked on right now. It lists
the active SPECs, their blockers, their verification state, and the next
permitted action.

When a SPEC finishes, `learn` removes it from this file. Its result is already
in `EVIDENCE.md` and its contract stays at `.scratch/<feature>/SPEC.md`. This
file never accumulates closed sections — that is what turned the previous phase
model into three parallel history ledgers.

The repository records no future intent. Direction is decided in conversation
and becomes durable only when it becomes a confirmed SPEC.

Use this shape per active SPEC:

```text
### <feature>

spec: `.scratch/<feature>/SPEC.md`
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

Two follow-ups are open from recent work, neither started:

1. Run the pre-split section of `UPGRADE.md` against one real project installed
   before the framework namespace split, and record where its classification
   step is wrong.
2. Decide whether `.scratch/` should be renamed. It is git-tracked and holds
   nine features' contracts, so the name is misleading. This is a semantic
   change and needs its own `plan`.
