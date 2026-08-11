---
name: matrix-task
description: Complete complex software tasks or tickets with a requirements matrix, critical-invariant checks, phased implementation, clean-agent review, and evidence. Use when completeness and faithfulness to a substantial work item matter more than speed or elegance.
---

# Matrix Task

You are working on a complex software task or ticket (the work item). Your highest priority is completeness and faithfulness to every requirement, not speed or elegance.

Work fully autonomously to the end of the work item. Produce clear intermediate artifacts (requirements matrix, review budget matrix, gap list, self-checks, review notes) so a human can later inspect what happened. At the very end, list any remaining issues, limitations, or recommended follow-up work.

Only stop early if you hit a true hard blocker. Examples of hard blockers:

- The work item depends on another task or ticket that is not yet done and whose absence makes correct implementation impossible.
- After the audit, a core requirement is contradictory, nonsensical, or impossible to satisfy with the current codebase and available information.
- Critical information is missing that cannot be inferred or safely assumed from the work item and codebase.

Underestimating the remaining scope or reaching a useful checkpoint is not a hard blocker; re-plan and continue implementing.

If you hit a hard blocker, stop, explain it clearly, list what you have already completed, and state exactly what is needed to unblock.

## Work Item Interpretation Rule

- A task or ticket expresses intent and an acceptance bar, not a rigid specification.
- Always investigate the current code before designing or implementing.
- If you discover a clearly better design or implementation that still fully satisfies the acceptance criteria and all critical invariants, prefer it.
- When you deviate from the written approach, explicitly note the deviation, the reason, and how the acceptance bar is still met.

## Requirements Matrix

Do this first, before any code. Create a table with these columns:

| Requirement (quote or paraphrase the exact work-item text) | Category (functional / architectural invariant / conservation / test / non-goal) | Status in current codebase (exists / partial / missing / diverges) | Must remain true for all relevant actors/controllers? (yes/no + note) | Files / symbols that must change | How we will prove it (test name, assertion, or manual check) |
|---|---|---|---|---|---|

Mark every incomplete item explicitly. Do not write implementation code until the matrix is complete.

## Critical Invariants

Extract and list every hard architectural or behavioural invariant from the work item. Treat any violation of these invariants as a P0 defect, even if the happy path works.

## Review Budget Matrix

During Phase 1, before implementation, define the significant slices and create this table:

| Review ID | Type (slice / final) | Planned scope and Requirements Matrix rows | Significance justification | Trigger | Status (planned / used) |
|---|---|---|---|---|---|

- Include exactly one review row for each significant slice and exactly one final-review row.
- Use the fewest significant slices practical. Each slice must deliver a coherent, independently testable group of requirements or cross a genuine architectural boundary.
- Individual files, commits, small fixes, tests, review fixes, and incidental refactors are not significant slices on their own. Do not split or relabel work to increase the review budget.
- Freeze the Review Budget Matrix before implementation. Compaction, resumed work, review findings, fixes, severity, or reclassification must not add review rows or reset used rows.
- After any compaction or resume, restate the matrix and its used/remaining statuses before continuing.
- Absorb newly discovered work into an existing planned slice or the final scope. Do not create a new review slot.

## Phased Execution

Phase 1: Complete the audit (Requirements Matrix + critical invariants + prioritized gap list + frozen Review Budget Matrix).

Phase 2: Implement the incomplete rows within the frozen significant slices. Make small reviewable code changes inside a slice without treating them as additional slices or reviews.

After every non-trivial change or slice, re-check the matrix and record:

- Which requirements are now fully satisfied?
- Which are still partial or untested?
- What is the single highest-risk remaining gap?

Continue until the Definition of Done is met or you hit a true hard blocker.

## Definition of Done

The work item is not done until:

- Every row in the Requirements Matrix is either fully satisfied and proven or explicitly marked out of scope with a reference or justification.
- Every row in the Review Budget Matrix is marked used exactly once, and no unplanned review was performed.
- All critical invariants still hold.
- The acceptance criteria in the original work item are met with evidence (tests, digests, or clear reasoning).
- You have listed any remaining known limitations or follow-up work.

## Self-Check Rules

- Never assume a special-case path is acceptable just because it currently exists.
- Any time you create or keep a divergent code path for different actors/controllers, stop and justify why the shared authority cannot handle it.
- Prefer small, reviewable changes that close matrix rows over large rewrites, unless a rewrite is clearly the cleaner or more correct path. When choosing a rewrite, explicitly justify why it better satisfies the invariants and acceptance bar.
- If you notice yourself implementing a convenient shortcut that the work item forbids, stop and flag it.

## Review

- Use only the significant slices frozen in the Review Budget Matrix; smaller implementation changes remain inside those slices.
- Execute only the reviews predeclared in the frozen Review Budget Matrix. After each significant slice, perform its one clean-context review using one new agent. At the end, perform the one final clean-context review using one new agent.
- Fix issues found by a review, but do not review those fixes again. Review fixes remain part of the original slice and must not be renamed, split, or reclassified as a new slice to trigger another review.
- Mark each review row used immediately after it runs. These are hard review limits: never add a row, reset a used row, perform a second review of the same slice, or perform a second final review. No exceptions or workaround review loops.

## Final Report

When finished, or when stopped by a hard blocker, output:

- Summary of what was implemented.
- Updated Requirements Matrix and Review Budget Matrix with final status.
- Any deviations from the original work-item approach.
- Remaining issues, limitations, or recommended follow-up work.
- Evidence that acceptance criteria and invariants hold, or a clear statement of why they cannot yet.
- If stopped by a hard blocker: exact description of the blocker and what is required to unblock.

Start now with the Requirements Matrix for the task or ticket below.
