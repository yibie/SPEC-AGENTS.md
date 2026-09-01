#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
CLI="$REPO_ROOT/.spec-agents/doctrine/bin/spec-agents"
ADAPTER="$REPO_ROOT/templates/AGENTS-adapter.md"
TRIAL_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-namespaced.XXXXXX")"
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
  if "$@"; then
    pass "$label"
  else
    fail "$label"
  fi
}

snapshot() {
  local root="$1"
  (
    cd "$root"
    find . -mindepth 1 -print | LC_ALL=C sort | while IFS= read -r item; do
      if [ -L "$item" ]; then
        printf 'link\t%s\t%s\n' "${item#./}" "$(readlink "$item")"
      elif [ -d "$item" ]; then
        printf 'directory\t%s\n' "${item#./}"
      elif [ -f "$item" ]; then
        printf 'file\t%s\t%s\n' "$(shasum -a 256 "$item" | awk '{print $1}')" "${item#./}"
      else
        printf 'other\t%s\n' "${item#./}"
      fi
    done
  )
}

expected_payload='AGENTS.md
START.md
UPGRADE.md
bin/spec-agents
docs/README.md
docs/WORKFLOW.md
docs/check-kernel.sh
docs/evidence-links.md
docs/jj-change-management.md
docs/jj-project-setup.md
docs/knowledge-promotion.md
docs/parallel-work.md
docs/single-authority.md
skills/arrange/SKILL.md
skills/arrange/agents/openai.yaml
skills/capture/SKILL.md
skills/capture/agents/openai.yaml
skills/check/SKILL.md
skills/check/agents/openai.yaml
skills/do/SKILL.md
skills/do/agents/openai.yaml
skills/learn/SKILL.md
skills/learn/agents/openai.yaml
skills/plan/SKILL.md
skills/plan/agents/openai.yaml'

payload_files() {
  local root="$1"
  (
    cd "$root/.spec-agents/doctrine"
    find . -type f -print | sed 's#^./##' | LC_ALL=C sort
  )
}

assert_root_set() {
  local root="$1"
  local actual
  actual="$(find "$root" -mindepth 1 -maxdepth 1 -print | sed "s#^$root/##" | LC_ALL=C sort)"
  [ "$actual" = ".spec-agents
AGENTS.md" ]
}

assert_no_instance_paths() {
  local root="$1"
  local absent
  for absent in START.md UPGRADE.md CONTEXT.md KERNEL.md STATUS.md EVIDENCE.md \
                ROADMAP.md state specs scratch archive docs/adr docs/protocols \
                docs/runbooks docs/lessons research bin tests; do
    [ ! -e "$root/$absent" ] || return 1
  done
  [ ! -e "$root/.spec-agents/state" ] || return 1
  [ ! -e "$root/.spec-agents/specs" ] || return 1
  [ ! -e "$root/.spec-agents/scratch" ] || return 1
  [ ! -e "$root/.spec-agents/archive" ] || return 1
  ! find "$root/.spec-agents/doctrine" -type f \( \
      -path '*/research/*' -o -path '*/archive/*' -o -path '*/docs/adr/*' \
      -o -path '*/docs/runbooks/*' -o -path '*/docs/lessons/*' \
    \) -print -quit | grep -q .
}

assert_no_instance_leakage() {
  local root="$1"
  local markdown matches line
  while IFS= read -r markdown; do
    if grep -Fq '.spec-agents/specs/namespaced-project-layout/SPEC.md' "$markdown"; then
      printf 'source-only SPEC path leaked into installed Markdown: %s\n' \
        "$markdown" >&2
      return 1
    fi
    matches="$(grep -nE 'Phase [0-9]+|task[0-9]+|research/' "$markdown" || true)"
    if [ -n "$matches" ]; then
      printf 'upstream Instance content in Markdown: %s\n%s\n' \
        "$markdown" "$matches" >&2
      return 1
    fi
    matches="$(grep -nE 'E-2026' "$markdown" || true)"
    if [ -n "$matches" ]; then
      while IFS= read -r line; do
        case "$line" in
          *upstream\ SPEC-AGENTS\ Evidence*) ;;
          *)
            printf 'unmarked upstream Evidence ID in Markdown: %s\n%s\n' \
              "$markdown" "$line" >&2
            return 1
            ;;
        esac
      done <<< "$matches"
    fi
  done < <(find -L "$root" -type f -name '*.md' -print)
}

