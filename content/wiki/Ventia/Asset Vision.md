---
type: entity
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md", "raw/DB walkthrough with Pranav Kumar.md", "raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443.md", "raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-05-28
date-updated: 2026-06-04
tags: [asset-vision, transport, work-management, asset-data, federated-query, condition-inspections]
---

# Asset Vision

Asset Vision is the main source system mentioned for Transport work order, work management, and asset data. In the Databricks walk-through, it was positioned separately from SAP, which mainly holds Transport financial data.

## Role In Transport Reporting

Asset Vision provides operational reporting data for Transport contracts. The source described Transport Australia as having multiple contract groupings and noted a separate mobilization effort for New Zealand Transport databases that were not yet fully in production.

The data supports contract-level operational reporting, including work management and asset views. It is one of the key systems to understand for the [[Transport Data Landscape]] gap analysis.

The Pranav walkthrough positions Asset Vision mainly in open-road contracts. Western Roads Upgrade was one of the first Transport contracts to adopt Asset Vision, followed by SRAPC. Queensland contracts such as RAMC, Port of Brisbane, and Brisbane Airport have data coming into Databricks, while VRMC Grampians and Metro East were being mobilized for a 2026-07-01 go-live.

Tunnel or closed-road contracts are treated differently. Sydney Harbour Tunnel uses [[Maximo]], and NZLNNO and T2D are expected to use Maximo because tunnel assets need hierarchical locations such as buildings, levels, rooms, and assets. Asset Vision was described as much cheaper than Maximo but not fit for the tunnel-contract requirements that triggered Maximo adoption.

The SAP finance walkthrough adds that Asset Vision is deployed across about five Australian roads contracts, but each contract has a different configuration. This reinforces that Asset Vision is not one uniform activity model even when the same product name is used across contracts.

The Rui Luan stakeholder interview reinforced this operating split from a Western Roads Upgrade perspective. Open-road maintenance needs rapid geolocated issue capture, while tunnel work needs componentised asset hierarchies. Rui described Asset Vision as the open-road system and [[Maximo]] as the tunnel system.

The Toby Lin stakeholder interview adds a field-level view of how Asset Vision is maintained by the open-road Asset team. Client handover data can be inaccurate at mobilisation, so crews and inspectors validate missing or wrongly located assets, then the asset team uses Nearmap, Google Street View, QGIS, and Asset Vision updates to keep the inventory aligned with site reality. This workflow is captured on [[Transport Asset Inventory Validation]].

Toby also described the operating hierarchy inside Asset Vision: roads contain asset categories such as drainage lines, pits, guardrails, kerb and channel, line marking, signage, and barriers; each asset can then have defects or hazards attached. The scheduled inspection and response workflow is captured on [[Transport Asset Condition Inspections]].

## Databricks Access Pattern

Ventia has an Azure SQL Server in its cloud environment with elastic compute and seven databases associated with the Asset Vision reporting data. Asset Vision synchronizes data from its cloud into this Azure SQL Server.

Databricks uses federated queries against those Azure SQL databases, so queries pass through rather than staging all Asset Vision reporting data through the full Databricks medallion pattern. The walk-through also described a migration from Asset Vision-hosted reporting data toward Ventia-hosted reporting data.

Rui described the open-road Asset Vision reporting path as a direct integration that pulls raw data into Ventia data services, hosts reporting data in Azure Databricks, and runs Power BI over the collated tables. He described the standard open-road modules as inspections, defects, and jobs.

Toby indicated that defect and hazard data is available through Transport Databricks views aligned to the Asset Vision hierarchy, but he had limited access and could not confirm whether SLA or response-time fields can be extracted directly. He uses Databricks mainly for KPI tracker and dashboard purposes.

## Data Product Implications

Asset Vision does not by itself solve the wider Transport asset-standardisation problem. The source noted that Transport contracts may define assets differently, use different systems, and need different metadata, so any centralized Transport asset product would require SME agreement beyond the technical Databricks connection.

## Tender And Transition Context

The Transport Data and AI Working Group source positions Asset Vision as both an important current-state tool and a transition risk. It says there is currently no connection between Retina Vision and Asset Vision, and describes that integration as lower hanging fruit before SAP.

The Evolve/RAMC discussion also says the Asset Vision contract should be renewed for at least two more years to maintain continuity while SAP and Nextspace options are explored. Concerns raised in the transcript include Asset Vision's pace of innovation, cost increases, data ownership and trust, and the need for operational teams to be comfortable with any replacement or transition.

In the [[Transport Gen 3 Tender Innovation]] context, Asset Vision needs to be compared side by side with SAP and Nextspace for functionality, cost, data ownership, and ability to support digitally actionable outputs from [[Transport Asset Intelligence Roadmap]].

The Pranav walkthrough adds that cross-contract reporting is difficult even inside Asset Vision because activity specifications use activity category, activity, and intervention levels, and each contract has configured those levels differently. This makes [[Transport Sector Reporting Opportunities]] dependent on definition alignment, not just source-system access.

The SAP walkthrough frames Asset Vision as one input to activity-based costing rather than the whole solution. Bhupesh Balani said Maximo and client AWM/AVM systems also need to be mapped, and the team needs a translation guide showing which fields in each system are equivalent before [[Transport Financial Reporting]] costs can be connected to operational activities.

Sydney Harbour Tunnel is already on Maximo, but Bhupesh understood that Maximo data for Sydney Harbour Tunnel was not yet connected into Databricks. Future contracts may be configured differently so Maximo data can be brought into Databricks more easily.

The Rui Luan interview adds a field-capture constraint for this costing path. Asset Vision job records only become useful for bid intelligence and benchmarking when crews capture timesheets, materials, equipment, and job details accurately and those entries are easy to validate.

Toby's interview adds an asset-register constraint. Asset Vision data is only useful for routing, inspections, defects, hazards, and capital planning when location, asset type, condition, ownership status, and third-party works updates are actively maintained.

## Related Pages

- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Gen 3 Tender Innovation]]
- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Maximo]]
- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Financial Reporting]]
- [[Transport Data and AI Working Group]]
- [[Ventia Databricks Platform]]
- [[Databricks Walk-Through]]
- [[Engagement Team]]
