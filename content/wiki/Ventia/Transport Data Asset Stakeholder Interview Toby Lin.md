---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-06-04
date-updated: 2026-06-04
tags: [transport, data-asset, stakeholder-interview, asset-vision, condition-inspections, source-summary]
---

# Transport Data Asset Stakeholder Interview Toby Lin

This source is a 45-minute stakeholder interview transcript from 2026-06-04 with Toby Lin and the Transport data asset discovery team. It covers open-road asset inventory validation, [[Asset Vision]] workflows, defect and hazard handling, condition inspection KPIs, Databricks use, contractual reporting, and follow-up stakeholders.

## Summary

Toby described asset data as a live operational register rather than a static handover dataset. DTP provides raw asset data at the start of a contract, but the initial records can be materially inaccurate. Toby gave the example of pit counts increasing from roughly 2,000 to 3,000 in client data to about 8,000 after field validation and ongoing correction.

The current open-road workflow uses crew observations, inspectors, Nearmap, Google Street View, QGIS, and [[Asset Vision]] updates to reconcile actual roadside assets with the inventory. This validation improves work assignment because inaccurate locations can cause crews to open the wrong asset after traffic setup has already been arranged.

Toby also explained the road asset hierarchy used in Asset Vision: roads sit above categories such as drainage lines, pits, vehicle barriers, kerb and channel, line marking, signage, and guardrails. Each asset can have defects or hazards attached to it, and the resulting job response time depends on urgency, severity, asset category, and contractual rules.

The interview adds a detailed view of condition inspection KPIs. Dedicated asset inspectors schedule and route annual or periodic inspections for assets such as guardrails, pits, and minor culverts, record condition ratings from 1 to 5, and feed monthly contract reporting. Maintenance crews own many rectification KPIs once jobs are raised, while the Asset team focuses on inventory quality and condition-inspection obligations.

## Key Details

- [[Transport Asset Inventory Validation]] is needed because client handover data can be incomplete, incorrectly located, or out of date after third-party works.
- Asset Vision inventory accuracy was described as fairly accurate after extensive validation, but hidden assets under bridges and unnotified third-party changes remain blind spots.
- Field validation can take months on a large network; Toby said the current network took at least half a year to make small assets such as pits, minor signs, and guardrails reliable.
- Defects and hazards are both asset issues, but hazards are urgent safety issues while defects are lower-severity problems that still require rectification.
- Asset Vision uses response levels: level 1 for hazards, level 2 for defects, and rare level 3 cases agreed with the client.
- [[Transport Asset Condition Inspections]] are scheduled to satisfy contract KPIs, not simply to capture issues during daily road patrols.
- Toby uses Databricks views mainly for KPI tracker or dashboard purposes and had limited access to confirm whether SLA or response-time fields can be extracted for defects and hazards.
- Monthly KPI reporting is contract-driven, assembled into a long Word report with tables contributed by different owners.
- KPI standards and condition definitions vary by contract even if open-road contracts share broadly similar asset categories.
- Josie Wilson, Business Performance Manager, and Ray were suggested as likely follow-ups for contractual KPI and reporting requirements.

## Connections

- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Integrated Transport Data Asset]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Sector Reporting Opportunities]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
- [[Engagement Team]]

## Open Questions

- Which Asset Vision fields expose defect, hazard, urgency level, SLA, due date, and completion evidence in Databricks?
- Which condition inspection and response KPIs are defined in each Transport contract, and where are the authoritative contract schedules stored?
- Can the Transport data asset separate inventory-quality obligations, condition-inspection KPIs, patrol KPIs, and maintenance rectification KPIs by contract?
- Who owns the full monthly KPI report and abatement justification process for each contract?
- How should hidden assets, third-party works, and ownership disputes be represented in a reusable cross-contract asset data model?
