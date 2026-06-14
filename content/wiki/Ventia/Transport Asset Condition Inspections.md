---
type: concept
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md", "raw/Transport Data Asset Stakeholder Interview-20260609_111323-Meeting Recording.md", "raw/Transport Data Asset Stakeholder Interview-20260605_140612-Meeting Recording.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443-Meeting Transcript Rui Luan Part 2.md"]
date-created: 2026-06-04
date-updated: 2026-06-14
tags: [transport, condition-inspections, defects, hazards, kpis, asset-vision, intervention-levels]
---

# Transport Asset Condition Inspections

Transport asset condition inspections are scheduled, contract-driven inspections that record asset condition, trigger defect or hazard jobs, and support monthly KPI reporting. Toby Lin's interview distinguishes this work from day-to-day patrols that detect road issues during normal maintenance operations.

## Asset And Issue Hierarchy

The open-road hierarchy starts with roads and then specific asset categories such as pits, guardrails, minor signs, drainage, kerb and channel, line marking, and barriers. In [[Asset Vision]], defects and hazards are attached to those assets where an issue exists.

Hazards are urgent safety issues, such as missing speed signs or barriers that no longer protect road users. Defects are lower-severity issues, such as twisted signage that still communicates the intended instruction but needs correction.

## Condition Ratings

Condition ratings run from 1 to 5, from very good to very poor. The definitions are contract-specific and supported by photographic examples in contract documents, so they are not guaranteed to be a Ventia-wide or industry-wide standard.

The operational goal is to avoid poor or very poor assets in the register. Toby said open-road contracts usually share similar asset categories, but the condition standards, KPI standards, and measurement rules differ by project.

The [[Transport Data Asset Stakeholder Interview Anna Covell]] confirms the same principle from RAMCSC, BAC, and Port of Brisbane. Anna said the underlying condition-rating principle is similar across the contracts, but the contract wording differs: the TMR/RAMCSC context uses terms such as notification, safety, and hazard, while Port of Brisbane and BAC use 1-to-5 ratings with different wording attached.

The [[Transport Data Asset Stakeholder Interview Huy Nguyen]] adds a tunnel handover nuance. North East Link assets should mostly be in good condition because they are new at handover, but pavement may require measured condition evidence such as roughness, rutting, and cracking before handover. For other assets, initial default condition values may have limited operational meaning until inspections are performed.

## Inspection Scheduling And Routing

The Asset team schedules condition inspections to satisfy inspection KPIs. Toby gave guardrails as an example: about 688 active guardrails must each be inspected annually, and about 2,000 pits also need inspection across the contract.

Routing matters because inspections can require traffic setup. The preferred approach is to inspect assets together along a road corridor instead of sending crews to scattered locations in an inefficient sequence.

[[Transport Data Asset Stakeholder Interview Rui Luan Part 2]] adds the [[Western Roads Upgrade]] inspection scheduling pattern. Rui said Victorian road maintenance classes determine inspection frequency, with higher-class roads inspected more often, and identified routing optimisation as a practical opportunity because inspection routes can be arranged to reduce travel and align with likely work locations.

## Defect And Hazard Jobs

When an inspector identifies an issue, Asset Vision can raise a job against the relevant asset. Urgency levels drive response timing: level 1 is a hazard, level 2 is a defect, and level 3 appears rarely by agreement with the client.

Response times are automatically calculated from the selected asset category, issue category, urgency level, and contractual rules. Once an Asset team inspection raises a job, the maintenance team owns the rectification KPI, although inspectors may fix simple issues on the spot when practical.

Anna added that response timing is driven by contract intervention levels. In her pothole example, Asset Vision constrains the user to relevant repair options, captures a measure such as pothole depth, links that to road classification and repair type, and then calculates the response time. This makes the configured contract rules part of the inspection and defect data model.

Anna also described the day-to-day handoff between asset management and routine maintenance. Inspectors usually inspect, log, and issue work rather than repairing during inspections, because they normally do not have traffic control with them. Crews can log and repair on the spot, inspectors can issue urgent jobs directly to crews, and non-immediate work can be backlogged in Asset Vision.

Rui's WRU workflow differs where short response times and simple road-patrol jobs make immediate action practical. He described two-person patrols where one person drives and the other can raise defects, capture evidence, pick up rubbish, straighten signs, or create a larger job for later dispatch before continuing the inspection.

## KPI Reporting And Audit

Condition inspection KPIs are client-facing contract requirements. Toby referenced KPI 3.1 as one reporting area where monthly reporting shows scheduled and completed inspections, incidents, and inspection counts by asset type.

The monthly KPI report is assembled as a long Word document with tables contributed by different owners. Annual client audits can inspect job records, completion evidence, response timing, and whether rectification work was performed properly.

Anna added that RAMCSC has an entire contract appendix of KPIs across routine maintenance, stakeholder relations, projects, lane openings, hazards, safety, jobs, and work orders. BAC and Port of Brisbane appear more focused on corrective and planned maintenance completion within the expected month. The contracts are therefore the source of truth for KPI lists, with commercial management likely needed for access.

## Capital Works Boundary

Routine maintenance handles smaller rectification jobs, while work that routine maintenance cannot fix moves toward capital works. Pavement was described as the most important asset class for capital works, with annual pavement testing used to predict likely failure areas and target critical sections rather than repairing whole roads unnecessarily.

Rui's WRU source adds that the asset management team processes annual pavement condition survey data, models treatment trigger points, and generates capital works programs for structures and pavement before handing validated work to delivery teams.

## Tunnel Operational Transition

Huy described North East Link condition and maintenance inspection obligations as largely operational-phase work. Once operations begin, the team expects to validate inspection data, maintenance data, and work order data for completeness, build operational reports and dashboards, and use the Asset Management Manual to guide inspection frequency and condition-assessment practice.

## Related Pages

- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Transport Data Asset Stakeholder Interview Rui Luan Part 2]]
- [[Transport Data Asset Stakeholder Interview Anna Covell]]
- [[Transport Data Asset Stakeholder Interview Huy Nguyen]]
- [[Western Roads Upgrade]]
- [[Transport Asset Inventory Validation]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Transport Sector Reporting Opportunities]]
- [[Integrated Transport Data Asset]]
- [[Transport Asset Intelligence Roadmap]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]
