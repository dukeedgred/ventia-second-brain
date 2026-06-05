---
type: visual-summary
topic: Ventia
sector: Transport
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, enterprise-asset-master, current-state, visual-summary]
---

# Transport Enterprise Current State Visuals

This folder contains an interactive current-state visual for Transport enterprise asset, job, defect, inspection, condition, and geospatial data readiness.

## Interactive Visual

[Open the interactive current-state visual](transport-enterprise-current-state.html)

The visual has five views:

| View | Purpose |
|---|---|
| Architecture | Shows the difference between shared, decommissioned, contract-specific, and proposed enterprise layers |
| Capability Matrix | Compares what each contract/schema can currently support |
| Data Maturity | Scores each contract/schema on a 1-5 maturity scale with the next improvement step |
| Contract Detail | Lets users inspect each contract/schema and its evidence boundary |
| Build Path | Shows what is possible now, what needs replacement source work, and what is blocked |

For the detailed scoring rationale, see [[Transport Contract Data Maturity Assessment]].

## Corrected Current-State Assumption

`transport_dev.transport.utbl_jobs_allcontract` should not be treated as an active enterprise source. The table is decommissioned and should only be treated as historical/reference evidence if it is still queryable and approved for that purpose.

This changes the proposal materially:

| Previous assumption | Corrected position |
|---|---|
| Enterprise work-order fact could start from `utbl_jobs_allcontract` | Active enterprise work-order fact needs a replacement active source |
| Enterprise defect activity could start from `HazardCode` and `HazardDefectCode` in `utbl_jobs_allcontract` | Defect activity must come from active contract sources or a new consolidated job/defect feed |
| Asset activity summary could be grouped from `utbl_jobs_allcontract` | Asset activity summary is blocked for current operations until active job sources are identified |
| Shared `transport` schema was the operational base | Shared `transport` schema is mostly finance, WBS, vendor, job-costing, and decommissioned/historical operational context |

## Summary

The current state supports a discovery and enrichment approach, not a production enterprise asset master yet.

| Layer | Current feasibility |
|---|---|
| Enterprise asset master | Not yet possible as a complete production layer |
| Enterprise work orders | Not possible from a confirmed active all-contract source yet |
| Enterprise defects | Not possible as a standardised cross-contract layer yet |
| Contract-specific enrichment | Possible for selected domains and contracts |
| Road/bridge/geospatial enrichment | Possible for FNDC, TSRC, RAMC, WRU, and partly NEL |
| Inspection compliance | Strong for SHT, partial or unknown elsewhere |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Contract Tables - transport]]
- [[Transport Contract Tables - transport_aklw]]
- [[Transport Contract Tables - transport_fndc]]
- [[Transport Contract Tables - transport_nel]]
- [[Transport Contract Tables - transport_ramc]]
- [[Transport Contract Tables - transport_sht]]
- [[Transport Contract Tables - transport_srapc]]
- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
