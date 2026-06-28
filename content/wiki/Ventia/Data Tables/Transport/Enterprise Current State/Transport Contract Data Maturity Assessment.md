---
type: maturity-assessment
topic: Ventia
sector: Transport
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, data-maturity, enterprise-asset-master, current-state]
---

# Transport Contract Data Maturity Assessment

This page assesses current data maturity by Transport contract/schema for the enterprise asset and operational analysis proposal.

The assessment is based on documented Transport table pages and the corrected assumption that `transport_dev.transport.utbl_jobs_allcontract` is decommissioned. It is a planning assessment, not a data-quality certification.

## Maturity Scale

| Score | Meaning |
|---:|---|
| 1 | Ad hoc, missing, truncated, or unconfirmed source evidence |
| 2 | Narrow reference source or limited contract-specific data with major gaps |
| 3 | Usable contract-specific data, but not enterprise-ready without mapping or validation |
| 4 | Strong contract-specific source with multiple enterprise-relevant domains covered |
| 5 | Active, governed, all-contract enterprise-ready source |

No current contract/schema reaches level 5 because no active, governed, all-contract asset or work-order source has been confirmed.

## Summary Matrix

| Contract/schema | Maturity | Current tier | Main strength | Main limitation |
|---|---:|---|---|---|
| `transport` | 2.0 | Reference-only shared layer | Finance, costing, WBS, vendor context | All-contract jobs table is decommissioned; no confirmed active asset master |
| `transport_aklw` | 3.1 | Usable contract asset source | Asset hierarchy, condition, risk, chainage | No documented active job table or complete inspection view |
| `transport_fndc` | 2.4 | Road geospatial reference | Road centreline, traffic, width, NZTM coordinates | No documented jobs, defects, inspections, or live condition |
| `transport_nel` | 2.7 | Rich upload-based dataset | Asset dimensions, classification, condition rating, work-order upload | Freshness, ownership, and source-of-truth status need validation |
| `transport_ramc` | 3.6 | Strong contract operational source | Jobs, defects, stripmap WKT, pavement classes | No complete standalone asset master documented |
| `transport_sht` | 2.6 | Inspection-focused contract source | Inspection compliance and schedule/due/completed dates | Asset master and job source not documented |
| `transport_srapc` | 2.1 | Reference and maintenance strategy context | Civil maintenance and TACP reference data | Key bridge/export views truncated; operational sources not confirmed |
| `transport_tsrc` | 3.2 | Strong bridge enrichment source | Bridge assets, condition, dimensions, lat/lon, WKT | General asset and work-order coverage is partial |
| `transport_wru` | 3.2 | Operational and traffic-counter source | Job export, counters, traffic counts, geospatial fields | Full asset inventory and inspection coverage not documented |

## Contract Detail

### `transport`

Current maturity: **2.0 / 5**

This schema has useful shared commercial and cost context, but it should not be treated as the current operational base. The previously considered all-contract jobs table, `utbl_jobs_allcontract`, is decommissioned.

What is mature:

- Job costing and timesheet context exists.
- SAP, WBS, vendor, and WO/NWA views support finance and procurement analysis.
- The decommissioned all-contract jobs table can help understand prior integration patterns if approved for historical reference.

What is not mature:

- No confirmed active all-contract job/work-order table.
- No confirmed all-contract asset table.
- No active all-contract condition, inspection, or asset geospatial source.

Next maturity step: identify the active replacement for all-contract jobs and confirm whether a current all-contract asset source exists.

### `transport_aklw`

Current maturity: **3.1 / 5**

AKLW has a relatively clean contract-level asset source through `uvw_asset`. It is one of the better candidates for asset-master enrichment, but not for full enterprise operations.

What is mature:

- Asset identity and hierarchy: `ID`, `Code`, `Name`, `AssetType`, parent asset fields.
- Linear referencing: `Direction`, `ChainageFrom`, `ChainageTo`.
- Asset state fields: `Stage`, `AssetCondition`, `AssetCriticality`, `AssetRisk`, `ConditionDate`.

What is not mature:

- No documented active job table.
- `uvw_inspection` was truncated and is not confirmed.
- No documented latitude, longitude, or WKT in the asset view.

Next maturity step: complete inspection metadata and identify the active AKLW job/work-order source.

### `transport_fndc`

Current maturity: **2.4 / 5**

FNDC is mature for road-network reference and geospatial enrichment, but immature for operational activity analysis.

What is mature:

- Road centreline and road attributes from `byo_tbl_national_road_cl_nz`.
- Road names, road IDs, ONRC class, surface type, width, traffic volume.
- NZTM start/end coordinate fields.

What is not mature:

