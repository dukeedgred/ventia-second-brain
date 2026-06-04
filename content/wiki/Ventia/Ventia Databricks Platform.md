---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/DB walkthrough with Pranav Kumar.md", "raw/Ventia_Transport_Executive_Brief_Damien.md", "raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443.md", "raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-05-28
date-updated: 2026-06-04
tags: [databricks, azure, data-platform, power-bi, data-engineering, transport, asset-data]
---

# Ventia Databricks Platform

Ventia's Databricks platform is the centralized enterprise data platform managed by the Digital Services data engineering and data science team. It supports reporting, analytics, and emerging AI workloads, while application integration is handled by a separate integration stack.

## Platform Shape

The platform ingests data from enterprise and contract-level source systems into Azure Databricks on top of Azure Data Lake Storage Gen2. Azure DevOps is used for repository management, and Power BI is the main downstream reporting consumer.

The common batch pattern moves data through defined hops, with standards for naming, housekeeping columns, CDC handling, and layer-specific processing. Patterns also exist for Event Hub, IoT, near-real-time, and streaming data, although the walk-through described those patterns as available rather than heavily used.

## Source System Patterns

Ventia has more than 60 source systems in production according to the walk-through. Some are staged into Databricks and processed through the platform layers; others use federated queries where Databricks passes queries through to an external database or already-modelled reporting layer.

Federated queries are used where re-staging modelled provider data would add little value. For example, E-Roads IVMS data is already provided in a modelled Snowflake layer, so Databricks can query that layer instead of rebuilding the same model.

## Orchestration And Metadata

Ventia uses Databricks jobs and pipelines rather than DBT, Airflow, or external orchestration tools. Jobs first read a framework pipeline parameters table, then standard notebooks use the metadata to connect, load, stage, and transform data.

For complex systems such as SAP and Novus, metadata can drive dynamic creation of notebooks and ETL jobs. SAP HANA information schema metadata can populate the pipeline parameters table so new tables can be onboarded without manually building each pipeline.

The [[SAP Data Walk-Through Transport Sector]] shows one current Transport finance limitation. SAP data is available in Databricks, but Bhupesh Balani said the raw table format does not yet provide the linked, granular operational finance view that SAP BW gives the [[Transport Financial Reporting]] report. That means some SAP-derived reporting still depends on BW until the S/4HANA and Databricks path is proven.

## Reporting And Promotion Model

Most report consumers use Power BI and may not know Databricks is behind their reports. Power users and report builders can access Databricks directly, create views or tables in development, and build semantic models or dataflows for other report builders.

Digital Services acts as the gatekeeper between development and production. Business-created Databricks assets can be peer-reviewed, backed up to the repository, migrated to production, and rolled back if needed.

The Pranav walkthrough adds the Transport operating detail. Transport users can develop tables, views, and SQL in development schemas, but production is owned by Kale Skinner's Digital Services team. Once Transport has built and tested a view, Digital Services promotes it into production.

Transport also manages object ownership carefully. Pranav described moving ownership from individual users to groups so that members of the right group can maintain the tables and views without being blocked by a single-person owner.

## Transport Catalog Pattern

Transport has a development catalog organized with schemas for contracts or purposes. Examples mentioned in the walkthrough include Auckland West, Brisbane Airport, finance, FNDC, SDC, NZLNNO, and SRAPC.

Within contract schemas, user tables and user views support downstream reporting. WRU was described as having the largest number of tables and views, while SRAPC was described as advanced in technology and delivery practice. The contract-schema pattern supports local flexibility but reinforces the standardisation questions on [[Transport Data Landscape]] and [[Transport Contract Portfolio]].

The Damien executive brief makes Databricks centralisation an explicit discovery and delivery question for the [[Integrated Transport Data Asset]]. The six-week work needs to show what Transport data has already been centralised into Databricks, what remains decentralised, and how centralised assets can be expanded across GPS, telematics, fleet, job scheduling, asset, KPI, location, and service provision data.

The SAP walkthrough adds two finance-specific centralised assets to map: enterprise open commitment tables in Databricks, and a likely sector-contract dataset in Databricks or BW that can list all Transport contracts even when a monthly finance report filter omits contracts with no cost.

The Rui Luan interview adds a business-facing description of the open-road [[Asset Vision]] reporting path: raw Asset Vision data is pulled into Ventia data services, hosted in Azure Databricks, and surfaced through Power BI. Rui described the core open-road reporting modules as inspections, defects, and jobs, which gives the discovery team a concrete starting point for validating Transport operational tables.

The [[Transport Data Asset Stakeholder Interview Toby Lin]] adds a user-facing constraint on that catalog pattern. Toby uses Databricks views for KPI tracking and dashboards, and believes defect and hazard data aligns to the Asset Vision hierarchy there, but his access was limited and did not confirm whether SLA, response-time, or completion-evidence columns can be extracted directly.

## Governance Context

The platform has a Databricks data dictionary dashboard to help users discover source systems, tables, schemas, and data steward or SME ownership. Alation is being implemented as the broader catalogue and governance tool, connecting this operating model to [[Ventia Data Governance Framework]].

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Executive Brief Damien]]
- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Transport Financial Reporting]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Asset Vision]]
- [[Maximo]]
- [[Ventia Data Platform Modernisation]]
- [[EDW Ernie]]
