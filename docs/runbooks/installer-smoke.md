# Runbook: Local Installer Smoke Test

status: active
scope: `.spec-agents/doctrine/bin/spec-agents` installation, the doctrine allowlist, and the Doctrine/Instance boundary
applies_when: changing installer argument handling, the installed file set, link behavior, `templates/`, or `.spec-agents/doctrine/docs/`
owner: project maintainer
source: E-20260817-005; E-20260820-001; E-20260831-006; E-20260831-007; E-20260831-008; E-20260831-009; `research/experiments/project-knowledge-routing-pilot/`
verification: namespaced copy/repeat/link and existing-entry installs, source-repository refusal, and `tests/upgrade-reset-smoke.sh` 10/10 match the assertions below

## Preconditions

- Run from the SPEC-AGENTS repository root.
- `bash` is available. The installer smoke test does not require a JJ or Git
  command; use the repository's configured version-control interface for any
  surrounding inspection.
- Use a directory created by `mktemp`; never use the source repository as the
  installation target.
- Do not use a real project or copy authentication files into the fixture.
- For doctrine replacement, complete the current upstream `.spec-agents/doctrine/UPGRADE.md` review
  and obtain confirmation of its exact disposition manifest first. Create the
  immutable confirmed-report snapshot and CUTOVER receipt only after that
  confirmation. The smoke fixture is not permission to replace doctrine in an
  unreviewed project.

## Steps

```bash
TARGET_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-installer-smoke.XXXXXX")"
trap 'rm -rf "$TARGET_ROOT"' EXIT

.spec-agents/doctrine/bin/spec-agents --help >/dev/null
bash -n .spec-agents/doctrine/bin/spec-agents

.spec-agents/doctrine/bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
.spec-agents/doctrine/bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
.spec-agents/doctrine/bin/spec-agents install "$TARGET_ROOT/linked" en --link </dev/null

tests/namespaced-install-check.sh

bash -n tests/upgrade-reset-smoke.sh
tests/upgrade-reset-smoke.sh
```

The second install checks that existing files are kept and the operation is
repeatable.

## Verification

### Namespaced installed set

The target contains exactly the root integration surface and this explicit
Doctrine payload:

```text
AGENTS.md                              copied adapter when the root path was free
.spec-agents/doctrine/AGENTS.md        selected-language full contract
.spec-agents/doctrine/{START,UPGRADE}.md
.spec-agents/doctrine/bin/spec-agents  (must be executable)
.spec-agents/doctrine/docs/{README,WORKFLOW,check-kernel,...}.md
.spec-agents/doctrine/skills/{plan,capture,arrange,do,check,learn}/
```

The docs directory is the explicit `.spec-agents/doctrine/docs/` allowlist with
its double namespace removed. Each action also carries its prompt file under
`agents/openai.yaml`. The Chinese and English fixtures compare the selected
full AGENTS contract byte-for-byte with the source.

### Root and Instance boundary

A fresh target has exactly `AGENTS.md` and `.spec-agents/` at its root. It has
no root `START.md`, `UPGRADE.md`, `CONTEXT.md`, `KERNEL.md`, `STATUS.md`, or
`EVIDENCE.md`, and no `.spec-agents/state/`, `.spec-agents/specs/`,
`.spec-agents/scratch/`, or `.spec-agents/archive/`.
It also has no copied `docs/adr`, `docs/protocols`, `docs/runbooks`,
`docs/lessons`, `research`, `bin`, or `tests`. The first Start and later actions
create the namespaced Instance paths only when the project needs them.

The shipped checker and CLI retain their executable bits. On a fresh target,
run the checker from the target root; without a KERNEL it exits 0 with a notice.
The focused fixture also scans the namespaced payload for retired Instance
directories, and checks the source refusal before any source-repository write.

### Leakage assertion

No installed Markdown may carry this repository's Instance material: `Phase N`,
`taskN`, `research/`, or an unmarked `E-2026` Evidence ID. An Evidence ID is
exempt only when its line explicitly says `upstream SPEC-AGENTS Evidence`.
The check follows links so copy and link installs are covered:

