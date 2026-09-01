# 02 Recognize every START-supported project root

status: done
blocked_by: 01
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — ProjectState
spec_ref: `.spec-agents/specs/upgrade-cutover-gate/SPEC.md`
context_ref: `.spec-agents/doctrine/START.md`, `.spec-agents/doctrine/bin/spec-agents`, `.spec-agents/doctrine/docs/jj-change-management.md`
evidence_ref: E-20260831-008

## Goal

Let workflow state commands operate in no-VCS modern installs and native JJ
projects that START already accepts, without weakening partial-entry or
arbitrary-directory refusal.

## Scope

- `bin/spec-agents` — workflow `project_root` discovery and its refusal text

## Acceptance

- Root discovery selects the nearest ancestor containing `.specs/`, `.git/`,
  `.jj/`, or the complete modern entry set declared by the SPEC.
- Commands work from the root and a nested directory of a current no-VCS
  install and a native `.jj/` fixture.
- A single familiar file, partial doctrine set, arbitrary directory, and parent
  containing only retired markers do not become workflow roots.
- Discovery does not initialize or mutate Git/JJ, create `.specs`, or change
  doctrine replacement's independent target-recognition guards.
- Existing Git and `.specs` roots retain their current nearest-ancestor
  behaviour and messages name every accepted strong root marker.

## Verification

- Disposable root/nested fixtures for `.specs`, Git, native JJ, complete modern
  entry, partial entry, and arbitrary directory.
- Run `status`, `check-state`, and `gate plan` where their action-specific
  preconditions allow; separate root discovery from expected state absence.
- Run shell syntax, existing workflow CLI fixtures, doctrine checks, state
  checks, and `git diff --check`.

## Evidence

`do` added one `has_complete_modern_entry` predicate and extended the existing
nearest-ancestor `project_root` search with native `.jj/` plus the SPEC's four
modern-entry files. Replacement target recognition was not touched. The
refusal now names `.specs/`, `.git/`, `.jj/`, and the complete modern entry.

`spec-agents-project-root.pFGqsV` runs `status`, `check-state`, and `gate plan`
from root and nested paths for `.specs`, Git, native JJ, and modern no-VCS
fixtures. A parent with deliberately invalid `.specs` state plus a nearer
complete modern child proves nearest-root selection. A lone AGENTS file, a
three-of-four partial entry, an arbitrary directory, and a retired-only parent
all refuse with the complete marker list. The no-VCS/JJ fixtures retain their
original marker sets and gain no `.specs` or second VCS.

`bash -n`, doctrine 400/400, Kernel-delta, `check-state`, and whitespace checks
pass.
