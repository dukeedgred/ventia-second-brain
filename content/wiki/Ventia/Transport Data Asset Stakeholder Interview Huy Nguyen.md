---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260605_140612-Meeting Recording.md"]
date-created: 2026-06-14
date-updated: 2026-06-14
tags: [transport, data-asset, stakeholder-interview, maximo, tunnel, mobilization, kpis, source-summary]
---

# Transport Data Asset Stakeholder Interview Huy Nguyen

This source is a 44-minute stakeholder interview transcript from 2026-06-05 with Huy Nguyen, Yinlun Pan, Nhung Seidensticker, Tanya Pita de Abreu, and the Transport data asset discovery team. It covers Huy's Asset Information Analyst role on North East Link / Spark, tunnel mobilisation, as-built asset handover, Maximo selection, Databricks-backed KPI design, OMCS incident flow, and cross-project standardisation opportunities.

## Summary

Huy Nguyen is the Asset Information Analyst for North East Link, reporting to the Asset Manager within the Spark consortium. The project is in design and mobilisation, so his current work focuses on asset data validation, KPI logic, asset-management documentation, and future operational-reporting design rather than mature BAU reporting.

The interview adds a tunnel mobilisation pattern to the [[Integrated Transport Data Asset]]. North East Link is a brand-new tunnel asset rather than a takeover of an existing road-maintenance contract, so mobilisation has run for years while business processes, management plans, asset hierarchy, metadata requirements, and handover formats are agreed.

Huy described asset handover as a managed as-built process. The D&C arm provides an asset register, often spreadsheet-based, plus spatial data such as GeoJSON, spatial files, or shapefiles. The asset team maps the register to the spatial file and validates completeness, agreed metadata, asset attributes, asset hierarchy, and coordinate reference details.

The source reinforces [[Maximo]] as the tunnel asset-management system, contrasting with [[Asset Vision]] for open-road contracts. Huy said Asset Vision was proposed during the bid but rejected because the client considered it insufficient for tunnel management. Maximo has not yet gone live for North East Link, so current KPI development relies on synthetic datasets and manual uploads by Huy and Umar.

Operationally, Huy expects data needs to include asset information, maintenance data, work order data, operational maintenance control system data, alarms, automatic incident detection alerts, and incident records. AID camera alerts feed into OMCS; operators create work orders when an issue is asset-related, or incident records when it is not.

For cross-project value, Huy wants visibility of other projects' asset registers, maintenance data, unit rates, SLA/KPI setup, and naming conventions. He cited inconsistent terms such as jet fan versus fan as a practical barrier to bid support and benchmarking.

## Key Details

- Huy has worked on North East Link, T2D bid work, a project transcribed as "Shrap C" in Western Sydney, and Western Roads Upgrade; before Ventia, he worked in DTP Asset Intelligence.
- North East Link is expected to move into operational phase around 2028, with a 25-year operating period from about 2029.
- Mobilisation for a brand-new tunnel can be much longer than the roughly three-month takeover pattern possible when systems and business processes already exist.
- Huy is developing an Asset Management Manual that guides inspectors on condition assessment, inspection frequency, and related SOP attachments.
- Corporate-preferred tools include QGIS for spatial analysis and Power BI for reporting and visualisation.
- Databricks is intended to receive data from source systems and apply KPI logic, but North East Link currently has only synthetic or manually uploaded KPI data because Maximo is not yet live.
- Huy said many other tunnel Maximo instances have historically been client-hosted, leaving Ventia without a direct connection to ingest those datasets into Ventia Databricks.
- QGIS is used as a manual spatial-analysis tool; Huy did not expect direct push/pull updates between QGIS and Maximo.
- The live D&C asset register is incomplete, duplicated, and full of placeholder values while construction continues. The team still needs it for planning, but can only trust it after formal handover and finalisation.
- Final XYZ coordinates are not available in the live asset register, so the team currently relies on location descriptions and its involvement in the location-hierarchy design.
- New assets should generally be in good condition at handover, with pavement an exception where roughness, rutting, cracking, or similar measures may need inspection before handover.
- A correspondence-related KPI for phone calls and emails may remain spreadsheet-based, creating a human-error risk.
- Huy suggested Jason Yu as a remaining Centre of Excellence / Transport asset-management contact.
- The raw source contains no URLs.

## Connections

- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Maximo]]
- [[Asset Vision]]
- [[Ventia Databricks Platform]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Transport Sector Reporting Opportunities]]
- [[Engagement Team]]

## Open Questions

- Can Huy share the briefing pack that explains tunnel contract lifecycle stages from design and mobilisation through operations?
- When will real North East Link Maximo data begin flowing, and which current Databricks assets are synthetic or manually uploaded placeholders?
- Which Maximo fields, custom attributes, custom modules, and KPI outputs are reusable across tunnel contracts, and which are contract-specific?
- Which OMCS, AID, alarm, work-order, and incident fields should be included in a reusable tunnel data model?
- Can Jason Yu recover useful artefacts from earlier corporate or Centre of Excellence standardisation work?
- How should the integrated Transport data asset preserve both common naming conventions and local terminology used by individual projects?
