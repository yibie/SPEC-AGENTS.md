# Runbooks

Use one Markdown file per repeatable project operation: deployment, release,
rollback, incident response, data repair, or environment setup.

Each runbook should state:

1. scope and owner;
2. preconditions and permissions;
3. ordered steps;
4. verification and expected result;
5. rollback or recovery path;
6. source Evidence ID and review status.

An unverified suggestion belongs in `EVIDENCE.md`, not here. Update a runbook
through `plan` and `learn` when its preconditions, effects, or verification
contract changes.
