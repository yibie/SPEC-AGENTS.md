#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOCTRINE_SOURCE="$REPO_ROOT/.spec-agents/doctrine"
TRIAL_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-upgrade-reset.XXXXXX")"
PASS_COUNT=0

cleanup() {
  if [ "${SPEC_AGENTS_KEEP_FIXTURES:-0}" = "1" ]; then
    echo "fixture retained: $TRIAL_ROOT"
  else
    chmod -R u+w -- "$TRIAL_ROOT" 2>/dev/null || true
    rm -rf -- "$TRIAL_ROOT"
  fi
}
trap cleanup EXIT

fail() { echo "not ok: $1" >&2; exit 1; }
pass() {
  PASS_COUNT=$((PASS_COUNT + 1))
  echo "ok $PASS_COUNT: $1"
}

hash_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$1" | awk '{print $NF}'
  else
    fail "no SHA-256 command"
  fi
}

canonical_absent() {
  local path="$1" parent
  parent="$(cd -P "$(dirname "$path")" && pwd -P)"
  printf '%s/%s\n' "$parent" "$(basename "$path")"
}

tree_manifest() {
  local root="$1" output="$2"
  shift 2
  (
    cd "$root"
    for item_path in "$@"; do
      [ -e "$item_path" ] || [ -L "$item_path" ] || fail "missing manifest path: $item_path"
      find "$item_path" -print
    done | LC_ALL=C sort -u | while IFS= read -r item_path; do
      if [ -L "$item_path" ]; then
        printf 'link\t-\t%s\t%s\n' "$item_path" "$(readlink "$item_path")"
      elif [ -d "$item_path" ]; then
        printf 'directory\t-\t%s\t-\n' "$item_path"
      elif [ -f "$item_path" ]; then
        printf 'file\t%s\t%s\t-\n' "$(hash_file "$item_path")" "$item_path"
      else
        printf 'other\t-\t%s\t-\n' "$item_path"
      fi
    done
  ) > "$output"
}

replay_doctrine_manifest() {
  local backup="$1" count=0 item_type digest rel link_target actual
  while IFS=$'\t' read -r item_type digest rel link_target; do
    count=$((count + 1))
    case "$item_type" in
      file)
        [ -f "$backup/$rel" ] || fail "manifest file missing: $rel"
        actual="$(hash_file "$backup/$rel")"
        [ "$actual" = "$digest" ] || fail "manifest hash mismatch: $rel"
        ;;
      directory) [ -d "$backup/$rel" ] || fail "manifest directory missing: $rel" ;;
      link)
        [ -L "$backup/$rel" ] || fail "manifest link missing: $rel"
        [ "$(readlink "$backup/$rel")" = "$link_target" ] ||
          fail "manifest link mismatch: $rel"
        ;;
      other) [ -e "$backup/$rel" ] || [ -L "$backup/$rel" ] || fail "manifest path missing: $rel" ;;
      *) fail "unknown manifest type: $item_type" ;;
    esac
  done < "$backup/DOCTRINE-MANIFEST.tsv"
  [ "$count" -gt 0 ] || fail "doctrine backup manifest is empty"
}

write_cutover() {
  local file="$1" target="$2" backup="$3" report_hash="$4"
  local unresolved="$5" decision="$6" format="${7:-spec-agents-cutover-v1}"
  printf 'format\t%s\ntarget\t%s\nbackup_dir\t%s\nreport_sha256\t%s\nunresolved_count\t%s\ndecision\t%s\n' \
    "$format" "$target" "$backup" "$report_hash" "$unresolved" "$decision" > "$file"
}

assert_no_success() {
  local output="$1"
  if grep -qE 'Doctrine replacement complete|Spec-AGENTS is ready' "$output"; then
    fail "refusal or failure printed success: $output"
  fi
}

prepare_valid_cutover() {
  local project="$1" backup="$2" project_abs backup_abs report report_hash
  mkdir -p "$project/.spec-agents/scratch/upgrade-review" "$(dirname "$backup")"
  report="$project/.spec-agents/scratch/upgrade-review/REPORT.md"
  printf '%s\n' '# Upgrade Review' '## User decision' '- confirmed' > "$report"
  project_abs="$(cd -P "$project" && pwd -P)"
  backup_abs="$(canonical_absent "$backup")"
  report_hash="$(hash_file "$report")"
  write_cutover "$project/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" \
    "$project_abs" "$backup_abs" "$report_hash" 0 confirmed
}

cd "$REPO_ROOT"

# 1. The prompt and receipt describe the executable order and exact shape.
receipt_doc="$TRIAL_ROOT/documented-cutover.tsv"
awk '
  /six tab-separated rows and no others:/ { want=1; next }
  want && /^```text$/ { capture=1; next }
  capture && /^```$/ { exit }
  capture { print }
' "$DOCTRINE_SOURCE/UPGRADE.md" > "$receipt_doc"
awk -F '\t' '
  BEGIN {
    expected["format"]="spec-agents-cutover-v1"
    expected["target"]="<canonical project path>"
    expected["backup_dir"]="<canonical absent doctrine-backup path>"
    expected["report_sha256"]="<SHA-256 of the confirmed REPORT.md>"
    expected["unresolved_count"]="0"
    expected["decision"]="confirmed"
  }
  NF != 2 || !($1 in expected) || $2 != expected[$1] || seen[$1]++ { bad=1 }
  END { if (NR != 6) bad=1; for (key in expected) if (seen[key] != 1) bad=1; exit bad }
