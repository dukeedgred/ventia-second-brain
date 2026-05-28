---
type: concept
topic: ResMed
sources: ["raw/May 25, 2026.md"]
date-created: 2026-05-25
date-updated: 2026-05-25
tags: [evaluation, accuracy, LLM-judge, UAT, reporting]
---

# Evaluation Framework

How the team measures and validates classification accuracy across rule-based, RAG, and LLM methods.

## LLM as Judge

Honglin Jin is integrating an LLM-as-judge component into the accuracy calculation pipeline. PRs under review as of 2026-05-25.

## Accuracy Reporting

- Determination columns appended to the current spreadsheet for tracking.
- Reports will include breakdowns by **subcategory** and **price range** to build confidence and support debugging.
- Subcategory breakdown assists in pinpointing where each method fails.

## Combined Evaluation Strategy

A definitive approach for combining rule-based, RAG, and LLM outputs has **not yet been decided**. A brainstorming session is planned (action: whole group) to determine how to trust and validate results across all three methods.

## UAT Evaluation

- Sample: 400 stratified records (see [[UAT Planning]]).
- Mia (IT category manager) reviews outputs in the mini UAT session.
- Results delivered as file extracts (pending Snowflake write access).

## Decisions (2026-05-25)

- Accuracy report will incorporate a subcategory breakdown.
- Price range breakdown to be added (Honglin Jin action item).
- Brainstorming session to finalise the combined evaluation approach.

## Related Pages

- [[Classification Approach]]
- [[UAT Planning]]
- [[Spend Cube Engagement]]
