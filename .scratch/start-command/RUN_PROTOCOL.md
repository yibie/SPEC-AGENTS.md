# Start route verification protocol

Run the route matrix in disposable directories. The route scan may create one
project file: an absent, confirmed-only `KERNEL.md` K1. It must never overwrite
an existing Kernel or touch application files, history, or dependencies.

| Case | Markers | Expected route |
| --- | --- | --- |
| modern | all modern root files, no legacy markers, no Kernel | create K1, then `plan` after confirmation |
| modern-existing-kernel | modern root files plus KERNEL.md | preserve K1, then `plan` after confirmation |
| legacy | `.phrase/` only | `UPGRADE.md` |
| mixed | modern root files plus `.phrase/` | `UPGRADE.md` with conflict |
| missing-entry | `START.md` without modern root files | install guidance |
| kernel-unavailable | modern markers but no directly confirmed project facts | report blocker |

Every case must leave application files unchanged after classification. Fresh
fixtures with stable facts must contain a K1; existing-Kernel fixtures must be
byte-for-byte preserved. The source SPEC-AGENTS repository must not acquire
`.jj/`, and no fixture may receive an application edit or version-control
initialization.
