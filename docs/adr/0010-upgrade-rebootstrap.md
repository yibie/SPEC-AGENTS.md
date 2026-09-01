# ADR 0010: Re-bootstrap upgraded projects instead of translating old state

status: accepted
date: 2026-08-31
scope: upgrading an existing project that has active retired SPEC-AGENTS workflow material or unsafe installed doctrine
applies_when: START classifies a project as `upgrade-needed`, or installed doctrine must be replaced during a confirmed upgrade
owner: project maintainer
source: E-20260831-006; `.specs/salvage-reset-start/SPEC.md` r2
supersedes: `docs/adr/0002-retire-phase.md` Consequences paragraph that converts phase tasks and STATUS; `.specs/spec-agents-upgrade/SPEC.md` r2 Decision, Model delta, and Action Contracts; `.specs/upgrade-prompt/SPEC.md` r1 Decision and post-confirmation Action Contracts
verification: `tests/upgrade-reset-smoke.sh` reports 8/8; `tests/doctrine-check.sh`, `tests/kernel-delta-check.sh`, `spec-agents check-state`, Kernel checks, installed-reference checks, and `git diff --check` pass

## Context

SPEC-AGENTS accumulated three upgrade designs.

The first gave the shell installer a mechanical `upgrade` command. It detected
v2, v3, or mixed input, archived `.phrase`, installed the new layout, and
mapped old files into modern root state. The second removed that command and
put semantic reconstruction into `UPGRADE.md`, but still told the agent to
install modern entry points first, reconstruct history and architecture, then
use the six actions to convert the old lifecycle into the current one. Later
sections added phase-shaped STATUS, tracked scratch SPECs, pre-split documents,
and locally modified doctrine as separate migration branches.

Those branches disagreed about their own write boundary and entry order. A
report-only reconnaissance pass could not also install doctrine or reconstruct
current records. Ordinary installation deliberately preserves existing files,
so installing first did not provide a current UPGRADE prompt. Replacing
doctrine after moving a project's sole retired marker made the destructive
operation refuse the target it was supposed to protect.

More importantly, old execution state is not current truth. Translating a
phase, task, blocker, Evidence ID, SPEC, Slice, or completion claim assigns
current authority to an old lifecycle without revalidating the project. The
information worth keeping is the user-approved content that may still affect a
future judgment, not the status that the old framework assigned to it.

## Decision

Upgrade is extraction followed by re-bootstrap:

```text
inspect → preservation manifest → user confirmation → recoverable reset
        → doctrine replacement → fresh START
```

An existing project starts from the current upstream `UPGRADE.md`; it does not
install over the project and then trust a possibly stale installed prompt.
Reconnaissance may write only `.scratch/upgrade-review/REPORT.md`. The report
lists every relevant path exactly once as `candidate`, `archive-only`,
`keep-active`, or `unresolved`, names the proposed archive and doctrine backup,
and separately lists current user intent that may need a new plan/capture pass.
Any unresolved entry stops cutover.

After the user confirms the exact manifest, doctrine replacement runs while at
least one recognised active marker still proves that the target is a
SPEC-AGENTS project. The explicit operation backs up and replaces only
`AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, and
`docs/spec-agents/`. Ordinary install remains preservation-first. CONTEXT,
KERNEL, STATUS, EVIDENCE, `.specs/`, project knowledge, application code,
configuration, tests, credentials, and repository history are Instance and are
never doctrine-replacement targets.

The confirmed reset moves only `candidate` and `archive-only` retired workflow
paths to the timestamped archive and proves source/destination path, type,
count, and content equality. `keep-active` paths remain byte-identical. The
archive and doctrine backup stay recoverable until the user accepts the fresh
START result.

The resulting project runs START again from its active code, tests,
configuration, and retained project-owned documents. START does not scan the
archive by default. Preserved content remains a candidate until current
project evidence and the user confirm it. Old lifecycle state never returns;
still-relevant intent goes through `plan` and `capture` as new work.

Source-generation labels such as v2, v3, pre-split, scratch-SPEC, or
phase-shaped are evidence in the review. They are not ProjectState values and
do not select separate conversion engines. START exposes one state for all of
them: `upgrade-needed`.

## Why this boundary

The four-way manifest separates three decisions that the older designs mixed:
what might still be useful, what is kept only for history or rollback, and what
belongs to the current project independently of the framework. `unresolved`
makes uncertainty a refusal instead of a guessed migration rule.

Keeping the backup and archive until START acceptance makes the destructive
part recoverable without treating the archive as active context. Running START
after reset gives the current project one semantic floor and one lifecycle,
instead of a translated floor whose claims depend on retired rules.

The replacement operation is explicit because it is the only installer route
that may overwrite doctrine. Giving ordinary install the same power would turn
a safe repeated setup command into an implicit migration.

## Alternatives rejected

- **Keep generation-specific conversion branches.** Each new historical layout
  adds another lifecycle mapper, and none can prove that an old completion or
  blocker is current.
- **Install current doctrine before reconnaissance.** Ordinary install keeps
  stale files, while overwriting first would cross the confirmation boundary
  and could erase locally meaningful doctrine edits before classification.
- **Move all files with familiar framework names.** A project-owned CONTEXT,
  ADR, handoff, or configuration can share a name with framework material.
  Classification requires content and current project evidence.
- **Delete old records after extracting text.** Recovery remains required until
  the fresh START result is accepted. Permanent deletion is a later explicit
  user choice.
- **Preload candidates into the new Kernel.** Preservation is not verification.
  Automatic promotion would recreate the same unverified state translation at
  a different layer.

## Consequences

Breaking for projects and automation that expect `legacy` or `mixed`
ProjectState values, the removed mechanical `upgrade` command, an
install-over-first sequence, or conversion of old records into current STATUS,
EVIDENCE, SPEC, Slice, or Kernel state. They must use `upgrade-needed`, the
current upstream prompt, the explicit `replace-doctrine` operation, and a fresh
START.

The preservation, confirmation, Doctrine/Instance split, and no-automatic-
deletion decisions in ADR 0001, ADR 0003, and ADR 0004 remain in force. ADR
0002 remains authoritative for retiring Phase and ROADMAP from the current
model; only its prescribed phase-to-Slice/STATUS conversion is superseded.
Accepted historical records are not edited in place.

The persistent fixture proves the file boundary and fresh-START eligibility on
generated projects. It does not execute an AI review and is not evidence that
arbitrary real repositories are generally safe to cut over. A reviewed
disposable copy of a real project must complete the prompt and receive user
acceptance before making that claim.
