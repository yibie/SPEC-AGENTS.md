# Evidence Delta Template

## YYYY-MM-DD: <topic>

**Observation**:

- What was directly observed.

**Interpretation**:

- What the observation likely means.

**Classification**:

- Local fix, shared mechanism, workflow boundary, platform divergence,
  product ambiguity, operational dependency, data quality issue, or another
  project-specific class.

**Verification**:

- Test, trace, benchmark, audit, manual check, or other proof.

**Before / After**:

- Baseline before the phase.
- Result after the phase.

**Remaining Blockers**:

- What still prevents completion.

**Recommended Next Action**:

- What the next phase or task should do.

## Cutover Example

### YYYY-MM-DD: vNext migration cutover

**Observation**:

- Legacy SPEC-AGENTS v2 material was archived under
  `.phrase/archive/legacy-v2/`.
- Active context was compressed into `.phrase/current.md`.

**Interpretation**:

- Old phase files are historical context, not default planning authority.

**Verification**:

- Agent can continue from `.phrase/decision.md`, `.phrase/roadmap.md`, and
  `.phrase/current.md`.

**Remaining Blockers**:

- Any missing rationale that still requires archive lookup.

**Recommended Next Action**:

- Continue from `current.md`; inspect the legacy archive only for regression or
  missing rationale.
