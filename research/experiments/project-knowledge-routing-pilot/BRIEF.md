# Project Knowledge Routing Pilot

## Question

After adding Protocols, Runbooks, and scoped Lessons, can a bounded task load
the right project knowledge, avoid applying an unrelated Lesson, and execute a
repeatable operational check with an explicit recovery boundary?

## Hypothesis

Intent-routed project knowledge will add a small context cost but make the
required verification and operational boundary visible. It should improve
traceability and repeatability; this pilot does not claim better code quality
or general Agent behavior.

## Scope

- one harmless shell-script change in an isolated temporary Git repository;
- the shell validation Protocol;
- the local installer smoke Runbook;
- the existing browser-only DOM Lesson as an unrelated-routing negative case;
- two repeated installer copy runs and one source-repository refusal.

## Arms

**Control** uses the default root context and runs the minimal syntax check on
the temporary shell change.

**Treatment** adds only the Protocol and Runbook selected by the shell/installer
intent, then runs the Protocol checks and the Runbook. It must not load or apply
the browser-only Lesson.

## Non-goals

This is not an LLM A/B test, scheduler test, multi-Agent test, graph/database
test, production installer redesign, or evidence of universal quality gains.