' "$receipt_doc" || fail "UPGRADE CUTOVER shape is not exact"
section4="$(awk '/^## 4\. Bind the confirmed cutover$/ { print NR }' "$DOCTRINE_SOURCE/UPGRADE.md")"
section5="$(awk '/^## 5\. Perform the recoverable reset$/ { print NR }' "$DOCTRINE_SOURCE/UPGRADE.md")"
replace_line="$(awk '/spec-agents replace-doctrine <project>/ { print NR; exit }' "$DOCTRINE_SOURCE/UPGRADE.md")"
section6="$(awk '/^## 6\. Run a fresh START$/ { print NR }' "$DOCTRINE_SOURCE/UPGRADE.md")"
section7="$(awk '/^## 7\. Complete the review$/ { print NR }' "$DOCTRINE_SOURCE/UPGRADE.md")"
[ "$section4" -lt "$section5" ] && [ "$section5" -lt "$replace_line" ] &&
  [ "$replace_line" -lt "$section6" ] && [ "$section6" -lt "$section7" ] ||
  fail "UPGRADE numbered order differs from the confirmed flow"
grep -q '^inspect → preservation manifest → user confirmation → cutover receipt$' "$DOCTRINE_SOURCE/UPGRADE.md" ||
  fail "UPGRADE diagram omits confirmation receipt"
grep -q '^        → doctrine replacement → retired-state reset → fresh START$' "$DOCTRINE_SOURCE/UPGRADE.md" ||
  fail "UPGRADE diagram order differs from its numbered procedure"
grep -q '^        → completion result$' "$DOCTRINE_SOURCE/UPGRADE.md" || fail "UPGRADE diagram omits completion"
for disposition in candidate archive-only keep-active unresolved; do
  grep -q "\`$disposition\`" "$DOCTRINE_SOURCE/UPGRADE.md" || fail "UPGRADE omits $disposition"
done
grep -q 'no old status, completion claim, dependency, Evidence ID' "$DOCTRINE_SOURCE/UPGRADE.md" ||
  fail "UPGRADE permits inherited work state"
pass "prompt order, preservation dispositions, and exact CUTOVER shape"

# 2. Reconnaissance writes only the report, with the complete manifest schema.
PROJECT="$TRIAL_ROOT/project"
mkdir -p "$PROJECT/skills/old" "$PROJECT/docs/spec-agents" \
  "$PROJECT/.phrase" "$PROJECT/.specs/old/issues" \
  "$PROJECT/.scratch/legacy-checkout" "$PROJECT/archive/legacy-workflow" \
  "$PROJECT/.spec-agents/doctrine" "$PROJECT/tests"
cp "$DOCTRINE_SOURCE/AGENTS_en.md" "$PROJECT/AGENTS.md"
printf 'old start\n' > "$PROJECT/START.md"
printf 'old upgrade\n' > "$PROJECT/UPGRADE.md"
printf 'old skill\n' > "$PROJECT/skills/old/SKILL.md"
printf 'old workflow\n' > "$PROJECT/docs/spec-agents/WORKFLOW.md"
printf 'old phase\n' > "$PROJECT/.phrase/current.md"
printf 'old invariant: legacy-only invariant\n' > "$PROJECT/KERNEL.md"
printf '**Phase**: delivery\ntask001 [ ] ship current request\n' > "$PROJECT/STATUS.md"
printf 'old evidence\n' > "$PROJECT/EVIDENCE.md"
printf 'ship current request\n' > "$PROJECT/ROADMAP.md"
printf 'status: confirmed\n' > "$PROJECT/.specs/old/SPEC.md"
printf 'status: doing\n' > "$PROJECT/.specs/old/issues/01-old.md"
printf 'tracked old spec\n' > "$PROJECT/.scratch/legacy-checkout/SPEC.md"
printf 'old archive record\n' > "$PROJECT/archive/legacy-workflow/record.md"
printf 'stale installed doctrine\n' > "$PROJECT/.spec-agents/doctrine/stale.md"
printf 'project vocabulary\n' > "$PROJECT/CONTEXT.md"
printf 'print("application")\n' > "$PROJECT/app.py"
printf 'mode=test\n' > "$PROJECT/config.ini"
printf 'application test\n' > "$PROJECT/tests/test_app.txt"

INITIAL_PATHS=(
  AGENTS.md START.md UPGRADE.md skills docs/spec-agents .phrase KERNEL.md
  STATUS.md EVIDENCE.md ROADMAP.md .specs .scratch/legacy-checkout
  archive/legacy-workflow .spec-agents/doctrine
  CONTEXT.md app.py config.ini tests
)
MANIFEST_PATHS=(
  AGENTS.md START.md UPGRADE.md skills/ docs/spec-agents/ .phrase/ KERNEL.md
  STATUS.md EVIDENCE.md ROADMAP.md .specs/ .scratch/legacy-checkout/
  archive/legacy-workflow/
  CONTEXT.md app.py config.ini tests/
)
tree_manifest "$PROJECT" "$TRIAL_ROOT/before-report.tsv" "${INITIAL_PATHS[@]}"

mkdir -p "$PROJECT/.spec-agents/scratch/upgrade-review"
cat > "$PROJECT/.spec-agents/scratch/upgrade-review/REPORT.md" <<'REPORT'
# Upgrade Review

