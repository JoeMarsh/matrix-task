# Matrix Task

`matrix-task` is an Agent Skill for Codex and Claude Code that helps complete complex software tickets thoroughly instead of stopping at a partial checkpoint.

## Install

```bash
npx skills add JoeMarsh/matrix-task --skill matrix-task
```

Select Codex, Claude Code, or both when prompted.

## The problem it solves

Coding agents can implement the obvious or happy-path parts of a ticket, reach a useful checkpoint—perhaps 80% complete—and then report the task as finished. Less-visible requirements, other actors or controllers, architectural invariants, edge cases, and tests may still be missing.

`matrix-task` is designed to prevent this by turning the entire ticket into an auditable checklist before implementation begins. If requirements remain incomplete and there is no true hard blocker, the agent must re-plan and continue rather than treating partial progress as completion.

It guides the agent to:

- Build a requirements matrix before changing code.
- Identify critical invariants and remaining gaps.
- Implement the ticket in reviewable slices.
- Use new agents for clean-context reviews.
- Finish with evidence, limitations, and follow-up work.

## How the requirements matrix works

Before writing code, the agent reads the full ticket and creates one matrix row for every requirement, acceptance criterion, invariant, test, and explicit non-goal. Each row records:

- What the ticket requires.
- Whether the current code already satisfies it.
- Which actors, controllers, files, or symbols it affects.
- Exactly how completion will be proved, such as a test or assertion.

Every incomplete row is clearly marked. As the agent implements the ticket, it updates the matrix after each significant slice and identifies the highest-risk remaining gap.

The task cannot be marked done until every row is either:

1. Fully satisfied and proven with evidence; or
2. Explicitly marked out of scope with a ticket reference.

This makes the matrix a completion checklist for the entire ticket, not just the main or happy-path behavior.

## Compatibility

The shared `SKILL.md` follows the open Agent Skills format used by both Codex and Claude Code. Both agents receive the same completion rules.

- Codex invokes the skill as `$matrix-task`.
- Claude Code invokes the skill as `/matrix-task`.

## Use

Codex:

```text
$matrix-task

Implement this ticket completely:

[paste the ticket here]
```

Claude Code:

```text
/matrix-task

Implement this ticket completely:

[paste the ticket here]
```

The skill begins with the Requirements Matrix and continues until the ticket's Definition of Done is met or a true hard blocker is found.
