---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260603_110443-Meeting Transcript Rui Luan Part 2.md"]
date-created: 2026-06-14
date-updated: 2026-06-14
tags: [transport, data-asset, stakeholder-interview, asset-vision, western-roads-upgrade, kpis, source-summary]
---

# Transport Data Asset Stakeholder Interview Rui Luan Part 2

This source is a 43-minute stakeholder interview transcript from 2026-06-03 with Rui Luan, Yinlun Pan, Donguk Kang, and Tanya Pita de Abreu. It is a screen-share walkthrough focused on [[Western Roads Upgrade]], [[Asset Vision]], open-road inspection and job workflows, Databricks-backed reporting, pavement and capital works planning, SAP cost linkage, and practical optimisation opportunities for the [[Integrated Transport Data Asset]].

## Summary

Rui described [[Asset Vision]] as the standard open-road system pattern across Transport road contracts. The core tables and mandatory fields are broadly consistent across Asset Vision databases, while custom fields, custom forms, workflow configuration, and contract-specific views vary because each contract has different requirements.

For [[Western Roads Upgrade]], the Asset Management team owns a broad operating span: structures inspections, routine and condition inspections, annual pavement condition survey processing, capital works programming for structures and pavement, third-party works coordination, inventory updates, KPI reporting, and the handoff of planned work to delivery teams.

The source adds a detailed WRU commercial context. WRU is described as a lump-sum or drawdown-style contract where the client pays a flat amount and expects KPI targets, response-time compliance, capital works locations, and pavement-performance outcomes. Because WRU is not paid by individual approved job rates, item-level Asset Vision-to-SAP costing has less contractual pull, even though Rui said it would still help forecasting, budgeting, bidding, and internal profit analysis.

Rui also walked through image and defect-capture workflows. Asset Vision can capture road images during inspections, store photo records with links back to inspections, defects, jobs, and image URLs, and expose those records through data services and Databricks. However, automatic job creation from AI detections still needs a human-in-the-loop because detections may be irrelevant, incomplete, or too noisy for strict response-time contracts.

## Key Details

- Asset Vision databases are contract-specific, but inspections, defects, and jobs are the common core modules across open-road contracts.
- Contract teams build their own views over Asset Vision data, then use those views for dashboards such as inspection KPI dashboards and response or job dashboards.
- WRU uses the VicRoads-related Asset Vision database context and is linked to the `transport_wru` table context documented in [[Transport Contract Tables - transport_wru]].
- Rui framed WRU asset management as project-owned rather than centrally owned. He said Ventia previously had a more centralised asset-management team, but current project asset managers own local processes.
- WRU asset management covers L1/L2 structures inspections, routine maintenance inspections, drainage, guardrails, annual pavement condition inspections, pavement data processing, capital works planning, third-party works, inventory updates, and reporting.
- Victorian road maintenance classes drive inspection frequency, with higher-class roads inspected more often than lower-class roads.
- Short response-time defects may need immediate action, sometimes within hours, so WRU inspectors often raise or resolve work while still on patrol rather than reviewing footage later.
- Many WRU jobs are small activities such as removing rubbish or turning signs, so two-person patrols can fix some issues on the spot and only dispatch crews for larger work such as potholes.
- Rui described annual pavement condition survey data, roughness and rutting-style measures, treatment trigger points, scenario generation, and a WRU-specific Julia linear-programming optimisation layer to satisfy multiple annual performance requirements.
- The transcript refers to pavement modelling tools as "DTP" or "D teams"; this should be validated against the DTIMS terminology used in other Transport sources.
- Regional Vision can capture images and detect defects, while Asset Vision Autopilot can also detect defects and create jobs, but neither is trusted for fully automatic job generation without cleansing.
- Asset Vision photo records include image URLs and metadata tying the photo to inspections, defects, jobs, and defect type; the image itself does not embed all structured metadata.
- SAP integration and item-level costing depend on crews entering timesheets, materials, equipment, vehicles, and job details accurately; this is difficult when crews may complete many small jobs in a day.
- Rui suggested Pranav Kumar or a central Asset Vision contact transcribed as "Dalla" as better sources for cross-contract Asset Vision tables across open roads and tunnels.
- The raw source contains no URLs.

## Connections

- [[Western Roads Upgrade]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Asset Condition Inspections]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Intelligence Roadmap]]
- [[Transport Financial Reporting]]
- [[Transport Sector Reporting Opportunities]]
- [[Integrated Transport Data Asset]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]

## Open Questions

- Which Asset Vision fields and views make up the reusable cross-contract core for inspections, defects, jobs, photos, response times, and KPI dashboards?
- What is the validated name and owner of the pavement modelling tool transcribed as DTP or D teams, and how does it relate to DTIMS in other sources?
- Which WRU `transport_wru` views are the current source of truth for inspection KPI dashboards, job response dashboards, photo records, capital works, and timesheet/material capture?
- Can WRU's Julia optimisation model, treatment triggers, and pavement survey inputs be documented enough to inform an enterprise forward-works or bid-intelligence use case?
- What minimum timesheet, materials, equipment, and vehicle details are needed to make item-level costing useful without making field capture slower than the work itself?
- Who is the central Asset Vision contact transcribed as "Dalla", and can they provide a cross-contract table/view map?