## Current project facts
- `app.py` is the application entry; `config.ini` and `tests/` are project-owned.
## Retired workflow markers
- old doctrine, `.phrase/`, phase STATUS, `.specs/`, and a tracked scratch SPEC
## Preservation manifest
| Source path | Path type | Disposition | Evidence | Archive destination | Count/hash check |
| --- | --- | --- | --- | --- | --- |
| AGENTS.md | file | candidate | installed old doctrine | doctrine backup/old/AGENTS.md | SHA-256 |
| START.md | file | archive-only | installed old doctrine | doctrine backup/START.md | SHA-256 |
| UPGRADE.md | file | archive-only | installed old doctrine | doctrine backup/UPGRADE.md | SHA-256 |
| skills/ | directory | archive-only | installed old doctrine | doctrine backup/old/skills/ | path count and SHA-256 |
| docs/spec-agents/ | directory | archive-only | installed old doctrine | doctrine backup/old/docs/spec-agents/ | path count and SHA-256 |
| .phrase/ | directory | archive-only | retired marker | retired-state/.phrase/ | path count and SHA-256 |
| KERNEL.md | file | candidate | old lifecycle model | retired-state/KERNEL.md | SHA-256 |
| STATUS.md | file | archive-only | phase and task state | retired-state/STATUS.md | SHA-256 |
| EVIDENCE.md | file | candidate | old evidence namespace | retired-state/EVIDENCE.md | SHA-256 |
| ROADMAP.md | file | candidate | future intent | retired-state/ROADMAP.md | SHA-256 |
| .specs/ | directory | archive-only | old execution state | retired-state/.specs/ | path count and SHA-256 |
| .scratch/legacy-checkout/ | directory | archive-only | tracked old SPEC | retired-state/.scratch/legacy-checkout/ | path count and SHA-256 |
| archive/legacy-workflow/ | directory | archive-only | retired workflow archive | retired-state/archive/legacy-workflow/ | path count and SHA-256 |
| CONTEXT.md | file | keep-active | project vocabulary | unchanged | SHA-256 before/after |
| app.py | file | keep-active | application entry | unchanged | SHA-256 before/after |
| config.ini | file | keep-active | application config | unchanged | SHA-256 before/after |
| tests/ | directory | keep-active | application tests | unchanged | path count and SHA-256 |
## Candidate knowledge
- `application entry is app.py` — source: `app.py`; supported by current code; candidate for fresh K1
- `legacy-only invariant` — source: `KERNEL.md`; unsupported by current code; reject after START
## Current user intent
- ship current request — recapture through `plan`/`capture`
## Conflicts and unknowns
- none in this fixture
## Proposed archive and doctrine backup
- archive root: `.spec-agents/archive/spec-agents-upgrade/trial/`
- doctrine backup: `.spec-agents/archive/spec-agents-upgrade/trial/doctrine/`
## Verification plan
- path/type/hash manifests; keep-active hashes; receipt refusals; fresh START and completion
## Questions for the user
- confirm every disposition, candidate, path, intent, and unknown
## User decision
- pending
## Completion result
- pending
REPORT

REPORT="$PROJECT/.spec-agents/scratch/upgrade-review/REPORT.md"
for heading in 'Current project facts' 'Retired workflow markers' 'Preservation manifest' \
               'Candidate knowledge' 'Current user intent' 'Conflicts and unknowns' \
               'Proposed archive and doctrine backup' 'Verification plan' \
               'Questions for the user' 'User decision' 'Completion result'; do
  grep -q "^## $heading$" "$REPORT" || fail "report omits section: $heading"
done
grep -q '^| Source path | Path type | Disposition | Evidence | Archive destination | Count/hash check |$' "$REPORT" ||
  fail "preservation manifest columns are incomplete"
for manifest_path in "${MANIFEST_PATHS[@]}"; do
  count="$(grep -F -c "| $manifest_path |" "$REPORT" || true)"
  [ "$count" -eq 1 ] || fail "manifest path appears $count times: $manifest_path"
done
awk -F '|' '
  function trim(value) { gsub(/^[ \t]+|[ \t]+$/, "", value); return value }
  /^## Preservation manifest$/ { capture=1; next }
  /^## Candidate knowledge$/ { exit }
  capture && /^\|/ {
    source=trim($2)
    if (source == "Source path" || source == "---") next
    type=trim($3); disposition=trim($4); evidence=trim($5); destination=trim($6); check=trim($7)
    if (type != "file" && type != "directory") bad=1
    if (disposition != "candidate" && disposition != "archive-only" &&
        disposition != "keep-active" && disposition != "unresolved") bad=1
    if (evidence == "" || destination == "" || check == "") bad=1
    rows++
  }
  END { if (rows != 17) bad=1; exit bad }
' "$REPORT" || fail "manifest rows do not have one valid disposition and complete evidence fields"
if grep -q '| unresolved |' "$REPORT"; then fail "fixture report retains an unresolved path"; fi
tree_manifest "$PROJECT" "$TRIAL_ROOT/after-report.tsv" "${INITIAL_PATHS[@]}"
cmp "$TRIAL_ROOT/before-report.tsv" "$TRIAL_ROOT/after-report.tsv" ||
  fail "reconnaissance changed a project path other than the report"
[ ! -e "$PROJECT/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" ] || fail "CUTOVER exists before confirmation"
[ -f "$PROJECT/archive/legacy-workflow/record.md" ] || fail "legacy archive input disappeared before confirmation"
pass "report-only reconnaissance and complete preservation manifest"

