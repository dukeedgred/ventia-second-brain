---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [transport, data-landscape, asset-data, sap, gis]
---

# Transport Data Landscape

The Transport data landscape spans enterprise financial data, contract-specific operational systems, asset and work management data, safety and compliance datasets, and possible GIS sources. The Databricks walk-through framed Transport as a gap-analysis area where the platform team can explain processing, but business SMEs need to validate KPIs, use cases, and definitions.

## Financial Data

Most Transport financial data is managed in SAP like other Ventia sectors. The source described this as enterprise financial data rather than Transport-named data, with Transport reporting filtered through structures such as profit centres and sector-level hierarchy.

Bhupesh was identified as the Transport reporting sector lead for financial and SAP-related Transport data. He is a key contact on [[Engagement Team]] for understanding how SAP-derived financial data is used in Transport reporting.

## Operational And Asset Data

Transport work order, work management, and asset data are not primarily held in SAP. [[Asset Vision]] was identified as the main operational source system for Transport asset and work management reporting.

The platform accesses Asset Vision reporting data through federated queries to Azure SQL databases. Production reporting was still tied to existing Asset Vision-hosted reporting structures, while Ventia was migrating toward hosting the reporting data in its own Azure SQL environment.

The Transport Data and AI Working Group source adds concrete roads-asset capture requirements for VRMC, RAMC, and most roads contracts. The defect list spans pavement, signs, vegetation, drainage, litter, barriers, line marking, roadkill, graffiti, guideposts, and possible future tunnel assets. Those inputs need to become geolocated outputs with defect data, duplicate capture detection, patterns, and work order details.

These requirements are tracked in [[Transport Asset Intelligence Roadmap]] because the key question is not only where the source data sits, but how captured observations become visual, trusted, and digitally actionable work.

## Contract-Level Schemas

Transport reporting is organized through schemas owned by Transport sector users and broader contract groups. Contract-specific schema names mentioned in the source included examples such as AKLW, BAC, and Final District.

Shared views can be placed in a common Transport schema, while contract-specific requirements sit in the relevant contract schema. This creates flexibility for local reporting but makes cross-contract standardisation harder.

## Standardisation Gaps

The source did not identify a centralized Transport asset master table or asset data product. Different contracts may use different source systems, different asset definitions, and different metadata, so the main problem is not only data flow but also data capture and definition alignment.

Any shared Transport asset model would need SME agreement on what counts as an asset and which attributes matter across contracts. The walk-through cautioned that contract teams may mainly value reporting for their own contract, even if a central model has enterprise value.

The later working group source reinforces this gap by naming several tools that may need to interoperate: SAP, Retina Vision, Nextspace, [[Asset Vision]], SAP S/4HANA, SAP SAC, Maximo, and SAP Asset Performance Management. It explicitly notes uncertainty about how those pieces are intended to fit together.

## Adjacent Data Domains

Ventia has enterprise safety and compliance data in Databricks, which may apply to Transport analysis. ESRI/GIS data is managed by a separate team, and Databricks can connect to the Postgres database behind ESRI for bespoke use cases. Whether Transport uses Ventia-managed GIS data or provider-managed GIS data still needs validation.

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Data and AI Working Group]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Gen 3 Tender Innovation]]
- [[Ventia Databricks Platform]]
- [[Asset Vision]]
- [[Engagement Team]]
- [[Safety Metrics Governance Pilot]]
- [[Ventia Data Platform Modernisation]]
