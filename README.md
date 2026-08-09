# Matrix Task

`matrix-task` is a Codex skill for completing complex software tickets thoroughly instead of stopping at a partial checkpoint.

## The problem it solves

Coding agents can implement the obvious or happy-path parts of a ticket, reach a useful checkpoint—perhaps 80% complete—and then report the task as finished. Less-visible requirements, other actors or controllers, architectural invariants, edge cases, and tests may still be missing.

`matrix-task` is designed to prevent this by turning the entire ticket into an auditable checklist before implementation begins. If requirements remain incomplete and there is no true hard blocker, the agent must re-plan and continue rather than treating partial progress as completion.

It guides Codex to:

- Build a requirements matrix before changing code.
- Identify critical invariants and remaining gaps.
- Implement the ticket in reviewable slices.
- Use new agents for clean-context reviews.
- Finish with evidence, limitations, and follow-up work.

## How the requirements matrix works

Before writing code, Codex reads the full ticket and creates one matrix row for every requirement, acceptance criterion, invariant, test, and explicit non-goal. Each row records:

- What the ticket requires.
- Whether the current code already satisfies it.
- Which actors, controllers, files, or symbols it affects.
- Exactly how completion will be proved, such as a test or assertion.

Every incomplete row is clearly marked. As Codex implements the ticket, it updates the matrix after each significant slice and identifies the highest-risk remaining gap.

The task cannot be marked done until every row is either:

1. Fully satisfied and proven with evidence; or
2. Explicitly marked out of scope with a ticket reference.

This makes the matrix a completion checklist for the entire ticket, not just the main or happy-path behavior.

## Install

Give Codex this prompt:

> Install the `matrix-task` skill from https://github.com/JoeMarsh/matrix-task. The skill is located at the repository root; install it as `matrix-task`.

## Use

Start a prompt with the skill name and include your ticket:

```text
$matrix-task

Implement this ticket completely:

[paste the ticket here]
```

The skill begins with the Requirements Matrix and continues until the ticket's Definition of Done is met or a true hard blocker is found.
