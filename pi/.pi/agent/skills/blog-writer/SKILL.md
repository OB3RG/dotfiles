---
name: blog-writer
description: Use when writing, drafting, or editing blog posts. Applies the user's preferred writing style — informal, personable, technically focused, and narrative-driven. Trigger when creating new blog content or revising existing prose.
---

# Blog Writing Skill

## Purpose

Write and edit blog posts in the user's preferred style: informal, educational, and technically focused while remaining approachable to a broader audience.

## ==========================================
## VOICE PREFERENCES — EDIT THIS SECTION
## ==========================================
<!-- To customize your writing voice, edit the rules below.
     Add words you love, words you hate, pronoun preferences,
     formality level, sentence length, or any AI patterns
     you've noticed that annoy you. The agent will follow
     these rules when drafting and editing. -->

### My Voice Rules
- Pronoun: "we" to guide the reader; "I" for personal opinions
- Contractions: always (we'll, it's, don't, we're, I've)
- Em dashes: use sparingly; prefer colons, commas, parentheses
- Formality: informal but technically precise
- Sentence length: varied, mix short and long

### Banned Words/Phrases (AI-smell)
- "It's not this, it's that."
- "Paying the ___ tax" (both "pay" and "tax")
- "__ changes that."
- "That matters because"
- "sidecar"
- (Add your own banned phrases here)

### Words I Love
- (Add words you enjoy using here)

### Words I Hate
- (Add words you never want to see here)

## ==========================================
## END VOICE PREFERENCES
## ==========================================

## Core Writing Guidelines

### 1. Use Contractions (Always)

Write informally. Use contractions throughout:
- "We'll" not "we will"
- "It's" not "it is"
- "Don't" not "do not"
- "We're" not "we are"
- "I've" not "I have"

Scan all prose for uncontracted forms and replace them.

### 2. Use "We" to Guide the Reader

Write as if taking the reader on a journey together:
- **Default to "we"**: "Let's look at...", "We'll explore...", "Here's what we need to consider..."
- **Use "I" for personal opinions**: When expressing a personal view or preference, "I" is appropriate. "I think this approach works best because..."

The goal is to make the reader feel like a collaborator, not a passive observer.

### 3. Tell a Cohesive Story

- Connect ideas smoothly from one section to the next
- Each paragraph should flow naturally into the next
- Avoid abrupt topic changes without transitions
- Keep it concise — don't be verbose, but don't sacrifice clarity for brevity

### 4. Minimize Em Dashes

Em dashes (—) can feel choppy when overused. Prefer:
- **Colons**: to introduce lists or explanations
- **Commas**: for natural pauses within sentences
- **Parentheses**: for asides and supplementary information

Reserve em dashes for occasional emphasis or dramatic effect.

### 5. Technical but Approachable

- Write primarily for a technical audience
- But keep explanations clear enough that someone adjacent to the field can follow
- Define jargon when first introduced, or provide enough context that meaning is clear
- Use concrete examples to ground abstract concepts

### 6. Make it sound like a human wrote it

LLM writing at times feels very formulaic, using very similar phrasing. The goal is to make what you write feel approachable and human, not like a dry manual that was written by a robot. Avoid repeating the same sentence structures, vary your word choice, and inject a bit of personality where appropriate. The content should be clear and accurate, but also engaging to read.

Avoid the following extremely common patterns or phrases:
- "It's not this, it's that."
- "Paying the ___ tax" (e.g., "paying the import tax", "paying the setup tax") − both "pay" and "tax" should be avoided
- "__ changes that."
- "That matters because"
- "sidecar"

## Tone Checklist

Before finalizing any blog prose, verify:

- [ ] All contractions are in place (no "do not", "we are", etc.)
- [ ] "We" is used by default; "I" only for personal opinions
- [ ] Em dashes are used sparingly
- [ ] Prose flows as a connected narrative
- [ ] Technical concepts are explained without being condescending

## Example Transformations

**Too formal:**
> "We will now examine the architecture. It is important to note that this approach does not work in all cases."

**Preferred:**
> "Let's look at the architecture. It's worth noting that this approach won't work in all cases."

---

**Overusing em dashes:**
> "The system — which handles authentication — uses JWTs — a common standard — for session management."

**Preferred:**
> "The system (which handles authentication) uses JWTs, a common standard for session management."

---

**Too impersonal:**
> "One might consider using a different approach here."

**Preferred:**
> "We might want to consider a different approach here."

---

**Personal opinion (use "I"):**
> "We think this is the best solution."

**Preferred:**
> "I think this is the best solution." (when it's genuinely a personal view)