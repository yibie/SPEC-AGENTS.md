# 04 The gates read the declaration

status: done
blocked_by: 01, 02, 03
writer: do
authority: `.spec-agents/doctrine/skills/capture/SKILL.md` — the CLI enforces the capture contract's field rule and cites it (ADR 0007: the tool never reproduces the skill)
spec_ref: `.spec-agents/specs/kernel-delta-declaration/SPEC.md`
context_ref: `docs/adr/0007-workflow-cli.md`
evidence_ref: `E-20260829-019`

## Goal

The declaration becomes machine-checked at the two points where dropping it
was silent: entering `do` and closing a SPEC.

## Scope

- `bin/spec-agents`
- `tests/` (fixtures for the three seams)

## Acceptance

- `gate do` refuses when the slice's SPEC declares `kernel_delta` entries but
  has no non-empty `## Model delta` section, and refuses a present-but-empty
  field; the refusal names `skills/capture/SKILL.md`;
- a SPEC without the field passes unchanged (legacy default);
- when entries exist, `gate do`'s ok output points at the SPEC's Model delta —
  a pointer, no skill prose;
- `check-state`, in a project with `KERNEL.md`: a `verified` SPEC with delta
  entries must resolve each entry to Kernel provenance citing that SPEC;
  skipped when no `KERNEL.md` exists;
- fixtures cover all three seams: entries-without-section refused,
  absent-field passing, empty-field refused;
- `spec-agents check-state` exits 0 across this repository's real SPECs.

## Verification

Run the fixtures; each behaves as accepted. `bin/spec-agents check-state`
exits 0. `tests/doctrine-check.sh` passes.

## Evidence

Run summary (not an Evidence record; `evidence_ref` stays empty for `learn`):

- Helpers added in `bin/spec-agents`: `kernel_delta_kind` uses awk to classify the
  pre-heading field as `absent`, `none`, `empty`, or `entries`; `model_delta_nonempty`
  succeeds only when `## Model delta` contains a non-blank line before the next `## `;
  `resolve_spec_path` accepts root-relative and slice-relative `spec_ref` values and
  falls back to the feature's `../SPEC.md`; `kernel_source_cites` checks `source:`
  lines for the SPEC path or feature directory/name.
- Exact `gate do` refusal strings are:
  `❌ refused: SPEC .specs/feature/SPEC.md declares kernel_delta entries but has no non-empty ## Model delta section (skills/capture/SKILL.md).`
  and
  `❌ refused: SPEC .specs/feature/SPEC.md has a present-but-empty kernel_delta field (skills/capture/SKILL.md).`
  The new check-state violation is:
  `✗ .specs/feature/SPEC.md: verified kernel_delta entries lack KERNEL.md source provenance for .specs/feature/SPEC.md (skills/learn/SKILL.md)`.
- The `check-state` resolution check proves only that, when the project has
  `KERNEL.md`, each `verified` SPEC with entries has at least one `source:` line
  containing its relative SPEC path, `.specs/<feature>` path, or feature name. It
  does not prove per-entry matching, semantic correspondence, or that the source
  record is attached to every promoted entry; it is skipped when `KERNEL.md` is absent.
- Fixture results: all seven cases passed — entries without Model delta refused,
  absent field passed with today's unchanged ok line, present-empty refused, entries
  with content passed with a pointer, explicit `none` passed unchanged, cited
  provenance passed, and uncited provenance refused naming the SPEC.
- Verification: `bash -n bin/spec-agents` and the fixture script passed;
  `tests/kernel-delta-check.sh` printed all cases `ok`; repository
  `bin/spec-agents check-state` exited 0; `gate do` on this slice exited 0 and
  printed `pointer: .specs/kernel-delta-declaration/SPEC.md: ## Model delta`;
  `tests/doctrine-check.sh` passed at 389/400. `git diff --stat bin/spec-agents
  tests/` reported the existing tracked CLI/README hunks (321 insertions, 1
  deletion); the new executable fixture script is untracked and therefore omitted
  by that command.
- Ontology answer: no new concept, identity, relation, lifecycle, or invariant was
  added. This enforces Action Contracts already declared by the SPEC. The new
  `gate do` refusal is not a new Action Contract; it is the executable enforcement
  of the SPEC's existing `spec-agents gate do` contract.

Left at `doing` as required; `evidence_ref` remains empty. No `KERNEL.md`,
`EVIDENCE.md`, `STATUS.md`, `CHANGELOG.md`, SPEC, or other out-of-scope file was
written.

## Post-check correction

- Replaced the per-SPEC substring check with per-entry resolution. Declaration
  lines accept one or more ASCII spaces before `- ` (tabs remain invalid); each
  `add | revise | supersede | retire` entry is parsed, and text from the first
  ` (` parenthetical onward is removed before matching.
- A non-retired entry must match a trimmed `### <entry>` heading exactly, and its
  record must contain a `source:` line citing the SPEC path, feature directory,
  or feature name as a whole token. The token must be preceded by start, space,
  backtick, `(`, `;`, or `,`, and followed by end, space, backtick, `)`, `;`, `,`,
  `:`, or `. `; this rejects the `.specs/kernel-delta` versus
  `.specs/kernel-delta-declaration` common-prefix trap.
- Exact new violation forms are:
  `✗ .specs/feature/SPEC.md: add 'second entry': no Kernel record (skills/learn/SKILL.md)`;
  `✗ .specs/feature/SPEC.md: add 'second entry': Kernel record has no source citing the SPEC (skills/learn/SKILL.md)`;
  and
  `✗ .specs/feature/SPEC.md: retire 'old rule': retired Kernel record still present (skills/learn/SKILL.md)`.
  `retire` is interpreted as resolved when no matching record remains; this
  proves absence only and does not prove the historical retirement decision.
- Added fixtures for one uncited of two entries, both entries cited, the common
  prefix trap, retired records absent/present, one- and four-space indentation,
  tab refusal, and parenthetical entry names. All original seven and all new
  cases passed.
- Post-check verification: `bash -n`, `tests/kernel-delta-check.sh`, repository
  `bin/spec-agents check-state`, `tests/doctrine-check.sh`, `git diff --check`,
  and the real slice gate all passed; the slice remains `doing` with an empty
  `evidence_ref`.
- Post-check correction 2 (redo): `cites` now accepts `.` at end-of-line as a citation boundary; the period fixture brings the suite to 17 passing cases; retire behavior is unchanged.
