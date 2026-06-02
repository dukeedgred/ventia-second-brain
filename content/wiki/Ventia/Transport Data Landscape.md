---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md", "raw/DB walkthrough with Pranav Kumar.md", "raw/Ventia_Transport_Executive_Brief_Damien.md", "raw/transport-first-two-week-plan-detailed-2026-05-28.md"]
date-created: 2026-05-28
date-updated: 2026-06-02
tags: [transport, data-landscape, asset-data, sap, gis, data-asset]
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

The Pranav walkthrough adds a portfolio-level view: Transport has roughly 15 to 20 contracts across Australia and New Zealand, captured on [[Transport Contract Portfolio]]. There is no confirmed centralized report that lists all contracts, dates, data feeds, and maturity, so contract inventory remains part of the data-discovery work.

The executive brief for Damien turns this discovery into a six-week [[Integrated Transport Data Asset]] programme. The immediate status map needs to show which data is available across Transport contracts, what has already been centralised into Databricks, what remains decentralised and why, and how the current data is used.

The [[Transport First Two Week Plan]] makes the first pass more explicit: the enterprise Transport data product should map core and adjacent data domains, source systems, ownership, access paths, and reusable asset patterns before week 3 starts. This raises access and ownership mapping to first-week deliverables, not later documentation tasks.

## Contract-Level Schemas

Transport reporting is organized through schemas owned by Transport sector users and broader contract groups. Contract-specific schema names mentioned in the source included examples such as AKLW, BAC, and Final District.

Shared views can be placed in a common Transport schema, while contract-specific requirements sit in the relevant contract schema. This creates flexibility for local reporting but makes cross-contract standardisation harder.

The Pranav walkthrough described a Transport development catalog with one schema per contract or purpose, including examples such as Auckland West, Brisbane Airport, finance, FNDC, SDC, NZLNNO, and SRAPC. User tables and user views are built in development and then promoted to production by the Digital Services team, linking the contract operating model back to [[Ventia Databricks Platform]].

## Standardisation Gaps

The source did not identify a centralized Transport asset master table or asset data product. Different contracts may use different source systems, different asset definitions, and different metadata, so the main problem is not only data flow but also data capture and definition alignment.

Any shared Transport asset model would need SME agreement on what counts as an asset and which attributes matter across contracts. The walk-through cautioned that contract teams may mainly value reporting for their own contract, even if a central model has enterprise value.

The later working group source reinforces this gap by naming several tools that may need to interoperate: SAP, Retina Vision, Nextspace, [[Asset Vision]], SAP S/4HANA, SAP SAC, Maximo, and SAP Asset Performance Management. It explicitly notes uncertainty about how those pieces are intended to fit together.

The Pranav walkthrough adds a more specific standardisation barrier: even when contracts use [[Asset Vision]], each contract can configure activity category, activity, and intervention structures differently. KPIs and SLAs also vary by contract, so cross-contract reporting needs a clear senior-management question before detailed KPI harmonisation.

## Reporting And Opportunity Areas

Most Databricks-backed Transport reporting is converted into simplified views for downstream Power BI reports, with Excel still used in some cases. WRU appears to have the most mature reporting footprint, while SRAPC appears more mature from a technology and delivery-practice perspective.

Enterprise opportunities are tracked on [[Transport Sector Reporting Opportunities]]. They include bid intelligence, mobilization support, delivery reporting, predictive maintenance, and benchmarking or activity-based costing. Pranav cautioned that earlier activity-based costing work struggled because SAP cost structures and contract-level activity models were not aligned.

The Damien brief adds the expected foundation scope for the integrated asset: asset management, GPS, telematics, fleet management, job scheduling, vehicle and service locations, contract KPIs, and service provision information. Those inputs need to support a business-tested live use case within the six-week programme and a roadmap for further operational and investment decisions.

## Adjacent Data Domains

Ventia has enterprise safety and compliance data in Databricks, which may apply to Transport analysis. ESRI/GIS data is managed by a separate team, and Databricks can connect to the Postgres database behind ESRI for bespoke use cases. Whether Transport uses Ventia-managed GIS data or provider-managed GIS data still needs validation.

The first-two-week plan also names sensing and telemetry inputs that sit adjacent to the existing operational landscape: Retina Vision, BYD telemetry, drainage IoT, weather data, traffic data, and open road datasets. These inputs connect the data landscape to [[Transport Asset Intelligence Roadmap]] and may require different owners, access paths, and integration patterns from existing Databricks-backed reporting sources.

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Data and AI Working Group]]
- [[Transport Executive Brief Damien]]
- [[Transport First Two Week Plan]]
- [[Integrated Transport Data Asset]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Gen 3 Tender Innovation]]
- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Ventia Databricks Platform]]
- [[Asset Vision]]
- [[Engagement Team]]
- [[Safety Metrics Governance Pilot]]
- [[Ventia Data Platform Modernisation]]
