---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260603_110443.md"]
date-created: 2026-06-03
date-updated: 2026-06-03
tags: [transport, data-asset, stakeholder-interview, asset-vision, maximo, source-summary]
---

# Transport Data Asset Stakeholder Interview

This source is an 8-minute stakeholder interview transcript from 2026-06-03 with Rui Luan, Yinlun Pan, Donguk Kang, and Tanya Pita de Abreu. It covers the scope of the six-week [[Integrated Transport Data Asset]] discovery and Rui's current-state view of Transport project types, operational systems, SAP cost linkage, and open-road reporting data.

## Summary

Yinlun Pan framed the engagement as a six-week discovery phase focused on Transport as an early area for standardising how isolated data is used for winning bids, mobilisation, delivery reporting, project obligations, and more proactive decision support.

Rui Luan described two practical Transport operating patterns. Tunnel projects such as Sydney Harbour Tunnel are asset-hierarchy-heavy and use [[Maximo]], while open-road maintenance contracts need rapid geolocated response workflows and use [[Asset Vision]]. Rui works on Western Roads Upgrade, which he positioned as an open-road contract.

The interview also connected operational capture to commercial value. Rui said every job should ideally link directly to SAP so actual costs can be captured for bid intelligence and benchmarking. The current linkage is not consistently in place, and the accuracy of timesheets, materials, equipment, and job data depends on easy field capture, validation, and crew education.

For open-road Asset Vision contracts, Rui described a direct integration that pulls raw data into Ventia data services, hosts reporting data in Azure Databricks, and runs Power BI over the collated tables. He described the common open-road dataset as built around three major modules: inspections, defects, and jobs.

## Key Details

- The discovery is intended to understand current-state Transport data assets before moving toward a more proactive intelligence platform.
- Tunnel projects need structured component and asset hierarchies; open-road maintenance needs fast location-based response such as dropping a pin for an issue.
- [[Asset Vision]] is the open-road work management system named in the interview; [[Maximo]] is the tunnel work management system.
- Western Roads Upgrade is Rui's open-road reference point.
- SAP is the financial system, and job-level operational records need stronger linkage to SAP actual costs.
- Useful bid and benchmark data depends on accurate capture of time, materials, equipment, and work details by field crews.
- Rui suggested Conor Murphy as a likely follow-up for cost and benchmarking context.
- Rui suggested Adam Taylor or Barat as tunnel contacts who can explain Maximo setup.
- Open-road Asset Vision reporting data is described as flowing into Azure Databricks and Power BI, with standard modules for inspections, defects, and jobs.

## Connections

- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Financial Reporting]]
- [[Asset Vision]]
- [[Maximo]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]

## Open Questions

- Which open-road contracts share the same inspections, defects, and jobs module structure, and where do their field definitions diverge?
- What is the precise technical path from Asset Vision into Ventia data services, Databricks, and Power BI, and how does it relate to the Azure SQL federated-query pattern described in earlier sources?
- Which job records currently link to SAP costs, and which contracts still require manual reconciliation?
- Who owns validation rules and crew education for timesheets, materials, equipment, and job capture?
- Which tunnel SMEs should be interviewed next to document Maximo setup, Adam Taylor, Barat, or both?
