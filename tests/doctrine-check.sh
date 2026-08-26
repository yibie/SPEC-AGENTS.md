#!/bin/bash
# doctrine-check.sh — checks this repository's own doctrine. Instance, not shipped.
#
# It enforces the three things STATUS.md had been carrying as "depends on
# someone remembering to look". Each one has already failed here at least once.
#
# Usage: tests/doctrine-check.sh   (from the repository root)

set -u
fail=0
bad() { echo "FAIL: $*" >&2; fail=1; }

# 1. The mandatory read has a ceiling. It grew from 299 to 586 lines in two days
#    without any single addition looking unreasonable.
LIMIT=400
n=$(( $(wc -l < AGENTS.md) + $(wc -l < docs/spec-agents/WORKFLOW.md) ))
if [ "$n" -gt "$LIMIT" ]; then
  bad "mandatory read is $n lines, over the $LIMIT ceiling. Remove something before adding."
else
  echo "ok: mandatory read $n/$LIMIT lines."
fi

# 2. Rationale was moved into ADRs and the rules left pointers. A pointer to a
#    missing ADR loses the reasoning entirely.
missing=0
for adr in $(grep -oh "ADR 0[0-9][0-9][0-9]" AGENTS.md AGENTS_en.md docs/spec-agents/*.md 2>/dev/null | sort -u | awk '{print $2}'); do
  ls docs/adr/"$adr"-*.md >/dev/null 2>&1 || { bad "ADR $adr is referenced but has no file."; missing=1; }
done
[ "$missing" -eq 0 ] && echo "ok: every ADR pointer resolves."

# 3. Version headings get renumbered at release. A citation of a heading that no
#    longer exists sends the reader nowhere.
stale=0
for v in $(grep -roh "CHANGELOG \[\?[0-9]\+\.[0-9]\+\.[0-9]\+\]\?" --include="*.md" . 2>/dev/null \
           | grep -v "^./archive/" | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" | sort -u); do
  grep -q "^## \[$v\]" CHANGELOG.md || { bad "a file cites CHANGELOG $v, which has no heading."; stale=1; }
done
[ "$stale" -eq 0 ] && echo "ok: no stale CHANGELOG citation."

exit "$fail"
