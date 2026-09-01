#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
SOURCE_CLI="$REPO_ROOT/.spec-agents/doctrine/bin/spec-agents"
TRIAL_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-workflow.XXXXXX")"
trap 'rm -rf "$TRIAL_ROOT"' EXIT

passed=0
failed=0

pass() {
  passed=$((passed + 1))
  printf 'ok: %s\n' "$1"
}

fail() {
  failed=$((failed + 1))
  printf 'FAIL: %s\n' "$1" >&2
}

expect() {
  local label="$1"
  shift
  if "$@"; then pass "$label"; else fail "$label"; fi
}

expect_output() {
  local label="$1" expected="$2" file="$3"
  if grep -Fq "$expected" "$file"; then pass "$label"; else fail "$label"; fi
}

expect_absent() {
  local label="$1" unexpected="$2" file="$3"
  if ! grep -Fq "$unexpected" "$file"; then pass "$label"; else fail "$label"; fi
}

assert_markdown_links() {
  local root="$1" markdown dir link target broken=0
  while IFS= read -r markdown; do
    dir="$(dirname "$markdown")"
    while IFS= read -r link; do
      [ -n "$link" ] || continue
      case "$link" in
        /*) target="$root$link" ;;
        *) target="$dir/$link" ;;
      esac
      if [ ! -e "$target" ]; then
        printf 'broken Markdown link: %s -> %s\n' "$markdown" "$link" >&2
        broken=1
      fi
    done < <(grep -o '](\([^)h][^)]*\.md\))' "$markdown" | sed 's/](\(.*\))/\1/')
  done < <(find -L "$root/.spec-agents/doctrine" -type f -name '*.md' -print)
  [ "$broken" -eq 0 ]
}

run_capture() {
  local output="$1" error="$2"
  shift 2
  local rc=0
  "$@" >"$output" 2>"$error" || rc=$?
  return "$rc"
}

make_fixture() {
  local root="$1"
  "$SOURCE_CLI" install "$root" cn </dev/null >"$TRIAL_ROOT/install-$(basename "$root").out"
  mkdir -p "$root/.spec-agents/specs/feature/issues" "$root/.spec-agents/state"
  cat > "$root/.spec-agents/specs/feature/SPEC.md" <<'EOF'
# feature

status: confirmed
revision: 1
kernel_delta:
  - revise: workflow root (layout)

## Model delta

The installed workflow resolves its own canonical root.

## Issue map

- 01-run
EOF
  cat > "$root/.spec-agents/specs/feature/issues/01-run.md" <<'EOF'
# 01 run

status: ready
blocked_by:
authority: n/a: workflow path resolution
spec_ref: .spec-agents/specs/feature/SPEC.md
writer:
evidence_ref:

## Goal

Exercise the installed CLI from a nested path.
EOF
  cat > "$root/.spec-agents/specs/feature/issues/02-dependent.md" <<'EOF'
# 02 dependent

status: ready
blocked_by: 01
authority: n/a: workflow path resolution
spec_ref: .spec-agents/specs/feature/SPEC.md
writer:
evidence_ref:

## Goal

Exercise canonical dependency discovery.
EOF
}

NO_VCS="$TRIAL_ROOT/no-vcs"
make_fixture "$NO_VCS"
INSTALLED_CLI="$NO_VCS/.spec-agents/doctrine/bin/spec-agents"
NESTED="$NO_VCS/.spec-agents/specs/feature/issues"
managed_cli() { (cd "$NO_VCS" && "$INSTALLED_CLI" "$@"); }

expect "installed Doctrine Markdown links resolve in the managed root" \
  assert_markdown_links "$NO_VCS"

run_capture "$TRIAL_ROOT/status-root.out" "$TRIAL_ROOT/status-root.err" \
  managed_cli status
expect_output "status sees the canonical SPEC from project root" \
  "confirmed  0/2 slices done" "$TRIAL_ROOT/status-root.out"
run_capture "$TRIAL_ROOT/status-nested.out" "$TRIAL_ROOT/status-nested.err" \
  bash -c "cd '$NESTED' && '$INSTALLED_CLI' status"
expect_output "status resolves the canonical project root from a nested directory" \
  "confirmed  0/2 slices done" "$TRIAL_ROOT/status-nested.out"

run_capture "$TRIAL_ROOT/ready.out" "$TRIAL_ROOT/ready.err" \
  bash -c "cd '$NESTED' && '$INSTALLED_CLI' ready"
expect_output "ready discovers canonical slices from a nested directory" \
  ".spec-agents/specs/feature/issues/01-run.md" "$TRIAL_ROOT/ready.out"
expect_absent "ready suppresses the slice whose dependency is unfinished" \
  "02-dependent.md" "$TRIAL_ROOT/ready.out"

run_capture "$TRIAL_ROOT/gate.out" "$TRIAL_ROOT/gate.err" \
  bash -c "cd '$NESTED' && '$INSTALLED_CLI' gate do 01-run.md"
expect_output "gate do resolves the canonical SPEC and prints its Model delta pointer" \
  ".spec-agents/specs/feature/SPEC.md: ## Model delta" "$TRIAL_ROOT/gate.out"
expect_output "gate do cites the installed canonical do skill" \
  ".spec-agents/doctrine/skills/do/SKILL.md" "$TRIAL_ROOT/gate.out"

run_capture "$TRIAL_ROOT/transition.out" "$TRIAL_ROOT/transition.err" \
  bash -c "cd '$NESTED' && '$INSTALLED_CLI' transition 01-run.md doing"
expect_output "transition updates only the canonical Slice" "01-run.md → doing" "$TRIAL_ROOT/transition.out"
run_capture "$TRIAL_ROOT/check-state.out" "$TRIAL_ROOT/check-state.err" \
  bash -c "cd '$NESTED' && '$INSTALLED_CLI' check-state"
expect_output "check-state reads canonical state from a nested directory" \
  "ok: no state violations." "$TRIAL_ROOT/check-state.out"

mkdir -p "$NO_VCS/.specs/legacy/issues"
printf '%s\n' 'status: confirmed' > "$NO_VCS/.specs/legacy/SPEC.md"
printf '%s\n' 'status: ready' > "$NO_VCS/.specs/legacy/issues/01-old.md"
printf '%s\n' '# retired root Kernel must be ignored' > "$NO_VCS/KERNEL.md"
run_capture "$TRIAL_ROOT/old-paths.out" "$TRIAL_ROOT/old-paths.err" \
  managed_cli status
expect_absent "managed status ignores retired root .specs records" "legacy" "$TRIAL_ROOT/old-paths.out"
expect_output "managed status continues to use canonical records beside old paths" \
  "confirmed" "$TRIAL_ROOT/old-paths.out"

mkdir -p "$NO_VCS/.spec-agents/state"
printf '%s\n' '# canonical K1 placeholder' > "$NO_VCS/.spec-agents/state/KERNEL.md"
run_capture "$TRIAL_ROOT/k1-check.out" "$TRIAL_ROOT/k1-check.err" \
  managed_cli check-state
expect_output "check-state reads the namespaced Kernel path" \
  "ok: no state violations." "$TRIAL_ROOT/k1-check.out"

run_capture "$TRIAL_ROOT/blocked-ready.out" "$TRIAL_ROOT/blocked-ready.err" \
  managed_cli ready
expect_output "ready keeps dependent work blocked after the first Slice starts" \
  "note: no slice is ready." "$TRIAL_ROOT/blocked-ready.out"

GIT_ROOT="$TRIAL_ROOT/git"
mkdir -p "$GIT_ROOT"
git -C "$GIT_ROOT" init -q
make_fixture "$GIT_ROOT"
run_capture "$TRIAL_ROOT/git-nested.out" "$TRIAL_ROOT/git-nested.err" \
  bash -c "cd '$GIT_ROOT/.spec-agents/specs/feature/issues' && '$GIT_ROOT/.spec-agents/doctrine/bin/spec-agents' status"
expect_output "Git project resolves the installed namespaced root" \
  "confirmed  0/2 slices done" "$TRIAL_ROOT/git-nested.out"

JJ_ROOT="$TRIAL_ROOT/jj"
mkdir -p "$JJ_ROOT"
(cd "$JJ_ROOT" && jj git init --colocate >/dev/null 2>&1)
make_fixture "$JJ_ROOT"
run_capture "$TRIAL_ROOT/jj-nested.out" "$TRIAL_ROOT/jj-nested.err" \
  bash -c "cd '$JJ_ROOT/.spec-agents/specs/feature/issues' && '$JJ_ROOT/.spec-agents/doctrine/bin/spec-agents' status"
expect_output "native-JJ project resolves the installed namespaced root" \
  "confirmed  0/2 slices done" "$TRIAL_ROOT/jj-nested.out"

LONE_ROOT="$TRIAL_ROOT/lone"
mkdir -p "$LONE_ROOT/.specs/legacy"
if run_capture "$TRIAL_ROOT/lone.out" "$TRIAL_ROOT/lone.err" \
  bash -c "cd '$LONE_ROOT' && '$SOURCE_CLI' check-state"; then
  fail "lone retired .specs path refuses project-root detection"
else
  pass "lone retired .specs path refuses project-root detection"
fi

PARTIAL_ROOT="$TRIAL_ROOT/partial"
mkdir -p "$PARTIAL_ROOT/.spec-agents/doctrine"
printf '%s\n' 'Read `.spec-agents/doctrine/AGENTS.md`.' > "$PARTIAL_ROOT/AGENTS.md"
if run_capture "$TRIAL_ROOT/partial.out" "$TRIAL_ROOT/partial.err" \
  bash -c "cd '$PARTIAL_ROOT' && '$SOURCE_CLI' check-state"; then
  fail "partial namespaced Doctrine refuses project-root detection"
else
  pass "partial namespaced Doctrine refuses project-root detection"
fi

if [ "$failed" -ne 0 ]; then
  printf 'namespaced workflow check: %d failure(s), %d passed\n' "$failed" "$passed" >&2
  exit 1
fi
printf 'namespaced workflow check: %d/%d\n' "$passed" "$passed"
