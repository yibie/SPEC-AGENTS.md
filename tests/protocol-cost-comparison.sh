#!/bin/bash
set -euo pipefail

# Compare the protocol overhead of legacy SPEC-AGENTS v2 and SPEC-AGENTS v3.
# The benchmark uses the same product request in both layouts, then measures
# the default context an agent must read before implementation.

KEEP=false
if [ "${1:-}" = "--keep" ]; then
  KEEP=true
fi

ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-protocol-cost.XXXXXX")"
if [ "$KEEP" != true ]; then
  trap 'rm -rf "$ROOT"' EXIT
fi

V2="$ROOT/v2"
V3="$ROOT/v3"

mkdir -p "$V2/.phrase/phases/phase-shortcut-toggle-20260509" "$V2/.phrase/docs"
mkdir -p "$V3/.phrase/archive" "$V3/.phrase/adr" "$V3/.phrase/protocol"

cat > "$V2/.phrase/phases/phase-shortcut-toggle-20260509/spec_shortcut_toggle_20260509.md" <<'DOC'
# Spec: Shortcut Toggle

## Summary

Add a keyboard shortcut that toggles a visible mode in the current session.

## Goals

- The shortcut is discoverable from the command surface.
- The shortcut toggles state without requiring restart.
- The UI reflects the current state immediately.

## Non-goals

- No persistence across app restarts.
- No preference sync.
- No global shortcut registration.

## User Flow

Given the app is running, when the user triggers the shortcut, then the app
toggles the mode and displays the new state. When the user triggers it again,
the app returns to the previous state.

## Acceptance Criteria

- Toggle works twice in one session.
- UI state updates after each toggle.
- No unrelated command behavior changes.
DOC

cat > "$V2/.phrase/phases/phase-shortcut-toggle-20260509/plan_shortcut_toggle_20260509.md" <<'DOC'
# Plan: Shortcut Toggle

## Milestones

1. Identify current command handling path.
2. Add shortcut command.
3. Wire command to session state.
4. Update UI state display.
5. Verify manual toggle behavior.

## Risks

- Shortcut handling may be platform-specific.
- Existing command state may be spread across UI and core modules.
- UI refresh may require explicit invalidation.

## Rollback

Remove the shortcut binding and state transition.
DOC

cat > "$V2/.phrase/phases/phase-shortcut-toggle-20260509/task_shortcut_toggle_20260509.md" <<'DOC'
# Task List

task001 [ ] Scenario: identify command path | Given: app source exists | When: search shortcut handling | Then: command owner is known | Verify: code search notes
task002 [ ] Scenario: toggle state | Given: command owner is known | When: shortcut is triggered | Then: session mode flips | Verify: unit test
task003 [ ] Scenario: UI reflects state | Given: session mode changed | When: render updates | Then: indicator changes | Verify: manual check
task004 [ ] Scenario: no persistence | Given: app restarts | When: state initializes | Then: default mode is used | Verify: unit test
DOC

cat > "$V2/.phrase/phases/phase-shortcut-toggle-20260509/change_shortcut_toggle_20260509.md" <<'DOC'
# Change Log

change001 date:2026-05-09 | file:<pending> | operation:Modify | impact:command handling | reason:add shortcut toggle | related:task002
change002 date:2026-05-09 | file:<pending> | operation:Modify | impact:UI state | reason:display toggle state | related:task003
DOC

cat > "$V2/.phrase/phases/phase-shortcut-toggle-20260509/issue_shortcut_toggle_20260509.md" <<'DOC'
# Issues

issue001 [ ] title:shortcut owner unknown | module:command handling | priority:P1 | related:task001
DOC

cat > "$V2/.phrase/docs/PHASES.md" <<'DOC'
# Phases

- phase-shortcut-toggle-20260509: add current-session shortcut toggle.
DOC

cat > "$V2/.phrase/docs/CHANGE.md" <<'DOC'
# Change Index

- change001: pending shortcut command change.
- change002: pending UI display change.
DOC

cat > "$V2/.phrase/docs/ISSUES.md" <<'DOC'
# Issue Index

- issue001 [ ] shortcut owner unknown.
DOC

cat > "$V3/.phrase/decision.md" <<'DOC'
# Decision Framework