assert_common_payload() {
  local root="$1" expected_language="$2"
  [ -f "$root/AGENTS.md" ] && [ ! -L "$root/AGENTS.md" ] || return 1
  cmp -s "$ADAPTER" "$root/AGENTS.md" || return 1
  [ "$(payload_files "$root")" = "$expected_payload" ] || return 1
  cmp -s "$REPO_ROOT/.spec-agents/doctrine/$expected_language" \
    "$root/.spec-agents/doctrine/AGENTS.md" || return 1
  [ -x "$root/.spec-agents/doctrine/bin/spec-agents" ] || return 1
  [ -x "$root/.spec-agents/doctrine/docs/check-kernel.sh" ] || return 1
  (cd "$root" && .spec-agents/doctrine/docs/check-kernel.sh . >/dev/null) || return 1
  assert_root_set "$root" || return 1
  assert_no_instance_paths "$root" || return 1
  assert_no_instance_leakage "$root"
}

COPY_ROOT="$TRIAL_ROOT/copy-cn"
EN_ROOT="$TRIAL_ROOT/copy-en"
LINK_ROOT="$TRIAL_ROOT/link"
UNINTEGRATED_ROOT="$TRIAL_ROOT/unintegrated"
INTEGRATED_ROOT="$TRIAL_ROOT/integrated"

"$CLI" install "$COPY_ROOT" cn </dev/null > "$TRIAL_ROOT/copy-cn.out"
expect "fresh Chinese install has the exact namespaced payload" \
  assert_common_payload "$COPY_ROOT" AGENTS.md

"$CLI" install "$EN_ROOT" en </dev/null > "$TRIAL_ROOT/copy-en.out"
expect "fresh English install selects the English Doctrine" \
  assert_common_payload "$EN_ROOT" AGENTS_en.md

before_repeat="$(snapshot "$COPY_ROOT")"
"$CLI" install "$COPY_ROOT" cn </dev/null > "$TRIAL_ROOT/repeat.out"
after_repeat="$(snapshot "$COPY_ROOT")"
expect "repeat copy install preserves every path and byte" test "$before_repeat" = "$after_repeat"

"$CLI" install "$LINK_ROOT" en --link </dev/null > "$TRIAL_ROOT/link.out"
expect "link install keeps the root adapter copied" test -f "$LINK_ROOT/AGENTS.md"
expect "link install does not symlink the root adapter" test ! -L "$LINK_ROOT/AGENTS.md"
expect "link install symlinks the Doctrine payload" test \
  -L "$LINK_ROOT/.spec-agents/doctrine/AGENTS.md" \
  -a -L "$LINK_ROOT/.spec-agents/doctrine/START.md" \
  -a -L "$LINK_ROOT/.spec-agents/doctrine/bin/spec-agents" \
  -a -L "$LINK_ROOT/.spec-agents/doctrine/docs/check-kernel.sh" \
  -a -L "$LINK_ROOT/.spec-agents/doctrine/skills/plan"
expect "link install preserves the root and Instance boundaries" \
  assert_no_instance_paths "$LINK_ROOT"
expect "link install has no Markdown Instance leakage" \
  assert_no_instance_leakage "$LINK_ROOT"

