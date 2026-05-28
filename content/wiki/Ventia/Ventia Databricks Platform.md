---
type: concept
topic: Ventia
sources: ["raw/Databricks walk-through.md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [databricks, azure, data-platform, power-bi, data-engineering]
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

## Governance Context

The platform has a Databricks data dictionary dashboard to help users discover source systems, tables, schemas, and data steward or SME ownership. Alation is being implemented as the broader catalogue and governance tool, connecting this operating model to [[Ventia Data Governance Framework]].

## Related Pages

- [[Databricks Walk-Through]]
- [[Transport Data Landscape]]
- [[Asset Vision]]
- [[Ventia Data Platform Modernisation]]
- [[EDW Ernie]]
