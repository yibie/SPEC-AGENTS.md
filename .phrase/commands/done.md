---
description: Save session summary (discussions, decisions, issues, next steps) to a markdown file
---

# /done — Session Wrap-up

At the end of a working session, review the full conversation and save a structured summary to a markdown file.

## Steps

1. **Determine save path**: `.claude/sessions/` inside the current project root. Create it if it doesn't exist.

2. **Generate filename**: `YYYY-MM-DD_<branch>.md`
   - Date: `date +"%Y-%m-%d"`
   - Branch: `git rev-parse --abbrev-ref HEAD` (use `no-git` if not a git repo)
   - If the file already exists, append `_2`, `_3`, etc.

3. **Write the file** with this header and sections:

```markdown
# Session: <branch> — <date>

> Project: <project name or directory>
> Branch: <branch>
> Date: <date>

## Summary
2–4 sentences on what was accomplished.

## Discussions
- Topics explored, questions asked, context reviewed

## Key Decisions
- Decisions made, approaches chosen, trade-offs accepted (with reasoning)

## Issues & Blockers
- Unresolved problems or open questions. Write _None_ if empty.

## Next Steps
- Follow-up tasks for next session. Write _None_ if empty.

## Files Changed
(output of `git diff --name-only` and `git status --short`)
(skip if not a git repo)
```

4. **Confirm** by printing the full path of the saved file.

## Constraints

- Only record what actually happened — do not invent content
- Keep it scannable; preserve technical specifics (file names, function names, error messages)
- If the session was short, still write the file but note it briefly in the summary
