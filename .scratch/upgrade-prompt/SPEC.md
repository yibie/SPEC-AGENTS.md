# Prompt-driven Project Upgrade

status: confirmed
revision: 1
context_refs: `CONTEXT.md`, `AGENTS.md`, `ROADMAP.md`, `STATUS.md`

## Problem and goal

Existing v2 and v3 projects need to preserve project cognition before they can
adopt the modern root layout. A shell installer cannot reconstruct recent
history or confirm a code architecture. Provide one upgrade Prompt that an
Agent runs after installing the modern entry points.

## Unchanged contracts

- Fresh installs contain only the modern root layout and six action skills.
- The installer does not move, delete, summarize, or overwrite project data.
- Existing `.phrase` material is temporary migration input, not a supported
  runtime mode.
- Semantic model changes require user confirmation before promotion.
- Code changes remain out of scope for the upgrade pass.

## Decision and boundaries

Add root `UPGRADE.md` as the single v2/v3 upgrade Prompt. It has two gates:

1. reconnaissance: classify the legacy source, reconstruct recent history,
   scan the code architecture, and write a candidate report;
2. cutover: after the user confirms the report, promote durable knowledge into
   root documents, archive legacy material, and verify the modern read path.

The installer only installs `UPGRADE.md` and warns when `.phrase` is present.
The mechanical `upgrade` CLI and automatic archive behavior are removed.

## Model delta

Legacy migration becomes a user-confirmed semantic activity driven by a Prompt,
not an `InstallMode` or an installer-side `UpgradeSource` implementation.

## Action Contracts

- `init`/`install` install the modern entry points and `UPGRADE.md`.
- If legacy markers are present, the installer prints a pointer to
  `UPGRADE.md` and leaves the project unchanged apart from new entry points.
- `UPGRADE.md` must stop after reconnaissance and ask for confirmation before
  editing root model documents, archiving legacy material, or changing code.
- After confirmation, `UPGRADE.md` uses the six actions and records a handoff,
  evidence delta, and archive path.

## Verification

- Prompt has explicit v2/v3 detection, reconnaissance, confirmation, cutover,
  and completion gates.
- Fresh install includes `UPGRADE.md`; install into an old project preserves
  `.phrase` and prints the pointer.
- `upgrade` is no longer a supported CLI command; `--legacy` is not advertised.
- Six skill validators, discovery, syntax, and whitespace checks pass.

## Out of scope

- Automatic history summarization or architecture inference by Bash.
- Automatic code changes during upgrade.
- Formal ontology schemas, graph storage, or synchronization.
- Real-project migration in this phase.

## Revision notes

Revision 1 replaces the mechanical v2/v3 CLI upgrade with a single
user-confirmed Prompt and a deliberately simple installer.
