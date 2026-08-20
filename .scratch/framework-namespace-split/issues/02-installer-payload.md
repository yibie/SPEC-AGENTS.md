# 02 Rewrite the installer payload

status: done
blocked_by: 01
spec_ref: `.scratch/framework-namespace-split/SPEC.md`
context_ref: `docs/spec-agents/WORKFLOW.md`
evidence_ref: `E-20260820-001`
## Goal

Make `bin/spec-agents` emit only doctrine, from an explicit allowlist, and
never emit this repository's instance state.

## Scope

- `bin/spec-agents`

## Acceptance

- installed set is exactly `AGENTS.md`, `START.md`, `UPGRADE.md`,
  `CONTEXT.md` (from `templates/`), `docs/spec-agents/`, and the six skills;
- `STATUS.md`, `ROADMAP.md`, `EVIDENCE.md`, `archive/`, `docs/adr/`,
  `docs/protocols/`, `docs/runbooks/`, and `docs/lessons/` are not installed;
- `docs/` is written through an explicit allowlist, not directory enumeration;
- `templates/`-sourced files are copied even under `--link`;
- an existing target file is still kept, and the source repository is still
  refused;
- the completion message lists what was installed and what the project owns.

## Verification

`bash -n bin/spec-agents`, then the installer smoke Runbook including the
leakage and `--link` assertions from issue 05.