mkdir -p "$UNINTEGRATED_ROOT"
printf '%s\n' '# project-owned instructions' > "$UNINTEGRATED_ROOT/AGENTS.md"
before_unintegrated="$(shasum -a 256 "$UNINTEGRATED_ROOT/AGENTS.md")"
"$CLI" install "$UNINTEGRATED_ROOT" en </dev/null > "$TRIAL_ROOT/unintegrated.out"
after_unintegrated="$(shasum -a 256 "$UNINTEGRATED_ROOT/AGENTS.md")"
expect "existing unintegrated AGENTS remains byte-identical" \
  test "$before_unintegrated" = "$after_unintegrated"
expect "unintegrated existing AGENTS reports the exact integration line" \
  grep -Fq 'Integration required: add this exact line' "$TRIAL_ROOT/unintegrated.out"
expect "unintegrated existing AGENTS does not claim readiness" \
  test ! -s <(grep -F 'Spec-AGENTS is ready' "$TRIAL_ROOT/unintegrated.out")

FALSE_POSITIVE_ROOT="$TRIAL_ROOT/false-positive"
mkdir -p "$FALSE_POSITIVE_ROOT"
printf '%s\n' '# project-owned instructions' \
  'This prose mentions `.spec-agents/doctrine/AGENTS.md` but is not an integration instruction.' \
  > "$FALSE_POSITIVE_ROOT/AGENTS.md"
"$CLI" install "$FALSE_POSITIVE_ROOT" en </dev/null > "$TRIAL_ROOT/false-positive.out"
expect "substring-only namespace mention remains integration-required" \
  grep -Fq 'Integration required: add this exact line' "$TRIAL_ROOT/false-positive.out"
expect "substring-only namespace mention does not claim readiness" \
  test ! -s <(grep -F 'Spec-AGENTS is ready' "$TRIAL_ROOT/false-positive.out")

printf '%s\n' '# project-owned instructions' 'Read `.spec-agents/doctrine/AGENTS.md`.' \
  > "$UNINTEGRATED_ROOT/AGENTS.md"
"$CLI" install "$UNINTEGRATED_ROOT" en </dev/null > "$TRIAL_ROOT/integrated-repeat.out"
expect "user-integrated repeat can claim readiness" \
  grep -Fq 'Spec-AGENTS is ready' "$TRIAL_ROOT/integrated-repeat.out"

mkdir -p "$INTEGRATED_ROOT"
printf '%s\n' '# project-owned instructions' 'Read `.spec-agents/doctrine/AGENTS.md`.' \
  > "$INTEGRATED_ROOT/AGENTS.md"
before_integrated="$(shasum -a 256 "$INTEGRATED_ROOT/AGENTS.md")"
"$CLI" install "$INTEGRATED_ROOT" en </dev/null > "$TRIAL_ROOT/integrated.out"
after_integrated="$(shasum -a 256 "$INTEGRATED_ROOT/AGENTS.md")"
expect "existing integrated AGENTS remains byte-identical" \
  test "$before_integrated" = "$after_integrated"
expect "existing integrated AGENTS may claim readiness" \
  grep -Fq 'Spec-AGENTS is ready' "$TRIAL_ROOT/integrated.out"

source_digest="$(shasum -a 256 "$CLI")"
if "$CLI" install "$REPO_ROOT" en > "$TRIAL_ROOT/source-refusal.out" 2>&1; then
  fail "source repository install refusal"
else
  after_source_digest="$(shasum -a 256 "$CLI")"
  if [ "$source_digest" = "$after_source_digest" ] &&
     grep -Fq 'Refusing to install into the Spec-AGENTS source repository' \
       "$TRIAL_ROOT/source-refusal.out"; then
    pass "source repository install refusal"
  else
    fail "source repository install refusal"
  fi
fi

if [ "$failed" -ne 0 ]; then
  printf 'namespaced install check: %d failure(s), %d passed\n' "$failed" "$passed" >&2
  exit 1
fi
printf 'namespaced install check: %d/%d\n' "$passed" "$passed"