```bash
while IFS= read -r markdown; do
  bad="$(grep -nE 'Phase [0-9]+|task[0-9]+|research/' "$markdown" || true)"
  if [ -n "$bad" ]; then
    echo "instance state leaked into installed Markdown: $markdown" >&2
    echo "$bad" >&2
    exit 1
  fi
  ids="$(grep -nE 'E-2026' "$markdown" || true)"
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    case "$line" in
      *upstream\ SPEC-AGENTS\ Evidence*) ;;
      *)
        echo "unmarked upstream Evidence ID in installed Markdown: $markdown" >&2
        echo "$line" >&2
        exit 1
        ;;
    esac
  done <<< "$ids"
done < <(find -L "$TARGET_ROOT/project" -type f -name '*.md' -print)
```

This is the standing guard against the installer copying upstream phases,
tasks, research, or Evidence into a managed project. The focused fixture keeps
the same scan and allows only the explicitly marked upstream Evidence lines.

### Link resolution

Every relative Markdown link in the installed Doctrine must resolve inside the
target. This remains a standing guard for the complete namespaced layout:

```bash
cd "$TARGET_ROOT/project"
find -L .spec-agents/doctrine -name '*.md' -type f | while read -r f; do
  d=$(dirname "$f")
  grep -o '](\([^)h][^)]*\.md\))' "$f" | sed 's/](\(.*\))/\1/' | while read -r l; do
    case "$l" in
      /*) target="$TARGET_ROOT/project$l" ;;
      *) target="$d/$l" ;;
    esac
    [ -e "$target" ] || echo "broken link: $f -> $l"
  done
done
```

The guard is expected to be green for the complete namespaced Doctrine; a
broken link is an installer or payload regression, not a reason to remove the
guard.

### Repeat and link assertion

The second copy install must preserve every path and byte. With `--link`, the
Doctrine payload may link to the source, including the CLI, checker, docs, and
skills; the generated root adapter is always a regular copied file so a managed
project cannot write through it into the source repository. Existing project
files are never replaced.

### Existing-entry integration assertion

An existing root `AGENTS.md` is hashed before and after installation. When it
lacks this exact whole line:

```text
Read `.spec-agents/doctrine/AGENTS.md`.
```

the command prints one actionable line containing the exact text to add and
does not print a readiness claim. After the project owner adds that line, a
repeat install may claim readiness. An absent root `AGENTS.md` receives the
copied adapter.

### Source-repository refusal

The command below must refuse without changing the source repository:

```bash
if .spec-agents/doctrine/bin/spec-agents install . en; then
  echo "source-repository refusal failed" >&2
  exit 1
fi
```

## Existing-project doctrine replacement

`tests/upgrade-reset-smoke.sh` is the executable replacement fixture. It uses
only generated temporary projects and names ten assertion groups. Require
exactly ten numbered `ok` lines and the final
`upgrade reset smoke: 10/10` line. A missing group, count mismatch, or early
exit is a failure even when no shell error is visible.

### Confirmed inputs before replacement

Before confirmation, the project may gain only
`.spec-agents/scratch/upgrade-review/REPORT.md` and its parent directories. The report must
contain every section declared by `.spec-agents/doctrine/UPGRADE.md`. Its preservation table has one
row per relevant path and records source path, path type, one of the four
dispositions, classification evidence, exact archive destination, and the
count/hash check. An `unresolved` row stops here.

After the user fills `## User decision`, create the confirmed archive root and:

1. copy REPORT byte-for-byte to `CONFIRMED-REPORT.md` under that root;
2. verify the active report and snapshot have the same SHA-256;
3. write the exact six-row CUTOVER defined by current upstream
   `.spec-agents/doctrine/UPGRADE.md`,
   using canonical target and absent backup paths, the report hash, literal
   zero unresolved rows, and `decision=confirmed`;
4. invoke replacement with the explicit receipt:

   ```text
   spec-agents replace-doctrine <project> <backup-dir> \
     --cutover <project>/.spec-agents/scratch/upgrade-review/CUTOVER.tsv [lang] [--link|-l]
   ```

Do not reuse a receipt after REPORT, target, or backup changes. Show the
revision, confirm it again, refresh the snapshot, and write a new receipt.

The fixture must prove these inputs are executable gates, not only prose:

- missing receipt or wrong canonical location;
- wrong format; missing, duplicate, or unknown field;
- target, backup, or report-hash mismatch, including a report changed after
  confirmation;
- non-zero `unresolved_count` or a decision other than `confirmed`.

Every case exits non-zero before the backup exists, leaves protected manifests
unchanged, and prints neither doctrine completion nor project readiness.

