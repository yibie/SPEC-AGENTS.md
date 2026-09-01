# Runbook: Local Installer Smoke Test

status: active
scope: `bin/spec-agents` installation, the doctrine allowlist, and the Doctrine/Instance boundary
applies_when: changing installer argument handling, the installed file set, link behavior, `templates/`, or `docs/spec-agents/`
owner: project maintainer
source: E-20260817-005; E-20260820-001; E-20260831-006; E-20260831-007; E-20260831-008; E-20260831-009; `research/experiments/project-knowledge-routing-pilot/`
verification: two isolated copy installs, one link install, source-repository refusal, and `tests/upgrade-reset-smoke.sh` 10/10 match the assertions below

## Preconditions

- Run from the SPEC-AGENTS repository root.
- `bash` is available. The installer smoke test does not require a JJ or Git
  command; use the repository's configured version-control interface for any
  surrounding inspection.
- Use a directory created by `mktemp`; never use the source repository as the
  installation target.
- Do not use a real project or copy authentication files into the fixture.
- For doctrine replacement, complete the current upstream `UPGRADE.md` review
  and obtain confirmation of its exact disposition manifest first. Create the
  immutable confirmed-report snapshot and CUTOVER receipt only after that
  confirmation. The smoke fixture is not permission to replace doctrine in an
  unreviewed project.

## Steps

```bash
TARGET_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-installer-smoke.XXXXXX")"
trap 'rm -rf "$TARGET_ROOT"' EXIT

bash -n bin/spec-agents

bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
bin/spec-agents install "$TARGET_ROOT/linked" en --link </dev/null

bash -n tests/upgrade-reset-smoke.sh
tests/upgrade-reset-smoke.sh
```

The second install checks that existing files are kept and the operation is
repeatable.

## Verification

### Installed set

The target contains exactly this doctrine, and nothing else:

```text
AGENTS.md  START.md  UPGRADE.md  CONTEXT.md
docs/spec-agents/README.md
docs/spec-agents/check-kernel.sh          (must be executable)
docs/spec-agents/{WORKFLOW,single-authority,parallel-work,evidence-links,knowledge-promotion,jj-change-management,jj-project-setup}.md
skills/{plan,capture,arrange,do,check,learn}/
```

### Absent set

These must not exist in a fresh target. They are Instance, or they are created
later by the project's own work:

```bash
for absent in STATUS.md ROADMAP.md EVIDENCE.md KERNEL.md archive \
              docs/adr docs/protocols docs/runbooks docs/lessons research bin tests; do
  if [ -e "$TARGET_ROOT/project/$absent" ]; then
    echo "installed Instance material: $absent" >&2
    exit 1
  fi
done
```

`KERNEL.md` is absent because the first `START.md` scan creates it from the
project's confirmed facts. `STATUS.md`, `ROADMAP.md`, and `EVIDENCE.md` are
absent because `learn` creates them on the first real write.

### Executable assertion

The payload is documents plus exactly one script. It must arrive runnable:

```bash
[ -x "$TARGET_ROOT/project/docs/spec-agents/check-kernel.sh" ] \
  || { echo "checker lost its executable bit" >&2; exit 1; }
( cd "$TARGET_ROOT/project" && ./docs/spec-agents/check-kernel.sh . ) \
  || { echo "shipped checker fails on a fresh install" >&2; exit 1; }
```

A fresh install has no `KERNEL.md`, so the checker must exit 0 with a notice.

### Leakage assertion

No installed file may name this repository's phases, tasks, scripts, research,
or Evidence. An upstream Evidence ID is allowed only on a line that labels it as
upstream, because such a line tells the reader the ID is not resolvable in their
project:

```bash
if grep -rnE "bin/spec-agents|Phase [0-9]|task[0-9]|research/|E-2026" \
     "$TARGET_ROOT/project" | grep -v "upstream SPEC-AGENTS Evidence"; then
  echo "instance state leaked into the installed payload" >&2
  exit 1
fi
```

This assertion is the standing guard for the defect that caused it: the
installer used to enumerate `docs/` and copy this repository's root documents,
so a managed project received this repository's active phase as its own.

### Link assertion

Doctrine may be symlinked. A file sourced from `templates/` may not — a symlink
would let the managed project write back into this repository:

```bash
[ -L "$TARGET_ROOT/linked/AGENTS.md" ] || { echo "doctrine should link" >&2; exit 1; }
[ -L "$TARGET_ROOT/linked/CONTEXT.md" ] && { echo "template must be copied" >&2; exit 1; }
```

### Link resolution

Every relative Markdown link in the installed payload must resolve inside the
target. This catches a doctrine record that still points at a path the installer
no longer emits:

```bash
cd "$TARGET_ROOT/project"
find . -name '*.md' | while read -r f; do
  d=$(dirname "$f")
  grep -o '](\([^)h][^)]*\.md\))' "$f" | sed 's/](\(.*\))/\1/' | while read -r l; do
    [ -e "$d/$l" ] || echo "broken link: $f -> $l"
  done
done
```

### Source-repository refusal

The command below must refuse without changing the source repository:

```bash
if bin/spec-agents install . en; then
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
`.scratch/upgrade-review/REPORT.md` and its parent directories. The report must
contain every section declared by `UPGRADE.md`. Its preservation table has one
row per relevant path and records source path, path type, one of the four
dispositions, classification evidence, exact archive destination, and the
count/hash check. An `unresolved` row stops here.

After the user fills `## User decision`, create the confirmed archive root and:

1. copy REPORT byte-for-byte to `CONFIRMED-REPORT.md` under that root;
2. verify the active report and snapshot have the same SHA-256;
3. write the exact six-row CUTOVER defined by current upstream `UPGRADE.md`,
   using canonical target and absent backup paths, the report hash, literal
   zero unresolved rows, and `decision=confirmed`;
4. invoke replacement with the explicit receipt:

   ```text
   spec-agents replace-doctrine <project> <backup-dir> \
     --cutover <project>/.scratch/upgrade-review/CUTOVER.tsv [lang] [--link|-l]
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

- reconnaissance writes only `.scratch/upgrade-review/REPORT.md`; every
  pre-existing path keeps the same type and SHA-256 content before user
  confirmation;
- User decision is filled before the immutable snapshot and receipt; snapshot,
  active report, and `report_sha256` agree when replacement begins;
- `replace-doctrine` backs up only `AGENTS.md`, `START.md`, `UPGRADE.md`,
  `skills/`, and `docs/spec-agents/`, then writes a replayable
  `DOCTRINE-MANIFEST.tsv` before removing the installed doctrine;
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
  archive/backup/report paths and replay results, and contains no pending
  decision or result;
- after Completion changes the active report, the immutable confirmed report
  still equals the receipt hash.

### Workflow root assertions

Run `status`, `check-state`, and `gate plan` from both root and nested
directories of `.specs`, Git, native-JJ, and complete modern no-VCS fixtures.
The native-JJ and no-VCS fixtures must not gain another VCS or `.specs`.
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

Recovery restores only the five doctrine allowlist
paths from that backup and verifies them against `DOCTRINE-MANIFEST.tsv`; it
does not overwrite CONTEXT, KERNEL, STATUS, EVIDENCE, `.specs/`, application
code, configuration, tests, credentials, or repository history.
