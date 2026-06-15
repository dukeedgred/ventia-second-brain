---
type: concept
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260609_160356-Meeting Recording Syed Umar.md"]
date-created: 2026-06-15
date-updated: 2026-06-15
tags: [transport, systems, hand-back, maximo, tunnel, governance, integration]
---

# Transport Hand-Back Systems

Transport hand-back systems are contract-governed systems that must remain with the client asset, or transfer to the client or next operator, when a contract ends. The concept comes from [[Transport Data Asset Stakeholder Interview Syed Umar]] and is a key boundary for [[Transport Data Landscape]] and the [[Integrated Transport Data Asset]].

## Definition

Syed Umar Anis distinguished hand-back systems from Ventia corporate systems. A hand-back system holds the operational data, configured processes, and asset-management capability needed to run the tunnel or transport asset. It cannot simply be replaced by a corporate Ventia system if the contract requires the system and its data to stay with the asset.

Corporate systems such as SAP, Databricks, Excel, SharePoint, and Power BI support Ventia internal processes, financial control, analytics, and reporting. They can receive extracts or support analysis, but they are not automatically acceptable as the primary system of record for client-operational tunnel data.

## Maximo Pattern

For North East Link, [[Maximo]] is the asset-management hand-back system. Ventia is responsible for choosing and configuring the system, implementing operational processes, and loading tunnel data into it. At contract end, the system remains with the tunnel by novating hosting and licensing arrangements to the client and severing Ventia corporate integrations.

The same pattern can apply to non-cloud systems that sit inside the tunnel. Those systems may simply remain local to the tunnel when the operator changes, which limits how tightly they can be integrated with corporate platforms.

## Contract And Governance Drivers

The contract ultimately determines which systems are hand-back systems, although the classification may require interpretation and agreement with the client. The project team often understands contract obligations and hand-back requirements better than corporate functions, while corporate teams naturally try to standardise processes across projects.

That creates a practical tension for Transport data work. Standard platforms and patterns are useful, but contract-specific governance, consortium or alliance structures, client system ownership, confidentiality obligations, and approved document-management structures can limit deep standardisation.

## Data Asset Implications

For the [[Integrated Transport Data Asset]], every Transport source system should be classified by whether it is a hand-back, client-controlled, tunnel-local, or Ventia corporate system. That classification affects data access, administrative control, integration rights, reporting reuse, and what must be disconnected or transferred at contract end.

Lean integration may be more practical than deep integration between hand-back systems and corporate systems. Syed described inventory and procurement as likely overlap areas where a demand signal may start in [[Maximo]] or another tunnel system but still require corporate SAP processes for purchasing and financial control.

## Related Pages

- [[Transport Data Asset Stakeholder Interview Syed Umar]]
- [[Maximo]]
- [[Transport Data Landscape]]
- [[Integrated Transport Data Asset]]
- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Ventia Databricks Platform]]
