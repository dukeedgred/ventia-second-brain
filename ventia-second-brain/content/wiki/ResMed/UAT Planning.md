---
type: concept
topic: ResMed
sources: ["raw/May 25, 2026.md"]
date-created: 2026-05-25
date-updated: 2026-05-25
tags: [UAT, testing, sample, Snowflake, milestone]
---

# UAT Planning

User Acceptance Testing plan for the spend cube classification output.

## Mini UAT

- **Reviewer:** Mia, IT category manager
- **Scheduled:** Tuesday or Wednesday, week of 2026-05-25
- **Purpose:** Share classification results (rule-based, RAG, LLM) for Mia's review and feedback

## Sample

- **Size:** 400 stratified records
- **Possible expansion:** sample can be increased if needed
- **Selection:** Junaid Dewan and Duke Kang apply rules to full dataset; results joined to Honglin Jin's base table

## Data Delivery

Write access to Snowflake has **not yet been confirmed** (pending Benji). To meet the Tuesday deadline, the team will use **file extracts** rather than a direct database connection.

- Junaid Dewan confirmed file extracts are feasible.
- Charlotte Pan is following up with Benji on write access status.

## Output Format

Three separate determination columns will be shared:
1. Rule-based result
2. RAG result
3. LLM / AI result (with taxonomy suggestion column)

Keeping results separate allows Mia and the team to evaluate each method independently before deciding on a combined approach (see [[Evaluation Framework]]).

## Related Pages

- [[Evaluation Framework]]
- [[Classification Approach]]
- [[Engagement Team]]
- [[Spend Cube Engagement]]
