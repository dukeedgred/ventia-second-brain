---
type: concept
topic: Ventia
sources: ["raw/Ventia_Transport_Executive_Brief_Damien.md", "raw/transport-first-two-week-plan-detailed-2026-05-28.md", "raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443.md"]
date-created: 2026-06-02
date-updated: 2026-06-03
tags: [transport, data-asset, databricks, telematics, fleet]
---

# Integrated Transport Data Asset

The Integrated Transport Data Asset is the six-week programme with Omnia Collective / EdgeRed to build a usable Transport data foundation across contract-by-contract silos. The executive brief for Damien frames the work as a foundation for future investment decisions, not a final-state platform build.

## Engagement Purpose

Ventia Transport mobilises people, vehicles, and equipment across hundreds of sites every day. The core problem is that relevant data currently sits in contract-specific silos, which limits portfolio-level analysis and reuse.

The programme aims to connect GPS, telematics, fleet, and job scheduling data into a single usable foundation. This links the concept directly to the broader [[Transport Data Landscape]], the [[Transport Contract Portfolio]], and the central platform patterns on [[Ventia Databricks Platform]].

The Rui Luan stakeholder interview reinforces that the engagement is starting as a current-state discovery before any intelligence platform is defined. It also makes Transport a practical pilot for standardising data usage across isolated contract systems.

## North Star

The brief defines the north star as a clear view of how integrated Transport data can add value in four areas:

- Winning bids.
- Mobilising workforce and equipment.
- Supporting delivery optimisation.
- Creating additional value through data and insights, including cost benchmarking.

These value areas overlap with [[Transport Sector Reporting Opportunities]], especially bid support, mobilisation readiness, delivery reporting, and benchmarking.

## Foundation Scope

The working data foundation should expand centralised Transport data assets, including asset management, GPS, telematics, fleet management, job scheduling, vehicle and service locations, contract KPIs, and service provision information.

This scope depends on resolving the same standardisation issues already captured on [[Transport Data Landscape]]: which sources exist across contracts, which data has been centralised into Databricks, what remains decentralised, and why.

The [[SAP Data Walk-Through Transport Sector]] adds a current-state finance anchor for this map. [[Transport Financial Reporting]] is already centralised enough for SAP-derived management reporting and open commitments, but it still relies on BW for detailed line items and does not solve operational activity classification.

The Rui Luan interview adds two immediate foundation inputs: open-road [[Asset Vision]] modules for inspections, defects, and jobs, and job-level SAP cost linkage across both open-road and [[Maximo]] tunnel contexts. These are necessary if the live use case is bid intelligence, activity costing, or benchmark reporting.

## Six-Week Outcomes

The expected outcomes after six weeks are:

- A north star for the Transport data asset.
- A status and progress map showing available data, centralised data, decentralised data, and current usage patterns.
- A working data foundation with expanded centralised Transport data assets.
- A live use case tested by the business.
- A delivery roadmap covering priorities, timeline, effort, operational changes, and investment recommendations.

## First Two-Week Mobilisation Plan

The [[Transport First Two Week Plan]] details how the programme should move from initial alignment into the week 3 delivery phase. Week 1 focuses on sponsor alignment, stakeholder interviews, and current-state systems and data mapping. Week 2 moves into sensing and RAMC deep dives, validation, access-blocker resolution, proof-of-concept selection, and roadmap definition.

The decision gate before week 3 needs explicit agreement on the proof point, owner, data access, and commencement conditions. This makes the first two weeks a mobilisation and de-risking phase for the broader six-week asset programme, rather than a standalone discovery exercise.

## Live Use Case Options

The brief leaves the live use case open but names the likely value zones: bid support, service mobilisation and readiness, contract operations and reporting, and benchmarking or insights.

The right use case should prove near-term value while leaving reusable foundations for the longer roadmap. That makes it a practical bridge between [[Transport Sector Reporting Opportunities]] and the longer-term [[Transport Asset Intelligence Roadmap]].

Activity-based costing is attractive but dependent on source alignment. The SAP walkthrough indicates that a credible proof point would need field mapping across [[Asset Vision]], Maximo, and client AWM/AVM systems, plus agreement on how SAP costs should join to operational activity records.

## Open Questions

- Which live use case will be selected for the six-week programme?
- Which Transport datasets are already centralised into Databricks, and which remain decentralised?
- What business reasons explain the decentralised datasets?
- Which operational changes and investment recommendations will be required beyond the initial six weeks?
- Will S/4HANA ACDOCA provide enough detail to move Transport finance reporting from BW into Databricks?
- Who owns the translation guide across Asset Vision, Maximo, and client AWM/AVM activity fields?
- Which open-road inspections, defects, and jobs fields are standard enough to reuse across contracts?
- Which tunnel stakeholders can validate Maximo data structures and SAP linkage?

## Related Pages

- [[Transport Executive Brief Damien]]
- [[Transport First Two Week Plan]]
- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Financial Reporting]]
- [[Transport Data Landscape]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Contract Portfolio]]
- [[Transport Asset Intelligence Roadmap]]
- [[Ventia Databricks Platform]]
- [[Maximo]]
- [[Engagement Team]]
