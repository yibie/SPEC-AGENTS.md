#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOCTRINE_ROOT="$REPO_ROOT/.spec-agents/doctrine"
CANONICAL_ROOT="$REPO_ROOT/.spec-agents/specs"
TRIAL_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-source-spec.XXXXXX")"
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

read_spec_ref() {
  awk '
    /^## / { exit }
    /^spec_ref:/ {
      v=$0
      sub(/^spec_ref:[[:space:]]*/, "", v)
      gsub(/`/, "", v)
      print v
      exit
    }' "$1"
}

assert_canonical_counts() {
  [ ! -e "$REPO_ROOT/.specs" ] || return 1
  [ "$(find "$CANONICAL_ROOT" -type f | wc -l | tr -d ' ')" -eq 129 ] || return 1
  [ "$(find "$CANONICAL_ROOT" -type f -name SPEC.md | wc -l | tr -d ' ')" -eq 27 ] || return 1
  [ "$(find "$CANONICAL_ROOT" -type f -path '*/issues/*.md' | wc -l | tr -d ' ')" -eq 101 ] || return 1
}

assert_spec_refs_resolve() {
  local f sr candidate
  while IFS= read -r f; do
    sr="$(read_spec_ref "$f")"
    [ -n "$sr" ] || continue
    candidate="$REPO_ROOT/$sr"
    if case "$candidate" in
      "$CANONICAL_ROOT"/*) [ -f "$candidate" ] ;;
      *) false ;;
    esac; then
      continue
    fi
    candidate="$(dirname "$f")/$sr"
    case "$candidate" in
      "$CANONICAL_ROOT"/*) [ -f "$candidate" ] || return 1 ;;
      *) return 1 ;;
    esac
  done < <(find "$CANONICAL_ROOT" -type f -name '*.md' -print | LC_ALL=C sort)
}

assert_feature_blockers_resolve() {
  local specs="$1" feature="$1/namespaced-project-layout/issues"
  local f dep candidate count
  for f in "$feature"/*.md; do
    [ -e "$f" ] || continue
    dep="$(awk '/^blocked_by:/{sub(/^blocked_by:[[:space:]]*/, ""); print; exit}' "$f")"
    for d in $(echo "$dep" | tr ',' ' '); do
      [ -n "$d" ] || continue
      count=0
      for candidate in "$feature/$d"-*.md; do
        [ -e "$candidate" ] || continue
        count=$((count + 1))
      done
      [ "$count" -eq 1 ] || return 1
    done
  done
}

assert_no_retired_frontmatter_tokens() {
  local f
  while IFS= read -r f; do
    if ! awk '
      /^## / { exit }
      /^(status|revision|kernel_delta|context_refs|blocked_by|writer|authority|spec_ref|context_ref|evidence_ref):/ {
        in_front=1
      }
      in_front && /^[[:space:]]*$/ { exit }
      !in_front { next }
      {
        if ($0 ~ /\.specs\// ||
            $0 ~ /docs\/spec-agents\// ||
            $0 ~ /(^|[[:space:]`])(AGENTS_en\.md|START\.md|UPGRADE\.md)/ ||
            $0 ~ /(^|[[:space:]`])skills\/(arrange|capture|check|do|learn|plan)\// ||
            $0 ~ /(^|[[:space:]`])bin\/spec-agents/ ||
            ($0 ~ /(^|[[:space:]`])STATUS\.md/ && $0 !~ /\.spec-agents\/state\/STATUS\.md/) ||
            ($0 ~ /(^|[[:space:]`])EVIDENCE\.md/ && $0 !~ /\.spec-agents\/state\/EVIDENCE\.md/) ||
            $0 ~ /(^|[[:space:]`])archive\// ||
            $0 ~ /(^|[[:space:]`])\.scratch\//) {
          bad=1
        }
      }
      END { exit bad }
    ' "$f"; then
      printf 'retired frontmatter token: %s\n' "$f" >&2
      return 1
    fi
  done < <(find "$CANONICAL_ROOT" -type f -name '*.md' -print | LC_ALL=C sort)
}

make_source_fixture() {
  local root="$TRIAL_ROOT/source"
  mkdir -p "$root/.spec-agents"
  cp "$REPO_ROOT/AGENTS.md" "$root/AGENTS.md"
  cp -R "$DOCTRINE_ROOT" "$root/.spec-agents/"
  cp -R "$CANONICAL_ROOT" "$root/.spec-agents/"
  local feature="$root/.spec-agents/specs/source-spec-cutover-fixture"
  local slice="$feature/issues/99-canonical-discovery.md"
  local adjusted="$slice.tmp"
  mkdir -p "$feature/issues"
  cp "$root/.spec-agents/specs/namespaced-project-layout/SPEC.md" "$feature/SPEC.md"
  cp "$root/.spec-agents/specs/namespaced-project-layout/issues/01-managed-install-tracer.md" "$slice"
  awk '/^status:/{print "status: ready"; next} /^blocked_by:/{print "blocked_by:"; next} /^writer:/{print "writer: do"; next} /^spec_ref:/{print "spec_ref: `.spec-agents/specs/source-spec-cutover-fixture/SPEC.md`"; next} /^evidence_ref:/{print "evidence_ref:"; next} {print}' "$slice" > "$adjusted"
  mv "$adjusted" "$slice"
  mkdir "$root/.git"
  printf '%s\n' "$root"
}

assert_source_status() {
  local root="$1" cli
  cli="$root/.spec-agents/doctrine/bin/spec-agents"
  cd "$root"
  "$cli" status | grep -F 'namespaced-project-layout' >/dev/null
}

