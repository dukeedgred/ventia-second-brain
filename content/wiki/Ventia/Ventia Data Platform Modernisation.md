---
type: concept
topic: Ventia
sources: ["raw/DAII Monthly Meeting Transcript.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [data-platform, databricks, program-evolve, sap, power-bi]
---

# Ventia Data Platform Modernisation

Ventia's data platform modernisation is tied to Program Evolve and the replacement of SAP ECC6 with SAP S/4HANA. The meeting described this as an opportunity to decommission SAP BW, rebuild ingestion patterns into Databricks, and align enterprise reporting to a cleaner source-to-bronze-to-silver-to-gold-to-Power-BI architecture.

## Reporting Architecture Shift

Current reporting includes a large amount of usage directly on bronze-layer data. The future-state pattern aims to move existing reporting onto governed gold-layer dimensional models while preserving business reporting outcomes.

This creates two linked workloads:

- Rebuild ingestion from S/4HANA into Databricks.
- Remediate hundreds of existing views and tables so reporting moves from bronze usage to best-practice gold models.

[[EDW Ernie]] was showcased as one way to accelerate the search, review, design, and remediation effort.

## Program Status From The Meeting

- Evolve SIT1 was reported as 43 percent complete, covering roughly 140 highest-priority tables.
- SIT2 is expected to cover the next tranche of roughly 150 to 160 tables.
- UAT will involve business users, sector leads, and report builders to confirm the solution aligns with existing reporting.
- New Zealand Transport work management data had passed UAT for one group of contracts, with additional contracts in testing before production.
- The ACMA rank/rating project was moving toward production for vendor information capture and later work assignment.

## Risks And Dependencies

The data engineering team is dependent on IBM and the broader Evolve project delivery. No red flags were raised in the meeting, but delivery timing flows directly into the data team's platform and reporting work.

## Transport Evolve Thread

The Transport Data and AI Working Group source adds a Transport-specific Evolve thread around SAP, Nextspace, and tender innovation. Sanja was described as looking at Nextspace and SAP in the Transport space, with IBM recommending Nextspace, while the source owner was unclear how SAP, Retina Vision, Nextspace, and [[Asset Vision]] are intended to fit together.

The Evolve/RAMC transcript also discusses SAP Asset Performance Management, SAP SAC, S/4HANA, IoT aggregation, and predictive failure/intervention backlog use cases. These ideas connect Program Evolve to [[Transport Gen 3 Tender Innovation]] and [[Transport Asset Intelligence Roadmap]], but still need architecture, data ownership, and implementation boundaries clarified.

## Related Pages

- [[EDW Ernie]]
- [[Ventia Data Governance Framework]]
- [[DAII Monthly Meeting Transcript]]
- [[Transport Data and AI Working Group]]
- [[Transport Gen 3 Tender Innovation]]
- [[Transport Asset Intelligence Roadmap]]
