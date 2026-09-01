# 02 Add recoverable doctrine replacement

status: done
blocked_by:
authority: `bin/spec-agents` — doctrine installation and replacement
spec_ref: `.specs/salvage-reset-start/SPEC.md`
context_ref: `docs/adr/0001-framework-namespace-split.md`, `docs/runbooks/installer-smoke.md`
evidence_ref: E-20260831-003

## Goal

Provide one explicit installer-owned operation that backs up and replaces the
complete doctrine allowlist without touching project Instance data.

## Scope

- `bin/spec-agents`

## Acceptance

- `spec-agents replace-doctrine <path> <backup-dir> [lang] [--link|-l]` is the
  only installer route allowed to overwrite doctrine.
- It requires an existing target, an absent explicit backup directory, and a
  target other than the SPEC-AGENTS source repository.
- It backs up `AGENTS.md`, `START.md`, `UPGRADE.md`, `skills/`, and
  `docs/spec-agents/` with relative paths and a verifiable manifest before
  removing or replacing any of them.
- Replacement removes obsolete entries inside the two doctrine directories;
  it does not merely overlay current entries.
- It never touches `CONTEXT.md` or any other Instance path.
- Failure does not claim success and prints the recovery location. Normal
  `init`/`install`, repeated install, copy/link mode, and source refusal retain
  their current behaviour.

## Verification

- Run `bash -n bin/spec-agents`.
- Use only `mktemp` fixtures: modified/stale doctrine, populated Instance
  paths, copy mode, link mode, existing backup refusal, missing target refusal,
  and source-repository refusal.
- Compare the pre-operation doctrine to the backup manifest and every
  pre/post Instance path hash.
- Run the existing fresh/repeated installer smoke assertions and
  `git diff --check`.

## Evidence

Implementation verification handed to `check` on 2026-08-31:

- `bash -n bin/spec-agents` and `git diff --check`: pass.
- `/tmp/spec-agents-replace-doctrine.imQkcU`: modified doctrine was backed up
  with 40 manifest entries, the stale skill disappeared from the installed
  tree, five representative Instance paths stayed hash-identical, existing
  backup/missing target/source target refused, and copy plus link replacement
  passed.
- `/tmp/spec-agents-replace-failure.FmhPuj`: a deliberate post-backup install
  failure exited 1, printed the resolved recovery directory, retained the old
  four-path doctrine bundle and manifest, and printed no success line. The
  bundle restored into a separate directory with all four contents equal.
- `/tmp/spec-agents-installer-regression.8MkWKg`: fresh, repeated, link,
  absent-Instance, executable-checker, and source-refusal assertions pass.
- `tests/doctrine-check.sh`: 389/400 and all checks pass;
  `spec-agents check-state`: pass.
- The execution environment had none of `shasum`/`sha256sum`; the first real
  fixture exposed that assumption, so the implementation now falls back to
  `openssl dgst -sha256`. The passing manifest was generated through that
  fallback.
- Same-context `check` found one blocker before accepting the destructive
  boundary: a fixed allowlist was still unsafe if the target itself was `/`,
  the user home, or an arbitrary directory. The implementation returned to
  `do`, rejects the two broad roots, and requires at least two active
  SPEC-AGENTS markers. `/tmp/spec-agents-replace-doctrine-guarded.pMyUad`
  reproduces the full success path plus arbitrary-directory refusal;
  `/tmp/spec-agents-replace-failure-guarded.3x5DY6` reproduces failure and
  restoration after the guard was added.
- Slice 01's integration check later made this Slice stale: the two-marker
  threshold rejected a genuine retired project whose only strong marker was
  `.phrase/`, once the new instructions stopped installing over it first.
  The guard now requires one strong active doctrine or retired-workflow marker
  while still refusing `/`, user home, the source repository, and a zero-marker
  directory. `/tmp/spec-agents-pure-retired.sno8Rh` proves doctrine replacement
  succeeds before the sole retired marker moves, keeps the application hash
  unchanged, does not create `CONTEXT.md`, and still refuses a plain target.
- The full entry matrix then exposed three more strong retired-marker families
  that the guard documented but did not recognise: root bundles, tracked
  scratch SPECs, and phase/pre-split layouts. The guard now recognises those as
  evidence for the same replacement command, without adding a conversion path.
  `/tmp/spec-agents-retired-marker-matrix.du4OWv` proves root-bundle,
  scratch-SPEC, phase-STATUS, and pre-split-CONTEXT targets independently;
  each keeps its application hash and a zero-marker target still refuses.
