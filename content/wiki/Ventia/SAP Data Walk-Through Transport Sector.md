---
type: source-summary
topic: Ventia
sources: ["raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md"]
date-created: 2026-06-03
date-updated: 2026-06-03
tags: [sap, transport, finance, reporting, source-summary]
---

# SAP Data Walk-Through Transport Sector

This source is a meeting transcript from a 29-minute SAP and Transport finance reporting walkthrough on 2026-06-03. Bhupesh Balani explained current Transport financial reporting, SAP BW and Databricks source paths, S/4HANA migration expectations, open commitments, and activity-based costing gaps for the [[Integrated Transport Data Asset]] discovery.

## Summary

Bhupesh Balani was previously business process improvement manager in Transport finance under Matt Fuller and is now seconded into the enterprise reporting team. He remains a key owner or maintainer of Transport finance reports, including a Power BI report that lets contract users inspect monthly revenue, cost, claims, WBS, work order, and line-item performance.

The current Transport finance report uses SAP controlling-document detail from SAP BW rather than Databricks because BW provides the granularity and table-linking needed by operations. Databricks does contribute open commitment data from enterprise procurement tables, and Bhupesh expects the Transport finance reporting path may move further into Databricks after the S/4HANA upgrade if ACDOCA provides the needed controlling and financial detail.

The discussion also clarified that current finance reporting is useful for management performance reporting but is not a complete source of truth for active contracts or contractual reporting obligations. Activity-based costing remains the larger cross-domain gap because operational activity data sits across [[Asset Vision]], Maximo, client AWM or AVM systems, and contract-specific configurations.

## Key Details

- The Power BI report is security-trimmed so each contract sees only its authorised projects.
- Users can filter by month, contract, WBS, and cost object, then drill from WBS to work orders and detailed SAP line items.
- The report refreshes every three hours and supports project engineers, supervisors, project managers, general managers, CFOs, and other contract stakeholders.
- It reports revenue claimed from clients and cost categories such as materials, subcontractors, payroll, and plant, with year-to-date and life-to-date cost views for long-running Transport contracts.
- Open commitment reporting shows remaining purchase-order commitment and has already moved from a Transport-only view into an enterprise report.
- The finance report does not classify work by service type, repair type, safety fix, or equipment failure because activity data is not consistently modelled across work management systems.
- Finance report filters should not be treated as the active contract list because a contract can disappear from a selected month if there was no cost.
- SAP S/4HANA go-live was described as expected around 2026-10-12 or 2026-10-14, with ACDOCA expected to combine controlling and financial documents.
- For [[Asset Vision]], Maximo, and client AWM/AVM data, Bhupesh highlighted the need for a translation guide mapping equivalent fields across systems.
- Dashboard access is constrained by report security; full-sector access requires approval, while one-project access may be enough to understand report logic.

## Connections

- [[Transport Financial Reporting]]
- [[Transport Data Landscape]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Contract Portfolio]]
- [[Integrated Transport Data Asset]]
- [[Ventia Databricks Platform]]
- [[Ventia Data Platform Modernisation]]
- [[Asset Vision]]
- [[Engagement Team]]

## Open Questions

- Which Databricks or BW table should be used as the authoritative list of all Transport contracts within the sector?
- Will the S/4HANA ACDOCA output contain enough detail to replace BW-sourced SAP line items in the Transport finance report?
- Who will define the cross-system translation guide for activity-based costing across Asset Vision, Maximo, and client AWM/AVM systems?
- Which level of dashboard access will the discovery team receive: one project for logic review or full-sector access after approval?
- Which SHeQ report owner should be engaged if safety data becomes part of the integrated reporting scope?
