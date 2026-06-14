---
type: entity
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260603_110443.md", "raw/Transport Data Asset Stakeholder Interview-20260605_140612-Meeting Recording.md"]
date-created: 2026-06-03
date-updated: 2026-06-14
tags: [maximo, transport, tunnel, work-management, asset-data]
---

# Maximo

Maximo is the work management and asset system positioned in the Rui Luan stakeholder interview as the fit for Transport tunnel projects, in contrast to [[Asset Vision]] for open-road maintenance contracts.

## Role In Transport

Rui described tunnel projects such as Sydney Harbour Tunnel as componentised environments with structured asset hierarchies and more planned equipment or work requirements. That operating model differs from open-road maintenance, where teams need fast geolocated issue response.

For the [[Transport Contract Portfolio]], this makes Maximo a key system wherever Transport needs to compare tunnel work with open-road activity data. For the [[Transport Data Landscape]], it means the integrated asset cannot treat Asset Vision as the only operational work management source.

The [[Transport Data Asset Stakeholder Interview Huy Nguyen]] adds the North East Link / Spark view. Huy said [[Asset Vision]] was proposed during the bid but rejected because the client considered it insufficient for tunnel management, so North East Link is adopting Maximo as its asset information management system.

## Relationship To SAP And Benchmarking

Maximo records still need to connect to SAP job costs if the [[Integrated Transport Data Asset]] is going to support bid intelligence, benchmark costing, or cross-contract activity reporting. Rui framed this as a general requirement across project types: every job should have a direct SAP linkage so actual costs can be captured consistently.

The interview did not capture Maximo's current integration path into Databricks or Power BI. Rui suggested Adam Taylor or Barat as follow-up contacts who can explain tunnel project setup.

Huy added that North East Link does not yet have a live Maximo instance, so current KPI development uses synthetic data and manual uploads in Databricks. He also said many existing tunnel Maximo instances have historically been client-hosted, with no direct Ventia Databricks ingestion path, making Maximo integration a concrete discovery gap rather than just a source-system label.

## Tunnel Data Model Considerations

Huy expects most Maximo tunnel data to share a broad default schema, but cautioned that contracts may add custom fields, custom modules, and different KPI logic. For the [[Integrated Transport Data Asset]], this means Maximo should be modelled as a reusable system pattern with contract-specific extensions rather than a single uniform tunnel schema.

North East Link also needs to connect Maximo with tunnel-adjacent operational sources. Huy named OMCS data, AID camera alerts, alarms, work orders, incident records, asset registers, spatial handover files, QGIS analysis, and Power BI reporting as part of the future operating landscape.

## Related Pages

- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Data Asset Stakeholder Interview Huy Nguyen]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Financial Reporting]]
- [[Integrated Transport Data Asset]]
- [[Engagement Team]]
