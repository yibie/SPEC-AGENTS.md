# SPEC-AGENTS doctrine

Everything in this directory is framework material. It is identical in every
project that installs SPEC-AGENTS, and the SPEC-AGENTS installer is the only
thing that writes it. Do not edit these files as part of project work — a local edit is
overwritten by the next install and is invisible to every other project.

- `WORKFLOW.md` — the workflow's stable semantic model: the concepts,
  relations, lifecycles, and invariants behind the six actions.
- `evidence-links.md` — when a Slice may carry an Evidence ID, and who writes it.
- `knowledge-promotion.md` — where a verified fact belongs once `learn`
  classifies it.
- `parallel-work.md` — when several SPECs may be active, and when concurrent
  work needs its own working copy.
- `jj-change-management.md` — local version control in a project with `.jj/`.
- `jj-project-setup.md` — enabling colocated JJ, only on an explicit user choice.

Your project's own knowledge does not live here. It lives in `KERNEL.md`,
`CONTEXT.md`, `STATUS.md`, `EVIDENCE.md`, and the knowledge
classes under `docs/adr/`, `docs/protocols/`, `docs/runbooks/`, and
`docs/lessons/`. To change how the framework itself works, change it upstream in
the SPEC-AGENTS repository, not here.