# Confirm the report, then bind its immutable snapshot before any replacement.
decision_tmp="$TRIAL_ROOT/confirmed-report.tmp"
awk '
  $0 == "## User decision" {
    print
    if ((getline) > 0) print "- confirmed: every disposition, candidate decision, path, intent, and unknown"
    next
  }
  { print }
' "$REPORT" > "$decision_tmp"
mv "$decision_tmp" "$REPORT"
user_decision="$(awk '/^## User decision$/ { getline; print }' "$REPORT")"
case "$user_decision" in *confirmed*) ;; *) fail "User decision was not filled before cutover" ;; esac

ARCHIVE="$PROJECT/.spec-agents/archive/spec-agents-upgrade/trial"
mkdir -p "$ARCHIVE"
CONFIRMED_REPORT="$ARCHIVE/CONFIRMED-REPORT.md"
cp "$REPORT" "$CONFIRMED_REPORT"
CONFIRMED_HASH="$(hash_file "$REPORT")"
[ "$(hash_file "$CONFIRMED_REPORT")" = "$CONFIRMED_HASH" ] || fail "confirmed report snapshot differs"
PROJECT_ABS="$(cd -P "$PROJECT" && pwd -P)"
CUTOVER="$PROJECT/.spec-agents/scratch/upgrade-review/CUTOVER.tsv"

# 3. Every receipt defect refuses before backup and leaves protected paths unchanged.
REFUSED_BACKUP="$ARCHIVE/refused-doctrine"
REFUSED_BACKUP_ABS="$(canonical_absent "$REFUSED_BACKUP")"
PROTECTED_PATHS=("${INITIAL_PATHS[@]}" .spec-agents/scratch/upgrade-review/REPORT.md)
expect_refusal() {
  local label="$1"
  shift
  tree_manifest "$PROJECT" "$TRIAL_ROOT/$label-before.tsv" "${PROTECTED_PATHS[@]}"
  if "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$PROJECT" "$REFUSED_BACKUP" "$@" \
       </dev/null > "$TRIAL_ROOT/$label.out" 2>&1; then
    fail "$label receipt was accepted"
  fi
  [ ! -e "$REFUSED_BACKUP" ] || fail "$label created the backup"
  tree_manifest "$PROJECT" "$TRIAL_ROOT/$label-after.tsv" "${PROTECTED_PATHS[@]}"
  cmp "$TRIAL_ROOT/$label-before.tsv" "$TRIAL_ROOT/$label-after.tsv" ||
    fail "$label changed a protected path"
  assert_no_success "$TRIAL_ROOT/$label.out"
}

expect_refusal cutover-missing en
WRONG_CUTOVER="$ARCHIVE/WRONG-CUTOVER.tsv"
write_cutover "$WRONG_CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
expect_refusal cutover-location --cutover "$WRONG_CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed wrong-format
expect_refusal cutover-format --cutover "$CUTOVER" en
printf 'format\tspec-agents-cutover-v1\ntarget\t%s\nbackup_dir\t%s\nreport_sha256\t%s\nunresolved_count\t0\n' \
  "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" > "$CUTOVER"
expect_refusal cutover-missing-key --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
printf 'decision\tconfirmed\n' >> "$CUTOVER"
expect_refusal cutover-duplicate --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
printf 'unknown\tvalue\n' >> "$CUTOVER"
expect_refusal cutover-unknown --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$TRIAL_ROOT/wrong-target" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
expect_refusal cutover-target --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$(canonical_absent "$ARCHIVE/wrong-backup")" "$CONFIRMED_HASH" 0 confirmed
expect_refusal cutover-backup --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" \
  '0000000000000000000000000000000000000000000000000000000000000000' 0 confirmed
expect_refusal cutover-hash --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 1 confirmed
expect_refusal cutover-unresolved --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 pending
expect_refusal cutover-decision --cutover "$CUTOVER" en
write_cutover "$CUTOVER" "$PROJECT_ABS" "$REFUSED_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
printf '%s\n' '- changed after confirmation' >> "$REPORT"
expect_refusal cutover-changed-report --cutover "$CUTOVER" en
cp "$CONFIRMED_REPORT" "$REPORT"
[ "$(hash_file "$REPORT")" = "$CONFIRMED_HASH" ] || fail "confirmed report restore failed"
pass "cutover receipt refusal matrix is pre-write"

# 4. The valid receipt reaches the existing recoverable replacement path.
KEEP_ACTIVE=(CONTEXT.md app.py config.ini tests)
RETIRED_PATHS=(.phrase KERNEL.md STATUS.md EVIDENCE.md ROADMAP.md .specs
  .scratch/legacy-checkout archive/legacy-workflow)
INSTANCE_PATHS=(
  "${RETIRED_PATHS[@]}" "${KEEP_ACTIVE[@]}" .spec-agents/scratch/upgrade-review
  .spec-agents/archive/spec-agents-upgrade/trial/CONFIRMED-REPORT.md
  .spec-agents/archive/spec-agents-upgrade/trial/WRONG-CUTOVER.tsv
)
DOCTRINE_BACKUP="$ARCHIVE/doctrine"
DOCTRINE_BACKUP_ABS="$(canonical_absent "$DOCTRINE_BACKUP")"
write_cutover "$CUTOVER" "$PROJECT_ABS" "$DOCTRINE_BACKUP_ABS" "$CONFIRMED_HASH" 0 confirmed
[ "$(hash_file "$REPORT")" = "$CONFIRMED_HASH" ] || fail "active report changed before replacement"
tree_manifest "$PROJECT" "$TRIAL_ROOT/keep-before.tsv" "${KEEP_ACTIVE[@]}"
tree_manifest "$PROJECT" "$TRIAL_ROOT/instance-before-replace.tsv" "${INSTANCE_PATHS[@]}"
"$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$PROJECT" "$DOCTRINE_BACKUP" \
  --cutover "$CUTOVER" en </dev/null > "$TRIAL_ROOT/replace.out"
