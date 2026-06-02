---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/DB walkthrough with Pranav Kumar.md", "raw/Ventia_Transport_Executive_Brief_Damien.md"]
date-created: 2026-05-28
date-updated: 2026-06-02
tags: [databricks, azure, data-platform, power-bi, data-engineering, transport]
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

## Reporting And Promotion Model

Most report consumers use Power BI and may not know Databricks is behind their reports. Power users and report builders can access Databricks directly, create views or tables in development, and build semantic models or dataflows for other report builders.

Digital Services acts as the gatekeeper between development and production. Business-created Databricks assets can be peer-reviewed, backed up to the repository, migrated to production, and rolled back if needed.

The Pranav walkthrough adds the Transport operating detail. Transport users can develop tables, views, and SQL in development schemas, but production is owned by Kale Skinner's Digital Services team. Once Transport has built and tested a view, Digital Services promotes it into production.

Transport also manages object ownership carefully. Pranav described moving ownership from individual users to groups so that members of the right group can maintain the tables and views without being blocked by a single-person owner.

## Transport Catalog Pattern

Transport has a development catalog organized with schemas for contracts or purposes. Examples mentioned in the walkthrough include Auckland West, Brisbane Airport, finance, FNDC, SDC, NZLNNO, and SRAPC.

Within contract schemas, user tables and user views support downstream reporting. WRU was described as having the largest number of tables and views, while SRAPC was described as advanced in technology and delivery practice. The contract-schema pattern supports local flexibility but reinforces the standardisation questions on [[Transport Data Landscape]] and [[Transport Contract Portfolio]].

The Damien executive brief makes Databricks centralisation an explicit discovery and delivery question for the [[Integrated Transport Data Asset]]. The six-week work needs to show what Transport data has already been centralised into Databricks, what remains decentralised, and how centralised assets can be expanded across GPS, telematics, fleet, job scheduling, asset, KPI, location, and service provision data.

## Governance Context

The platform has a Databricks data dictionary dashboard to help users discover source systems, tables, schemas, and data steward or SME ownership. Alation is being implemented as the broader catalogue and governance tool, connecting this operating model to [[Ventia Data Governance Framework]].

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Executive Brief Damien]]
- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Asset Vision]]
- [[Ventia Data Platform Modernisation]]
- [[EDW Ernie]]
