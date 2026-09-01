#!/bin/bash
# check-kernel.sh — verify the FORM of a project Kernel's authority map.
#
# It checks that entries parse, that the paths they name exist, and that a
# `derived` rule carries no second site. It does NOT check that the map is
# complete or that its entries are true: a map can be perfectly formed and
# wrong. Judging whether a rule really lives where the map says is the job of
# `check`'s placement item.
#
# Usage:  .spec-agents/doctrine/docs/check-kernel.sh [project-root]
# Exit:   0 pass or nothing to check, 1 one or more failures.

set -u
ROOT="${1:-.}"
KERNEL="$ROOT/.spec-agents/state/KERNEL.md"
fail=0

note() { echo "note: $*"; }
bad()  { echo "FAIL: $*" >&2; fail=1; }

if [ ! -f "$KERNEL" ]; then
  note "no .spec-agents/state/KERNEL.md in $ROOT — nothing to check."
  exit 0
fi

section=$(awk '/^## Architecture boundaries[[:space:]]*$/{f=1;next} /^## /{f=0} f' "$KERNEL")
if [ -z "$(printf '%s' "$section" | tr -d '[:space:]')" ]; then
  note ".spec-agents/state/KERNEL.md has no Architecture boundaries entries — the authority map is a gap, not a failure."
  exit 0
fi

entry_re='^- .+ — authority: `[^`]+` \| (owned|source-backed|derived)[[:space:]]*$'
site_re='^[[:space:]]+second site: `[^`]+`'

current_state=""
current_rule=""

while IFS= read -r line; do
  case "$line" in
    "") continue ;;
    "- "*)
      if printf '%s' "$line" | grep -Eq "$entry_re"; then
        current_rule=$(printf '%s' "$line" | sed -E 's/^- (.+) — authority.*/\1/')
        current_state=$(printf '%s' "$line" | sed -E 's/.*\| ([a-z-]+)[[:space:]]*$/\1/')
        path=$(printf '%s' "$line" | sed -E 's/.*authority: `([^`]+)`.*/\1/')
        [ -e "$ROOT/$path" ] || bad "authority path does not exist: $path  (rule: $current_rule)"
      else
        bad "entry does not match the required form: $line"
        current_state=""; current_rule=""
      fi
      ;;
    *)
      if printf '%s' "$line" | grep -Eq "$site_re"; then
        [ "$current_state" = "derived" ] && \
          bad "a derived rule must have no second site (rule: $current_rule)"
        sp=$(printf '%s' "$line" | sed -E 's/.*second site: `([^`]+)`.*/\1/')
        [ -e "$ROOT/$sp" ] || bad "second site does not exist: $sp  (rule: $current_rule)"
        if printf '%s' "$line" | grep -q 'equivalence test:'; then
          et=$(printf '%s' "$line" | sed -E 's/.*equivalence test: `([^`]+)`.*/\1/')
          [ -e "$ROOT/$et" ] || bad "equivalence test does not exist: $et  (rule: $current_rule)"
        else
          bad "second site has no equivalence test (rule: $current_rule)"
        fi
      else
        bad "unrecognised line under Architecture boundaries: $line"
      fi
      ;;
  esac
done <<< "$section"

[ "$fail" -eq 0 ] && echo "ok: authority map form is valid."
exit "$fail"
