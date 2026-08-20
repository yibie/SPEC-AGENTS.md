# Lesson: Do Not Shadow Native Form APIs

status: active
scope: browser form code that calls native form methods or properties
applies_when: adding an element `id` or `name` to a form
owner: project maintainer
source: E-20260817-004; `research/experiments/room-v4-direct-repro/RESULTS.md`
verification: `node --check`, the forbidden-API scan, and the real-browser submit matrix all pass after the control is renamed

## Observation

The treatment app used `id="reset"` for a button and then called
`form.reset()`. The control shadowed the form's native method, so a valid submit
persisted data but threw `TypeError: form.reset is not a function` before the
same-submit render completed.

## Lesson

Do not use element IDs or names that shadow native form methods or properties.
Prefer descriptive names such as `cancel-edit`, and check the complete submit
flow in a real browser rather than treating syntax validation as sufficient.

## Verification

The corrected treatment renamed the control, passed `node --check`, passed the
forbidden-API scan, and passed the full browser matrix. This is a scoped browser
practice, not a universal claim about every DOM identifier.
