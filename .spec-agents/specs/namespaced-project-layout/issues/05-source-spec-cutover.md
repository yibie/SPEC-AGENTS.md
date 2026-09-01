# 05 Move current SPEC and Slice records to their canonical home

status: done
blocked_by: 04
writer: capture
authority: `.spec-agents/doctrine/docs/WORKFLOW.md` — SPEC and Slice
spec_ref: `.spec-agents/specs/namespaced-project-layout/SPEC.md`
context_ref: `.spec-agents/specs/`, `.spec-agents/doctrine/skills/capture/SKILL.md`, `.spec-agents/doctrine/skills/arrange/SKILL.md`
evidence_ref: E-20260831-013

## Goal

Relocate this repository's durable feature contracts without losing their
history, frontmatter reachability, active Slice, or terminal records.

## Scope

- move `.specs/` to `.spec-agents/specs/`
- update live `spec_ref`, `blocked_by`, `context_ref`, and state pointers that
  must resolve under the new canonical location
- update capture/arrange path assertions and fixtures that directly validate
  the contract tree
- preserve historical prose unless it acts as a current instruction

## Acceptance

- Every tracked SPEC and Slice exists exactly once below
  `.spec-agents/specs/`; root `.specs/` is absent as an active path.
- Git recognises the move without content loss, including verified and
  superseded records.
- Current frontmatter references resolve and `check-state`, `status`, `ready`,
  every gate, and transitions find the active feature from root and nested
  paths.
- The active `namespaced-project-layout` SPEC and this Slice remain reachable
  before, during, and after the cutover; no second authority or compatibility
  link is left behind.

## Verification

- Pre/post tracked-file manifest and content-hash comparison.
- Installed CLI `status`, `check-state`, `ready`, gate, and nested-root probes.
- Root old-path scan, reference check, `git diff --check`, and manual rename
  review.

## Evidence

Pending Slice 04. Execute under `capture`, not `do`.

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- `gate capture` passed for this Slice after the source Doctrine cutover; Slice
  04's external blocker is cleared and remains preserved as a historical note.
- Moved the complete durable `.specs/` tree to `.spec-agents/specs/` with an
  explicit `mv`: 129 records total, including 27 `SPEC.md` files and 101
  `issues/*.md` Slice records. The old root `.specs/` is absent; no
  `STATUS.md`, `EVIDENCE.md`, archive, scratch, research, or other Instance
  tree was moved.
- Updated live machine-readable paths to the canonical namespace, including
  `spec_ref`, `authority`, `context_ref`, `context_refs`, and the active
  `STATUS.md` state pointer. The namespaced feature's exact `blocked_by` values
  are now `01`, `01`, `01`, `04`, `05`, and `06` for Slices 02–07; Slice 01's
  dependency remains empty. No status meaning changed: Slice 01 and Slice 04
  remain `done` with `E-20260831-011` and `E-20260831-012`.
- The source CLI uses `.spec-agents/specs` as `specs_root`; source and managed
  probes therefore read one canonical SPEC tree. No compatibility link or
  runtime fallback to `.specs` was added.
- Added `tests/source-spec-cutover-check.sh`, which verifies the canonical
  manifest/counts, every present `spec_ref`, and every non-empty namespaced
  `blocked_by` prefix resolves to exactly one Slice. Its throwaway source copy
  adds a synthetic canonical SPEC and a dedicated ready Slice with empty
  `blocked_by` to test canonical discovery, then checks root/nested status,
  ready, all six gates, transitions, check-state, and a Git throwaway rename.
  It passes 16/16. The source-doctrine fixture's root/nested probes are
  lifecycle-independent status checks and pass 13/13.
- Verification passed: installed namespaced fixture 17/17; workflow 17/17;
  Upgrade 10/10; kernel delta 17/17; source Doctrine 13/13; source SPEC
  16/16; Doctrine 399/400; `check-state` exit 0; `git diff --check`; and the
  source Markdown/README link checks. `bash -n` passed for the source CLI and
  new/updated fixtures. The CLI's existing `blocker_unfinished`/`ready`
  implementation was not changed; the namespaced feature now conforms to its
  documented numeric prefix input, while full-basename dependencies elsewhere
  remain subject to E-20260828-012. The fixture only asserts the dedicated
  no-dependency discovery case.
- Post-check correction: the two unqualified `AGENTS_en.md` context references
  were reanchored to `.spec-agents/doctrine/AGENTS_en.md`, and the remaining
  current multiline `context_refs` path tokens were mechanically reanchored
  within frontmatter only. The fixture now scans the frontmatter block up to
  its terminating blank line, ignores historical prose and root State refs,
  and passes the retired-token assertion; root and nested fixture runs each
  exercise `plan`, `capture`, `arrange`, `do`, `check`, and `learn`, with
  transition exercised from both directories.
- The ontology answer is no: this is a storage/path and machine-reference
  relocation. It adds, alters, or retires no concept, identity, relation,
  lifecycle, invariant, or Action Contract. `STATUS.md` was treated only as
  the SPEC-declared state-pointer migration exception; its state semantics
  were preserved.