assert_source_ready() {
  local root="$1" cli
  cli="$root/.spec-agents/doctrine/bin/spec-agents"
  cd "$root"
  "$cli" ready | grep -F '.spec-agents/specs/source-spec-cutover-fixture/issues/99-canonical-discovery.md' >/dev/null
}

assert_source_gate_matrix() {
  local root="$1" working_dir="$2" cli slice spec output
  cli="$root/.spec-agents/doctrine/bin/spec-agents"
  slice="$root/$SOURCE_SLICE"
  spec="$root/$SOURCE_SPEC"
  cd "$working_dir"
  "$cli" gate plan "$slice" >/dev/null
  "$cli" gate capture "$slice" >/dev/null
  "$cli" gate arrange "$spec" >/dev/null
  output="$("$cli" gate do "$slice")"
  grep -F '.spec-agents/specs/source-spec-cutover-fixture/SPEC.md: ## Model delta' <<< "$output" >/dev/null
  "$cli" gate check "$slice" >/dev/null
  "$cli" gate learn "$slice" >/dev/null
}

SOURCE_ROOT="$(make_source_fixture)"
SOURCE_CLI="$SOURCE_ROOT/.spec-agents/doctrine/bin/spec-agents"
SOURCE_SLICE='.spec-agents/specs/source-spec-cutover-fixture/issues/99-canonical-discovery.md'
SOURCE_SPEC='.spec-agents/specs/source-spec-cutover-fixture/SPEC.md'

expect "canonical SPEC root has no active old root and exact records" assert_canonical_counts
expect "canonical SPEC manifest has 27 SPECs and 101 Slices" bash -c '
  test "$(find "$1" -type f -name SPEC.md | wc -l | tr -d " ")" -eq 27 &&
  test "$(find "$1" -type f -path "*/issues/*.md" | wc -l | tr -d " ")" -eq 101
' bash "$CANONICAL_ROOT"
expect "all machine-readable spec_ref values resolve canonically" assert_spec_refs_resolve
expect "namespaced blocked_by prefixes resolve to exactly one Slice" assert_feature_blockers_resolve "$SOURCE_ROOT/.spec-agents/specs"
expect "current SPEC and Slice frontmatter has no retired path tokens" assert_no_retired_frontmatter_tokens
expect "source root status reads canonical SPECs" assert_source_status "$SOURCE_ROOT"
expect "source nested status reads canonical SPECs" bash -c '
  set -e
  mkdir -p "$1/nested/deep"
  cd "$1/nested/deep"
  "$1/.spec-agents/doctrine/bin/spec-agents" status | grep -Fq namespaced-project-layout
' bash "$SOURCE_ROOT"
expect "source root ready lists the canonical Slice" assert_source_ready "$SOURCE_ROOT"
expect "source nested ready lists the canonical Slice" bash -c '
  set -e
  mkdir -p "$1/nested/deep"
  cd "$1/nested/deep"
  "$1/.spec-agents/doctrine/bin/spec-agents" ready | grep -Fq ".spec-agents/specs/source-spec-cutover-fixture/issues/99-canonical-discovery.md"
' bash "$SOURCE_ROOT"
expect "source root exercises all six gates against the synthetic SPEC" \
  assert_source_gate_matrix "$SOURCE_ROOT" "$SOURCE_ROOT"
expect "source nested exercises all six gates against the synthetic SPEC" \
  assert_source_gate_matrix "$SOURCE_ROOT" "$SOURCE_ROOT/.spec-agents/specs/source-spec-cutover-fixture/issues"
expect "source root transition reaches doing" bash -c '
  set -e
  cd "$1"
  "$2" transition "$3" doing | grep -Fq "99-canonical-discovery.md → doing"
' bash "$SOURCE_ROOT" "$SOURCE_CLI" "$SOURCE_SLICE"
expect "source nested transition reaches doing" bash -c '
  set -e
  cd "$1/.spec-agents/specs/source-spec-cutover-fixture/issues"
  "$1/.spec-agents/doctrine/bin/spec-agents" transition 99-canonical-discovery.md doing |
    grep -Fq "99-canonical-discovery.md → doing"
' bash "$SOURCE_ROOT"
expect "source transition persists on the canonical Slice" grep -Fxq 'status: doing' "$SOURCE_ROOT/$SOURCE_SLICE"
expect "source nested check-state accepts the transitioned records" bash -c '
  set -e
  cd "$1/.spec-agents/specs/source-spec-cutover-fixture/issues"
  "$1/.spec-agents/doctrine/bin/spec-agents" check-state
' bash "$SOURCE_ROOT"
expect "Git recognizes the complete SPEC tree move" bash -c '
  set -e
  fixture=$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-spec-rename.XXXXXX")
  trap "rm -rf \"$fixture\"" EXIT
  mkdir -p "$fixture/repo/.specs"
  cp -R "$1/.spec-agents/specs/." "$fixture/repo/.specs/"
  git -C "$fixture/repo" init -q
  git -C "$fixture/repo" add -A
  old_tree=$(git -C "$fixture/repo" write-tree)
  mkdir -p "$fixture/repo/.spec-agents"
  mv "$fixture/repo/.specs" "$fixture/repo/.spec-agents/specs"
  git -C "$fixture/repo" add -A
  new_tree=$(git -C "$fixture/repo" write-tree)
  git -C "$fixture/repo" diff --summary --find-renames=100% "$old_tree" "$new_tree" |
    grep -Eq "rename .*\\.spec-agents/specs[}/]"
' bash "$REPO_ROOT"

if [ "$failed" -ne 0 ]; then
  printf 'source SPEC cutover check: %d failure(s), %d passed\n' "$failed" "$passed" >&2
  exit 1
fi
printf 'source SPEC cutover check: %d/%d\n' "$passed" "$passed"