grep -q 'Doctrine replacement complete' "$TRIAL_ROOT/replace.out" || fail "replacement omitted doctrine completion"
if grep -q 'Spec-AGENTS is ready' "$TRIAL_ROOT/replace.out"; then fail "replacement claimed project readiness"; fi
replay_doctrine_manifest "$DOCTRINE_BACKUP"
[ -f "$DOCTRINE_BACKUP/OLD-DOCTRINE-MANIFEST.tsv" ] || fail "old doctrine manifest missing"
[ -f "$DOCTRINE_BACKUP/NEW-DOCTRINE-MANIFEST.tsv" ] || fail "new doctrine manifest missing"
grep -q $'AGENTS.md' "$DOCTRINE_BACKUP/OLD-DOCTRINE-MANIFEST.tsv" ||
  fail "old doctrine manifest omitted AGENTS.md"
grep -q $'stale.md' "$DOCTRINE_BACKUP/NEW-DOCTRINE-MANIFEST.tsv" ||
  fail "new doctrine manifest omitted existing namespaced Doctrine"
tree_manifest "$PROJECT" "$TRIAL_ROOT/instance-after-replace.tsv" "${INSTANCE_PATHS[@]}"
cmp "$TRIAL_ROOT/instance-before-replace.tsv" "$TRIAL_ROOT/instance-after-replace.tsv" ||
  fail "doctrine replacement changed an Instance path"
pass "confirmed recoverable doctrine replacement"

# 5. Reset reproduces every retired path and removes it from the active read path.
tree_manifest "$PROJECT" "$TRIAL_ROOT/retired-before.tsv" "${RETIRED_PATHS[@]}"
RETIRED_ROOT="$ARCHIVE/retired-state"
mkdir -p "$RETIRED_ROOT/.scratch"
for item_path in .phrase KERNEL.md STATUS.md EVIDENCE.md ROADMAP.md .specs; do
  mv "$PROJECT/$item_path" "$RETIRED_ROOT/$item_path"
done
mv "$PROJECT/.scratch/legacy-checkout" "$RETIRED_ROOT/.scratch/legacy-checkout"
mkdir -p "$RETIRED_ROOT/archive"
mv "$PROJECT/archive/legacy-workflow" "$RETIRED_ROOT/archive/legacy-workflow"
tree_manifest "$RETIRED_ROOT" "$TRIAL_ROOT/retired-after.tsv" "${RETIRED_PATHS[@]}"
cmp "$TRIAL_ROOT/retired-before.tsv" "$TRIAL_ROOT/retired-after.tsv" ||
  fail "retired-state archive does not reproduce source paths"
cp "$TRIAL_ROOT/retired-after.tsv" "$ARCHIVE/RETIRED-STATE-MANIFEST.tsv"
for retired_path in "${RETIRED_PATHS[@]}"; do
  [ ! -e "$PROJECT/$retired_path" ] || fail "retired path remains active: $retired_path"
done
pass "exact retired-state archive and clean active path"

# 6. Current doctrine and project-owned paths survive replacement/reset exactly.
tree_manifest "$PROJECT" "$TRIAL_ROOT/keep-after.tsv" "${KEEP_ACTIVE[@]}"
cmp "$TRIAL_ROOT/keep-before.tsv" "$TRIAL_ROOT/keep-after.tsv" ||
  fail "keep-active or application content changed"
cmp "$DOCTRINE_SOURCE/AGENTS_en.md" "$PROJECT/.spec-agents/doctrine/AGENTS.md"
cmp templates/AGENTS-adapter.md "$PROJECT/AGENTS.md"
cmp "$DOCTRINE_SOURCE/START.md" "$PROJECT/.spec-agents/doctrine/START.md"
cmp "$DOCTRINE_SOURCE/UPGRADE.md" "$PROJECT/.spec-agents/doctrine/UPGRADE.md"
diff -qr "$DOCTRINE_SOURCE/skills" "$PROJECT/.spec-agents/doctrine/skills" >/dev/null
diff -qr "$DOCTRINE_SOURCE/docs" "$PROJECT/.spec-agents/doctrine/docs" >/dev/null
[ -f "$REPORT" ] && [ -f "$CUTOVER" ] || fail "upgrade report or receipt disappeared"
pass "current doctrine and unchanged project-owned paths"

# 7. Simulate the fresh START result, user acceptance, and final report handoff.
grep -q 'marker under `\.spec-agents/archive/`.*does not' \
  "$PROJECT/.spec-agents/doctrine/START.md" || fail "START does not exclude archive"
[ -f "$PROJECT/AGENTS.md" ] && [ -f "$PROJECT/.spec-agents/doctrine/START.md" ] &&
  [ -f "$PROJECT/.spec-agents/doctrine/docs/WORKFLOW.md" ] &&
  [ -f "$PROJECT/.spec-agents/doctrine/skills/plan/SKILL.md" ] || fail "current entry is incomplete"