### Replacement, reset, and completion assertions

The fixture must prove all of these boundaries together:

- reconnaissance writes only `.spec-agents/scratch/upgrade-review/REPORT.md`; every
  pre-existing path keeps the same type and SHA-256 content before user
  confirmation;
- User decision is filled before the immutable snapshot and receipt; snapshot,
  active report, and `report_sha256` agree when replacement begins;
- `replace-doctrine` backs up the explicit old-root Doctrine paths and any
  existing `.spec-agents/doctrine/` payload as separate old/new manifests,
  retains the `.spec-agents/` parent, then writes replayable
  `OLD-DOCTRINE-MANIFEST.tsv`, `NEW-DOCTRINE-MANIFEST.tsv`, and aggregate
  `DOCTRINE-MANIFEST.tsv` records before installing the namespaced Doctrine;
- root project-owned `AGENTS.md` and all other Instance paths remain byte-
  identical; only an exact generated adapter may be replaced;
- stale doctrine entries disappear, the current allowlist is installed, and a
  complete pre/post manifest proves every Instance path unchanged;
- the retired-state archive reproduces every approved source path, type, and
  hash; the active tree contains no inherited KERNEL, STATUS, EVIDENCE,
  ROADMAP, SPEC, Slice, phase, task, or completion state;
- `.phrase`, a root legacy bundle, a tracked scratch SPEC, a phase-shaped
  STATUS, and a pre-split CONTEXT all reach the same replacement operation.
  These marker names are recognition evidence, not conversion selectors;
- successful replacement prints doctrine completion, never project readiness;
  ordinary install retains `Spec-AGENTS is ready`;
- a zero-marker target, existing backup, source-repository target, and forced
  post-backup installation failure all exit non-zero and print neither success
  claim;
- a post-backup failure prints `Recovery material:` and leaves the doctrine
  backup plus manifest available for exact restoration;
- a simulated fresh START produces a current K1 and `ProjectState: modern`,
  accepts a currently supported candidate, rejects an unsupported legacy
  candidate, receives user acceptance, and hands current intent to `plan`;
- Completion result is filled only after that START result, names actual
  `.spec-agents/archive/`, backup, and `.spec-agents/scratch/` report paths and
  replay results, and contains no pending
  decision or result;
- after Completion changes the active report, the immutable confirmed report
  still equals the receipt hash.

### Workflow root assertions

Run `status`, `check-state`, and `gate plan` from both root and nested
directories of `.spec-agents/specs/`, Git, native-JJ, and complete modern
no-VCS fixtures. The native-JJ and no-VCS fixtures must not gain another VCS
or a retired root `.specs/`.
A nearer complete modern root must win over a parent marker. A lone familiar
file, partial modern entry, arbitrary directory, and retired-only parent all
refuse and name every accepted strong marker.

The fixture authors the K1 and Start Report that simulate the Prompt outcome;
it does not execute an AI review, authenticate the confirmer, or prove general
safety on arbitrary real repositories. Keep a real-project cutover claim
separate until a reviewed disposable copy has completed the full prompt and
the user has accepted its START report.

## Recovery

The `trap` removes only the generated `TARGET_ROOT`. If a command stops before
the trap is installed, remove the exact printed temporary path after checking
that it is under `/tmp` or the platform temporary directory. No repository
file should need recovery.

The upgrade fixture also removes its generated project by default. Set
`SPEC_AGENTS_KEEP_FIXTURES=1` only when a failed assertion needs inspection;
the script prints the retained path. On a real confirmed replacement, keep the
printed doctrine backup, immutable confirmed report, CUTOVER receipt, and
retired-state archive until the user accepts the fresh START result. An invalid
receipt creates no backup: regenerate it from unchanged confirmed inputs, or,
if the report or paths change, show the revision and obtain confirmation again.
A failure after backup keeps the printed recovery location and never authorizes
START; inspect or restore before retrying.

Recovery restores only the explicit old/new Doctrine trees from that backup
and verifies them against `OLD-DOCTRINE-MANIFEST.tsv`,
`NEW-DOCTRINE-MANIFEST.tsv`, and `DOCTRINE-MANIFEST.tsv`; it does not overwrite
project-owned `AGENTS.md`, CONTEXT, `.spec-agents/state/`,
`.spec-agents/specs/`, application code, configuration, tests, credentials, or
repository history.