- No documented work-order source.
- No documented defects or inspections.
- No live asset condition source beyond road attributes such as surface type.

Next maturity step: locate FNDC active work-order, defect, and inspection sources before using it for enterprise operations.

### `transport_nel`

Current maturity: **2.7 / 5**

NEL has rich data, but it appears upload/KPI oriented. The main maturity issue is not column richness; it is governance and source-of-truth confidence.

What is mature:

- Rich asset classification: asset type, discipline, component, element type, Uniclass fields.
- Asset dimensions and physical properties.
- Condition rating and pre-condition fields.
- Work-order upload with target and actual dates.

What is not mature:

- Upload cadence and owner are not documented.
- Source-of-truth status is not confirmed.
- Defect taxonomy is weak.
- Inspection register is missing.

Next maturity step: confirm upload cadence, owner, reconciliation process, and whether KPI tables are accepted operational sources.

### `transport_ramc`

Current maturity: **3.6 / 5**

RAMC is currently the strongest documented contract-specific operational source. It has jobs, defects, WKT, and pavement condition-style fields.

What is mature:

- `uvw_stripmap_jobs` has job IDs, SAP work orders, hazard codes, defect codes, activity/intervention fields, dates, status, and chainage.
- `uvw_stripmap_wkt` provides WKT and pavement classes.
- Backlog snapshot/change tables support backlog movement analysis.

What is not mature:

- No complete standalone asset master is documented.
- Condition coverage is pavement/stripmap oriented, not all-asset.
- Some referenced stripmap/full objects remain undocumented.

Next maturity step: complete missing stripmap/full asset documentation and map RAMC pavement condition to enterprise condition scales.

### `transport_sht`

Current maturity: **2.6 / 5**

SHT is mature for inspection compliance, but not for enterprise asset or defect analysis from the documented sources.

What is mature:

- `uvw_ai1` has inspection ID, route, type, asset name/code, assigned user, scheduled date, due date, completed date, WBS, WO, compliance flag, and failure reason.
- Sensor and weather tables are documented.

What is not mature:

- No documented asset master.
- SHT job view was truncated.
- No documented asset geospatial source.
- Defect/action analysis is not supported without another active job source.

Next maturity step: complete the truncated SHT job and inspection objects, then locate active asset and geospatial sources.

### `transport_srapc`

Current maturity: **2.1 / 5**

SRAPC currently looks more like reference and maintenance strategy context than a ready operational source.

What is mature:

- Civil maintenance master data exists.
- TACP constants and mapping tables exist.
- Weather observations are documented.

What is not mature:

- `uvw_a_bridge_all_data` was truncated and not verified.
- A TACP/export view was truncated and not verified.
- No confirmed active work-order, inspection, or geospatial source.

Next maturity step: obtain complete metadata for the bridge/all-data and TACP/export views, then validate whether they are active operational sources.

### `transport_tsrc`

Current maturity: **3.2 / 5**

TSRC is strong for bridge asset enrichment and traffic/incident context, but it is not a general all-asset operational source.

What is mature:

- `utbl_aed_asset_bridge` includes bridge identity, road ID, chainage, dimensions, material, condition, L2 inspection date, latitude, longitude, and WKT.
- Incident, closure, event, and traffic volume tables are documented.

What is not mature:

- General asset master across all asset classes is not documented.
- Incident/closure data is not the same as a work-order source.
- Some incident/KPI objects were truncated.

Next maturity step: separate bridge asset maturity from broader TSRC asset maturity and locate active work-order/defect sources beyond closures.

### `transport_wru`

Current maturity: **3.2 / 5**

WRU has useful operational and traffic-counter data, but complete asset inventory and inspections are still incomplete from the documented state.

What is mature:

- `vw_job_export_final` provides job/action fields.
- `utbl_counter_locations` provides counter asset data, condition, risk, latitude, longitude, WKT, lanes, and speed zone.
- Traffic counts and timesheets are documented.

What is not mature:

- Full asset master is not documented.
- `utbl_inspection_road_sections` was truncated.
- Defect taxonomy still needs standardisation.

Next maturity step: complete inspection road section metadata and locate the active WRU full asset inventory source.

## Overall Conclusion

The current maturity profile supports an enterprise discovery and enrichment roadmap, not a production enterprise asset master.

The immediate path is:

1. Treat `utbl_jobs_allcontract` as decommissioned/historical only.
2. Find active work-order and defect sources by contract or a replacement all-contract feed.
3. Build contract-specific enrichment views where data is strong.
4. Standardise mappings for asset IDs, asset type, condition, defect, inspection, and geometry.
5. Create the enterprise asset master only after active asset inventory coverage is confirmed.

## Related Pages

- [[Transport Enterprise Current State Visuals]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