mkdir -p "$PROJECT/nested/check"
(cd "$PROJECT/nested/check" && "$DOCTRINE_SOURCE/bin/spec-agents" gate plan > "$TRIAL_ROOT/project-plan.out")
grep -q 'no machine-checkable precondition' "$TRIAL_ROOT/project-plan.out" ||
  fail "fresh no-VCS project cannot enter plan"

mkdir -p "$PROJECT/.spec-agents/state"
cat > "$PROJECT/.spec-agents/state/KERNEL.md" <<'KERNEL'
# Kernel

version: K1

## Confirmed project facts

- Application entry: `app.py`.
- Configuration: `config.ini`.
- Tests: `tests/`.
KERNEL
mkdir -p "$PROJECT/.spec-agents/scratch/start"
cat > "$PROJECT/.spec-agents/scratch/start/REPORT.md" <<'START_REPORT'
# Start Report

ProjectState: modern
KernelStatus: bootstrapped K1 from current confirmed files
Candidate accepted: application entry is app.py
Candidate rejected: legacy-only invariant
User decision: accepted fresh START
Next permitted action: plan the current request
START_REPORT
START_REPORT="$PROJECT/.spec-agents/scratch/start/REPORT.md"
grep -q 'Application entry: `app.py`' "$PROJECT/.spec-agents/state/KERNEL.md" ||
  fail "supported candidate was not accepted"
if grep -q 'legacy-only invariant' "$PROJECT/.spec-agents/state/KERNEL.md"; then
  fail "rejected legacy candidate entered K1"
fi
grep -q '^ProjectState: modern$' "$START_REPORT" || fail "fresh START is not modern"
grep -q '^User decision: accepted fresh START$' "$START_REPORT" || fail "fresh START was not accepted"

ARCHIVE_ABS="$(cd -P "$ARCHIVE" && pwd -P)"
START_REPORT_ABS="$(cd -P "$(dirname "$START_REPORT")" && pwd -P)/$(basename "$START_REPORT")"
completion_tmp="$TRIAL_ROOT/completed-report.tmp"
awk -v archive="$ARCHIVE_ABS" -v backup="$DOCTRINE_BACKUP_ABS" -v start_report="$START_REPORT_ABS" '
  $0 == "## Completion result" {
    print
    if ((getline) > 0) {
      print "- archive: " archive
      print "- doctrine backup: " backup
      print "- doctrine and retired-state manifests: replayed"
      print "- application and keep-active hashes: unchanged"
      print "- fresh START: " start_report "; ProjectState modern; user accepted"
      print "- candidates: application entry accepted; legacy-only invariant rejected"
      print "- current intent: ship current request handed to plan"
      print "- remaining blockers: none; next permitted action: plan"
    }
    next
  }
  { print }
' "$REPORT" > "$completion_tmp"
mv "$completion_tmp" "$REPORT"
if grep -q -- '- pending' "$REPORT"; then fail "completed report retains pending decision/result"; fi
grep -q "fresh START: $START_REPORT_ABS; ProjectState modern; user accepted" "$REPORT" ||
  fail "Completion result omits the accepted START path/state"
grep -q 'current intent: ship current request handed to plan' "$REPORT" || fail "current intent was not handed to plan"
[ "$(hash_file "$CONFIRMED_REPORT")" = "$CONFIRMED_HASH" ] || fail "confirmed snapshot changed after completion"
receipt_hash="$(awk -F '\t' '$1 == "report_sha256" { print $2 }' "$CUTOVER")"
[ "$receipt_hash" = "$CONFIRMED_HASH" ] || fail "receipt no longer names the confirmed snapshot"
[ "$(hash_file "$REPORT")" != "$CONFIRMED_HASH" ] || fail "active report did not record completion"
if (cd "$PROJECT" && rg -q 'old evidence|task001|status: doing' . \
    -g '!.spec-agents/archive/**' -g '!.spec-agents/scratch/**' \
    -g '!.spec-agents/doctrine/**'); then
  fail "old lifecycle state re-entered the active project"
fi
pass "fresh START acceptance, candidate decisions, and Completion result"

# 8. Every retired marker family reaches the same receipt-gated link replacement.
for marker_kind in phrase root-bundle scratch-spec phase-status presplit-context; do
  marker_project="$TRIAL_ROOT/marker-$marker_kind"
  marker_backup="$marker_project/.spec-agents/archive/doctrine"
  mkdir -p "$marker_project/.spec-agents/archive"
  printf 'marker application\n' > "$marker_project/app.txt"
  case "$marker_kind" in
    phrase)
      mkdir "$marker_project/.phrase"
      printf 'old current\n' > "$marker_project/.phrase/current.md"
      ;;
    root-bundle) printf 'old spec\n' > "$marker_project/spec_checkout.md" ;;
    scratch-spec)
      mkdir -p "$marker_project/.scratch/checkout"
      printf 'old spec\n' > "$marker_project/.scratch/checkout/SPEC.md"
      ;;
    phase-status) printf '**Phase**: delivery\ntask001 [ ] ship\n' > "$marker_project/STATUS.md" ;;
    presplit-context)
      printf '# Workflow\n\n### Change\nold\n\n### Plan\nold\n' > "$marker_project/CONTEXT.md"
      ;;
  esac
  marker_app_hash="$(hash_file "$marker_project/app.txt")"
  prepare_valid_cutover "$marker_project" "$marker_backup"
  "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$marker_project" "$marker_backup" \
    --cutover "$marker_project/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" en --link </dev/null \
    > "$TRIAL_ROOT/marker-$marker_kind.out"
  [ -f "$marker_project/AGENTS.md" ] &&
    cmp "$REPO_ROOT/templates/AGENTS-adapter.md" "$marker_project/AGENTS.md" ||
    fail "$marker_kind did not install the copied root adapter"
  [ "$(hash_file "$marker_project/app.txt")" = "$marker_app_hash" ] ||
    fail "$marker_kind changed application content"
  grep -q 'Doctrine replacement complete' "$TRIAL_ROOT/marker-$marker_kind.out" ||
    fail "$marker_kind omitted doctrine completion"
  if grep -q 'Spec-AGENTS is ready' "$TRIAL_ROOT/marker-$marker_kind.out"; then
    fail "$marker_kind claimed project readiness"
  fi
