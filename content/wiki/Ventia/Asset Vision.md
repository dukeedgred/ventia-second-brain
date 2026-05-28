---
type: entity
topic: Ventia
sources: ["raw/Databricks walk-through.md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [asset-vision, transport, work-management, asset-data, federated-query]
---

# Asset Vision

Asset Vision is the main source system mentioned for Transport work order, work management, and asset data. In the Databricks walk-through, it was positioned separately from SAP, which mainly holds Transport financial data.

## Role In Transport Reporting

Asset Vision provides operational reporting data for Transport contracts. The source described Transport Australia as having multiple contract groupings and noted a separate mobilization effort for New Zealand Transport databases that were not yet fully in production.

The data supports contract-level operational reporting, including work management and asset views. It is one of the key systems to understand for the [[Transport Data Landscape]] gap analysis.

## Databricks Access Pattern

Ventia has an Azure SQL Server in its cloud environment with elastic compute and seven databases associated with the Asset Vision reporting data. Asset Vision synchronizes data from its cloud into this Azure SQL Server.

Databricks uses federated queries against those Azure SQL databases, so queries pass through rather than staging all Asset Vision reporting data through the full Databricks medallion pattern. The walk-through also described a migration from Asset Vision-hosted reporting data toward Ventia-hosted reporting data.

## Data Product Implications

Asset Vision does not by itself solve the wider Transport asset-standardisation problem. The source noted that Transport contracts may define assets differently, use different systems, and need different metadata, so any centralized Transport asset product would require SME agreement beyond the technical Databricks connection.

## Related Pages

- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Databricks Walk-Through]]
- [[Engagement Team]]
