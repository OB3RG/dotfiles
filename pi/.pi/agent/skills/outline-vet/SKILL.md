---
name: outline-vet
description: Produce a structured, human-reviewable outline from a scoped plan before drafting. Use when the user says outline, vet, review outline, or checkpoint. Checks intent match, section boundaries, flow coherence, and model overreach.
---

# Outline Vet Skill

## Purpose

Produce a structured outline that a human can quickly vet before drafting begins. This is the checkpoint between brainstorming/scoping and writing. The goal is to catch structural problems while they are cheap to fix, before they become expensive rewrites.

## When to Use

After brainstorming and scope refinement have produced a content brief, but before any section drafting begins. This skill transforms the brief into a reviewable outline and runs it through a vetting checklist.

## How to Execute

### 1. Assemble the Outline

From the content brief and brainstorming artifacts, produce a structured outline with:
- Working title
- One-sentence thesis
- Section list, each with:
  - Section heading
  - 3-5 bullet points covering what the section addresses
  - Evidence/artifacts needed (code snippets, diagrams, benchmarks, examples)
  - Estimated word count range
  - Transition note: how it connects to the previous section

### 2. Run the Vetting Checklist

For each section, verify:

**Intent match**: Does this section reflect the author's actual argument or experience, not an adjacent topic the model found more interesting?

**Section boundaries**: Is this a single coherent idea, or are two distinct points lumped together? Is one idea split across two sections unnecessarily?

**Flow coherence**: Read the section headings in order. Does a reader feel a natural progression from one to the next? Flag any abrupt jumps.

**Model overreach**: Did the model introduce framings, generalizations, or claims that sound plausible but don't reflect the author's lived experience? Flag these for removal.

**Evidence coverage**: Does every key claim in this section have a planned proof artifact (code, data, example, screenshot)?

**Scope discipline**: Does this section stay within the agreed scope boundary, or does it drift into out-of-scope territory?

### 3. Output Format

Present the outline as a markdown document with the vetting results inline:

```
# [Working Title]

**Thesis:** [one sentence]

## Section 1: [Heading]
- Bullet 1
- Bullet 2
- Evidence needed: [code snippet | diagram | benchmark | example]
- Est. words: [range]
- Transition: [how it connects from previous section]

Vet: [PASS | FLAG: reason]
```

### 4. Human Checkpoint

After producing the vetted outline, STOP. Do not proceed to drafting. Present the outline to the human and ask:
- Do the sections match your intent?
- Are the boundaries sensible?
- Does the flow feel coherent?
- Did the model overreach anywhere?

If the human requests changes, revise the outline and re-vet. Only proceed to drafting when the human explicitly approves.

## Stop Rules

- Do NOT start writing prose. This skill produces an outline only.
- Do NOT proceed past the human checkpoint without explicit approval.
- If the outline feels wrong after vetting, recommend going back to brainstorming rather than pushing forward.

## Tone

Direct, structural, editorial. Flag problems honestly. Do not rubber-stamp a flawed outline.