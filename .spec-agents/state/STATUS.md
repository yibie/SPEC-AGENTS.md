# STATUS

No SPEC is active.

## What this file is

`.spec-agents/state/STATUS.md` answers one question: what is being worked on right now. It lists
the active SPECs, their blockers, their verification state, and the next
permitted action.

When a SPEC finishes, `learn` removes it from this file. Its result is already
in `.spec-agents/state/EVIDENCE.md` and its contract stays at `.spec-agents/specs/<feature>/SPEC.md`. This
file never accumulates closed sections — that is what turned the previous phase
model into three parallel history ledgers.

The repository records no future intent. Direction is decided in conversation
and becomes durable only when it becomes a confirmed SPEC.

Use this shape per active SPEC:

```text
### <feature>

spec: `.spec-agents/specs/<feature>/SPEC.md`
scope: <files or area — must not intersect another active SPEC>
slices: <n> total, <n> done
blockers: <none, or what is blocking>
next: <the next permitted action>
```

Several SPECs may be active at once. Their scopes must not intersect, and work
that runs at the same time needs its own working copy — see
[the parallel-work Protocol](.spec-agents/doctrine/docs/parallel-work.md).

## Blockers

None recorded.

## Waiting pointers

`reference-existence` remains `confirmed` in lifecycle status; its layout
assumptions are stale after the namespaced cutover and it returns to `plan`.

`evidence-reproducibility` keeps its confirmed meaning and points to the
canonical `.spec-agents/state/EVIDENCE.md` home.
