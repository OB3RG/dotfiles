---
name: llm-memory
description: Save and recall durable knowledge in the llm-brain memory vault — user preferences, environment quirks, fixes, decisions, findings. Use when remembering something across sessions, filing a learning, or checking what memory knows before repeating past work.
---

# llm-memory — persistent memory conventions

The brain is the vault at `~/Documents/llm-brain` (an agent-maintained wiki; schema in its `AGENTS.md`). Sessions die; the brain accumulates.

## Worth saving
- User preferences and working style (formats, tone, tools, review habits)
- Environment quirks (machine setup, versions, workarounds, what breaks and how it was fixed)
- Decisions and their rationale (architecture choices, "we tried X and rejected it because Y")
- Fixes that worked — and fixes that failed (both prevent re-work)
- Recurring problems and their patterns
- Interesting settled findings and insights worth revisiting
- Project state snapshots at natural milestones

Do not save transient troubleshooting, unresolved guesses, or passing mentions; wait for a settled outcome.

## Not worth saving
- Trivia and one-off facts with no future bearing
- Anything already in the brain (grep first — dedup, update instead of duplicate)
- Secrets: API keys, tokens, passwords, private personal data — never
- Raw transcripts; distill to the finding

## How to save
- From outside the brain: `subagent` tool, agent `brain-scribe`, `cwd` `/home/oberg/Documents/llm-brain`, task = the finding + one line of context. The scribe files it (learning page, related page updates, index, log), uses read-only JABFA MCP for deduplication, and refreshes `/tmp/llm-brain-jabfa.sqlite3` after writes. JABFA structured writes on the real vault remain canary-gated.
- Inside the brain: file directly per the vault schema — `wiki/learnings/YYYY-MM-DD-<slug>.md`, frontmatter `type: learning` with `origin` (provenance), then index + log (`learn` entry).

## How to recall
- From outside: `subagent` tool, agent `brain-recall`, `cwd` `/home/oberg/Documents/llm-brain`, task = the topic. It uses read-only JABFA MCP search/context/sections first, with targeted legacy search fallback for unavailable or incomplete coverage, and returns compressed findings with citations and gaps.
- Inside the brain: use the `jabfa` MCP tools when available, or `scripts/search.sh <terms>`/targeted `rg` as fallback, then read only the relevant pages. Do not read the full index/log for routine recall.

## Discipline
- Batch related findings into one scribe call at a natural milestone; save during work only when context may be lost.
- Reuse recall results within a session topic instead of calling repeatedly.
- When a memory turns out wrong, correct it in the brain (update the page, note the correction in the log) rather than silently working around it.
- If a task contradicts memory, trust the task's fresh evidence, then update memory.