done
OWNED_AGENT_PROJECT="$TRIAL_ROOT/project-owned-agent"
OWNED_AGENT_BACKUP="$OWNED_AGENT_PROJECT/.spec-agents/archive/doctrine"
mkdir -p "$OWNED_AGENT_PROJECT/.phrase" "$OWNED_AGENT_PROJECT/.spec-agents/archive"
printf '%s\n' '# project-owned instructions' > "$OWNED_AGENT_PROJECT/AGENTS.md"
printf '%s\n' 'old doctrine marker' > "$OWNED_AGENT_PROJECT/START.md"
OWNED_AGENT_HASH="$(hash_file "$OWNED_AGENT_PROJECT/AGENTS.md")"
prepare_valid_cutover "$OWNED_AGENT_PROJECT" "$OWNED_AGENT_BACKUP"
"$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$OWNED_AGENT_PROJECT" "$OWNED_AGENT_BACKUP" \
  --cutover "$OWNED_AGENT_PROJECT/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" en --link \
  </dev/null > "$TRIAL_ROOT/project-owned-agent.out"
[ "$(hash_file "$OWNED_AGENT_PROJECT/AGENTS.md")" = "$OWNED_AGENT_HASH" ] ||
  fail "project-owned AGENTS.md changed during replacement"
[ -f "$OWNED_AGENT_PROJECT/.spec-agents/doctrine/AGENTS.md" ] ||
  fail "project-owned AGENTS replacement omitted Doctrine"
grep -q 'Integration required:' "$TRIAL_ROOT/project-owned-agent.out" ||
  fail "project-owned AGENTS replacement omitted integration guidance"
pass "receipt-gated retired-marker recognition matrix"

# 9. Existing guards, failure recovery, and ordinary-install readiness remain distinct.
PLAIN="$TRIAL_ROOT/plain"
mkdir "$PLAIN"
if "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$PLAIN" "$TRIAL_ROOT/plain-backup" \
     --cutover "$PLAIN/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" en </dev/null \
     > "$TRIAL_ROOT/plain.out" 2>&1; then
  fail "zero-marker target accepted"
fi
if "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$PROJECT" "$DOCTRINE_BACKUP" \
     --cutover "$CUTOVER" en </dev/null > "$TRIAL_ROOT/existing-backup.out" 2>&1; then
  fail "existing backup accepted"
fi
if "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$REPO_ROOT" "$TRIAL_ROOT/source-backup" \
     --cutover "$TRIAL_ROOT/no-receipt" en </dev/null > "$TRIAL_ROOT/source-target.out" 2>&1; then
  fail "source repository accepted as a replacement target"
fi

BROKEN="$TRIAL_ROOT/broken"
BROKEN_BACKUP="$TRIAL_ROOT/broken-backups/doctrine"
mkdir -p "$BROKEN/skills" "$(dirname "$BROKEN_BACKUP")" "$BROKEN/.spec-agents"
printf 'old start\n' > "$BROKEN/START.md"
printf 'old upgrade\n' > "$BROKEN/UPGRADE.md"
prepare_valid_cutover "$BROKEN" "$BROKEN_BACKUP"
chmod a-w "$BROKEN/.spec-agents"
if "$DOCTRINE_SOURCE/bin/spec-agents" replace-doctrine "$BROKEN" "$BROKEN_BACKUP" \
     --cutover "$BROKEN/.spec-agents/scratch/upgrade-review/CUTOVER.tsv" en </dev/null \
     > "$TRIAL_ROOT/broken.out" 2>&1; then
  fail "post-backup install failure reported success"
fi
grep -q 'Recovery material:' "$TRIAL_ROOT/broken.out" || fail "failure omitted recovery path"
[ -f "$BROKEN_BACKUP/DOCTRINE-MANIFEST.tsv" ] || fail "failure omitted doctrine backup"
replay_doctrine_manifest "$BROKEN_BACKUP"
for refusal_output in plain.out existing-backup.out source-target.out broken.out; do
  assert_no_success "$TRIAL_ROOT/$refusal_output"
done

FRESH_INSTALL="$TRIAL_ROOT/fresh-install"
"$DOCTRINE_SOURCE/bin/spec-agents" install "$FRESH_INSTALL" en </dev/null > "$TRIAL_ROOT/fresh-install.out"
grep -q 'Spec-AGENTS is ready' "$TRIAL_ROOT/fresh-install.out" || fail "ordinary install lost readiness output"
if grep -q 'Doctrine replacement complete' "$TRIAL_ROOT/fresh-install.out"; then
  fail "ordinary install printed replacement completion"
fi
pass "guard refusals, post-backup recovery, and distinct install readiness"

