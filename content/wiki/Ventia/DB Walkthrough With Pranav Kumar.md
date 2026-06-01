---
type: source-summary
topic: Ventia
sources: ["raw/DB walkthrough with Pranav Kumar.md"]
date-created: 2026-06-01
date-updated: 2026-06-01
tags: [databricks, transport, contracts, source-summary]
---

# DB Walkthrough With Pranav Kumar

This source is a meeting transcript from a 50-minute walkthrough with Pranav Kumar on 2026-05-29. It covers the Transport contract portfolio, Databricks contract schemas, reporting maturity, source-system boundaries, and enterprise data opportunities for the Transport data work.

## Summary

Pranav described Transport as a portfolio of roughly 15 to 20 contracts across Australia and New Zealand. Australia includes New South Wales, Queensland, Victoria, Western Australia, and newly South Australia, while New Zealand includes Auckland West, Transmission Gully, and several smaller projects.

The walkthrough clarified that Transport's data landscape is contract-led. Larger contracts such as SRAPC, WRU, NEL, and RAMC have their own data people, while smaller contracts generally rely on shared support. [[Ventia Databricks Platform]] uses a Transport development catalog with contract-level schemas, but cross-contract reporting remains difficult because activity structures, KPIs, contract obligations, and source-system maturity vary by contract.

The source also distinguishes open roads from tunnel or closed-road contracts. Open roads are mostly associated with [[Asset Vision]], while tunnel contracts are expected to use Maximo because tunnel assets require richer location hierarchy. Sydney Harbour Tunnel is already on Maximo, but its data is not yet syncing into Databricks.

## Key Details

- [[Transport Contract Portfolio]] includes SRAPC, Sydney Harbour Tunnel, Western Harbour Tunnel, CCT, Western Distributor, M5 East, LCT, RAMC/QSTC, Port of Brisbane, Brisbane Airport, WRU, VRMC Grampians and Metro East, NEL, T2D, Venture Smart in Western Australia, Auckland West, and Transmission Gully.
- There is no current centralized Transport contract report listing all contracts, dates, and data status, although Pranav recalled an older cross-contract report that may still be worth checking.
- Contract schemas in Transport dev include examples such as Auckland West, Brisbane Airport, finance, FNDC, SDC, NZLNNO, and SRAPC.
- WRU has the most mature reporting footprint, while SRAPC is stronger from a technology and delivery-practice perspective.
- Most downstream reporting is Power BI, with Excel still used for some analysis and charting.
- Contract documents, KPIs, and SLAs are not centrally available from this discussion; the team likely needs to request them contract by contract.

## Connections

- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Asset Vision]]
- [[Transport Asset Intelligence Roadmap]]
- [[Engagement Team]]

## Open Questions

- Does the older cross-contract report still exist, and can it be used as a starting contract inventory?
- Which contract owners can provide contract documents, KPIs, SLAs, and reporting packs for the priority contracts?
- Can Sydney Harbour Tunnel, NZLNNO, and T2D Maximo data be connected to Databricks using the existing Telco-sector integration pattern?
- Which standard sector-level reports does Transport senior management actually want before deeper contract-level KPI work begins?
