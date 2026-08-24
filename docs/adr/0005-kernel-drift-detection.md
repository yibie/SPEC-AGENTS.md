# ADR 0005: Detect ontology drift in check, decide it in plan

status: accepted
date: 2026-08-21
scope: how a project's Kernel stays true to its code
applies_when: verifying a change, reading a Kernel entry, or re-scanning a project
owner: project maintainer
source: E-20260821-006
verification: `check` defines four finding types with routing destinations; a re-scan leaves `KERNEL.md` byte-identical

## Context

The Kernel was read by five actions and written by one, and every relationship
was one-directional. Code had to conform to the Kernel. Nothing ever asked
whether the Kernel still conformed to the code. A project running for months
could hold a K1 that no longer described its system while every `check` passed,
because `check` used the Kernel as the ruler and never as the measured thing.

The process gate was not the problem. Three documents already required that
Kernel evolution pass `plan`. What was missing was the route to it: `check`'s
findings were `blocker`, `required`, and `suggestion`, and all three returned to
`do`. A conflict between code and Kernel could only be filed as `blocker` —
"violates an invariant" — which sent it back to change the code. A finding could
not leave `check` toward `plan`.

The capture path had the same shape. `skills/learn/SKILL.md` already routed a
verified concept, identity, relation, lifecycle, or invariant into `KERNEL.md`
after `plan` confirmed it. But nothing detected that a change had touched the
ontology. `check`'s contract axis asked the reverse question, and `do` stopped
only when it happened to notice. A change introducing a concept the Kernel did
not contain violated nothing at all.

Provenance was entirely file-level. Reading a Kernel, one could not tell which
entry was new, which had been stable since K1, or which decision admitted it.

`KernelStatus` already defined `stale` and `contradicted`, and
`skills/plan/SKILL.md` already carried a `kernel_status:` field with those
values. Nothing produced them.

## Decision

`check` gains a fourth finding, `semantic`, whose routing destination is `plan`.
The destination is part of the type, so it does not depend on the reader
inferring it.

`check` does not adjudicate. It never decides whether the code or the Kernel is
wrong. Deciding it inside `check` would bypass the `plan` gate, and bypassing
that gate is precisely how an ontology drifts without anyone noticing.

`check` answers one question in writing on every run, including when the answer
is no: did this change add, alter, or retire a concept, identity, relation,
lifecycle, invariant, or Action Contract? Adding one the Kernel does not contain
violates nothing, so no axis catches it — the question is what catches it. A
recorded "no" is required because an unrecorded answer decays into silence, and
silence is the failure being fixed.

Each enacted Kernel entry carries `since:` and `source:`. `since:` points into
the file's version sequence; `source:` names what admitted the entry.

`start` becomes re-runnable as a re-scan that writes nothing to `KERNEL.md` and
produces a `KernelStatus` plus a difference report. It routes nothing itself.

A revision that only re-anchors `source`, with enacted meaning unchanged, is
still a revision and advances the file version, leaving every `since:` untouched.

## Alternatives rejected

- **Let `check` decide whether the code or the Kernel is wrong,** by grading
  entries with a per-entry confidence. This was proposed and withdrawn: the user
  pointed out that the question is not which action may change the Kernel but
  through what process, and any adjudication inside `check` bypasses that
  process. It would also have required a confidence field on every entry, a
  third structural change to the Kernel in two days.
- **Keep three finding types and file Kernel conflicts as `blocker`.** That is
  the status quo, and it routes every conflict back to changing the code — which
  is correct only when the code is the thing that is wrong.
- **Mark each Evidence entry as supporting or challenging the Kernel.** Proposed
  as a way to accumulate staleness. Dropped once detection moved into `check`: a
  second marker in `learn` would duplicate the same signal in a place that fires
  later.
- **Per-entry version numbers and an in-file changelog.** Rejected on two
  grounds. Two version axes drift out of sync, and a changelog duplicates what
  `git log -L` and `git blame` already give while rotting. `source:` carries the
  one thing git cannot: which decision admitted the entry.
- **Ask the ontology-impact question only when the change touches an existing
  Kernel entry.** Cheaper, and it misses the main way an ontology goes
  incomplete — introducing something the Kernel never had.

## Consequences

Compatible. Existing Kernels stay valid without per-entry provenance; a re-scan
reports missing fields as a gap rather than failing. Checks become stricter,
which cannot invalidate past work.

The ontology-impact question is a procedure with no automated enforcement, like
the reference-integrity axis added the day before. Its failure mode is silent:
a run that skips the question looks exactly like a run that answered no.

Nothing schedules a re-scan. A project that never re-scans still drifts; the
difference is that it can now find out, not that it will.
