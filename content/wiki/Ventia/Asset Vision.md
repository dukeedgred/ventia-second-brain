---
type: entity
topic: Ventia
sources: ["raw/Databricks walk-through.md", "raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md", "raw/DB walkthrough with Pranav Kumar.md"]
date-created: 2026-05-28
date-updated: 2026-06-01
tags: [asset-vision, transport, work-management, asset-data, federated-query]
---

# Asset Vision

Asset Vision is the main source system mentioned for Transport work order, work management, and asset data. In the Databricks walk-through, it was positioned separately from SAP, which mainly holds Transport financial data.

## Role In Transport Reporting

Asset Vision provides operational reporting data for Transport contracts. The source described Transport Australia as having multiple contract groupings and noted a separate mobilization effort for New Zealand Transport databases that were not yet fully in production.

The data supports contract-level operational reporting, including work management and asset views. It is one of the key systems to understand for the [[Transport Data Landscape]] gap analysis.

The Pranav walkthrough positions Asset Vision mainly in open-road contracts. Western Roads Upgrade was one of the first Transport contracts to adopt Asset Vision, followed by SRAPC. Queensland contracts such as RAMC, Port of Brisbane, and Brisbane Airport have data coming into Databricks, while VRMC Grampians and Metro East were being mobilized for a 2026-07-01 go-live.

Tunnel or closed-road contracts are treated differently. Sydney Harbour Tunnel uses Maximo, and NZLNNO and T2D are expected to use Maximo because tunnel assets need hierarchical locations such as buildings, levels, rooms, and assets. Asset Vision was described as much cheaper than Maximo but not fit for the tunnel-contract requirements that triggered Maximo adoption.

## Databricks Access Pattern

Ventia has an Azure SQL Server in its cloud environment with elastic compute and seven databases associated with the Asset Vision reporting data. Asset Vision synchronizes data from its cloud into this Azure SQL Server.

Databricks uses federated queries against those Azure SQL databases, so queries pass through rather than staging all Asset Vision reporting data through the full Databricks medallion pattern. The walk-through also described a migration from Asset Vision-hosted reporting data toward Ventia-hosted reporting data.

## Data Product Implications

Asset Vision does not by itself solve the wider Transport asset-standardisation problem. The source noted that Transport contracts may define assets differently, use different systems, and need different metadata, so any centralized Transport asset product would require SME agreement beyond the technical Databricks connection.

## Tender And Transition Context

The Transport Data and AI Working Group source positions Asset Vision as both an important current-state tool and a transition risk. It says there is currently no connection between Retina Vision and Asset Vision, and describes that integration as lower hanging fruit before SAP.

The Evolve/RAMC discussion also says the Asset Vision contract should be renewed for at least two more years to maintain continuity while SAP and Nextspace options are explored. Concerns raised in the transcript include Asset Vision's pace of innovation, cost increases, data ownership and trust, and the need for operational teams to be comfortable with any replacement or transition.

In the [[Transport Gen 3 Tender Innovation]] context, Asset Vision needs to be compared side by side with SAP and Nextspace for functionality, cost, data ownership, and ability to support digitally actionable outputs from [[Transport Asset Intelligence Roadmap]].

The Pranav walkthrough adds that cross-contract reporting is difficult even inside Asset Vision because activity specifications use activity category, activity, and intervention levels, and each contract has configured those levels differently. This makes [[Transport Sector Reporting Opportunities]] dependent on definition alignment, not just source-system access.

## Related Pages

- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Gen 3 Tender Innovation]]
- [[Transport Data and AI Working Group]]
- [[Ventia Databricks Platform]]
- [[Databricks Walk-Through]]
- [[Engagement Team]]
