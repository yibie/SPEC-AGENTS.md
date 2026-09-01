#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOCTRINE_ROOT="$REPO_ROOT/.spec-agents/doctrine"
CLI="$DOCTRINE_ROOT/bin/spec-agents"
TRIAL_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-source-doctrine.XXXXXX")"
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

source_manifest() {
  find "$DOCTRINE_ROOT" -type f -print | sed "s#^$DOCTRINE_ROOT/##" | LC_ALL=C sort
}

installed_manifest() {
  find "$1/.spec-agents/doctrine" -type f -print |
    sed "s#^$1/.spec-agents/doctrine/##" | LC_ALL=C sort
}

expected_source_manifest() {
  printf '%s\n' \
    AGENTS.md AGENTS_en.md START.md UPGRADE.md bin/spec-agents \
    docs/README.md docs/WORKFLOW.md docs/check-kernel.sh \
    docs/evidence-links.md docs/jj-change-management.md \
    docs/jj-project-setup.md docs/knowledge-promotion.md \
    docs/parallel-work.md docs/single-authority.md \
    skills/arrange/SKILL.md skills/arrange/agents/openai.yaml \
    skills/capture/SKILL.md skills/capture/agents/openai.yaml \
    skills/check/SKILL.md skills/check/agents/openai.yaml \
    skills/do/SKILL.md skills/do/agents/openai.yaml \
    skills/learn/SKILL.md skills/learn/agents/openai.yaml \
    skills/plan/SKILL.md skills/plan/agents/openai.yaml | LC_ALL=C sort
}

expected_installed_manifest() {
  expected_source_manifest | grep -v '^AGENTS_en\.md$'
}

