# 04 Bootstrap the project Kernel on first Start

status: done
blocked_by:
spec_ref: `.specs/start-command/SPEC.md`
context_ref: `CONTEXT.md`
evidence_ref: `E-20260819-008`

## Goal

Make the first `START.md` scan create a minimal, confirmed-only `KERNEL.md`
version `K1` when the project has enough directly observable stable facts.

## Scope

- `START.md`, `CONTEXT.md`, `AGENTS.md`, `AGENTS_en.md`
- `skills/plan/`, `skills/capture/`, `skills/check/`, `skills/learn/`
- `UPGRADE.md`, README and knowledge-promotion guidance

## Acceptance

- an absent Kernel is bootstrapped before the Start report waits for user
  confirmation;
- existing Kernel files are never overwritten by Start;
- inferred and unknown claims stay in the report, not in enacted K1;
- later Kernel evolution still uses `plan`, verification, and `learn`;
- legacy and modern routes preserve the K1 boundary.

## Verification

Disposable fixtures cover fresh modern, existing Kernel, legacy, mixed, and
insufficient-evidence states. Static checks prove K1 creation is absent-only,
confirmed-only, and does not alter application files or repository history.
