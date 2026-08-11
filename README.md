# Matrix Task

`matrix-task` is an Agent Skill for Codex and Claude Code that helps complete complex software tasks or tickets thoroughly instead of stopping at a partial checkpoint.

[![skills.sh](https://skills.sh/b/JoeMarsh/matrix-task)](https://skills.sh/JoeMarsh/matrix-task)

## Install

```bash
npx skills add JoeMarsh/matrix-task --skill matrix-task
```

Select Codex, Claude Code, or both when prompted.

### Use

Codex:

```text
$matrix-task <task or ticket>
```

Claude Code:

```text
/matrix-task <task or ticket>
```

## The problem it solves

Coding agents can implement the obvious or happy-path parts of a task, reach a useful checkpoint—perhaps 80% complete—and then report it as finished. Less-visible requirements, other actors or controllers, architectural invariants, edge cases, and tests may still be missing.

`matrix-task` is designed to prevent this by turning the entire task or ticket into an auditable checklist before implementation begins. If requirements remain incomplete and there is no true hard blocker, the agent must re-plan and continue rather than treating partial progress as completion.

It guides the agent to:

- Build a requirements matrix before changing code.
- Identify critical invariants and remaining gaps.
- Implement the work within substantial, preplanned slices.
- Pre-plan a fixed review budget using the fewest substantial, independently testable slices practical, with one new-agent review per slice and one final review.
- Finish with evidence, limitations, and follow-up work.

## How the requirements matrix works

Before writing code, the agent reads the full task or ticket and creates one matrix row for every requirement, acceptance criterion, invariant, test, and explicit non-goal. Each row records:

- What the task or ticket requires.
- Whether the current code already satisfies it.
- Which actors, controllers, files, or symbols it affects.
- Exactly how completion will be proved, such as a test or assertion.

Every incomplete row is clearly marked. As the agent completes the work, it updates the matrix after each significant slice and identifies the highest-risk remaining gap.

The task cannot be marked done until every row is either:

1. Fully satisfied and proven with evidence; or
2. Explicitly marked out of scope with a reference or justification.

This makes the matrix a completion checklist for the entire task or ticket, not just the main or happy-path behavior.

Before implementation, the agent also freezes a Review Budget Matrix listing every significant slice review plus the final review. Compaction, fixes, or reclassifying work cannot create additional review slots.

## Compatibility

The shared `SKILL.md` follows the open Agent Skills format used by both Codex and Claude Code. Both agents receive the same completion rules.

- Codex invokes the skill as `$matrix-task`.
- Claude Code invokes the skill as `/matrix-task`.

The skill begins with the Requirements Matrix and continues until the task's Definition of Done is met or a true hard blocker is found.