## Principles

- Read minimal current context.
- Define boundaries before implementation details.
- Verify before claiming completion.

## Durable Boundaries

- This phase may add only current-session behavior.
- No persistence, preference sync, or global shortcut registration.
DOC

cat > "$V3/.phrase/roadmap.md" <<'DOC'
# Roadmap

## Phase: Shortcut Toggle

Status: Planned

Goal: Add a current-session shortcut toggle.

Entry condition: command handling path exists.

Acceptance gate:

- Toggle works twice in one session.
- UI state updates after each toggle.
- No unrelated command behavior changes.
DOC

cat > "$V3/.phrase/current.md" <<'DOC'
# Current Phase

## Goal

Add a keyboard shortcut that toggles a visible mode in the current session.

## Scope

- Command handling path.
- Current-session state.
- UI state indicator.

## Out Of Scope

- Persistence across restarts.
- Preference sync.
- Global shortcut registration.

## Active Task Slice

task001 [ ] goal:toggle current-session mode via shortcut | scope:command/state/UI indicator | verify:unit test plus manual double-toggle check

## Verification Plan

- Unit test state toggle.
- Manual double-toggle check.
- Confirm no persistence behavior was added.
DOC

cat > "$V3/.phrase/evidence.md" <<'DOC'
# Evidence

## 2026-05-09: baseline

Observation:

- No shortcut implementation has been measured yet.

Interpretation:

- Start by identifying command ownership, then implement only the current-session slice.

Recommended next action:

- Execute task001 and record verification result after tests.
DOC

count_files() {
  find "$1" -type f | wc -l | tr -d ' '
}

count_bytes() {
  find "$1" -type f -print0 | xargs -0 wc -c | tail -n 1 | awk '{print $1}'
}

count_words() {
  find "$1" -type f -print0 | xargs -0 wc -w | tail -n 1 | awk '{print $1}'
}

estimate_tokens() {
  awk -v bytes="$1" 'BEGIN { printf "%.0f", bytes / 4 }'
}

percent_saved() {
  awk -v old="$1" -v new="$2" 'BEGIN {
    if (old == 0) { print "n/a"; }
    else { printf "%.1f%%", (old - new) * 100 / old; }
  }'
}

v2_default="$V2/.phrase"
v3_default="$V3/.phrase/decision.md $V3/.phrase/roadmap.md $V3/.phrase/current.md"

v2_files=$(count_files "$v2_default")
v2_bytes=$(count_bytes "$v2_default")
v2_words=$(count_words "$v2_default")
v2_tokens=$(estimate_tokens "$v2_bytes")

v3_files=3
v3_bytes=$(wc -c $v3_default | tail -n 1 | awk '{print $1}')
v3_words=$(wc -w $v3_default | tail -n 1 | awk '{print $1}')
v3_tokens=$(estimate_tokens "$v3_bytes")

cat <<REPORT
# SPEC-AGENTS Protocol Cost Comparison

Scenario: add a current-session keyboard shortcut toggle.

| Metric | v2 static SPEC | v3 EDPP | Saved |
| --- | ---: | ---: | ---: |
| Default read files | $v2_files | $v3_files | $(percent_saved "$v2_files" "$v3_files") |
| Default read words | $v2_words | $v3_words | $(percent_saved "$v2_words" "$v3_words") |
| Default read bytes | $v2_bytes | $v3_bytes | $(percent_saved "$v2_bytes" "$v3_bytes") |
| Estimated read tokens | $v2_tokens | $v3_tokens | $(percent_saved "$v2_tokens" "$v3_tokens") |
| Required write surfaces after implementation | 5 | 2 | $(percent_saved 5 2) |

Interpretation:

- v2 reads the whole phase bundle plus global indexes before work.
- v3 reads only decision, roadmap, and current phase by default.
- v2 usually writes task, change, issue/spec updates, and indexes after work.
- v3 writes verification evidence and updates current/roadmap only when the phase changes.

This benchmark measures protocol overhead, not model intelligence or code quality.
Run it again after changing templates to see whether protocol cost moved.

REPORT

if [ "$KEEP" = true ]; then
  echo "Fixture kept at: $ROOT"
fi
