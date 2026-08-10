---
name: matrix-task
description: Complete complex software tasks or tickets with a requirements matrix, critical-invariant checks, phased implementation, clean-agent review, and evidence. Use when completeness and faithfulness to a substantial work item matter more than speed or elegance.
---

# Matrix Task

You are working on a complex software task or ticket (the work item). Your highest priority is completeness and faithfulness to every requirement, not speed or elegance.

Work fully autonomously to the end of the work item. Produce clear intermediate artifacts (matrix, gap list, self-checks, review notes) so a human can later inspect what happened. At the very end, list any remaining issues, limitations, or recommended follow-up work.

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

## Phased Execution

Phase 1: Complete the audit (matrix + prioritized gap list).

Phase 2: Implement the incomplete rows, preferably in small reviewable slices.

After every non-trivial change or slice, re-check the matrix and record:

- Which requirements are now fully satisfied?
- Which are still partial or untested?
- What is the single highest-risk remaining gap?

Continue until the Definition of Done is met or you hit a true hard blocker.

## Definition of Done

The work item is not done until:

- Every row in the Requirements Matrix is either fully satisfied and proven or explicitly marked out of scope with a reference or justification.
- All critical invariants still hold.
- The acceptance criteria in the original work item are met with evidence (tests, digests, or clear reasoning).
- You have listed any remaining known limitations or follow-up work.

## Self-Check Rules

- Never assume a special-case path is acceptable just because it currently exists.
- Any time you create or keep a divergent code path for different actors/controllers, stop and justify why the shared authority cannot handle it.
- Prefer small, reviewable changes that close matrix rows over large rewrites, unless a rewrite is clearly the cleaner or more correct path. When choosing a rewrite, explicitly justify why it better satisfies the invariants and acceptance bar.
- If you notice yourself implementing a convenient shortcut that the work item forbids, stop and flag it.

## Review

- Break work into reviewable slices wherever practical.
- After each significant slice (and once at the end), perform a clean-context review of the changes using a new agent.
- Fix issues found in the reviews. Do only one additional clean-context agent review pass using a second new agent if the first review surfaces multiple P0/P1 problems; otherwise stop after the single clean-context review + fixes.

## Final Report

When finished, or when stopped by a hard blocker, output:

- Summary of what was implemented.
- Updated Requirements Matrix with final status.
- Any deviations from the original work-item approach.
- Remaining issues, limitations, or recommended follow-up work.
- Evidence that acceptance criteria and invariants hold, or a clear statement of why they cannot yet.
- If stopped by a hard blocker: exact description of the blocker and what is required to unblock.

Start now with the Requirements Matrix for the task or ticket below.
