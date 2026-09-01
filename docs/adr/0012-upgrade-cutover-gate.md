# ADR 0012: Bind doctrine replacement to a confirmed cutover receipt

status: accepted
date: 2026-08-31
scope: the confirmation boundary for existing-project doctrine replacement and the workflow roots available after fresh START
applies_when: `UPGRADE.md` has classified an existing project and is about to replace installed doctrine
owner: project maintainer
source: E-20260831-007; E-20260831-008; E-20260831-009; `.specs/upgrade-cutover-gate/SPEC.md` r1
supersedes: only the unguarded `replace-doctrine` invocation implied by `docs/adr/0010-upgrade-rebootstrap.md` Decision and Consequences; its salvage/reset/re-bootstrap decision remains accepted
verification: `tests/upgrade-reset-smoke.sh` reports 10/10; receipt refusal, replacement/recovery, report completion, project-root, installer, doctrine, Kernel-delta, state, installed-reference, and whitespace checks pass

## Context

ADR 0010 made existing-project upgrade a preservation review followed by a
recoverable reset and fresh START. It required an exact user decision before
`replace-doctrine`, but the shell command could not distinguish a confirmed
review from a direct call. Any recognisable target and absent backup path could
therefore cross the written confirmation boundary.

The same process simulation found two related mismatches. Replacement printed
the generic `Spec-AGENTS is ready` result before retired state had moved or the
fresh START had been accepted. After reset, the workflow CLI could not find a
modern project without `.git/` or `.specs/`, even though START explicitly
supports no VCS and native JJ.

The review report later needs a Completion result, so hashing only the mutable
active report would make its confirmation evidence impossible to replay after
the lifecycle completes.

## Decision

After the user confirms the final pre-cutover report, Upgrade creates an
immutable `CONFIRMED-REPORT.md` under the confirmed archive root and writes the
adjacent `.scratch/upgrade-review/CUTOVER.tsv`. The receipt has exactly six
unique two-column rows: format `spec-agents-cutover-v1`, canonical target,
canonical absent doctrine backup, confirmed report SHA-256, literal zero
unresolved rows, and decision `confirmed`.

Doctrine replacement now requires:

```text
spec-agents replace-doctrine <project> <backup-dir> \
  --cutover <project>/.scratch/upgrade-review/CUTOVER.tsv [lang] [--link|-l]
```

Before creating the backup or changing the target, the CLI requires a regular
non-symlink receipt at that exact target location, its exact field set and
values, and a regular adjacent REPORT whose current hash matches. Missing,
malformed, duplicated, unknown, stale, unresolved, unconfirmed, or path-
mismatched input refuses. The prior call without `--cutover` has no
compatibility bypass. `init` and `install` neither require nor accept the
receipt option.

Successful replacement reports doctrine completion, the recovery backup, and
the remaining Upgrade steps. It does not report project readiness. The active
report may gain Completion result after fresh START; the confirmed snapshot
stays byte-identical to the receipt hash.

Workflow commands recognise the nearest ancestor containing `.specs/`,
`.git/`, native `.jj/`, or the complete modern entry set (`AGENTS.md`,
`START.md`, `docs/spec-agents/WORKFLOW.md`, and `skills/plan/SKILL.md`). A
partial entry or retired marker alone is not a workflow root. Discovery never
initializes version control or changes doctrine replacement's separate target
guard.

## Why this boundary

The receipt is deliberately small. It binds the one artifact already reviewed
to one target and recovery location without duplicating the preservation
manifest. Canonical paths prevent the same-looking relative invocation from
selecting a different project or backup. Zero unresolved rows and the report
hash make the two strongest written preconditions machine-checkable before the
first destructive write.

The immutable snapshot separates approval evidence from the report's own
lifecycle. Completion can describe what actually happened without rewriting
what was approved.

This receipt proves artifact agreement, not human identity. Authentication,
signatures, and runtime authorization are outside this workflow and are not
inferred from `decision=confirmed`.

## Alternatives rejected

- **Keep confirmation as Prompt prose only.** A direct CLI call would still
  bypass the most important precondition.
- **Add `--force` or retain the old call for compatibility.** That recreates
  the bypass under a different name and makes automation silently unsafe.
- **Embed the full preservation manifest in CUTOVER.** It creates a second
  representation that can drift from REPORT without improving the binding.
- **Hash the report only after Completion result.** Replacement needs approval
  evidence before Completion exists; the resulting hash would say nothing
  about the pre-cutover decision.
- **Require Git or initialize JJ.** START already supports no-VCS projects, and
  choosing a version-control system is a separate user decision.

## Consequences

This is breaking for scripts that call the old three-positional-argument
replacement form. They must run the current upstream UPGRADE review, receive
exact confirmation, create the snapshot and six-row receipt, and pass
`--cutover`. Reusing a receipt after changing REPORT, target, or backup is an
error; confirm the revision and issue a new receipt instead.

Ordinary copy/link install and its readiness result are unchanged. Replacement
still uses ADR 0010's doctrine allowlist, Instance boundary, recovery manifest,
retired-state reset, and fresh-START requirement. This ADR supersedes no other
part of ADR 0010 and does not edit that accepted record.

The 10/10 persistent fixture proves deterministic generated projects, refusal
before backup, recovery, root discovery, and a simulated completed Prompt. It
cannot prove who confirmed the report, that an AI will classify an arbitrary
real repository correctly, or general real-project cutover safety. Keep the
archive and doctrine backup through user acceptance of a real fresh START.
