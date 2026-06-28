---
type: concept
topic: Ventia
sources: ["raw/DAII Monthly Meeting Transcript.md", "raw/transport-first-two-week-plan-detailed-2026-05-28.md", "raw/Transport Data Product-20260622_153334-Meeting Recording.md"]
date-created: 2026-05-28
date-updated: 2026-06-22
tags: [data-governance, data-management, controls, risk, operating-model, alation, transport, data-products]
---

# Ventia Data Governance Framework

Ventia is building its data governance capability from a relatively greenfield position. The May 2026 DAII monthly meeting described a move from broad organisational engagement and risk-based prioritisation into execution, with the [[Safety Metrics Governance Pilot]] as the first major proving ground.

## Governance Pattern

The target pattern is to embed governance and controls by design into data delivery. For new data products, governance should not be a separate after-the-fact review; it should be part of requirements, build, testing, catalogue, quality, ownership, traceability, and release.

The framework is positioned as an enterprise control layer that helps de-risk business outcomes while enabling data-driven innovation. It links data management work to enterprise risk, including operational, reputational, financial, strategic, architectural, quality, and integrity risks.

The [[Transport Data Product Meeting Recording]] makes this pattern concrete for the [[Integrated Transport Data Asset]]. Shachi Shastry described data governance as the contextual layer required for data products and AI: business terms, critical data elements, agreed definitions, transformation logic, data-quality rules, source-to-consumption lineage, ownership, monitoring, and data-risk controls need to be defined while the product is being designed and built.

## Execution Focus

- Critical data elements are being identified and catalogued with business definitions, semantic context, traceability, ownership, and controls.
- Alation is being used as the data catalogue, with CD Manager being assessed to accelerate CDE discovery and reduce manual effort.
- The Transport data-product team is a focus for embedding governed delivery into a data product from the start.
- The Transport team is expected to share the Databricks tables, schemas, attributes, or data assets in focus once discovery settles, so governance can send a metadata template or checklist and start curating business context in Alation.
- Sustainability is a candidate area because the team has good business-process controls, but its data pipelines remain manual.

## Transport Programme Governance

The [[Transport First Two Week Plan]] applies the governance pattern to the [[Integrated Transport Data Asset]] mobilisation period. It names working groups, decision rights, access blockers, meeting evidence, and the handoff to weeks 3 to 6 as explicit operating-model outputs.

This reinforces that [[Transport Data Landscape]] mapping should capture ownership and access paths alongside source systems. The decision gate before week 3 should confirm the proof point, owner, data access, and commencement conditions, so governance is part of delivery readiness rather than a later assurance step.

The 2026-06-22 Transport data product meeting adds the next governance integration point. The data-product team is still investigating which Asset Vision and other Transport tables matter, while governance needs enough table and attribute visibility to define metadata, critical data elements, and data-quality rules. Osaka Tillakaratne also raised an unresolved design question: if AI or analytics will run in Databricks while curated context lives in Alation, the project needs a way to make governed metadata available to the consuming experience.

## Value Expected

The meeting described the expected value as reduced data risk, clearer ownership, better consistency, better quality and integrity, less reconciliation and rework, and less time spent re-explaining definitions, schemas, and business logic. Catalogued definitions and context are intended to become reusable assets rather than tribal knowledge.

## Adoption Lessons

Focused use cases and targeted stakeholder engagement have worked better than broad or intrusive governance messaging. The team is taking business stakeholders through what controls mean, why they matter, and how governance enables rather than blocks data use.

## Challenges

Ventia's breadth and lower maturity create challenges in explaining data governance, data management, data risk, and the relationship to enterprise risk. Fragmented ownership and siloed ways of working make cross-functional engagement hard, especially where both producer teams and consumer teams must change together.

## Related Pages

- [[Safety Metrics Governance Pilot]]
- [[Ventia Data Platform Modernisation]]
- [[DAII Monthly Meeting Transcript]]
- [[Transport First Two Week Plan]]
- [[Transport Data Product Meeting Recording]]
- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
