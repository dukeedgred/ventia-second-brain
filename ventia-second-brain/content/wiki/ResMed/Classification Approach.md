---
type: concept
topic: ResMed
sources: ["raw/May 25, 2026.md"]
date-created: 2026-05-25
date-updated: 2026-05-25
tags: [classification, AI, LLM, RAG, rules, methodology]
---

# Classification Approach

The spend cube uses a three-stage classification cascade, with each method producing its own determination column. Results are kept separate for the initial [[UAT Planning]] phase so accuracy can be evaluated independently.

## Classification Methods

| Method | Owner | Description |
|---|---|---|
| Rule-based | Junaid Dewan | Explicit rules applied to supplier/GL data; flags items that cannot be classified (insufficient context) |
| RAG | Honglin Jin | Retrieval-augmented generation; accuracy being evaluated with LLM-as-judge |
| LLM / AI | Honglin Jin | Invoice description analysis; produces a taxonomy suggestion column |

## Key Decisions (2026-05-25)

- **Separate determinations:** Rule-based, RAG, and LLM results are maintained as separate columns for the initial UAT phase — no forced merge yet.
- **Taxonomy suggestion column:** AI output now includes an additional column capturing the classification suggestion and reasoning.
- **AI flags unclassifiables:** AI is configured to flag invoices where the description lacks sufficient context to classify, rather than defaulting to "others" or "general".
- **Supplier + GL signal:** Supplier-related data points and GL codes are available as supplementary signals; their impact on AI classification is inconsistent and under review.

## Unclassifiable Items

- Rule-based: items without sufficient description are excluded from results to preserve accuracy.
- AI: tasked with flagging these items via description-field analysis, not silently binning them.
- Vague taxonomy labels ("others", "general") to be avoided — taxonomy definitions refined accordingly (see [[Taxonomy and Stakeholders]]).

## Data Flow

1. Junaid Dewan and Duke Kang populate rules and apply them to the full dataset.
2. Results joined to Honglin Jin's base table in Snowflake.
3. Combined output (three determination columns) shared via file extract for UAT review.

## Related Pages

- [[Taxonomy and Stakeholders]]
- [[Evaluation Framework]]
- [[UAT Planning]]
- [[Spend Cube Engagement]]
