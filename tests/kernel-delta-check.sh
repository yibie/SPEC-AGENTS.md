#!/bin/bash
# kernel-delta-check.sh — checks the CLI's kernel_delta seams in throwaway projects.

set -u
fail=0
bad() { echo "FAIL: $*" >&2; fail=1; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT/bin/spec-agents"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

OK_LINE="ok: gate passed. Read skills/do/SKILL.md and perform the slice."

make_gate_project() {
  local dir="$1" field="$2" model="$3" indent="${4:-  }"
  mkdir -p "$dir/.specs/feature/issues"
  {
    printf '%s\n\n' '# fixture'
    printf '%s\n' 'status: confirmed' 'revision: 1'
    case "$field" in
      absent) ;;
      none) printf '%s\n' 'kernel_delta: none' ;;
      empty) printf '%s\n' 'kernel_delta:' ;;
      entries)
        printf '%s\n' 'kernel_delta:'
        printf '%s\n' "${indent}- revise: fixture Kernel item"
        ;;
    esac
    printf '%s\n' 'context_refs:' '' '## Model delta'
    [ "$model" = nonempty ] && printf '%s\n' 'fixture delta'
    printf '%s\n' '' '## Action Contracts' 'fixture'
  } > "$dir/.specs/feature/SPEC.md"
  {
    printf '%s\n\n' '# fixture slice'
    printf '%s\n' 'status: ready' 'writer: do' 'authority: fixture' \
      'spec_ref: .specs/feature/SPEC.md' 'evidence_ref:'
  } > "$dir/.specs/feature/issues/01-slice.md"
}

run_gate() {
  local dir="$1" out="$2" err="$3"
  (cd "$dir" && "$CLI" gate do .specs/feature/issues/01-slice.md >"$out" 2>"$err")
}

case_entries_empty="$TMP/entries-empty"
make_gate_project "$case_entries_empty" entries empty
if run_gate "$case_entries_empty" "$TMP/entries-empty.out" "$TMP/entries-empty.err"; then
  bad "entries without Model delta was accepted"
else
  grep -Fq 'skills/capture/SKILL.md' "$TMP/entries-empty.err" \
    && echo "ok: entries without Model delta refused with capture citation" \
    || bad "entries without Model delta refusal lacks capture citation"
fi

case_absent="$TMP/absent"
make_gate_project "$case_absent" absent nonempty
if run_gate "$case_absent" "$TMP/absent.out" "$TMP/absent.err"; then
  if [ "$(cat "$TMP/absent.out")" = "$OK_LINE" ] && [ ! -s "$TMP/absent.err" ]; then
    echo "ok: absent kernel_delta passes with unchanged output"
  else
    bad "absent kernel_delta output changed"
  fi
else
  bad "absent kernel_delta was refused"
fi

case_empty="$TMP/empty"
make_gate_project "$case_empty" empty nonempty
if run_gate "$case_empty" "$TMP/empty.out" "$TMP/empty.err"; then
  bad "present-empty kernel_delta was accepted"
else
  grep -Fq 'skills/capture/SKILL.md' "$TMP/empty.err" \
    && echo "ok: present-empty kernel_delta refused with capture citation" \
    || bad "present-empty kernel_delta refusal lacks capture citation"
fi

case_entries_ok="$TMP/entries-ok"
make_gate_project "$case_entries_ok" entries nonempty
if run_gate "$case_entries_ok" "$TMP/entries-ok.out" "$TMP/entries-ok.err"; then
  if grep -Fq '.specs/feature/SPEC.md: ## Model delta' "$TMP/entries-ok.out"; then
    echo "ok: entries with Model delta pass with pointer"
  else
    bad "entries with Model delta output lacks pointer"
  fi
else
  bad "entries with Model delta was refused"
fi

case_none="$TMP/none"
make_gate_project "$case_none" none nonempty
if run_gate "$case_none" "$TMP/none.out" "$TMP/none.err"; then
  if [ "$(cat "$TMP/none.out")" = "$OK_LINE" ] && [ ! -s "$TMP/none.err" ]; then
    echo "ok: none kernel_delta passes with unchanged output"
  else
    bad "none kernel_delta output changed"
  fi
else
  bad "none kernel_delta was refused"
fi

