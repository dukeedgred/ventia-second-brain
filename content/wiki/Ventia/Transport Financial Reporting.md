---
type: concept
topic: Ventia
sources: ["raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md"]
date-created: 2026-06-03
date-updated: 2026-06-03
tags: [transport, finance, sap, power-bi, reporting]
---

# Transport Financial Reporting

Transport financial reporting is the current-state management reporting layer that gives Transport contract stakeholders visibility of monthly performance, SAP line items, claims, and open purchase-order commitments. The 2026-06-03 SAP walkthrough positions it as a mature finance-reporting slice of the broader [[Transport Data Landscape]], but not as a complete operational or contractual reporting solution.

## Current Report

Bhupesh Balani maintains a Power BI report for Transport finance that shows what contracts have spent, what they have claimed, and how they are performing for a selected month and year. It is security-based, so each contract sees only its authorised projects.

The report supports filters and drill-through across contract, WBS, cost object, work order, and detailed SAP line items. It includes revenue claimed from clients, cost categories such as materials, subcontractors, payroll, and plant, plus year-to-date and life-to-date views that matter for Transport contracts that may run for 8 to 30 years.

The report refreshes every three hours and is used by project engineers, supervisors, project managers, general managers, CFOs, and other contract stakeholders. Its purpose is internal performance management rather than contractual client reporting obligations.

## Source Paths

Detailed SAP line items currently come from SAP BW controlling-document data, not from Databricks. Bhupesh described BW as providing the granularity and table-linking needed by operations, while Databricks currently exposes SAP data closer to raw table format and requires additional merging to reproduce the operational finance view.

Databricks is still part of the finance reporting ecosystem. Open commitment data, which shows remaining purchase-order commitments, comes from enterprise procurement tables in Databricks and has moved from a Transport-only report into an enterprise solution.

## S/4HANA Dependency

The expected move to S/4HANA creates a possible path away from BW for this reporting. Bhupesh expects the new ACDOCA table to combine controlling and financial document data in a way that may allow the Transport finance report to switch to Databricks after the S/4HANA go-live, described in the meeting as roughly 2026-10-12 or 2026-10-14.

That expectation still needs validation. The team has not yet seen the final ACDOCA output, so the future reporting path depends on whether the new table contains the required line-item detail for operations.

## Boundaries

The finance report should not be used as the source of truth for the active [[Transport Contract Portfolio]]. Its filters are based on whether a contract had cost in the selected month, so a contract may appear one month and not the next.

It also does not classify activities by repair job, safety fix, equipment failure, or service type. Those dimensions depend on operational work management and asset systems such as [[Asset Vision]], Maximo, and client AWM/AVM systems.

## Activity-Based Costing Gap

Activity-based costing remains a major gap because cost data and activity data are not yet standardised across systems. Asset Vision has different configurations across Australian roads contracts, Sydney Harbour Tunnel is on Maximo, future contracts may move to Maximo, and New Zealand uses a client system now referred to as AWM or AVM.

Bhupesh said the team needs a translation guide that maps equivalent fields across these systems before meaningful activity-based reporting can be built. This reinforces the standardisation challenge already tracked in [[Transport Sector Reporting Opportunities]] and [[Integrated Transport Data Asset]].

## Access And Follow-Up

Dashboard access is constrained by report security. Bhupesh can provide access to one project for logic review, but full-sector dashboard access requires approval from Damien. He also noted a pending request for read-only access to the Transport Databricks schema.

Relevant follow-up contacts include Bhupesh Balani for SAP and Transport finance reporting, Pranav Kumar for Asset Vision, Maximo, and client operational-system context, and Liz Jessop for the activity-based costing solution work connected to Damien's Transport dashboard request.

## Related Pages

- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Data Landscape]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Contract Portfolio]]
- [[Integrated Transport Data Asset]]
- [[Ventia Databricks Platform]]
- [[Ventia Data Platform Modernisation]]
- [[Asset Vision]]
- [[Engagement Team]]
