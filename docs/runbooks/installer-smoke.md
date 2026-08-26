# Runbook: Local Installer Smoke Test

status: active
scope: `bin/spec-agents` installation, the doctrine allowlist, and the Doctrine/Instance boundary
applies_when: changing installer argument handling, the installed file set, link behavior, `templates/`, or `docs/spec-agents/`
owner: project maintainer
source: E-20260817-005; E-20260820-001; `research/experiments/project-knowledge-routing-pilot/`
verification: two isolated copy installs, one link install, and a source-repository install all match the assertions below

## Preconditions

- Run from the SPEC-AGENTS repository root.
- `bash` is available. The installer smoke test does not require a JJ or Git
  command; use the repository's configured version-control interface for any
  surrounding inspection.
- Use a directory created by `mktemp`; never use the source repository as the
  installation target.
- Do not use a real project or copy authentication files into the fixture.

## Steps

```bash
TARGET_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/spec-agents-installer-smoke.XXXXXX")"
trap 'rm -rf "$TARGET_ROOT"' EXIT

bash -n bin/spec-agents

bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
bin/spec-agents install "$TARGET_ROOT/project" en </dev/null
bin/spec-agents install "$TARGET_ROOT/linked" en --link </dev/null
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

## Recovery

The `trap` removes only the generated `TARGET_ROOT`. If a command stops before
the trap is installed, remove the exact printed temporary path after checking
that it is under `/tmp` or the platform temporary directory. No repository
file should need recovery.
