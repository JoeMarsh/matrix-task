# Matrix Task

`matrix-task` is a Codex skill for completing complex software tickets thoroughly instead of stopping at a partial checkpoint.

It guides Codex to:

- Build a requirements matrix before changing code.
- Identify critical invariants and remaining gaps.
- Implement the ticket in reviewable slices.
- Use new agents for clean-context reviews.
- Finish with evidence, limitations, and follow-up work.

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
