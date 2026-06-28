---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Product-20260622_153334-Meeting Recording.md"]
date-created: 2026-06-22
date-updated: 2026-06-22
tags: [transport, data-product, data-asset, databricks, asset-vision, data-quality, data-governance, alation, kpis, source-summary]
---

# Transport Data Product Meeting Recording

This source is an AI-generated meeting recording transcript from 2026-06-22. It captures a Transport data product discussion between Donguk Kang, Tanya Pita de Abreu, Shachi Shastry, and Osaka Tillakaratne about the emerging [[Integrated Transport Data Asset]], current [[Asset Vision]] data-quality investigation in Databricks, and how [[Ventia Data Governance Framework|data governance]] should be embedded before the data product matures.

## Summary

Donguk framed the work as a Transport-sector starting point for a standardised Ventia data asset. The core problem is that Ventia does not yet have a standardised data asset, making enterprise-level reporting and AI capability difficult because source data is spread across many systems and locations.

The current technical work is an initial Databricks investigation of [[Asset Vision]] data quality and data completeness for a limited subset of Transport contracts. Donguk said the team had aggregated available source tables without applying transformation logic, then reviewed metric completeness. The early finding is that metric coverage appears sparse, but the team still needs to understand the source ingestion path, expected usage, and whether each metric is critical to the Transport data product.

The meeting also clarified that [[Asset Vision]] is only the first visible source. The desired Transport data product is intended to cover all Transport contracts, look at both data already in Databricks and data missing from Databricks, and eventually bring in sources such as [[Maximo]] for tunnel contexts. Sydney Harbour was named as a Maximo rather than Asset Vision example.

Shachi positioned her team as the data governance owner for Ventia and described an operating model where governance, cataloguing, business terms, critical data elements, definitions, transformation logic, data-quality rules, risk controls, and lineage are embedded by design into data-product delivery. Alation is the metadata and governance platform, and it is expected to catalogue Databricks metadata and the contextual layer needed to support trustworthy reporting or AI use cases.

The main next step is for the Transport data-product team to provide the data governance team with visibility of the Databricks tables, schemas, and attributes they are focusing on once the scope becomes clearer. Shachi's team will then send a metadata template and work with the project and business stakeholders to define terms, critical data elements, and agreed enterprise definitions. A weekly or next-Monday touchpoint was proposed; relative to the meeting date, the likely Monday is 2026-06-29, but the transcript does not state the calendar date explicitly.

## Key Details

- The material is a meeting transcript, not table metadata, a finished specification, or a dashboard export.
- EdgeRed / consultant involvement is explicit in Donguk's introduction.
- The stated enterprise issue is the lack of a standardised data asset across Ventia.
- The Transport sector is being used as the starting sector for a standard data asset.
- Enterprise reporting and AI capability are named as future beneficiaries of the data asset.
- Current analysis is limited to Asset Vision data available in Databricks for certain Transport contracts.
- The data completeness check aggregated available source tables without transformation logic.
- The dashboard examples included a standardised contract dimension, metric completeness, contract map view, average days overdue, defect and hazard views, criticality, and asset-level analysis.
- The team is also investigating what is missing from Databricks and which fields or metrics are available across different source systems and contracts.
- The target is all Transport contracts rather than one contract or one source system.
- Maximo is expected to be added eventually, especially for contracts such as Sydney Harbour where operational data does not sit in Asset Vision.
- Stakeholder interviews had not yet focused deeply on data-specific roles; they had mainly covered what business users see in Asset Vision, Databricks, and day-to-day reporting.
- A consolidated enterprise-level KPI view remains a gap; named examples include job or work-order volume, completion, on-time or overdue work, defect and hazard reporting, safety incident KPIs, and contract-specific KPI reporting.
- Shachi linked Transport incident and safety KPI overlap to the enterprise safety metrics pilot, including TRIFR, SIFR, and SAIFR.
- Bhupesh Balani was recommended again for job/work-order management, operational reporting, Transport finance enterprise reporting, and Project on a Page overlap.
- The governance team wants to know the product's key data touchpoints and transformation logic before defining data-quality rules.
- Alation is being configured as Ventia's metadata-management and governance tool; a separate Intelligen team member is supporting that configuration.
- Alation is expected to ingest Databricks metadata, but Osaka raised the unresolved issue that curated Alation context does not automatically sync back into Databricks for a Databricks-based AI or chatbot capability.
- The data-product outcome may be a chatbot or another AI/reporting capability; chatbot was discussed as an example rather than a committed product.
- The raw source contains no URLs.

## Actions And Follow-Ups

- Transport data-product team to keep the data governance team in the loop, likely through a weekly update.
- Transport data-product team to share the Databricks tables, schemas, attributes, or data assets in focus once the next one to two weeks of business discussions clarify scope.
- Data governance team to provide a metadata template or checklist for the relevant data asset once focus tables are known.
- Both teams to work with business stakeholders on business terms, critical data elements, agreed definitions, and common enterprise definitions.
- Data governance team to use those definitions and metadata in Alation and later data-quality rule design.
- Teams to schedule another Monday touchpoint, likely 2026-06-29 if interpreted from the 2026-06-22 meeting date.

## Connections

- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Asset Vision]]
- [[Ventia Data Governance Framework]]
- [[Safety Metrics Governance Pilot]]
- [[Engagement Team]]

## Open Questions

- Which Asset Vision tables, schemas, and metrics will remain in scope after the next one to two weeks of business validation?
- Which dashboard completeness gaps are expected source sparsity versus ingestion, modelling, or business-definition gaps?
- Which KPIs will the Transport data product actually need to answer first, and which are lower-priority exploratory metrics?
- Which Maximo and non-Asset Vision sources need to be brought into Databricks for all-contract Transport coverage?
- How will curated Alation metadata and agreed definitions be made available to any Databricks-based AI or chatbot experience if there is no two-way Alation-to-Databricks sync?
- Who owns the follow-up meeting and integration cadence between the data-product and data-governance teams?
- Is the next Monday follow-up intended for 2026-06-29?