case_indent_one="$TMP/indent-one"
make_gate_project "$case_indent_one" entries nonempty ' '
if run_gate "$case_indent_one" "$TMP/indent-one.out" "$TMP/indent-one.err"; then
  grep -Fq '.specs/feature/SPEC.md: ## Model delta' "$TMP/indent-one.out" \
    && echo "ok: one-space entry indentation passes with pointer" \
    || bad "one-space entry indentation lacks pointer"
else
  bad "one-space entry indentation was refused"
fi

case_indent_four="$TMP/indent-four"
make_gate_project "$case_indent_four" entries nonempty '    '
if run_gate "$case_indent_four" "$TMP/indent-four.out" "$TMP/indent-four.err"; then
  grep -Fq '.specs/feature/SPEC.md: ## Model delta' "$TMP/indent-four.out" \
    && echo "ok: four-space entry indentation passes with pointer" \
    || bad "four-space entry indentation lacks pointer"
else
  bad "four-space entry indentation was refused"
fi

case_indent_tab="$TMP/indent-tab"
make_gate_project "$case_indent_tab" entries nonempty $'\t'
if run_gate "$case_indent_tab" "$TMP/indent-tab.out" "$TMP/indent-tab.err"; then
  bad "tab entry indentation was accepted"
else
  grep -Fq 'skills/capture/SKILL.md' "$TMP/indent-tab.err" \
    && echo "ok: tab entry indentation refused as invalid YAML" \
    || bad "tab entry indentation refusal lacks capture citation"
fi

make_check_state_project() {
  local dir="$1" source="$2"
  mkdir -p "$dir/.specs/feature/issues"
  {
    printf '%s\n\n' '# verified fixture'
    printf '%s\n' 'status: verified' 'revision: 1' 'kernel_delta:' \
      '  - revise: fixture Kernel item' 'context_refs:' '' '## Model delta' \
      'fixture delta' '' '## Action Contracts' 'fixture'
  } > "$dir/.specs/feature/SPEC.md"
  {
    printf '%s\n\n' '# verified fixture slice'
    printf '%s\n' 'status: ready' 'authority: fixture' \
      'spec_ref: .specs/feature/SPEC.md' 'evidence_ref: E-fixture'
  } > "$dir/.specs/feature/issues/01-slice.md"
  printf '%s\n' '# fixture kernel' '### fixture Kernel item' 'since: K1' "source: $source" > "$dir/KERNEL.md"
}

case_source_ok="$TMP/source-ok"
make_check_state_project "$case_source_ok" '.specs/feature/SPEC.md'
if (cd "$case_source_ok" && "$CLI" check-state >"$TMP/source-ok.out" 2>"$TMP/source-ok.err"); then
  echo "ok: cited SPEC provenance passes check-state"
else
  bad "cited SPEC provenance was refused"
fi

case_source_bad="$TMP/source-bad"
make_check_state_project "$case_source_bad" '.specs/other/SPEC.md'
if (cd "$case_source_bad" && "$CLI" check-state >"$TMP/source-bad.out" 2>"$TMP/source-bad.err"); then
  bad "uncited SPEC provenance was accepted"
else
  grep -Fq '.specs/feature/SPEC.md' "$TMP/source-bad.err" \
    && echo "ok: uncited SPEC provenance refused and names the SPEC" \
    || bad "uncited SPEC provenance refusal lacks the SPEC path"
fi

make_resolution_project() {
  local dir="$1" feature="$2" declarations="$3" kernel="$4"
  mkdir -p "$dir/.specs/$feature/issues"
  {
    printf '%s\n\n' '# resolution fixture'
    printf '%s\n' 'status: verified' 'revision: 1' 'kernel_delta:'
    printf '%s\n' "$declarations"
    printf '%s\n' 'context_refs:' '' '## Model delta' 'fixture delta' '' '## Action Contracts' 'fixture'
  } > "$dir/.specs/$feature/SPEC.md"
  {
    printf '%s\n\n' '# resolution fixture slice'
    printf '%s\n' 'status: ready' 'authority: fixture' \
      "spec_ref: .specs/$feature/SPEC.md" 'evidence_ref:'
  } > "$dir/.specs/$feature/issues/01-slice.md"
  {
    printf '%s\n' '# fixture kernel'
    printf '%s\n' "$kernel"
  } > "$dir/KERNEL.md"
}

