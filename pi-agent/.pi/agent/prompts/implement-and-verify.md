---
description: Plan a task, delegate implementation, and independently verify the result
argument-hint: <task>
---
Use the subagent tool with the chain parameter for this workflow:

1. Use `planner` to inspect the relevant code and create a concrete implementation plan for: $@
2. Use `worker` to implement the original request using the plan from `{previous}`. Require it to preserve the agreed design, make only necessary changes, and report files changed plus checks already run.
3. Use `verifier` to independently verify the original request: $@. Give it the worker report from `{previous}`; require inspection of the actual changes, meaningful tests/builds, and explicit reporting of anything unverified.

Pass the original request and prior output between steps so each agent has the acceptance criteria. Keep the steps in the same working directory.

After the chain, if verification failed, delegate the specific failures to `worker` and rerun `verifier`. Do not claim success until the acceptance criteria pass; if live or manual verification remains, report that limitation explicitly.
