# Shell Change Validation

status: active
scope: executable Bash files under `bin/` and `tests/`
applies_when: a task changes a `.sh` file or installer behavior
owner: project maintainer
source: E-20260817-005; `research/experiments/project-knowledge-routing-pilot/`
verification: run `bash -n` for each changed script, then the repository's read-only diff check (`jj diff` in a JJ repo, `git diff --check` otherwise); installer changes also run the local installer smoke Runbook

## Practice

Keep shell changes small and prove them at the shell boundary before claiming
completion:

1. Parse every changed script with `bash -n`.
2. In a JJ repository, inspect `jj status` and `jj diff`. In a Git-only
   repository, run `git diff --check` from the repository root. These are
   read-only checks; do not create a bookmark or push.
3. If installer behavior or the installed file set changed, run the
   [local installer smoke Runbook](../runbooks/installer-smoke.md).

This is a verification practice, not a requirement to rewrite existing shell
files or to add a new shell abstraction.
