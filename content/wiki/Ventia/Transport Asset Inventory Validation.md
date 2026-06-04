---
type: concept
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md"]
date-created: 2026-06-04
date-updated: 2026-06-04
tags: [transport, asset-data, data-quality, asset-vision, gis]
---

# Transport Asset Inventory Validation

Transport asset inventory validation is the workflow for reconciling client-supplied road asset data with the physical asset register used in [[Asset Vision]]. Toby Lin's interview frames it as a core open-road operating process because asset counts, locations, types, and ownership statuses determine whether work can be assigned and audited correctly.

## Why It Matters

DTP can provide raw asset datasets at contract start, but Toby said those datasets may be materially incomplete or inaccurate. One example was pit data that began around 2,000 to 3,000 records and grew to about 8,000 after validation and ongoing correction.

Incorrect asset locations can have immediate operational cost. If a pit or sign is 5 to 6 metres away from its true location, crews may open the wrong asset after traffic setup has already been paid for and arranged.

## Validation Workflow

The workflow combines field validation and desktop GIS work. Crews or inspectors flag missing or incorrectly located assets, then the asset team checks imagery through Nearmap or Google Street View and uses QGIS to map locations before updating the Asset Vision inventory.

Asset attributes are corrected at the same time as locations. Examples from the interview included guardrail length and type, pit material, lid type, inlet details, drainage lines, vehicle barriers, kerb and channel, line marking, and signage.

## Ongoing Change Drivers

Inventory quality is not a one-off mobilisation task. Third-party works can create or alter driveways, pits, kerbs, and other road assets without timely notification to Ventia. Inspectors may discover these changes during normal work and then escalate to DTP for confirmation.

Some assets remain difficult to validate remotely. Assets under bridges may not be visible in aerial imagery, so the team needs site photos and field inspection, and the exact location can still be less precise than directly mapped assets.

## Ownership And Status Decisions

The asset team also resolves whether a discovered asset belongs to Ventia's contract scope. If an asset is in scope, the team creates or updates it in Asset Vision. If it is out of scope, Toby said they may still create a record with a disposed status and a comment explaining why Ventia is not responsible, so future crews do not repeat the same query.

Asset statuses can change frequently across active, inactive, disposed, or planned states. Third-party works can temporarily make an asset inactive, and program work may require dummy assets so jobs can direct crews to designed locations such as West Gate Tunnel signage installation points.

## Data Asset Implications

For the [[Integrated Transport Data Asset]], this means the asset register needs more than a raw asset table. It needs provenance for client handover data, validation status, evidence, ownership decisions, status history, and links to [[Transport Asset Condition Inspections]] and work records.

## Related Pages

- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Integrated Transport Data Asset]]
- [[Transport Asset Condition Inspections]]
- [[Transport Asset Intelligence Roadmap]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]