case_one_uncited="$TMP/one-uncited"
make_resolution_project "$case_one_uncited" feature \
  $'  - revise: first entry\n  - add: second entry' \
  $'### first entry\nsince: K1\nsource: .specs/feature/SPEC.md\n\n### second entry\nsince: K1\nsource: .specs/other/SPEC.md'
if (cd "$case_one_uncited" && "$CLI" check-state >"$TMP/one-uncited.out" 2>"$TMP/one-uncited.err"); then
  bad "one uncited entry was accepted"
else
  grep -Fq "second entry" "$TMP/one-uncited.err" \
    && echo "ok: one uncited entry is named by check-state" \
    || bad "one uncited entry is not named by check-state"
fi

case_both_cited="$TMP/both-cited"
make_resolution_project "$case_both_cited" feature \
  $'  - revise: first entry\n  - add: second entry' \
  $'### first entry\nsince: K1\nsource: .specs/feature/SPEC.md\n\n### second entry\nsince: K1\nsource: .specs/feature/SPEC.md'
if (cd "$case_both_cited" && "$CLI" check-state >"$TMP/both-cited.out" 2>"$TMP/both-cited.err"); then
  echo "ok: both cited entries pass check-state"
else
  bad "both cited entries were refused"
fi

case_common_prefix="$TMP/common-prefix"
make_resolution_project "$case_common_prefix" kernel-delta '  - revise: Model delta' \
  $'### Model delta\nsince: K1\nsource: .specs/kernel-delta-declaration/SPEC.md'
if (cd "$case_common_prefix" && "$CLI" check-state >"$TMP/common-prefix.out" 2>"$TMP/common-prefix.err"); then
  bad "common-prefix provenance trap was accepted"
else
  if grep -Fq '.specs/kernel-delta/SPEC.md' "$TMP/common-prefix.err" &&
     grep -Fq "Model delta" "$TMP/common-prefix.err"; then
    echo "ok: common-prefix provenance trap is refused"
  else
    bad "common-prefix refusal lacks SPEC or entry name"
  fi
fi

case_retire_absent="$TMP/retire-absent"
make_resolution_project "$case_retire_absent" retire-feature '  - retire: old rule' \
  $'## Other\nsource: .specs/retire-feature/SPEC.md'
if (cd "$case_retire_absent" && "$CLI" check-state >"$TMP/retire-absent.out" 2>"$TMP/retire-absent.err"); then
  echo "ok: retired entry with no record passes check-state"
else
  bad "retired entry with no record was refused"
fi

case_retire_present="$TMP/retire-present"
make_resolution_project "$case_retire_present" retire-feature '  - retire: old rule' \
  $'### old rule\nsince: K1\nsource: .specs/retire-feature/SPEC.md'
if (cd "$case_retire_present" && "$CLI" check-state >"$TMP/retire-present.out" 2>"$TMP/retire-present.err"); then
  bad "retired entry with a remaining record was accepted"
else
  grep -Fq "retire 'old rule'" "$TMP/retire-present.err" \
    && echo "ok: retired entry with a remaining record is refused" \
    || bad "retired-record refusal lacks verb and entry"
fi

case_parenthetical="$TMP/parenthetical"
make_resolution_project "$case_parenthetical" parenthetical \
  '  - revise: plain name (context note)' \
  $'### plain name\nsince: K1\nsource: .specs/parenthetical/SPEC.md'
if (cd "$case_parenthetical" && "$CLI" check-state >"$TMP/parenthetical.out" 2>"$TMP/parenthetical.err"); then
  echo "ok: parenthetical entry resolves to the plain heading"
else
  bad "parenthetical entry did not resolve to the plain heading"
fi

case_period="$TMP/period"
make_resolution_project "$case_period" period '  - revise: period entry' \
  $'### period entry\nsince: K1\nsource: .specs/period/SPEC.md.'
if (cd "$case_period" && "$CLI" check-state >"$TMP/period.out" 2>"$TMP/period.err"); then
  echo "ok: period-at-EOL provenance passes check-state"
else
  bad "period-at-EOL provenance was refused"
fi

exit "$fail"
