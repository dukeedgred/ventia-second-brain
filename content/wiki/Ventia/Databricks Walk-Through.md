---
type: source-summary
topic: Ventia
sources: ["raw/Databricks walk-through.md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [databricks, transport, data-platform, source-summary]
---

# Databricks Walk-Through

This source is a meeting transcript from a 27-minute Databricks walk-through led by Kale Skinner on 2026-05-27. It covered Ventia's enterprise Databricks platform, how Digital Services supports reporting and analytics, and what the Spend Cube team should know before investigating Transport data.

## Summary

Ventia has a centralized data engineering and data science team in Digital Services, but the business operates across many contracts that often behave like separate businesses. The platform team has consolidated a large share of enterprise data into Databricks, while much reporting still happens through Excel, SharePoint, Power BI, and citizen-developer workflows.

The platform is mainly built for reporting, analytics, and emerging AI workloads, not as the application-to-application integration layer. Databricks sits on Azure Data Lake Storage Gen2, uses Azure DevOps repositories, and is primarily consumed through Power BI, though power users and report builders can also work directly in Databricks.

For Transport, financial data is mainly in SAP and enterprise warehouse structures, while operational work management and asset data is mainly associated with [[Asset Vision]]. Transport has contract-specific schemas and source systems, so a gap analysis needs both platform understanding and input from Transport SMEs tracked on [[Engagement Team]].

## Key Details

- [[Ventia Databricks Platform]] uses Databricks jobs and pipelines for orchestration rather than DBT, Airflow, or a separate orchestration layer.
- Pipeline metadata is held in a framework pipeline parameters table; standard notebooks use that metadata to load, stage, and transform data.
- Complex sources such as SAP and Novus can dynamically generate notebooks and ETL jobs from source metadata.
- Source systems are split between staged data processed through bronze/silver/gold style layers and federated queries that pass through to an external database or modelled reporting layer.
- A Databricks data dictionary dashboard is used while Alation remains in progress as the fuller data catalogue and governance tool.
- Power users can build in development environments, but Digital Services peer-reviews and promotes production workloads.
- Schema evolution automatically handles new columns, while deleted or changed columns are expected to surface as monitoring alerts or job issues.

## Transport Notes

- Transport financials are mostly SAP-driven and can be filtered through enterprise warehouse dimensions such as profit centre hierarchy.
- Transport operational data, work orders, work management, and asset data are primarily tied to [[Asset Vision]].
- Transport Australia has multiple contract groupings; New Zealand Transport data migration was described as a separate mobilization effort.
- There is no known standardized master asset table or shared Transport asset data product across all contracts.
- GIS data may be available through ESRI/Postgres integrations, but Transport-specific GIS usage requires SME validation.
- Safety and compliance datasets are also available in Databricks at an enterprise level and may apply to Transport reporting.

## Connections

- [[Ventia Databricks Platform]]
- [[Transport Data Landscape]]
- [[Asset Vision]]
- [[Engagement Team]]
- [[Ventia Data Platform Modernisation]]
- [[Ventia Data Governance Framework]]

## Open Questions

- Which Transport contracts, regions, and data domains are in scope for the Spend Cube gap analysis?
- Which Transport SMEs should validate asset definitions, work management definitions, and reporting use cases?
- Does Transport use Ventia-managed ESRI/GIS data, provider-managed GIS data, or both?
- What access path should each project team member use for Databricks, VPN, Confluence, and Databricks training?
