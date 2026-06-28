---
type: concept
topic: Ventia
sources: ["raw/DAII Monthly Meeting Transcript.md", "raw/Transport Data Product-20260622_153334-Meeting Recording.md"]
date-created: 2026-05-28
date-updated: 2026-06-22
tags: [safety, data-governance, metrics, cde, alation, transport, kpis]
---

# Safety Metrics Governance Pilot

The safety metrics pilot is the first priority execution area for [[Ventia Data Governance Framework]]. It was selected because safety is heavily regulated, there is already a Databricks check model that can be governed, and the area carries high enterprise and operational risk.

## Metrics In Scope

The DAII transcript names injury-rate and seriousness measures, but the exact acronyms were garbled. The [[Transport Data Product Meeting Recording]] gives a clearer list from Shachi Shastry's description of the safety pilot: TRIFR, SIFR, and SAIFR. These should still be validated against the official safety glossary before being treated as final enterprise definitions.

The same Transport meeting shows why the safety pilot matters to Transport. If the [[Integrated Transport Data Asset]] includes incident KPIs or safety-related jobs, those fields may overlap with enterprise safety metrics and should reuse governed definitions rather than create Transport-only interpretations.

## Governance Work

The pilot is identifying what is critical for safety reporting, including critical data elements, definitions, business context, semantic layer, traceability, ownership, and controls. This work is being documented in Alation so the safety team can reuse governed definitions and logic rather than relying on repeated explanation or tribal knowledge transfer.

## Expected Benefits

The pilot is expected to reduce data risk and improve reporting efficiency by making definitions, schemas, and business logic easier to find and trust. It should also reduce reconciliations and rework, while giving Ventia a repeatable governance pattern for other data products and risk areas.

## Related Pages

- [[Ventia Data Governance Framework]]
- [[Ventia Data Platform Modernisation]]
- [[DAII Monthly Meeting Transcript]]
- [[Transport Data Product Meeting Recording]]