assert_markdown_links() {
  local root="$1" markdown link target broken=0
  while IFS= read -r markdown; do
    while IFS= read -r link; do
      [ -n "$link" ] || continue
      case "$link" in
        /*) target="$root$link" ;;
        *) target="$(dirname "$markdown")/$link" ;;
      esac
      if [ ! -e "$target" ]; then
        printf 'broken Markdown link: %s -> %s\n' "$markdown" "$link" >&2
        broken=1
      fi
    done < <(grep -oE '\]\([^)]*\.md\)' "$markdown" | sed 's/^](\(.*\))$/\1/' || true)
  done < <(find -L "$root/.spec-agents/doctrine" -type f -name '*.md' -print)
  [ "$broken" -eq 0 ]
}

assert_root_readme_links() {
  local link target broken=0
  while IFS= read -r link; do
    [ -n "$link" ] || continue
    case "$link" in
      /*)
        printf 'site-root Markdown link in source README: %s\n' "$link" >&2
        broken=1
        continue
        ;;
    esac
    target="$REPO_ROOT/$link"
    if [ ! -e "$target" ]; then
      printf 'broken source README link: %s\n' "$link" >&2
      broken=1
    fi
  done < <(grep -oE '\]\([^)]*\.md\)' "$REPO_ROOT/README.md" |
    sed 's/^](\(.*\))$/\1/' || true)
  [ "$broken" -eq 0 ]
}

assert_legacy_phrase_inventory() {
  local phrase="$REPO_ROOT/.spec-agents/archive/legacy-phrase"
  local all_hash tracked_hash tracked_count
  [ "$(find "$phrase" -type f | wc -l | tr -d ' ')" -eq 23 ] || return 1
  [ "$(find "$phrase" -type d | wc -l | tr -d ' ')" -eq 10 ] || return 1
  [ "$(du -sk "$phrase" | awk '{print $1}')" -eq 144 ] || return 1
  all_hash="$(find "$phrase" -type f -print |
    sed "s#^$phrase/##" | LC_ALL=C sort |
    while IFS= read -r p; do
      shasum -a 256 "$phrase/$p" | sed "s#  .*#  $p#"
    done | shasum -a 256 | awk '{print $1}')"
  [ "$all_hash" = c68f96e7344a7739d83a430db68efaad2be1201a79df4f51ac9d542113ad0d2d ] || return 1
  tracked_count="$(git -C "$REPO_ROOT" ls-files -- '.phrase/*' '.spec-agents/archive/legacy-phrase/*' |
    sed -E 's#^\.phrase/##; s#^\.spec-agents/archive/legacy-phrase/##' |
    LC_ALL=C sort -u | wc -l | tr -d ' ')"
  [ "$tracked_count" -eq 22 ] || return 1
  tracked_hash="$(git -C "$REPO_ROOT" ls-files -- '.phrase/*' '.spec-agents/archive/legacy-phrase/*' |
    sed -E 's#^\.phrase/##; s#^\.spec-agents/archive/legacy-phrase/##' |
    LC_ALL=C sort -u |
    while IFS= read -r p; do
      shasum -a 256 "$phrase/$p" | sed "s#  .*#  $p#"
    done | shasum -a 256 | awk '{print $1}')"
  [ "$tracked_hash" = fd2edcb0ec6e94588a18524a6fbc5579f04fdea701a9df32b2a3808fa27793c2 ]
}

assert_source_root_clean() {
  local absent
  cmp -s "$REPO_ROOT/templates/AGENTS-adapter.md" "$REPO_ROOT/AGENTS.md" || return 1
  ! grep -q '^## Default context$' "$REPO_ROOT/AGENTS.md" || return 1
  for absent in AGENTS_en.md START.md UPGRADE.md skills docs/spec-agents bin/spec-agents \
                STATUS.md EVIDENCE.md .scratch archive .specs .phrase; do
    [ ! -e "$REPO_ROOT/$absent" ] || return 1
  done
  [ -f "$REPO_ROOT/.spec-agents/state/STATUS.md" ] || return 1
  [ -f "$REPO_ROOT/.spec-agents/state/EVIDENCE.md" ] || return 1
  [ -d "$REPO_ROOT/.spec-agents/archive" ] || return 1
  [ -d "$REPO_ROOT/.spec-agents/archive/legacy-phrase" ] || return 1
  grep -Fxq '.spec-agents/scratch/' "$REPO_ROOT/.gitignore" || return 1
  assert_legacy_phrase_inventory
}

expect "source Doctrine has the exact cutover manifest" test \
  "$(source_manifest)" = "$(expected_source_manifest)"

FRESH="$TRIAL_ROOT/fresh"
"$CLI" install "$FRESH" cn </dev/null > "$TRIAL_ROOT/fresh.out"
expect "installed Doctrine has the exact selected-language manifest" test \
  "$(installed_manifest "$FRESH")" = "$(expected_installed_manifest)"
expect "installed Chinese Doctrine matches the source contract" \
  cmp "$DOCTRINE_ROOT/AGENTS.md" "$FRESH/.spec-agents/doctrine/AGENTS.md"
expect "installed docs and skills match source Doctrine" \
  diff -qr "$DOCTRINE_ROOT/docs" "$FRESH/.spec-agents/doctrine/docs"
expect "source root has only the adapter at old integration path" \
  assert_source_root_clean
expect "source Doctrine Markdown links resolve" assert_markdown_links "$REPO_ROOT"
expect "source README Markdown links are repository-relative and resolve" \
  assert_root_readme_links
expect "source repository install refuses without mutation" bash -c '
  set -e
  before=$(shasum -a 256 "$1")
  if "$2" install "$3" en </dev/null >"$4" 2>&1; then exit 1; fi
  after=$(shasum -a 256 "$1")
  test "$before" = "$after"
' bash "$CLI" "$REPO_ROOT/AGENTS.md" "$REPO_ROOT" "$TRIAL_ROOT/source-refusal.out"

expect "source root check-state uses canonical Instance state" \
  bash -c 'cd "$1" && "$2" check-state' bash "$REPO_ROOT" "$CLI"
expect "source root status is lifecycle-independent" \
  bash -c 'cd "$1" && "$2" status | grep -Fq "SPECs:"' \
  bash "$REPO_ROOT" "$CLI"
expect "source nested status is lifecycle-independent" \
  bash -c 'cd "$1" && "$2" status | grep -Fq "SPECs:"' \
  bash "$REPO_ROOT/.spec-agents/specs/namespaced-project-layout/issues" "$CLI"
expect "source check-kernel uses namespaced Doctrine path" \
  "$DOCTRINE_ROOT/docs/check-kernel.sh" "$REPO_ROOT"

expect "Git recognizes Doctrine renames in a throwaway tree" bash -c '
  set -e
  repo_root="${!#}"
  fixture=$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-rename-tree.XXXXXX")
  trap "rm -rf \"$fixture\"" EXIT
  mkdir "$fixture/repo"
  mkdir -p "$fixture/repo/skills" "$fixture/repo/docs/spec-agents" "$fixture/repo/bin"
  mkdir -p "$fixture/repo/.phrase"
  cp -R "$repo_root/.spec-agents/archive/legacy-phrase/." "$fixture/repo/.phrase/"
  find "$fixture/repo/.phrase" -name .DS_Store -delete
  cp "$repo_root/.spec-agents/doctrine/AGENTS.md" "$fixture/repo/AGENTS.md"
  cp "$repo_root/.spec-agents/doctrine/AGENTS_en.md" "$fixture/repo/AGENTS_en.md"
  cp "$repo_root/.spec-agents/doctrine/START.md" "$fixture/repo/START.md"
  cp "$repo_root/.spec-agents/doctrine/UPGRADE.md" "$fixture/repo/UPGRADE.md"
  cp "$repo_root/.spec-agents/doctrine/bin/spec-agents" "$fixture/repo/bin/spec-agents"
  cp -R "$repo_root/.spec-agents/doctrine/skills/." "$fixture/repo/skills/"
  cp -R "$repo_root/.spec-agents/doctrine/docs/." "$fixture/repo/docs/spec-agents/"
  git -C "$fixture/repo" init -q
  git -C "$fixture/repo" add -A
  old_tree=$(git -C "$fixture/repo" write-tree)
  mkdir -p "$fixture/repo/.spec-agents/archive"
  mv "$fixture/repo/.phrase" "$fixture/repo/.spec-agents/archive/legacy-phrase"
  mkdir -p "$fixture/repo/.spec-agents/doctrine/docs" \
    "$fixture/repo/.spec-agents/doctrine/bin"
  mv "$fixture/repo/AGENTS.md" "$fixture/repo/.spec-agents/doctrine/AGENTS.md"
  mv "$fixture/repo/AGENTS_en.md" "$fixture/repo/.spec-agents/doctrine/AGENTS_en.md"
  mv "$fixture/repo/START.md" "$fixture/repo/UPGRADE.md" "$fixture/repo/.spec-agents/doctrine/"
  mv "$fixture/repo/skills" "$fixture/repo/.spec-agents/doctrine/skills"
  mv "$fixture/repo/docs/spec-agents"/* "$fixture/repo/.spec-agents/doctrine/docs/"
  mv "$fixture/repo/bin/spec-agents" "$fixture/repo/.spec-agents/doctrine/bin/spec-agents"
  cp -R "$repo_root/.spec-agents/doctrine/." "$fixture/repo/.spec-agents/doctrine/"
  cp "$repo_root/AGENTS.md" "$fixture/repo/AGENTS.md"
  git -C "$fixture/repo" add -A
  new_tree=$(git -C "$fixture/repo" write-tree)
  summary=$(git -C "$fixture/repo" diff --summary --find-renames=50% "$old_tree" "$new_tree")
  printf "%s\n" "$summary"
  printf "%s\n" "$summary" | grep -Eq "rename .*\.spec-agents/doctrine/(AGENTS|AGENTS_en|START|UPGRADE)"
  printf "%s\n" "$summary" | grep -Eq "rename .*\.spec-agents/archive/legacy-phrase"
  test ! -e "$fixture/repo/.phrase"
  test -d "$fixture/repo/.spec-agents/archive/legacy-phrase"
  git -C "$fixture/repo" -c user.name=fixture -c user.email=fixture@example.invalid \
    commit -qm fixture
  git clone -q "$fixture/repo" "$fixture/clone"
  test "$(git -C "$fixture/clone" ls-files -- ".spec-agents/archive/legacy-phrase/*" |
    wc -l | tr -d " ")" -eq 22
  while IFS= read -r phrase_file; do
    test -f "$fixture/clone/$phrase_file"
    cmp "$fixture/repo/$phrase_file" "$fixture/clone/$phrase_file"
  done < <(git -C "$fixture/clone" ls-files -- ".spec-agents/archive/legacy-phrase/*")
' bash "$REPO_ROOT"

if [ "$failed" -ne 0 ]; then
  printf 'source doctrine cutover check: %d failure(s), %d passed\n' "$failed" "$passed" >&2
  exit 1
fi
printf 'source doctrine cutover check: %d/%d\n' "$passed" "$passed"
