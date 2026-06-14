---
type: entity
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260603_110443-Meeting Transcript Rui Luan Part 2.md"]
date-created: 2026-06-14
date-updated: 2026-06-14
tags: [transport, western-roads-upgrade, wru, asset-vision, asset-management, kpis]
---

# Western Roads Upgrade

Western Roads Upgrade, or WRU, is a Victorian open-road Transport contract used by Rui Luan as the detailed reference point in [[Transport Data Asset Stakeholder Interview Rui Luan Part 2]]. It sits within the open-road side of the [[Transport Contract Portfolio]], uses [[Asset Vision]], and provides a mature example of contract-specific Transport reporting, pavement planning, and field workflow constraints.

## Operating Context

Rui described WRU as an open-road contract rather than a tunnel contract. It therefore depends on rapid geolocated inspection, defect, and job workflows in [[Asset Vision]], not the componentised tunnel hierarchy associated with [[Maximo]].

Asset management is locally owned on the project. Rui said the WRU Asset Management team covers structures inspections, L1 and L2 inspections, routine maintenance inspections, drainage and guardrail condition inspections, annual pavement condition inspections, pavement data processing, capital works programming, third-party works, inventory updates, and KPI reporting.

## Asset Vision And Reporting

WRU uses the VicRoads-related Asset Vision context. Rui said Asset Vision's core mandatory fields are broadly standard across contract databases, with inspections, defects, and jobs as the common open-road modules. WRU then builds contract-specific views and dashboards over those records, including inspection KPI dashboards and response or job dashboards.

The Databricks table documentation for the corresponding WRU context is captured under [[Transport Contract Tables - transport_wru]]. Rui's walkthrough makes the `transport_wru` inspection, job, photo, timesheet, and capital works views important candidates for current-state lineage checks.

## Inspection And Job Workflow

Inspection schedules are driven by contract rules and Victorian road maintenance classes. Higher-class roads are inspected more frequently, while lower-class roads may be inspected weekly, monthly, or on another cadence.

WRU response times can be short enough that retrospective review is not practical. Inspectors may raise a job or resolve a minor issue while still on patrol because creating the record later can already miss the required response timing.

Many open-road jobs are small, such as picking up rubbish or straightening a sign. WRU therefore uses two-person inspection patrols where one person drives and the other can capture evidence, raise defects, or complete simple work on the spot before dispatching crews for larger jobs such as pothole repairs.

## Pavement And Capital Works

WRU uses annual pavement condition survey data and network measures such as roughness and rutting-style indicators to identify treatment needs. Rui described modelling treatment triggers, generating many potential scenarios, and then using a WRU-specific Julia linear-programming script to optimise capital works against multiple annual performance requirements.

The transcript refers to pavement modelling tools as "DTP" and "D teams"; this should be validated against the DTIMS terminology used elsewhere in the wiki. Rui contrasted WRU's multiple KPI constraints with other contracts that may optimise against fewer pavement targets.

## Commercial And Costing Shape

Rui described WRU as a flat-payment or drawdown-style contract. The client mainly needs evidence that inspection KPIs, defect response times, capital works locations, and pavement performance targets are being met.

That commercial model weakens the contractual incentive to connect every Asset Vision job to SAP at item level. Rui still saw internal value in item-level costing for forecasting, budgeting, bid intelligence, and understanding activity-level spend, but he said WRU has not implemented the SAP linkage as strongly as contracts where each job is approved and paid through standard rates.

## Data Asset Implications

For the [[Integrated Transport Data Asset]], WRU is useful because it exposes both a mature open-road reporting pattern and the limits of naive standardisation. The reusable core is inspections, defects, jobs, photos, timesheets, capital works, and KPI views; the local variation is the contract-specific forms, fields, response rules, commercial model, pavement targets, and field-capture burden.

WRU also highlights optimisation opportunities beyond dashboards. Candidate use cases include inspection route optimisation, aligning inspections with crew dispatch, shifting suitable work from reactive to cyclical maintenance, and analysing inspector capacity by road or route segment.

## Related Pages

- [[Transport Data Asset Stakeholder Interview Rui Luan Part 2]]
- [[Asset Vision]]
- [[Transport Contract Portfolio]]
- [[Transport Data Landscape]]
- [[Transport Asset Condition Inspections]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Financial Reporting]]
- [[Transport Sector Reporting Opportunities]]
- [[Integrated Transport Data Asset]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]
