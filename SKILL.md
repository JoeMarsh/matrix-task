---
name: matrix-task
description: Complete substantial software tasks or tickets with a requirements matrix, review-budget ledger, invariant checks, phased implementation, bounded clean-agent reviews, a blocker challenge, and evidence. Use when completeness and faithfulness matter more than speed or elegance.
---

# Matrix Task

Complete the task or ticket (the work item) autonomously. Prioritize completeness and faithfulness to every requirement over speed or elegance. Maintain auditable artifacts: Requirements Matrix, Review Budget Ledger, prioritized gap list, self-checks, and review notes.

Stop early only for a true hard blocker. A blocker is hard only when, after the audit, investigation, and safe in-scope alternatives, no meaningful progress remains on any incomplete requirement. Complete every unaffected row before stopping.

- Every remaining incomplete row depends on an unavailable task, system, or dependency.
- A core requirement is contradictory, nonsensical, or impossible to satisfy with the current codebase and available information.
- Information required for every remaining row cannot be inferred or safely assumed from the work item and codebase.

Ambiguity, difficulty, risk, underestimated scope, turn limits, noncritical failures, or anything that can be safely assumed, isolated, deferred, or reported as a limitation or follow-up is not a blocker. Record it and continue. Before the first proposed stop, run the one Blocker Challenge below. If blocked, explain why, list completed work, and state exactly what is needed to unblock.

## Work Item Interpretation

- Treat the work item as intent and an acceptance bar, not a rigid specification.
- Inspect the current code before designing or implementing.
- Prefer a clearly better solution when it still satisfies all acceptance criteria and critical invariants.
- Report deviations from the written approach, their reasons, and how the acceptance bar remains met.

## Requirements Matrix

Before writing code, create:

| Requirement (quote or paraphrase the work item) | Category (functional / architectural invariant / conservation / test / non-goal) | Current status (exists / partial / missing / diverges) | Must remain true for all relevant actors/controllers? (yes/no + note) | Files / symbols to change | Proof (test, assertion, or manual check) |
|---|---|---|---|---|---|

Mark every incomplete row. Do not implement until the matrix is complete.

## Critical Invariants

Extract every hard architectural or behavioural invariant from the work item. Treat any violation as a P0 defect, even when the happy path works.

## Review Budget Ledger

During Phase 1, before implementation, define the significant slices and create:

| Slot ID | Type (slice review / final review / blocker challenge) | Scope and Requirements Matrix rows | Significance justification | Trigger | Status (planned / used / not needed) |
|---|---|---|---|---|---|

- The frozen rows are the entire review-and-challenge budget: exactly one per significant slice, one final-review row, and one conditional blocker-challenge row.
- Use the fewest significant slices practical. Each must deliver a coherent, independently testable requirement group or cross a genuine architectural boundary.
- Individual files, commits, small fixes, tests, review fixes, and incidental refactors are not slices by themselves. Never split or relabel work to increase reviews.
- Freeze the Review Budget Ledger before implementation. Compaction, resumed work, findings, fixes, severity, or reclassification cannot add rows or reset used rows.
- After compaction or resume, restate the ledger and used/remaining statuses before continuing.
- Absorb newly discovered work into an existing slice or final scope; do not add a review slot.

## Blocker Challenge

- Immediately before the first proposed hard-blocker stop, use the one blocker-challenge slot with a new clean-context agent. Give it the work item, Requirements Matrix, Review Budget Ledger, current code and evidence, incomplete rows, attempted paths, safe assumptions considered, and exact proposed blocker.
- Instruct it to try to disprove the blocker by finding a safe assumption, alternative implementation, or meaningful partial path. This is a blocker challenge, not a broad code review.
- If it finds any viable path, mark the slot used and continue. Stop only if it finds no meaningful path and the hard-blocker test above still holds.
- Use the slot at most once; never reset it or add another. If no blocker is proposed, mark it not needed in the Final Report.

## Phased Execution

1. Audit: complete the Requirements Matrix, critical invariants, prioritized gap list, and frozen Review Budget Ledger.
2. Implement incomplete rows within the frozen slices. Small reviewable code changes remain inside their slice and do not create reviews.

After every non-trivial change or slice, update the Requirements Matrix and record:

- Requirements now fully satisfied.
- Requirements still partial or untested.
- The single highest-risk remaining gap.

Continue until the Definition of Done is met or a true hard blocker occurs.

## Definition of Done

The work item is done only when:

- Every Requirements Matrix row is satisfied and proven, or out of scope with a reference or justification.
- Every slice/final review row was used exactly once; the blocker-challenge row is used before a proposed stop or marked not needed. No unplanned review or challenge occurred.
- All critical invariants hold.
- Acceptance criteria are met with tests, digests, or clear reasoning.
- Remaining limitations and follow-up work are listed.

## Self-Check Rules

- Never accept a special-case path merely because it exists.
- When creating or keeping a divergent actor/controller path, stop and justify why shared authority cannot handle it.
- Prefer small changes that close matrix rows. Rewrite only when clearly cleaner or more correct; explain why it better satisfies the invariants and acceptance bar.
- Stop and flag any shortcut forbidden by the work item.

## Review

- Use only frozen slices; smaller changes remain inside them.
- Run only predeclared reviews: one clean-context review by one new agent after each slice, then one final clean-context review by one new agent.
- Fix findings without re-review. Fixes remain in the original slice; never rename, split, or reclassify them to trigger another review.
- Mark each row used immediately. Never add or reset a row, repeat a slice review, or repeat the final review. No exceptions or workarounds.

## Final Report

On completion or a hard blocker, report:

- Implementation summary.
- Final Requirements Matrix and Review Budget Ledger.
- Deviations from the written approach.
- Remaining issues, limitations, or follow-up work.
- Evidence that acceptance criteria and invariants hold, or why they cannot.
- For a blocker, its exact cause and what is needed to unblock.

Start with the Requirements Matrix for the task or ticket below.
