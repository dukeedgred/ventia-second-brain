---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260609_111323-Meeting Recording.md"]
date-created: 2026-06-14
date-updated: 2026-06-14
tags: [transport, data-asset, stakeholder-interview, asset-vision, kpis, source-summary]
---

# Transport Data Asset Stakeholder Interview Anna Covell

This source is a 24-minute stakeholder interview transcript from 2026-06-09 with Anna Covell and Yinlun Pan. It covers Anna's shared [[Asset Vision]] and data role across RAMCSC, BAC / Brisbane Airport, and Port of Brisbane, plus contract-specific KPI reporting, condition terminology, field workflow, GIS use, Databricks-backed reporting, and system-inventory follow-up paths.

## Summary

Anna described herself as the go-to person for [[Asset Vision]] across the three Queensland contracts she supports. She tested and implemented Asset Vision into those contracts, helped build the back-end data needed to run them, and assists with reporting and other data-related work across RAMCSC, BAC, and Port of Brisbane.

The three contracts share people and a broadly standard field-capture approach, but contract requirements diverge after field recording. Billing, KPI reporting, intervention terminology, and condition-rating wording differ because each client contract specifies its own obligations.

The interview adds detail to the open-road workflow. Inspectors usually inspect, log, and issue work rather than fix issues themselves, except in emergency or unusual weather situations where it is safe to act. Jobs can be issued directly to crews, backlogged in Asset Vision, or escalated by direct phone call for urgent work.

Anna also identified useful discovery paths. Katerina and Liz Jessop were named as people likely to have deeper system-mapping context, and Katerina's earlier graduate-led contract-office visits reportedly produced a very detailed inventory of software used across Transport contracts.

## Key Details

- RAMCSC was still BAU while the Gen 3 bid or renewal process was underway; BAC started around 2022 or 2023, and Port of Brisbane started around 2020.
- The three Queensland contracts use shared resources, so changes to RAMCSC should align with BAC and Port of Brisbane where practical.
- Field work recording is standardised across the three contracts, but billing, monthly reporting, and contractual treatment differ after the field step.
- RAMCSC has a varied KPI appendix covering areas such as routine maintenance, stakeholder relations, projects, lane openings, hazards, safety, jobs, and work orders.
- BAC and Port of Brisbane were described as more focused on corrective and planned maintenance completion within the relevant month.
- Contracts are the authoritative source for KPI lists; Corrine, the commercial manager, was suggested as a route for contract access, although full contracts may be sensitive.
- Condition rating principles are similar, but terminology varies. Anna described TMR/RAMCSC terminology such as notification, safety, and hazard, while Port of Brisbane and BAC use 1-to-5 ratings with different wording.
- Intervention levels are set by the contract and determine response times. In [[Asset Vision]], defect codes, activity codes, repair options, intervention depth, road classification, and repair type are configured so the system can calculate the required response time.
- Anna said the three contracts use Asset Vision Autopilot rather than Retina Vision.
- Spatial work primarily uses QGIS, with ArcGIS also used.
- Anna does not personally use Databricks much, but Pranav Kumar has built Power BI reporting that uses Databricks for RAMCSC backlog status.
- Capital works planning uses client modelling outputs, including DTIMS reports for the TMR/RAMCSC context, plus field repair history and client review. For BAC and Port of Brisbane, recommendations are more inspection-led.
- Example systems mentioned for the wider Transport software inventory included Asset Guard for vehicle pre-start checks and Civil Pro for quality assurance.

## Connections

- [[Asset Vision]]
- [[Transport Contract Portfolio]]
- [[Transport Data Landscape]]
- [[Transport Asset Condition Inspections]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Sector Reporting Opportunities]]
- [[Integrated Transport Data Asset]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]

## Open Questions

- Can the team obtain the detailed Transport software inventory that Katerina's graduate reportedly assembled across contract offices?
- Which RAMCSC Gen 3 changes could break or complicate alignment with BAC and Port of Brisbane because of shared resources?
- Which Asset Vision fields expose the configured defect codes, activity codes, SORs, intervention levels, road classification, repair type, and calculated response time?
- Who owns the authoritative monthly KPI reporting requirements for RAMCSC, BAC, and Port of Brisbane?
- What is the exact Databricks and Power BI lineage for the RAMCSC backlog-status report?
