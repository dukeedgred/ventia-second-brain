---
type: concept
topic: Ventia
sources: ["raw/Transport Data and AI Working Group[SEC=INTERNAL CONFIDENTIAL].md", "raw/DB walkthrough with Pranav Kumar.md", "raw/transport-first-two-week-plan-detailed-2026-05-28.md", "raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-05-28
date-updated: 2026-06-04
tags: [transport, asset-data, ai, predictive-maintenance, digital-twin, telemetry, condition-inspections]
---

# Transport Asset Intelligence Roadmap

The Transport asset intelligence roadmap describes the capabilities Transport wants from asset-condition capture, visualisation, analytics, and digital action workflows. It connects road-defect capture and operational work management to [[Transport Gen 3 Tender Innovation]], [[Transport Data Landscape]], and [[Asset Vision]].

## Defect And Attribute Capture

John Parisella's input identifies the practical road-defect data that needs to be captured for VRMC, RAMC, and most roads contracts. Inputs include cracking, potholes, foliage, sign damage, crocodile cracking, shoving, rutting, raveling, flushing, edge damage, faded line marking, kerb and channel, barriers and guardrails, litter and debris, vegetation, overhanging branches, ponding water, sweeping, roadkill, graffiti, deformed signage, faded signage, and deformed guideposts.

Future scope may include tunnel assets such as fans and wall cracks. This makes the roadmap broader than simple defect detection: it needs an extensible asset and condition model that can support multiple roads contracts and later asset classes.

The Toby Lin interview adds how this plays out in the current open-road Asset Vision register. The Asset team maintains asset attributes such as guardrail length and type, pit material and lid type, inlet details, and accurate geolocation, while also correcting gaps in client handover data through [[Transport Asset Inventory Validation]].

## Output Requirements

The data needs to be geolocated and usable in visualisation or action platforms including Maximo, SAP, [[Asset Vision]], and Nextspace. Required outputs include location, defect data, duplicate capture detection, patterns, and work order details.

The source stresses that visual output is important, but not enough on its own. Outputs need to support digital action, such as remediation projects, programs, work orders, or intervention backlog items.

Toby's workflow confirms that digital action depends on attaching defects or hazards to the correct asset, selecting the right category and urgency level, and allowing Asset Vision to calculate the response due date. This connects automated capture directly to [[Transport Asset Condition Inspections]] and work-order evidence, not just to a map layer.

## Integration Themes

The note states that Retina Vision is not currently connected to [[Asset Vision]], and describes that connection as a lower-hanging opportunity before deeper SAP integration. It also raises the possibility of a working prototype across Retina Vision, Nextspace, SAP S/4HANA, and SAP SAC.

The architecture question remains unsettled: SAP, Retina Vision, Nextspace, [[Asset Vision]], SAP S/4HANA, SAP SAC, and SAP Asset Performance Management all appear in the discussion, but their target roles and boundaries have not been resolved.

## Predictive Capability

The source asks whether the team can demonstrate planned predictive capability, including use of IoT data to predict failures and trigger intervention backlog items. SAP Asset Performance Management is mentioned as providing an IoT aggregation database capability that could support predictive failure or intervention use cases.

Traffic types, traffic volumes, weather, historic condition data, real-time sensor inputs, and maintenance history may be important future inputs, but their availability for the Transport SOW still needs validation through [[Engagement Team]] contacts.

The Pranav walkthrough adds a concrete failure-code path for predictive maintenance. Contracts could capture why a defect occurred as well as what repair was applied, then use patterns such as flooding-related potholes to plan upstream interventions. SRAPC started work on failure-code setup but did not complete the full list; Sydney Harbour Tunnel was described as having a stronger Maximo failure-code setup.

Vehicle telemetry was also raised as a possible internal Ventia opportunity. The value would come from connecting engine or asset telemetry to maintenance history so that the team can predict issues such as battery failures or future vehicle maintenance needs.

Toby added a capital-works angle for road pavement. Annual pavement testing helps predict which sections are likely to fail and supports targeted capital works proposals instead of broad road replacement.

## Sensing And Telemetry Inputs

The [[Transport First Two Week Plan]] turns sensing and telemetry into a named week-2 deep-dive area. Candidate inputs include Retina Vision, BYD telemetry, drainage IoT, weather data, traffic data, and open road datasets.

These inputs should support the initial operational decision use case and the decision gate for week 3. The key integration question is which sources can be accessed quickly enough to provide a credible proof point while still fitting the longer-term [[Integrated Transport Data Asset]] and [[Transport Data Landscape]].

## Related Pages

- [[Transport Data and AI Working Group]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Transport First Two Week Plan]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Transport Gen 3 Tender Innovation]]
- [[Transport Sector Reporting Opportunities]]
- [[Transport Contract Portfolio]]
- [[Transport Data Landscape]]
- [[Asset Vision]]
- [[Ventia Databricks Platform]]
- [[Ventia Data Platform Modernisation]]
