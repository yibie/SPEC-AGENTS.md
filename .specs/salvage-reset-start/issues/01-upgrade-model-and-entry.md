# 01 Replace conversion with salvage and reset

status: done
blocked_by:
authority: `docs/spec-agents/WORKFLOW.md` — Upgrade and ProjectState
spec_ref: `.specs/salvage-reset-start/SPEC.md`
context_ref: `UPGRADE.md`, `START.md`, `docs/spec-agents/WORKFLOW.md`, `README.md`
evidence_ref: E-20260831-004

## Goal

Make every existing-project entry use one preservation-manifest and reset flow,
with no v2/v3/phase conversion branch and no inherited execution state.

## Scope

- `UPGRADE.md`
- `START.md`
- `docs/spec-agents/WORKFLOW.md`
- `README.md`
- the retired-marker and existing-project entry sections in `AGENTS.md` and
  `AGENTS_en.md`
- `bin/spec-agents` (upgrade-entry messages only; replacement implementation
  remains slice 02)

## Acceptance

- `UPGRADE.md` has one route: inspect, write the exact disposition manifest,
  stop for confirmation, recoverably remove approved retired state, replace
  doctrine, and hand off to a fresh START.
- The prompt does not construct KERNEL, CONTEXT, STATUS, EVIDENCE, SPEC, or
  Slice state from an old lifecycle. Still-current intent is recaptured later.
- `START.md` uses `modern`, `upgrade-needed`, `missing-entry`, and `blocked`,
  routes every active retired-marker family to the current upstream UPGRADE
  prompt, and ignores archived-only markers by default.
- `WORKFLOW.md` enacts the SPEC's four declared Kernel deltas exactly: Upgrade
  is added, ProjectState is revised, Legacy Upgrade Boundary is retired, and
  Upgrade Boundary is added.
- README installation and upgrade instructions no longer say to install over
  an old project and trust the possibly stale installed UPGRADE prompt.
- Both AGENTS entry documents route every retired-marker family to the current
  upstream review and describe salvage/reset/fresh START instead of history
  reconstruction.
- CLI help and rejected legacy/upgrade invocations point to the current
  upstream review and never instruct an install-over-first sequence.
- No compatibility conversion instructions remain live outside explicit
  history under `.specs/`, `EVIDENCE.md`, `archive/`, or `research/`.

## Verification

- Search the live doctrine and README for the retired state names and the old
  conversion verbs; every remaining hit is history or an explicit rejection.
- Exercise START text against clean-modern, active-retired-marker,
  archived-only-marker, missing-entry, and unknown-ownership fixtures.
- Resolve every changed Markdown reference and run `tests/doctrine-check.sh`,
  `spec-agents check-state`, Kernel checks, and `git diff --check`.

## Evidence

Implementation verification handed to `check` on 2026-08-31:

- `UPGRADE.md` is one 6-step salvage/reset/fresh-START prompt with one four-way
  disposition manifest. The five doctrine paths are explicitly left for
  `replace-doctrine`; old state paths are never converted into current
  lifecycle state.
- START's route table has four ProjectState values, every retired-marker family
  routes to the current upstream prompt, archived markers are excluded, and an
  `upgrade-needed` pass writes no Kernel before reset.
- The three enacted Workflow sections normalize byte-for-byte to the SPEC's
  declared Upgrade, ProjectState, and Upgrade Boundary paragraphs; the Legacy
  Upgrade Boundary heading is absent.
- `/tmp/spec-agents-entry-docs.OSaJlV`: a fresh English install contains
  byte-identical AGENTS, START, UPGRADE, and Workflow entry documents; all
  installed relative Markdown references resolve.
- Both AGENTS files now route active retired markers to the current upstream
  review and state salvage/reset/fresh START. CLI help, refusal messages, and
  both live README languages carry the same entry order.
- An implementation pass found two omitted consumers before `check`: the CLI
  refusal text and the AGENTS existing-project section. Slice scope was paused,
  narrowed against `authority-order` by section, and corrected without adding
  a Slice or a conversion fallback.
- Static route/model assertions, `tests/doctrine-check.sh` (400/400),
  `spec-agents check-state`, `docs/spec-agents/check-kernel.sh .`,
  `bash -n bin/spec-agents`, installed reference checks, and
  `git diff --check`: pass.