# 10. Workflow commands accept all strong roots and refuse partial/retired roots.
make_modern_root() {
  local root="$1"
  "$DOCTRINE_SOURCE/bin/spec-agents" install "$root" en </dev/null >/dev/null
  mkdir -p "$root/nested/deep"
}
exercise_root() {
  local root="$1" label="$2"
  (cd "$root" && "$DOCTRINE_SOURCE/bin/spec-agents" status > "$TRIAL_ROOT/$label-root-status.out")
  (cd "$root/nested/deep" && "$DOCTRINE_SOURCE/bin/spec-agents" status > "$TRIAL_ROOT/$label-nested-status.out")
  (cd "$root/nested/deep" && "$DOCTRINE_SOURCE/bin/spec-agents" check-state > "$TRIAL_ROOT/$label-check.out")
  (cd "$root/nested/deep" && "$DOCTRINE_SOURCE/bin/spec-agents" gate plan > "$TRIAL_ROOT/$label-plan.out")
  grep -Eq 'No SPECs\.|SPECs:' "$TRIAL_ROOT/$label-root-status.out"
  grep -Eq 'No SPECs\.|SPECs:' "$TRIAL_ROOT/$label-nested-status.out"
  grep -Eq 'no .*\.spec-agents/specs/|no state violations' "$TRIAL_ROOT/$label-check.out"
  grep -q 'no machine-checkable precondition' "$TRIAL_ROOT/$label-plan.out"
}
refuse_root() {
  local root="$1" label="$2"
  mkdir -p "$root/nested"
  if (cd "$root/nested" && "$DOCTRINE_SOURCE/bin/spec-agents" status > "$TRIAL_ROOT/$label.out" 2>&1); then
    fail "$label unexpectedly became a workflow root"
  fi
  grep -q 'no complete \.spec-agents/doctrine/ entry' "$TRIAL_ROOT/$label.out" ||
    fail "$label refusal omitted the accepted root markers"
}

MODERN_ROOT="$TRIAL_ROOT/root-modern"
make_modern_root "$MODERN_ROOT"
exercise_root "$MODERN_ROOT" root-modern
[ ! -e "$MODERN_ROOT/.git" ] && [ ! -e "$MODERN_ROOT/.jj" ] && [ ! -e "$MODERN_ROOT/.specs" ] ||
  fail "modern no-VCS root was mutated"
JJ_ROOT="$TRIAL_ROOT/root-jj"
mkdir -p "$JJ_ROOT/.jj"
make_modern_root "$JJ_ROOT"
exercise_root "$JJ_ROOT" root-jj
[ -d "$JJ_ROOT/.jj" ] && [ ! -e "$JJ_ROOT/.git" ] && [ ! -e "$JJ_ROOT/.specs" ] ||
  fail "native JJ root was mutated"
GIT_ROOT="$TRIAL_ROOT/root-git"
mkdir -p "$GIT_ROOT/.git"
make_modern_root "$GIT_ROOT"
exercise_root "$GIT_ROOT" root-git
SPECS_ROOT="$TRIAL_ROOT/root-specs"
mkdir -p "$SPECS_ROOT/.specs" "$SPECS_ROOT/nested/deep"
refuse_root "$SPECS_ROOT" root-specs

NEAREST_PARENT="$TRIAL_ROOT/root-nearest"
mkdir -p "$NEAREST_PARENT/.git" "$NEAREST_PARENT/.specs/broken" "$NEAREST_PARENT/project"
printf '%s\n' 'status: broken' > "$NEAREST_PARENT/.specs/broken/SPEC.md"
make_modern_root "$NEAREST_PARENT/project"
(cd "$NEAREST_PARENT/project/nested/deep" &&
  "$DOCTRINE_SOURCE/bin/spec-agents" status > "$TRIAL_ROOT/root-nearest.out")
grep -q '^No SPECs\.$' "$TRIAL_ROOT/root-nearest.out" || fail "nearest modern child did not win"

ARBITRARY_ROOT="$TRIAL_ROOT/root-arbitrary"
refuse_root "$ARBITRARY_ROOT" root-arbitrary
SINGLE_ROOT="$TRIAL_ROOT/root-single"
mkdir -p "$SINGLE_ROOT"
printf '%s\n' '# familiar' > "$SINGLE_ROOT/AGENTS.md"
refuse_root "$SINGLE_ROOT" root-single
PARTIAL_ROOT="$TRIAL_ROOT/root-partial"
mkdir -p "$PARTIAL_ROOT/docs/spec-agents"
printf '%s\n' '# project' > "$PARTIAL_ROOT/AGENTS.md"
printf '%s\n' '# start' > "$PARTIAL_ROOT/START.md"
printf '%s\n' '# workflow' > "$PARTIAL_ROOT/docs/spec-agents/WORKFLOW.md"
refuse_root "$PARTIAL_ROOT" root-partial
RETIRED_ONLY_ROOT="$TRIAL_ROOT/root-retired"
mkdir -p "$RETIRED_ONLY_ROOT/.phrase"
printf '%s\n' 'old' > "$RETIRED_ONLY_ROOT/.phrase/current.md"
refuse_root "$RETIRED_ONLY_ROOT" root-retired
pass "workflow project-root matrix"

bash -n "$DOCTRINE_SOURCE/bin/spec-agents"
bash -n "$REPO_ROOT/tests/upgrade-reset-smoke.sh"
[ "$PASS_COUNT" -eq 10 ] || fail "expected 10 assertion groups, ran $PASS_COUNT"
echo "ok: upgrade reset smoke: 10/10"
