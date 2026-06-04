---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md", "raw/DB walkthrough with Pranav Kumar.md", "raw/Ventia_Transport_Executive_Brief_Damien.md", "raw/transport-first-two-week-plan-detailed-2026-05-28.md", "raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443.md", "raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-05-28
date-updated: 2026-06-04
tags: [transport, data-landscape, asset-data, sap, gis, data-asset, condition-inspections]
---

# Transport Data Landscape

The Transport data landscape spans enterprise financial data, contract-specific operational systems, asset and work management data, safety and compliance datasets, and possible GIS sources. The Databricks walk-through framed Transport as a gap-analysis area where the platform team can explain processing, but business SMEs need to validate KPIs, use cases, and definitions.

## Financial Data

Most Transport financial data is managed in SAP like other Ventia sectors. The source described this as enterprise financial data rather than Transport-named data, with Transport reporting filtered through structures such as profit centres and sector-level hierarchy.

Bhupesh Balani was identified as the Transport reporting sector lead for financial and SAP-related Transport data. He is a key contact on [[Engagement Team]] for understanding how SAP-derived financial data is used in [[Transport Financial Reporting]].

The [[SAP Data Walk-Through Transport Sector]] clarifies the current finance source path. Detailed Transport finance line items come from SAP BW controlling-document data rather than Databricks because BW currently provides the granularity and table-linking needed by operations. Databricks contributes enterprise open commitment data for remaining purchase-order commitments, but the SAP line-item view still depends on BW.

The same source warns that Transport finance report filters are not an authoritative contract inventory. The filters are based on cost in a selected month, so a contract can appear in one month and disappear in another even if it remains part of the [[Transport Contract Portfolio]]. Bhupesh said there are separate Databricks or BW datasets that can list all contracts within a sector.

## Operational And Asset Data

Transport work order, work management, and asset data are not primarily held in SAP. [[Asset Vision]] was identified as the main operational source system for Transport asset and work management reporting.

The platform accesses Asset Vision reporting data through federated queries to Azure SQL databases. Production reporting was still tied to existing Asset Vision-hosted reporting structures, while Ventia was migrating toward hosting the reporting data in its own Azure SQL environment.

The Transport Data and AI Working Group source adds concrete roads-asset capture requirements for VRMC, RAMC, and most roads contracts. The defect list spans pavement, signs, vegetation, drainage, litter, barriers, line marking, roadkill, graffiti, guideposts, and possible future tunnel assets. Those inputs need to become geolocated outputs with defect data, duplicate capture detection, patterns, and work order details.

These requirements are tracked in [[Transport Asset Intelligence Roadmap]] because the key question is not only where the source data sits, but how captured observations become visual, trusted, and digitally actionable work.

The Rui Luan stakeholder interview clarified the operational split behind those data requirements. Open-road contracts need fast location-based issue capture and response, while tunnel projects need componentised asset hierarchies and more planned work management. Rui described [[Asset Vision]] as the open-road system and [[Maximo]] as the tunnel system.

For open-road Asset Vision reporting, Rui described a relatively standard module set of inspections, defects, and jobs. Those modules are an immediate candidate for current-state mapping in the [[Integrated Transport Data Asset]], but the field definitions still need contract-by-contract validation.

The [[Transport Data Asset Stakeholder Interview Toby Lin]] adds the asset-team operating detail behind those modules. Open-road roads assets include drainage lines, pits, guardrails, kerb and channel, line marking, signage, and barriers; each asset can carry defects or hazards, inspection records, condition ratings, and job history. The Asset team actively reconciles client handover data with site reality through [[Transport Asset Inventory Validation]].

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

The SAP finance walkthrough adds the operational-system side of the same gap. Activity-based costing requires a translation guide across [[Asset Vision]], Maximo, and client AWM/AVM systems so equivalent fields can be mapped before costs and activities are combined.

Rui's interview adds the field-capture side of the same issue: SAP job-cost linkage is only useful if crews capture time, materials, equipment, and job details accurately, and if those entries are validated in a way that is practical for field teams.

Toby's interview adds that open-road contracts may share broad asset categories, but condition definitions, KPI standards, response rules, and reporting measures remain contract-specific. That makes [[Transport Asset Condition Inspections]] a data-standardisation problem as much as an operational workflow.

## Reporting And Opportunity Areas

Most Databricks-backed Transport reporting is converted into simplified views for downstream Power BI reports, with Excel still used in some cases. WRU appears to have the most mature reporting footprint, while SRAPC appears more mature from a technology and delivery-practice perspective.

Enterprise opportunities are tracked on [[Transport Sector Reporting Opportunities]]. They include bid intelligence, mobilization support, delivery reporting, predictive maintenance, and benchmarking or activity-based costing. Pranav cautioned that earlier activity-based costing work struggled because SAP cost structures and contract-level activity models were not aligned.

The current [[Transport Financial Reporting]] layer is comparatively mature for finance management reporting: it is Power BI based, contract-secured, refreshed every three hours, and supports drilling from WBS to work orders and SAP line items. It does not cover contractual reporting obligations, SHeQ reporting, or operational activity classification.

The Damien brief adds the expected foundation scope for the integrated asset: asset management, GPS, telematics, fleet management, job scheduling, vehicle and service locations, contract KPIs, and service provision information. Those inputs need to support a business-tested live use case within the six-week programme and a roadmap for further operational and investment decisions.

Toby's interview shows one concrete contract-reporting shape for this scope. Monthly client KPI reporting can include scheduled and completed condition inspections, inspection incidents, and counts by asset class, while annual audits may test job evidence and response compliance. The full KPI list is likely owned by commercial or project leadership rather than a single data table.

## Adjacent Data Domains

Ventia has enterprise safety and compliance data in Databricks, which may apply to Transport analysis. ESRI/GIS data is managed by a separate team, and Databricks can connect to the Postgres database behind ESRI for bespoke use cases. Whether Transport uses Ventia-managed GIS data or provider-managed GIS data still needs validation.

The first-two-week plan also names sensing and telemetry inputs that sit adjacent to the existing operational landscape: Retina Vision, BYD telemetry, drainage IoT, weather data, traffic data, and open road datasets. These inputs connect the data landscape to [[Transport Asset Intelligence Roadmap]] and may require different owners, access paths, and integration patterns from existing Databricks-backed reporting sources.

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Data and AI Working Group]]
- [[Transport Executive Brief Damien]]
- [[Transport First Two Week Plan]]
- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Maximo]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Transport Financial Reporting]]
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
