---
type: analysis-summary
topic: Ventia
sector: Transport
analysis: asset-type-metrics
date-created: 2026-06-17
date-updated: 2026-06-17
tags: [transport, data-tables, asset-vision, databricks, asset-type-metrics]
---

# Transport Asset Type Metrics and Attributes

Generated from live Databricks validation at `2026-06-17T07:45:45+00:00` using the Databricks CLI OAuth profile `ventia-transport` and SQL warehouse `e736bc08efffb739`.

This page summarizes what data is available by standardised asset type, what attributes and metrics can be pulled, and how generated metrics are formulated. It is intentionally asset-type-level rather than only source-table-level because WKT geometry, linear reference fields, condition/risk/criticality fields, custom attributes, jobs, inspections, capital works, and photo evidence vary materially by raw Asset Vision asset type and source context.

## Executive Summary

- Live validation returned `645,806` non-deleted source assets across `7` active Asset Vision source labels.
- Raw `asset.AssetType` values were standardised into `227` standardised asset type rows from `245` raw source asset-type labels.
- The standardised naming layer comes from `analysis/deterioration-analysis/create_asset_type_category_map.sql`; `0` standardised rows still use the fallback `Other / Unclassified` mapping and should be manually reviewed before being treated as final taxonomy.
- WKT is validated from `vassetlocation.WKT`, not from `asset.SpatialType`; an asset type can have a source spatial type value and still have no usable WKT, or can have mixed WKT geometry types.
- Generated operational metrics are relationship proxies, not contract KPI definitions. They are valid for triage and data-product design, but formal KPI reporting needs contract-specific SLA rules, due-date rules, inspection schedules, and status definitions.

## Skipped / Limited Sources

| Source context | Catalog | Reason |
|---|---|---|
| `asset_vision_ven_rms_old` | `ext_mssql_asset_vision_ven_rms_old` | Statement failed: [TABLE_OR_VIEW_NOT_FOUND] The table or view `ext_mssql_asset_vision_ven_rms_old`.`information_schema`.`tables` cannot be found. Verify the spelling and correctness of the schema and catalog. |

## Source Tables Used

| Source table | What it contributes | Asset-type use |
|---|---|---|
| `*.dbo.asset` | Asset identity, raw asset type, contract, source classification, source spatial type, parent asset, chainage, lifecycle fields, condition, criticality, risk | Base denominator and core attribute coverage by asset type |
| `*.dbo.vassetlocation` | WKT, spatial information, location chainage/direction | WKT coverage, geometry type, valid-Australia coordinate proxy, location-row coverage |
| `*.dbo.assetattribute` | Custom name/value attributes by asset | Attribute coverage, distinct custom attribute name counts, example attribute names |
| `*.dbo.job` | Direct asset-linked jobs, due date, completed date | Linked job count, assets with jobs, job completion/overdue proxy |
| `*.dbo.jobasset` | Many-to-many job-to-asset links | Adds job coverage where jobs are related through bridge records rather than direct `job.AssetID` |
| `*.dbo.inspection` | Asset-linked inspections, scheduled dates, completed date | Inspection coverage, inspection completion/overdue proxy |
| `*.dbo.capitalwork` | Asset-linked capital works, planned/actual dates | Capital-work coverage and completed capital-work count |
| `*.dbo.photo` | Direct photos for assets and photos attached to jobs | Evidence/photo coverage by asset type |

## Databricks Tables Published

The same run publishes dashboard-ready Delta tables to `transport_dev.integ_transport_assets` with the `atm_` prefix.

| Table | Rows | Grain | Dashboard use |
|---|---:|---|---|
| `transport_dev.integ_transport_assets.atm_asset_type_metrics_summary` | 227 | standardised asset type | Primary dashboard table with numeric coverage rates. |
| `transport_dev.integ_transport_assets.atm_asset_type_metrics_detail` | 421 | source context + contract + raw asset type | Drill-down table for raw Asset Vision type/source/contract slices. |
| `transport_dev.integ_transport_assets.atm_asset_type_source_contract_breakdown` | 421 | standardised asset type + source + contract | Source/contract coverage matrix. |
| `transport_dev.integ_transport_assets.atm_asset_type_mapping` | 245 | raw asset type | Raw-to-standardised naming audit. |
| `transport_dev.integ_transport_assets.atm_metric_dictionary` | 20 | metric definition | Definitions and caveats for dashboard tooltips or documentation. |
| `transport_dev.integ_transport_assets.atm_run_status` | 8 | source context refresh status | Refresh status, skipped contexts, and loaded asset counts. |

## Metric Dictionary

| Metric / attribute | Source columns | Formula used here | Caveat |
|---|---|---|---|
| Standardised asset type | `analysis/deterioration-analysis/create_asset_type_category_map.sql`; raw `asset.AssetType` | Manual mapping by raw `AssetType`; fallback keeps live raw value and marks it `Other / Unclassified`. | Created classification layer. Review fallback rows before using as a final taxonomy. |
| Asset count | `*.dbo.asset.ID` | `COUNT(DISTINCT asset.ID)` where `COALESCE(asset.Deleted, false) = false`. | Base denominator for most asset-type rates. |
| Source / contract coverage | `asset.Contract`; source catalog label | Distinct source contexts and contracts where the asset type is present. | Blank source contract is replaced by source context to keep the grain explicit. |
| Classification coverage | `asset.Classification` | Assets with non-empty classification divided by asset count; distinct examples retained. | Classification is source-populated, not the same as the manual standardised asset category. |
| Spatial type values | `asset.SpatialType` | Distinct non-empty source spatial type values by asset type. | Useful because WKT geometry can differ by asset type and by source. |
| WKT coverage | `vassetlocation.WKT` joined by `AssetID` | Assets with at least one non-empty WKT divided by asset count. | Generated metric. WKT lives in the view-style location table, not the base `asset` table. |
| Valid AU coordinate coverage | `vassetlocation.WKT` | Extract first numeric coordinate pair from WKT and count assets where lon is 112..180 and lat is -48..-9. | Generated proxy for map-readiness; line/polygon assets use first coordinate only. |
| WKT geometry type | `vassetlocation.WKT` | Uppercase first token of WKT, such as `POINT`, `LINESTRING`, `POLYGON`, or `MULTIPOLYGON`. | Generated parser; does not validate full geometry syntax. |
| Condition / criticality / risk coverage | `asset.AssetCondition`, `asset.AssetCriticality`, `asset.AssetRisk` | Assets with non-empty field divided by asset count. | Source-populated attributes. Values are not harmonised in this run. |
| Chainage coverage | `asset.ChainageFrom`, `asset.ChainageTo` | Assets with either chainage endpoint populated divided by asset count. | Source-populated linear-reference availability metric. |
| Chainage length km proxy | `asset.ChainageFrom`, `asset.ChainageTo` | `SUM(ABS(ChainageTo - ChainageFrom) / 1000)` where both endpoints exist, delta is positive, and delta is less than 1,000,000. | Generated metric. Treat as a proxy because source units and route semantics can vary. |
| Parent asset coverage | `asset.ParentAssetID` | Assets with a parent asset ID divided by asset count. | Source-populated hierarchy metric. |
| Lifecycle/commercial coverage | `asset.ConstructionDate`, `asset.ConstructionCost`, `asset.UsefulLife`, `asset.ConditionDate` | Assets with non-empty lifecycle/commercial fields divided by asset count. | Source-populated; availability can vary sharply by asset type. |
| Custom attribute coverage | `assetattribute.AssetID`, `assetattribute.Name`, `assetattribute.Value` | Assets with at least one non-deleted attribute divided by asset count; counts rows and distinct attribute names. | Source-populated custom attributes. Attribute semantics are not normalised here. |
| Job coverage | `job.AssetID`, `jobasset.AssetID`, `job.ID` | Assets linked to at least one job divided by asset count; job count is distinct linked jobs. | Generated relationship metric; uses both direct job asset ID and many-to-many `jobasset` links. Counts are standardised from source-contract/raw-type slices. |
| Open overdue job count | `job.DueDate`, `job.CompletedDate` | Distinct linked jobs where `CompletedDate IS NULL AND DueDate < current_timestamp()`. | Generated operational proxy, not a contract KPI. |
| Inspection coverage | `inspection.AssetID`, `inspection.ID` | Assets linked to at least one inspection divided by asset count; inspection count is distinct inspections. | Generated relationship metric from the inspection table. |
| Open overdue inspection count | `inspection.ScheduledDateTo`, `inspection.ScheduledDate`, `inspection.CompletedDate` | Distinct linked inspections where open and scheduled due date is in the past. | Generated proxy, not a contract-specific inspection KPI. |
| Capital work coverage | `capitalwork.AssetID`, `capitalwork.ID` | Assets linked to at least one capital work record divided by asset count. | Generated relationship metric from source Asset Vision capital works. |
| Photo/evidence coverage | `photo.SourceTable`, `photo.SourceTableID` | Assets with direct asset photos plus assets whose linked jobs have job photos. | Generated evidence proxy. Direct asset photos and job photos are reported separately. |

## Top Asset Types by Volume

| Standardised asset type | Category | Assets | Sources | WKT assets | Valid AU coord | Condition | Criticality | Risk | Jobs / asset | Inspections / asset | Notes |
|---|---|---:|---|---:|---:|---:|---:|---:|---:|---:|---|
| Linemarking Condition | Line Marking / Delineation | 72,637 | VicRoads | 72,637 (100.0%) | 72,637 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 39 custom attribute names |
| Minor Sign | Signs / Roadside Information | 60,077 | RMS; RMS new; VicRoads | 60,077 (100.0%) | 60,077 (100.0%) | 38.6% | 22.9% | 0.0% | 0.47 | 0.00 | 78 custom attribute names |
| Raised Reflective Pavement Marker | Line Marking / Delineation | 47,531 | VicRoads | 47,531 (100.0%) | 47,531 (100.0%) | 99.8% | 0.0% | 0.0% | 0.00 | 0.00 | 4 custom attribute names |
| Line Marking | Line Marking / Delineation | 29,158 | RAMC / BAC / PoB / TSRC group; VNZ; VicRoads | 29,158 (100.0%) | 29,158 (100.0%) | 78.1% | 68.4% | 0.0% | 0.25 | 0.04 | 94 custom attribute names |
| Kerb and Channel | Kerb / Channel / Road Edge | 27,898 | RAMC / BAC / PoB / TSRC group; VicRoads | 27,898 (100.0%) | 27,898 (100.0%) | 82.4% | 96.0% | 0.0% | 0.14 | 0.03 | 58 custom attribute names |
| Sign | Signs / Roadside Information | 27,448 | RAMC / BAC / PoB / TSRC group; VNZ | 27,444 (100.0%) | 27,444 (100.0%) | 11.3% | 0.0% | 0.0% | 0.02 | 0.03 | 4 assets missing WKT; 114 custom attribute names |
| Pit | Drainage / Stormwater | 27,321 | RAMC / BAC / PoB / TSRC group; VicRoads | 27,321 (100.0%) | 27,321 (100.0%) | 85.7% | 68.2% | 0.0% | 0.54 | 0.58 | 88 custom attribute names |
| Culvert | Drainage / Stormwater | 20,936 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VNZ | 20,935 (100.0%) | 20,935 (100.0%) | 0.0% | 0.0% | 0.0% | 0.07 | 0.16 | 1 assets missing WKT; 212 custom attribute names |
| Stormwater | Drainage / Stormwater | 18,596 | VNZ | 18,596 (100.0%) | 18,596 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 5 custom attribute names |
| Crossing | Footpath / Pedestrian / Access | 16,629 | VNZ | 16,629 (100.0%) | 16,629 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 44 custom attribute names |
| Segment | Road Network / Geometry | 15,783 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VicRoads | 15,689 (99.4%) | 15,689 (99.4%) | 0.0% | 0.0% | 0.0% | 8.87 | 0.03 | 94 assets missing WKT; 158 custom attribute names |
| Streetlight | Lighting / Electrical / Mechanical | 15,332 | RMS; RMS new | 15,332 (100.0%) | 15,332 (100.0%) | 0.0% | 0.0% | 0.0% | 0.35 | 0.06 | 65 custom attribute names |
| Line Marking Symbol | Line Marking / Delineation | 15,051 | RAMC / BAC / PoB / TSRC group; VicRoads | 15,051 (100.0%) | 15,051 (100.0%) | 92.6% | 47.5% | 0.0% | 0.02 | 0.00 | 34 custom attribute names |
| Tree | Vegetation / Landscaping | 12,763 | RAMC / BAC / PoB / TSRC group; VNZ; VicRoads | 12,763 (100.0%) | 12,763 (100.0%) | 59.9% | 57.9% | 0.0% | 0.15 | 0.03 | 90 custom attribute names |
| Channel | Kerb / Channel / Road Edge | 11,639 | VNZ | 11,639 (100.0%) | 11,639 (100.0%) | 0.0% | 0.0% | 0.0% | 0.01 | 0.00 | 40 custom attribute names |
| AED Point Asset | Road Network / Geometry | 10,950 | RAMC / BAC / PoB / TSRC group | 10,950 (100.0%) | 10,950 (100.0%) | 0.0% | 0.0% | 0.0% | 0.14 | 7.49 | 5 custom attribute names |
| School Zone Static Sign | Signs / Roadside Information | 10,458 | RMS; RMS new | 10,458 (100.0%) | 10,458 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.04 | 9 custom attribute names |
| Footpath | Footpath / Pedestrian / Access | 10,184 | RAMC / BAC / PoB / TSRC group; VNZ | 10,184 (100.0%) | 10,184 (100.0%) | 0.0% | 0.0% | 0.0% | 0.01 | 0.00 | 55 custom attribute names |
| Pavement Surfacing | Pavement / Surfacing | 9,524 | RAMC / BAC / PoB / TSRC group; VNZ | 9,524 (100.0%) | 9,524 (100.0%) | 3.8% | 0.0% | 0.0% | 0.00 | 0.00 | 93 custom attribute names |
| PCAS 100m Segment | Road Network / Geometry | 9,065 | RAMC / BAC / PoB / TSRC group | 9,065 (100.0%) | 9,065 (100.0%) | 0.0% | 0.0% | 0.0% | 0.02 | 0.02 | 86 custom attribute names |
| Berm | Kerb / Channel / Road Edge | 8,843 | VNZ | 8,843 (100.0%) | 8,843 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 14 custom attribute names |
| School Zone Sign | Signs / Roadside Information | 8,808 | RMS; RMS new | 8,808 (100.0%) | 8,808 (100.0%) | 0.0% | 0.0% | 0.0% | 6.67 | 1.03 | 75 custom attribute names |
| Pavement Inventory | Pavement / Surfacing | 7,919 | VicRoads | 7,919 (100.0%) | 7,919 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 16 custom attribute names |
| AED Linear Asset | Road Network / Geometry | 5,593 | RAMC / BAC / PoB / TSRC group | 5,593 (100.0%) | 5,593 (100.0%) | 0.0% | 0.0% | 0.0% | 0.10 | 6.97 | 5 custom attribute names |
| Traffic Control Signal Lantern | ITS / Traffic Control | 5,506 | RMS; RMS new | 5,506 (100.0%) | 5,506 (100.0%) | 0.0% | 0.0% | 0.0% | 0.00 | 0.00 | 73 custom attribute names |

## WKT and Geometry Watchlist

These are high-volume standardised asset types with fewer than 50% of assets carrying WKT in the live validation. This does not mean the assets have no spatial reference at all; some may have chainage, parent asset, source spatial type, or source binary `SpatialInfo`, but they are not immediately map-ready through `vassetlocation.WKT`.

| Standardised asset type | Assets | WKT coverage | Valid AU coordinate coverage | Source spatial types | WKT geometry types observed | Chainage coverage |
|---|---:|---:|---:|---|---|---:|
| Structure Component | 1,893 | 0.0% | 0.0% | None |  | 0.0% |

## Full Standardised Asset Type Register

| Category | Subcategory | Standardised asset type | Raw source asset types | Assets | Source labels | Contracts | WKT | Valid AU coord | Condition | Criticality | Risk | Chainage | Parent | Custom attributes | Jobs | Inspections | Photos | Capital works |
|---|---|---|---|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Barriers / Safety Devices | Crash Cushions / End Treatments | Barrier End Terminal | Barrier End Terminal | 188 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 98.9% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 15 names | 20 | 628 | 84 | 0 |
| Barriers / Safety Devices | Crash Cushions / End Treatments | Crash Cushion | Crash Cushions | 135 | RAMC / BAC / PoB / TSRC group | RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.0% | 0.7% | 0.0% | 100.0% | 100.0% | 100.0% / 1 names | 0 | 0 | 632 | 0 |
| Barriers / Safety Devices | Crash Cushions / End Treatments | Impact Absorption Terminal | Impact Absorbtion Terminals | 37 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 48.6% | 48.6% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 8 | 12 | 116 | 0 |
| Barriers / Safety Devices | Fencing | Fence | Fences | 465 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 84.7% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 53 names | 2,267 | 1,753 | 1,775 | 0 |
| Barriers / Safety Devices | Fencing | Fence Gate | Fence Gates | 153 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 15 names | 3 | 603 | 4 | 0 |
| Barriers / Safety Devices | Fencing | Fencing | Fencing | 358 | VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 79.9% | 91.1% | 0.0% | 100.0% | 100.0% | 100.0% / 27 names | 355 | 871 | 2,766 | 0 |
| Barriers / Safety Devices | Railings | Railing | Railings | 919 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 39 names | 5 | 0 | 7 | 0 |
| Barriers / Safety Devices | Safety Barriers / Guardrail | Guardrail | Guardrail | 307 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 13 names | 22 | 0 | 88 | 4 |
| Barriers / Safety Devices | Safety Barriers / Guardrail | Road Barrier | Road Barrier | 605 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 79.2% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 58 names | 55 | 1,864 | 278 | 0 |
| Barriers / Safety Devices | Safety Barriers / Guardrail | Safety Barrier | Safety Barrier | 4,048 | RMS; RMS new | SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC | 99.7% | 99.7% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 46 names | 2,345 | 3,421 | 9,832 | 4 |
| Barriers / Safety Devices | Safety Barriers / Guardrail | Vehicle Barrier | Vehicle Barriers | 1,242 | VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 81.0% | 66.9% | 0.0% | 100.0% | 100.0% | 100.0% / 68 names | 3,139 | 3,172 | 17,831 | 0 |
| Barriers / Safety Devices | Safety Ramps / Arrestor Beds | Arrestor Bed | Arrestor Bed | 2 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 17 names | 15 | 3 | 27 | 0 |
| Barriers / Safety Devices | Safety Ramps / Arrestor Beds | Safety Ramp | Safety Ramp | 2 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 25 names | 8 | 22 | 68 | 0 |
| Communications / Monitoring | Communications Systems | Communication Node | Communication Node | 94 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 420 | 0 | 91 | 0 |
| Communications / Monitoring | Communications Systems | Data Communication System | Data Communication Systems | 12 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 0.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% / 71 names | 0 | 0 | 0 | 0 |
| Communications / Monitoring | Communications Systems | Motorway Network Communication System | Motorway Network Communication System | 123 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 98.4% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% / 75 names | 13 | 397 | 48 | 0 |
| Communications / Monitoring | Communications Systems | Voice Communication System | Voice Communication Systems | 317 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 40.1% | 21.1% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 26 | 926 | 52 | 2 |
| Communications / Monitoring | Fibre / Communications Conduits | Fibre | Fibre | 15 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 0 | 0 | 0 | 0 |
| Communications / Monitoring | Fibre / Communications Conduits | ITS Conduit | ITS - Conduits | 603 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 99.8% | 99.8% | 100.0% / 46 names | 0 | 0 | 0 | 0 |
| Communications / Monitoring | Monitoring / Control Systems | Control and Monitoring System | Control and Monitorings | 37 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 24.3% | 64.9% | 0.0% | 0.0% | 0.0% | 100.0% / 71 names | 40 | 73 | 86 | 0 |
| Communications / Monitoring | Monitoring / Control Systems | Kurloo Monitoring Point | Kurloo Monitoring points | 11 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 2 names | 0 | 118 | 0 | 0 |
| Communications / Monitoring | Monitoring / Control Systems | Operations Management Control System | Operations Management Control Systems | 78 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 98.7% | 98.7% | 0.0% | 0.0% | 0.0% | 100.0% / 75 names | 6 | 53 | 14 | 0 |
| Communications / Monitoring | Monitoring / Control Systems | Plant Monitoring and Control System | Plant Monitoring and Control Systems | 146 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 39.7% | 91.1% | 0.0% | 0.0% | 0.0% | 100.0% / 71 names | 18 | 226 | 18 | 0 |
| Communications / Monitoring | Monitoring / Control Systems | Warning System | Warning Systems | 150 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 515 | 0 | 148 | 0 |
| Communications / Monitoring | Surveillance Systems | Surveillance and Detection System | Surveillance and Detection Systems | 373 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 70.8% | 54.4% | 0.0% | 0.0% | 0.0% | 100.0% / 83 names | 41 | 1,206 | 119 | 0 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Bridge or Major Culvert | Bridge/Major Culvert | 192 | VicRoads | Initial Rehabilitation Works (IRW); Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA); Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 115 names | 4,745 | 1,929 | 31,000 | 295 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Bridge-size Culvert | Bridge Size Culvert | 232 | RMS; RMS new | SRAP-C; SRAP-C, SRAP-C OOC | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 95 names | 238 | 762 | 1,378 | 0 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Culvert | Culvert | 20,936 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VNZ | Auckland West Transport; Demo Contract, RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - 2019-2024; SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 212 names | 1,478 | 3,327 | 15,558 | 2 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Major Culvert | Major Culvert; Major Culverts | 44 | RAMC / BAC / PoB / TSRC group | Port of Brisbane; Toowoomba Second Range Crossing | 100.0% | 100.0% | 11.4% | 0.0% | 0.0% | 88.6% | 88.6% | 100.0% / 107 names | 101 | 84 | 453 | 0 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Minor Culvert | Minor Culvert; Minor Culverts | 2,572 | RAMC / BAC / PoB / TSRC group; VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 99.7% | 99.7% | 98.4% | 76.3% | 0.0% | 100.0% | 100.0% | 100.0% / 109 names | 1,115 | 1,720 | 5,488 | 0 |
| Drainage / Stormwater | Culverts / Watercourse Crossings | Watercourse Crossing | Water Course Crossings | 96 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 9 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Drains / Channels | Airside Drainage | Airside Drainage | 1 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Drains / Channels | Drainage | Drainage | 1,606 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 12 names | 24 | 1,547 | 2,737 | 13 |
| Drainage / Stormwater | Drains / Channels | Drainage Line | Drainage Lines | 5,055 | VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 23 names | 10 | 0 | 57 | 0 |
| Drainage / Stormwater | Drains / Channels | Drainage System | Drainage Systems | 612 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 97.1% | 0.3% | 0.0% | 0.0% | 0.0% | 100.0% / 82 names | 15 | 1,343 | 36 | 3 |
| Drainage / Stormwater | Drains / Channels | Open Drainage | Open Drainage | 38 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 40 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Drains / Channels | Subsoil Drain | Subsoil Drains | 2,607 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 37.4% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 37 names | 63 | 5,845 | 222 | 0 |
| Drainage / Stormwater | Drains / Channels | Subsoil Drain Outlet | Subsoil Drain Outlets | 1,634 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 99.9% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 15 names | 4 | 3,324 | 11 | 0 |
| Drainage / Stormwater | Drains / Channels | Table Drain | Table Drain | 1,364 | RAMC / BAC / PoB / TSRC group; VicRoads | Brisbane Airport; Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); RAMC - Gen 2 - 2019-2024; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 62.2% | 60.3% | 0.0% | 65.6% | 65.6% | 100.0% / 51 names | 800 | 2,090 | 4,878 | 0 |
| Drainage / Stormwater | Drains / Channels | Table Drain - AGAZ | Table Drain-AGAZ | 826 | RAMC / BAC / PoB / TSRC group | RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 29 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Drains / Channels | Table Drain - GAZ | Table Drain-GAZ | 1,757 | RAMC / BAC / PoB / TSRC group | RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.1% | 0.1% | 0.0% | 100.0% | 100.0% | 100.0% / 31 names | 277 | 0 | 4,791 | 0 |
| Drainage / Stormwater | Drains / Channels | Table Drain - TSRC | Table Drain (TSRC) | 1,750 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 99.9% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 60 names | 669 | 5,911 | 5,259 | 0 |
| Drainage / Stormwater | Drains / Channels | Trench Drain | Trench Drain | 1 | RAMC / BAC / PoB / TSRC group | RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 0 | 0 | 1 | 0 |
| Drainage / Stormwater | Pipes / Valves | Penstock | Penstock | 1 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 3 | 0 | 12 | 0 |
| Drainage / Stormwater | Pipes / Valves | Pipe | Pipe | 3,632 | RAMC / BAC / PoB / TSRC group | Demo Contract, RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.1% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 58 names | 2,012 | 40 | 43,285 | 1 |
| Drainage / Stormwater | Pipes / Valves | Valve | Valves | 5 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 5 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Pits / Inlets | Field Inlet | Field Inlet | 397 | RAMC / BAC / PoB / TSRC group | Demo Contract; Demo Contract, RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.5% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 23 names | 409 | 0 | 2,157 | 0 |
| Drainage / Stormwater | Pits / Inlets | Gully Pit | Gully Pit | 4,659 | RAMC / BAC / PoB / TSRC group | Demo Contract; Demo Contract, RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - 2019-2024 | 100.0% | 100.0% | 0.1% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 22 names | 6,150 | 0 | 25,779 | 0 |
| Drainage / Stormwater | Pits / Inlets | Pit | Pit | 27,321 | RAMC / BAC / PoB / TSRC group; VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 85.7% | 68.2% | 0.0% | 100.0% | 100.0% | 100.0% / 88 names | 14,737 | 15,753 | 76,303 | 3 |
| Drainage / Stormwater | Pollution / Debris Capture | Gross Pollutant Trap | Gross Pollutant Traps | 20 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 40 | 0 | 282 | 0 |
| Drainage / Stormwater | Pollution / Debris Capture | Spill Capture | Spill Captures | 5 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 3 names | 9 | 0 | 50 | 0 |
| Drainage / Stormwater | Pollution / Debris Capture | Trash Rack | Trash Racks | 14 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 79 | 0 | 294 | 0 |
| Drainage / Stormwater | Pumps / Hydraulic Controls | Hydraulic Treatment and Pumping System | Hydraulic Treatment and Pumping Systems | 66 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 74.2% | 28.8% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 83 | 904 | 149 | 1 |
| Drainage / Stormwater | Pumps / Hydraulic Controls | Pump Station | Pump Station | 2 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 47 names | 4 | 64 | 46 | 0 |
| Drainage / Stormwater | Rain Gardens | Stormwater Rain Garden | SW Rain Gardens | 169 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 6 names | 0 | 0 | 0 | 0 |
| Drainage / Stormwater | Stormwater Systems / Treatment | Stormwater | Storm Waters | 18,596 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 60 | 0 | 258 | 0 |
| Drainage / Stormwater | Stormwater Systems / Treatment | Stormwater Quality Improvement | Stormwater Quality Improvement | 62 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 28 names | 170 | 240 | 1,354 | 0 |
| Earthworks / Geotechnical | Slopes / Embankments | Embankment | Embankments | 168 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 100.0% | 100.0% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 9 | 32 | 185 | 0 |
| Earthworks / Geotechnical | Slopes / Embankments | Embankment Monitoring | Embankment Monitoring | 721 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 40 names | 17 | 655 | 16 | 0 |
| Earthworks / Geotechnical | Slopes / Embankments | Slope | Slope | 2,220 | RAMC / BAC / PoB / TSRC group; RMS; RMS new | SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC; Toowoomba Second Range Crossing | 98.8% | 98.8% | 11.3% | 0.1% | 0.0% | 100.0% | 100.0% | 100.0% / 116 names | 454 | 3,284 | 2,339 | 7 |
| Environment / Monitoring | Air Monitoring | Air Monitoring System | Air Monitoring Systems | 27 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 100.0% | 33.3% | 0.0% | 0.0% | 0.0% | 100.0% / 75 names | 8 | 114 | 18 | 0 |
| Environment / Monitoring | Water Quality | Water Quality | Water Quality | 32 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 78 names | 19 | 64 | 114 | 0 |
| Facilities / Buildings | Building Components | Door and Frame | Doors and Frames | 4 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 6 names | 20 | 0 | 0 | 0 |
| Facilities / Buildings | Buildings / Depots | Building | Building; Buildings | 2 | RAMC / BAC / PoB / TSRC group; VNS | Sydney Harbour Tunnel (SHT); Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 50.0% | 0.0% | 50.0% | 0.0% | 100.0% / 129 names | 10 | 27 | 29 | 0 |
| Facilities / Buildings | Buildings / Depots | Depot | Depot | 9 | RMS; RMS new; VNZ | Auckland West Transport; SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 11.1% | 11.1% | 88.9% / 4 names | 7,968 | 0 | 5,262 | 0 |
| Facilities / Buildings | Buildings / Depots | Disaster Recovery Building | Disaster recovery building | 12 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 3 names | 0 | 0 | 0 | 0 |
| Facilities / Buildings | Buildings / Depots | Other Building Asset | Other Building Assets | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 1 names | 0 | 0 | 0 | 0 |
| Facilities / Buildings | Control Rooms | TCC Operation Room | TCC Operation Room | 14 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 3 names | 0 | 0 | 0 | 0 |
| Facilities / Buildings | Control Rooms | TCC Server Room | TCC Server Room | 22 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 5 names | 3 | 5 | 0 | 0 |
| Facilities / Buildings | Yards / Wash Bays | Compound Yard/Outer Grounds | Compound Yard/Outer Grounds | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 1 names | 5 | 0 | 23 | 0 |
| Facilities / Buildings | Yards / Wash Bays | Wash Bay | Wash Bay | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 0.0% / 0 names | 2 | 4 | 8 | 0 |
| Footpath / Pedestrian / Access | Access Points | Access Point | AP - Access Points | 34 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 68 names | 18 | 0 | 18 | 0 |
| Footpath / Pedestrian / Access | Access Ramps | Boat Ramp | Boat Ramps | 3 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 1 names | 19 | 0 | 70 | 0 |
| Footpath / Pedestrian / Access | Crossings | Crossing | Crossings | 16,629 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 44 names | 1 | 0 | 0 | 0 |
| Footpath / Pedestrian / Access | Crossings | Vehicle Crossing | Vehicle Crossings | 8 | RAMC / BAC / PoB / TSRC group; VNZ | Auckland West Transport; Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 32 names | 4 | 7 | 0 | 0 |
| Footpath / Pedestrian / Access | Cycleways | Cycleway | Cycleway | 2 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 36 names | 16 | 2 | 124 | 0 |
| Footpath / Pedestrian / Access | Footpaths / Pathways | Footpath | Footpath; Footpaths | 10,184 | RAMC / BAC / PoB / TSRC group; VNZ | Auckland West Transport; Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 93.8% | 93.8% | 100.0% / 55 names | 95 | 28 | 346 | 5 |
| Footpath / Pedestrian / Access | Footpaths / Pathways | Pathway | Pathway; Pathways | 190 | RAMC / BAC / PoB / TSRC group; VicRoads | Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 98.4% | 87.9% | 0.0% | 95.8% | 98.4% | 100.0% / 72 names | 631 | 761 | 4,167 | 0 |
| ITS / Traffic Control | Bluetooth / Tolling | Bluetooth Beacon | Bluetooth Beacon | 829 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 3,020 | 0 | 866 | 0 |
| ITS / Traffic Control | Bluetooth / Tolling | Bluetooth Device | ITS - Bluetooth Device | 10 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Bluetooth / Tolling | Tolling Point | ITS - Tolling Point | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 8 names | 1 | 0 | 0 | 0 |
| ITS / Traffic Control | Cameras / CCTV | Closed Circuit Television | Close Circuit Television; ITS - CCTV | 1,041 | RAMC / BAC / PoB / TSRC group; VentureSmart | Toowoomba Second Range Crossing; VentureSmart | 100.0% | 100.0% | 1.9% | 0.0% | 0.0% | 0.0% | 1.9% | 100.0% / 14 names | 3,799 | 187 | 2,746 | 0 |
| ITS / Traffic Control | Cameras / CCTV | QPS Camera | ITS - QPS Camera | 10 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 11 names | 1 | 0 | 0 | 0 |
| ITS / Traffic Control | Cameras / CCTV | Webcam | ITS - Webcam | 4 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 1 | 0 | 2 | 0 |
| ITS / Traffic Control | Detection / Classification | Infrared Traffic Logger | TIRTL - Infra Red Traffic Logger | 38 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 59 names | 176 | 38 | 352 | 0 |
| ITS / Traffic Control | Detection / Classification | Over-height Detection System | OHDS - Over Height Detection Systems | 32 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 48 | 26 | 432 | 0 |
| ITS / Traffic Control | Detection / Classification | Over-speed Detection System | OSDS - Over Speed Detection Systems | 170 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 58 names | 156 | 162 | 1,162 | 4 |
| ITS / Traffic Control | Detection / Classification | Traffic Measurement System | Traffic Measurement System | 2 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 100.0% | 100.0% | 0.0% | 100.0% | 100.0% | 100.0% / 10 names | 2 | 0 | 39 | 0 |
| ITS / Traffic Control | Detection / Classification | Traffic Monitoring Unit | TMU - Traffic Monitoring Unit | 126 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 65 names | 530 | 100 | 4,422 | 0 |
| ITS / Traffic Control | Detection / Classification | Vehicle Detection Station | Vehicle Detection Station | 745 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 1,894 | 0 | 650 | 0 |
| ITS / Traffic Control | Detection / Classification | Vehicle Detection and Classification System | VDCS - Vehicle Detection & Classification System | 624 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 66 names | 272 | 334 | 2,900 | 0 |
| ITS / Traffic Control | Detection / Classification | Vehicle Detector and Classifier | ITS - Vehicle Detector and Classifier | 21 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 11 names | 119 | 67 | 3 | 0 |
| ITS / Traffic Control | Detection / Classification | Weigh in Motion | WIM - Weigh in Motion | 26 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 70 names | 62 | 28 | 458 | 0 |
| ITS / Traffic Control | Emergency Phones | Emergency Phone | METS - Emergency Phones | 792 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 38 names | 2,040 | 634 | 6,414 | 0 |
| ITS / Traffic Control | Emergency Phones | Help Phone | Help Phone | 614 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 2,166 | 0 | 74 | 0 |
| ITS / Traffic Control | ITS Field Infrastructure | ITS Electrical and Communications Pit | ITS - Elec & Coms Pits | 1,211 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 19 names | 5 | 0 | 7 | 0 |
| ITS / Traffic Control | ITS Field Infrastructure | ITS Field Cabinet | ITS - Field Cabinet | 48 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 36 names | 22 | 238 | 35 | 0 |
| ITS / Traffic Control | Traffic Control Systems | Lane Use Management System | Lane Use Management System | 36 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Control Systems | Ramp Metering Control Signal | RMCS - Ramp Metering Control Signals | 16 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 19 names | 2 | 0 | 24 | 0 |
| ITS / Traffic Control | Traffic Control Systems | Traffic Facilities | Traffic Facilities | 626 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 36 names | 1 | 0 | 7 | 0 |
| ITS / Traffic Control | Traffic Control Systems | Traffic Management Device | Traffic Management Device | 34 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 82.4% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 54 names | 9 | 40 | 5 | 0 |
| ITS / Traffic Control | Traffic Control Systems | Traffic Management System | Traffic Management System | 18 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 100.0% | 100.0% | 0.0% | 100.0% | 100.0% | 100.0% / 7 names | 21 | 0 | 279 | 8 |
| ITS / Traffic Control | Traffic Monitoring / Weather | Road Weather Information System | RWIS - Road Weather Info Systems | 8 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Monitoring / Weather | Road Weather Monitoring System | ITS - Road Weather Monitoring System | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 1 | 22 | 0 | 0 |
| ITS / Traffic Control | Traffic Signals | Ramp Signal Controller | Ramp Signal Controller | 31 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Signals | Traffic Control Signal | TCS - Traffic Control Signals | 1,894 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 82 names | 57,652 | 2,776 | 380,031 | 48 |
| ITS / Traffic Control | Traffic Signals | Traffic Control Signal Lantern | TCS (Lanterns) | 5,506 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 73 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Signals | Traffic Control Signal Loop | TCS (Loops) | 2,690 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 7 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Signals | Traffic Control Signal Post | TCS (Post) | 3,942 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 25 names | 0 | 0 | 0 | 0 |
| ITS / Traffic Control | Traffic Signals | Traffic Signal | Traffic Signals | 1,318 | RAMC / BAC / PoB / TSRC group; VentureSmart | Toowoomba Second Range Crossing; VentureSmart | 100.0% | 100.0% | 10.9% | 0.0% | 0.0% | 10.9% | 10.9% | 100.0% / 76 names | 5,835 | 278 | 8,283 | 0 |
| Kerb / Channel / Road Edge | Kerb and Channel | Channel | Channel | 11,639 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 40 names | 154 | 0 | 1,035 | 0 |
| Kerb / Channel / Road Edge | Kerb and Channel | Kerb | Kerbs | 898 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 12 names | 0 | 0 | 0 | 3 |
| Kerb / Channel / Road Edge | Kerb and Channel | Kerb and Channel | Kerb and Channel | 27,898 | RAMC / BAC / PoB / TSRC group; VicRoads | Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 82.4% | 96.0% | 0.0% | 100.0% | 100.0% | 100.0% / 58 names | 3,860 | 901 | 15,091 | 0 |
| Kerb / Channel / Road Edge | Shoulders / Berms | Berm | Berms | 8,843 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 14 names | 6 | 0 | 13 | 0 |
| Kerb / Channel / Road Edge | Shoulders / Berms | Road Shoulder | Road Shoulder | 581 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 98.3% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 7 names | 839 | 0 | 5,248 | 0 |
| Kerb / Channel / Road Edge | Shoulders / Berms | Shoulder | Shoulders | 323 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 49 names | 5 | 0 | 27 | 0 |
| Lighting / Electrical / Mechanical | Electrical Distribution | Distribution Board | Distribution Boards | 32 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 1 names | 0 | 0 | 0 | 0 |
| Lighting / Electrical / Mechanical | Electrical Distribution | Electrical | Electrical | 3 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 8 names | 0 | 12 | 0 | 0 |
| Lighting / Electrical / Mechanical | Electrical Distribution | ITS Switchboard | ITS - Switchboard | 27 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 32 names | 4 | 25 | 4 | 0 |
| Lighting / Electrical / Mechanical | Electrical Distribution | Low Voltage System | Low Voltage Systems | 251 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 87.3% | 41.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 17 | 1,715 | 30 | 1 |
| Lighting / Electrical / Mechanical | Fire Systems | Fire Detection and Suppression System | Fire Detection and Suppression Systems | 1,859 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 70.3% | 58.6% | 0.0% | 0.0% | 0.0% | 100.0% / 80 names | 69 | 9,892 | 201 | 6 |
| Lighting / Electrical / Mechanical | Fire Systems | Fire System | Fire Systems | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 0.0% / 0 names | 0 | 0 | 0 | 0 |
| Lighting / Electrical / Mechanical | Fire Systems | Operations and Maintenance Fire System | O&M Fire Systems | 6 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 8 names | 65 | 0 | 0 | 0 |
| Lighting / Electrical / Mechanical | Fire Systems | Passive Fire System | Passive Fire Systems | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 4 names | 10 | 0 | 0 | 0 |
| Lighting / Electrical / Mechanical | Fire Systems | Portable Fire Equipment | Portable Fire Equipment | 31 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 536 | 0 | 0 | 0 |
| Lighting / Electrical / Mechanical | Lighting Assets | Lighting | Lighting | 548 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 62 names | 8 | 0 | 25 | 0 |
| Lighting / Electrical / Mechanical | Lighting Assets | Lighting and Switching System | Lighting and Switching Systems | 674 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 90.9% | 56.2% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 27 | 3,020 | 104 | 3 |
| Lighting / Electrical / Mechanical | Lighting Assets | Road Lighting | Road Lighting | 825 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 3,283 | 0 | 5,297 | 2 |
| Lighting / Electrical / Mechanical | Lighting Assets | Street and Area Lighting | Street & Area Lighting | 637 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 26 names | 38 | 0 | 143 | 0 |
| Lighting / Electrical / Mechanical | Lighting Assets | Streetlight | Streetlight | 15,332 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 65 names | 5,360 | 974 | 40,958 | 14 |
| Lighting / Electrical / Mechanical | Mechanical / HVAC / Ventilation | HVAC | HVAC | 126 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 42.1% | 81.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 20 | 1,163 | 58 | 2 |
| Lighting / Electrical / Mechanical | Mechanical / HVAC / Ventilation | Mechanical | Mechanical | 35 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 322 | 291 | 2 | 0 |
| Lighting / Electrical / Mechanical | Mechanical / HVAC / Ventilation | Ventilation System | Ventilation Systems | 237 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 84.0% | 81.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 24 | 2,973 | 81 | 0 |
| Lighting / Electrical / Mechanical | UPS / Generators | Operations and Maintenance Building Generator | O&M Building Generator | 1 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 3 names | 0 | 1 | 0 | 0 |
| Lighting / Electrical / Mechanical | UPS / Generators | UPS and Generator System | UPS and Generator Systems | 21 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 16 | 631 | 37 | 2 |
| Lighting / Electrical / Mechanical | UPS / Generators | Uninterruptible Power Supply | ITS - UPS | 10 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 10 names | 53 | 132 | 5 | 0 |
| Line Marking / Delineation | General Line Marking | Line Marking | Linemarking; Markings | 29,158 | RAMC / BAC / PoB / TSRC group; VNZ; VicRoads | Auckland West Transport; Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 78.1% | 68.4% | 0.0% | 100.0% | 100.0% | 100.0% / 94 names | 7,178 | 1,135 | 27,991 | 0 |
| Line Marking / Delineation | Line Marking Condition | Linemarking Condition | Linemarking Condition | 72,637 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 39 names | 2 | 0 | 12 | 0 |
| Line Marking / Delineation | Raised Pavement Markers | Raised Reflective Pavement Marker | Linemarking RRPMs | 47,531 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 99.8% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 4 names | 1 | 0 | 4 | 0 |
| Line Marking / Delineation | Symbols / School Zone Markings | Line Marking Symbol | Linemarking Symbols | 15,051 | RAMC / BAC / PoB / TSRC group; VicRoads | Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 92.6% | 47.5% | 0.0% | 100.0% | 100.0% | 100.0% / 34 names | 311 | 0 | 917 | 0 |
| Line Marking / Delineation | Symbols / School Zone Markings | School Zone 40 Patch | SZ 40 Patch | 3,184 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 9 names | 4 | 0 | 4 | 0 |
| Line Marking / Delineation | Symbols / School Zone Markings | School Zone Dragons Teeth | SZ Dragons Teeth | 2,496 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 9 names | 0 | 0 | 0 | 0 |
| Line Marking / Delineation | Symbols / School Zone Markings | School Zone Raised Zebra Crossing | SZ Raised Zebra Crossing | 622 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 9 names | 0 | 0 | 0 | 0 |
| Line Marking / Delineation | Symbols / School Zone Markings | Symbolic Pavement Marking | Symbolic Pavement Marking | 748 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 9 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Paved Areas / Parking | Carpark | Carparks | 343 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 7 names | 453 | 42 | 684 | 31 |
| Pavement / Surfacing | Paved Areas / Parking | Off-road Paved Area | Offroad Paved Area | 83 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 44 names | 4 | 0 | 2 | 0 |
| Pavement / Surfacing | Paved Areas / Parking | Parking | Parking | 51 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 38 names | 16 | 540 | 123 | 0 |
| Pavement / Surfacing | Paved Areas / Parking | Parking Area | Parking Areas | 216 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 9 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Paved Areas / Parking | Paved Area | Paved Areas | 4,139 | VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA); Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 51.6% | 43.6% | 0.0% | 100.0% | 100.0% | 100.0% / 15 names | 4,316 | 4,959 | 21,475 | 0 |
| Pavement / Surfacing | Pavement Inventory / Condition | Pavement Inventory | Pavement Inventory | 7,919 | VicRoads | WRU - DTP Reporting | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 16 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Pavement Inventory / Condition | Road in Good Condition | Roads in Good Condition | 88 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 8 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Pavement Inventory / Condition | Roughness | Roughness | 1 | VicRoads | Ventia - Custom Asset Registers | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 10 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Pavement Structure / Formation | Pavement Structures | Pavement Structures | 4,182 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 15 names | 0 | 0 | 0 | 0 |
| Pavement / Surfacing | Pavement Surface | Pavement | Pavement; Pavements | 5,476 | RAMC / BAC / PoB / TSRC group; VNS; VNZ | Auckland West Transport; Sydney Harbour Tunnel (SHT); Toowoomba Second Range Crossing | 100.0% | 100.0% | 1.8% | 0.0% | 0.0% | 98.2% | 98.2% | 100.0% / 155 names | 453 | 819 | 1,321 | 3 |
| Pavement / Surfacing | Pavement Surface | Pavement Surfacing | Pavement Surfacing; Surfacing | 9,524 | RAMC / BAC / PoB / TSRC group; VNZ | Auckland West Transport; Toowoomba Second Range Crossing | 100.0% | 100.0% | 3.8% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 93 names | 27 | 0 | 114 | 0 |
| Pavement / Surfacing | Road Carriageway | Road | Road; Roads | 2,983 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VNZ; VicRoads | Auckland West Transport; Brisbane Airport; Demo Contract, RAMC - Gen 2 - 2019-2024; Initial Capital Projects (ICP), Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU), WRU - DTP Reporting; Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU), WRU - DTP Reporting; Port of Brisbane; RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - North; +5 more | 98.4% | 98.4% | 0.0% | 0.0% | 0.0% | 4.7% | 4.7% | 98.6% / 41 names | 335,151 | 125,599 | 1,322,553 | 729 |
| Pavement / Surfacing | Unsealed Pavement | Unsealed Pavement | Unsealed | 55 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 28 names | 6 | 0 | 39 | 0 |
| Plant / Vehicles / Equipment | Tools | Tools | Tools | 83 | VNS | Sydney Harbour Tunnel (SHT) | 0.0% | 0.0% | 34.9% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 7 | 207 | 13 | 0 |
| Plant / Vehicles / Equipment | Vehicles | Vehicle | Vehicles | 56 | RAMC / BAC / PoB / TSRC group; VNS | Sydney Harbour Tunnel (SHT); Toowoomba Second Range Crossing | 0.0% | 0.0% | 23.2% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 77 names | 1 | 816 | 1 | 1 |
| Road Network / Geometry | AED Spatial Assets | AED Linear Asset | AED - Linear Assets | 5,593 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 5 names | 536 | 39,008 | 0 | 0 |
| Road Network / Geometry | AED Spatial Assets | AED Point Asset | AED - Point Assets | 10,950 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 5 names | 1,521 | 81,984 | 0 | 0 |
| Road Network / Geometry | AED Spatial Assets | AED Polygon Asset | AED - Polygon Assets | 5,134 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 5 names | 227 | 3,871 | 0 | 0 |
| Road Network / Geometry | Carriageway / Airside Network | Airside | Airside | 13 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 127 | 3 | 417 | 168 |
| Road Network / Geometry | Carriageway / Airside Network | Link Carriageway | Link Carriageway | 1,538 | RMS; RMS new | SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC | 96.5% | 96.5% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 8 names | 80,885 | 206 | 454,935 | 55 |
| Road Network / Geometry | Geometric Features | Feature | Feature | 3,706 | VicRoads | Western Roads Upgrade (WRU) | 99.7% | 99.7% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 7 names | 24 | 1,170 | 1,126 | 0 |
| Road Network / Geometry | Geometric Features | Feature - Old Shape Version | Feature - Old Shape Version | 335 | VicRoads | Western Roads Upgrade (WRU) | 98.8% | 98.8% | 0.0% | 88.4% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 0 | 298 | 0 | 0 |
| Road Network / Geometry | Geometric Features | Strip Map Geometric Feature | Strip Map - Geometric Features | 607 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 8 names | 0 | 0 | 0 | 0 |
| Road Network / Geometry | Network Segments / Sections | PCAS 100m Segment | PCAS 100m Segments | 9,065 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 86 names | 217 | 173 | 0 | 0 |
| Road Network / Geometry | Network Segments / Sections | Section | Sections | 5,106 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 30 names | 47,578 | 0 | 58,248 | 0 |
| Road Network / Geometry | Network Segments / Sections | Segment | Segment; Segments | 15,783 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VicRoads | Demo Contract, RAMC - Gen 2 - 2019-2024; Port of Brisbane; RAMC - Gen 2 - 2019-2024; SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC; Western Roads Upgrade (WRU) | 99.4% | 99.4% | 0.0% | 0.0% | 0.0% | 99.2% | 99.2% | 100.0% / 158 names | 139,922 | 486 | 689,231 | 2 |
| Road Network / Geometry | Operational Areas | PSDR Additional Area | PSDR Additional Areas | 174 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.6% | 100.0% | 0.0% | 100.0% | 100.0% | 100.0% / 6 names | 21 | 0 | 203 | 0 |
| Road Network / Geometry | Ramps / Maintenance Tracks | Maintenance Track | Maintenance Tracks | 525 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 54 names | 123 | 674 | 1,070 | 0 |
| Road Network / Geometry | Ramps / Maintenance Tracks | Ramp | Ramp | 1,854 | RAMC / BAC / PoB / TSRC group | Demo Contract, RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - 2019-2024; RAMC - Gen 2 - North | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 38 names | 624 | 18,741 | 2,589 | 3 |
| Roadside Furniture / Amenities | Litter Baskets | Litter Basket | Litter Baskets | 166 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 5.4% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 7 names | 1,441 | 0 | 3,079 | 0 |
| Roadside Furniture / Amenities | Public Art | Public Art | Public Art | 24 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 95.8% | 87.5% | 0.0% | 100.0% | 100.0% | 100.0% / 14 names | 3 | 4 | 77 | 0 |
| Roadside Furniture / Amenities | Roadside Furniture | Roadside Furniture | Roadside Furnitures | 105 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 89.5% | 3.8% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 8 | 524 | 30 | 0 |
| Roadside Furniture / Amenities | Shelters / Rest Areas | Rest Area | Rest Area | 84 | RMS; RMS new | SRAP-C; SRAP-C, SRAP-C OOC | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 154 names | 31 | 0 | 391 | 0 |
| Roadside Furniture / Amenities | Shelters / Rest Areas | Shelter | Shelters | 954 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 44 names | 24 | 0 | 48 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Changeable Message Sign | CMS - Changeable Message Signs | 2 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 51 names | 0 | 0 | 0 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Electronic Regulatory Sign | RC4 - Electronic Regulatory Signs | 20 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 16 names | 0 | 0 | 0 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Electronic Sign | RC1 - Electronic Signs | 18 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 86 names | 94 | 0 | 618 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Electronic Signage System | Electronic Signage Systems | 380 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 41 | 2,593 | 75 | 2 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Electronic Speed Limit Sign | ESLS(VSS) | 979 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 4,174 | 0 | 730 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Flasher Sign | RC2 - Flasher Signs | 4 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 84 names | 0 | 0 | 0 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Integrated Speed Limit and Lane Usage Sign | ISLUS - Integrated Speed Limit & Lane Usage Sign | 252 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 64 names | 418 | 252 | 2,058 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Variable Message Sign | ITS - Variable Message Sign; VMS - Variable Message Signs; Variable Message Sign | 473 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VentureSmart | SRAP-C; Toowoomba Second Range Crossing; VentureSmart | 100.0% | 100.0% | 1.5% | 0.0% | 0.0% | 0.0% | 1.5% | 100.0% / 82 names | 2,938 | 232 | 18,751 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Variable Message Sign Gantry | Gantries & VMS Signs | 2 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 2 | 0 | 0 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Variable Message Sign Type A | RC3 - Electronic message signs (VMS type A) | 18 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 83 names | 94 | 0 | 634 | 0 |
| Signs / Roadside Information | Electronic / Dynamic Signs | Variable Speed Limit Sign | VSLS - Variable Speed Limit Signs | 206 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 65 names | 116 | 32 | 2,024 | 0 |
| Signs / Roadside Information | Guide / Warning Signs | Advanced Warning Sign | AWS - Advanced Warning Signs | 58 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 3.4% | 0.0% | 0.0% | 0.0% | 100.0% / 51 names | 182 | 42 | 1,872 | 0 |
| Signs / Roadside Information | Guide / Warning Signs | Flood Route Sign | Flood Route Signs | 104 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 14 names | 0 | 0 | 0 | 0 |
| Signs / Roadside Information | Guide / Warning Signs | Guide Sign | Guide Signs | 437 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 99.3% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 7 names | 49 | 0 | 167 | 0 |
| Signs / Roadside Information | Guide / Warning Signs | Guidepost | Guideposts | 2,185 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 5 names | 9 | 0 | 121 | 0 |
| Signs / Roadside Information | School Zone Signs | School Zone | School Zone | 744 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 39 names | 54 | 878 | 162 | 0 |
| Signs / Roadside Information | School Zone Signs | School Zone Sign | SZAS - School Zone Signs | 8,808 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 75 names | 58,750 | 9,096 | 176,594 | 54 |
| Signs / Roadside Information | School Zone Signs | School Zone Static Sign | SZ Static Sign | 10,458 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 9 names | 26 | 458 | 106 | 0 |
| Signs / Roadside Information | Sign Structures | Major Sign Structure | Major Sign Structure; Major Sign Structures | 55 | RAMC / BAC / PoB / TSRC group; VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA); Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Proposed Work Applications (PWA); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 20.0% | 29.1% | 0.0% | 100.0% | 98.2% | 100.0% / 65 names | 189 | 374 | 643 | 28 |
| Signs / Roadside Information | Static Signs | Minor Sign | Minor Sign | 60,077 | RMS; RMS new; VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); SRAP-C; SRAP-C, SRAP-C OOC; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 38.6% | 22.9% | 0.0% | 100.0% | 100.0% | 100.0% / 78 names | 28,149 | 2 | 74,276 | 0 |
| Signs / Roadside Information | Static Signs | Sign | Sign; Signage; Signs | 27,448 | RAMC / BAC / PoB / TSRC group; VNZ | Auckland West Transport; Brisbane Airport; Toowoomba Second Range Crossing | 100.0% | 100.0% | 11.3% | 0.0% | 0.0% | 91.2% | 100.0% | 100.0% / 114 names | 600 | 713 | 1,911 | 0 |
| Structures / Bridges / Tunnels | Bridges | Bridge | Bridge; Bridges | 868 | RAMC / BAC / PoB / TSRC group; RMS; RMS new; VNZ | Auckland West Transport; Port of Brisbane; SRAP-C; SRAP-C OOC; SRAP-C, SRAP-C OOC; Toowoomba Second Range Crossing | 98.8% | 98.8% | 3.6% | 0.0% | 0.0% | 86.6% | 86.6% | 100.0% / 150 names | 2,027 | 1,627 | 14,625 | 9 |
| Structures / Bridges / Tunnels | Bridges | Lift Bridge | Lift Bridges | 2 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 18 names | 20 | 224 | 28 | 0 |
| Structures / Bridges / Tunnels | Gantries | Gantry | Gantries | 1 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 1 | 0 | 13 | 0 |
| Structures / Bridges / Tunnels | Structures / Components | Airside Major Structure | Major Structure Airside | 16 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 9 names | 1 | 0 | 19 | 1 |
| Structures / Bridges / Tunnels | Structures / Components | Art Structure | Art Structure | 1 | RMS | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 63 names | 0 | 0 | 0 | 0 |
| Structures / Bridges / Tunnels | Structures / Components | Landside Major Structure | Major Structure Landside | 51 | RAMC / BAC / PoB / TSRC group | Brisbane Airport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 9 names | 22 | 0 | 128 | 6 |
| Structures / Bridges / Tunnels | Structures / Components | Minor Structure | Minor Structures | 763 | VNZ | Auckland West Transport | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 7 names | 1 | 0 | 2 | 0 |
| Structures / Bridges / Tunnels | Structures / Components | Structural Component | Structural Component | 2,087 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 62 names | 2 | 0 | 7 | 0 |
| Structures / Bridges / Tunnels | Structures / Components | Structure | Structures | 266 | RAMC / BAC / PoB / TSRC group; VNS | Sydney Harbour Tunnel (SHT); Toowoomba Second Range Crossing | 100.0% | 100.0% | 93.6% | 15.8% | 0.0% | 0.4% | 0.4% | 100.0% / 148 names | 98 | 5,794 | 253 | 10 |
| Structures / Bridges / Tunnels | Structures / Components | Structure Component | Structure Components | 1,893 | VicRoads | Western Roads Upgrade (WRU) | 0.0% | 0.0% | 92.0% | 0.0% | 0.0% | 0.0% | 99.9% | 100.0% / 39 names | 0 | 0 | 0 | 0 |
| Structures / Bridges / Tunnels | Structures / Components | Support Structure | Support Structure | 1,332 | RMS; RMS new | SRAP-C; SRAP-C, SRAP-C OOC | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 98.3% | 98.3% | 100.0% / 63 names | 544 | 1,958 | 2,740 | 0 |
| Structures / Bridges / Tunnels | Tunnels | Tunnel | Tunnels | 1,499 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 6.1% | 79.7% | 0.0% | 0.0% | 0.0% | 100.0% / 77 names | 147 | 3,494 | 142 | 6 |
| Structures / Bridges / Tunnels | Tunnels | Tunnel Structure | Tunnel Structure | 4 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 95 names | 52 | 116 | 252 | 0 |
| Structures / Bridges / Tunnels | Walls | Noise Wall | Noise Wall | 288 | RMS; RMS new; VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); SRAP-C; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 9.7% | 9.7% | 100.0% / 112 names | 442 | 727 | 2,535 | 11 |
| Structures / Bridges / Tunnels | Walls | Retaining Wall | Retaining Wall | 869 | RAMC / BAC / PoB / TSRC group; VNZ; VicRoads | Auckland West Transport; Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA); Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.6% | 0.6% | 0.0% | 100.0% | 100.0% | 100.0% / 138 names | 510 | 422 | 4,084 | 41 |
| Third Party / Temporary / Other | Miscellaneous / Other | Miscellaneous | Miscellaneous | 5 | VentureSmart | VentureSmart | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 4 names | 0 | 0 | 0 | 0 |
| Third Party / Temporary / Other | Miscellaneous / Other | Other Item | Other Items | 23 | VNS | Sydney Harbour Tunnel (SHT) | 100.0% | 100.0% | 65.2% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 78 names | 7 | 348 | 9 | 0 |
| Third Party / Temporary / Other | Sites / Stockpiles | Bid Site | Bid Site | 1 | VicRoads | Melton City Council | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% / 0 names | 1 | 1 | 2 | 0 |
| Third Party / Temporary / Other | Sites / Stockpiles | Stockpile Site | Stockpile Sites | 42 | RAMC / BAC / PoB / TSRC group | RAMC - Gen 2 - North | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 15 names | 0 | 0 | 106 | 0 |
| Third Party / Temporary / Other | Temporary Assets | Temporary Asset | Temporary Asset | 82 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 7.3% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 10 names | 0 | 0 | 64 | 0 |
| Third Party / Temporary / Other | Third Party Works | Third Party Work - Consent | Third Party Works (Consents) | 11 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 9.1% | 0.0% | 100.0% | 100.0% | 100.0% / 49 names | 4 | 0 | 32 | 0 |
| Third Party / Temporary / Other | Third Party Works | Third Party Work - PWA | Third Party Works (PWAs) | 197 | VicRoads | Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 1.0% | 0.0% | 100.0% | 100.0% | 100.0% / 49 names | 183 | 134 | 714 | 0 |
| Vegetation / Landscaping | Landscaping / Grass | Grass and Landscaping | Grass & Landscaping | 3,716 | VicRoads | Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Western Roads Upgrade (WRU) | 100.0% | 100.0% | 0.0% | 50.2% | 0.0% | 100.0% | 100.0% | 100.0% / 19 names | 6,040 | 0 | 19,313 | 0 |
| Vegetation / Landscaping | Landscaping / Grass | Landscape Area | Landscape Areas | 57 | RAMC / BAC / PoB / TSRC group | Port of Brisbane | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 0.0% | 0.0% | 100.0% / 6 names | 48 | 0 | 17 | 0 |
| Vegetation / Landscaping | Landscaping / Grass | Landscaping | Landscaping | 3,775 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 37 names | 238 | 180 | 2,312 | 0 |
| Vegetation / Landscaping | Landscaping / Grass | Landscaping Design Polygon | Landscaping - Design Polygons | 3,745 | RAMC / BAC / PoB / TSRC group | Toowoomba Second Range Crossing | 100.0% | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% / 19 names | 13 | 0 | 153 | 0 |
| Vegetation / Landscaping | Landscaping / Grass | Roadside Landscaping | Roadside Landscaping | 100 | RMS; RMS new | SRAP-C | 100.0% | 100.0% | 0.0% | 0.0% | 0.0% | 100.0% | 100.0% | 100.0% / 32 names | 48 | 0 | 158 | 0 |
| Vegetation / Landscaping | Trees | Tree | Tree; Trees | 12,763 | RAMC / BAC / PoB / TSRC group; VNZ; VicRoads | Auckland West Transport; Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU); Proposed Work Applications (PWA), Western Roads Upgrade (WRU); Toowoomba Second Range Crossing; Western Roads Upgrade (WRU) | 100.0% | 100.0% | 59.9% | 57.9% | 0.0% | 100.0% | 100.0% | 100.0% / 90 names | 1,875 | 334 | 3,581 | 0 |

## Asset Type Detail

Each section below uses the standardised name as the heading. Raw source names are retained so the mapping can be audited back to Asset Vision. `Rows by source/contract` is capped to the largest source-contract combinations for scanability; the CSV output keeps the same aggregate metrics in machine-readable form.

### Barrier End Terminal

- Category: Barriers / Safety Devices / Crash Cushions / End Treatments.
- Raw source asset types: Barrier End Terminal.
- Asset count: `188` across `1` source labels and `1` source contract values.
- WKT: `188` assets with WKT (100.0%), `188` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 98.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 98.9%.
- Custom attributes: `2,636` attribute rows, `15` distinct attribute names, covering `188` assets (100.0%). Examples: Barrier End Style; Barrier End Type; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; End Offset; Information Source; Inspection Zone; Prev. AV ID; QGIS fid; Road Section; Side; Start Offset; Type Description; Verification Notes; Wire Rope Tension.
- Operations/evidence: `20` linked jobs (0.11 per asset), `0` open-overdue job proxy records, `628` linked inspections (3.34 per asset), `67` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `84` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 188 | Barrier End Terminal |

### Crash Cushion

- Category: Barriers / Safety Devices / Crash Cushions / End Treatments.
- Raw source asset types: Crash Cushions.
- Asset count: `135` across `1` source labels and `1` source contract values.
- WKT: `135` assets with WKT (100.0%), `135` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.7%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 97.8%.
- Custom attributes: `135` attribute rows, `1` distinct attribute names, covering `135` assets (100.0%). Examples: Compliant.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `632` direct asset photos, `0` linked job photos.
- Classification examples: T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 135 | Crash Cushions |

### Impact Absorption Terminal

- Category: Barriers / Safety Devices / Crash Cushions / End Treatments.
- Raw source asset types: Impact Absorbtion Terminals.
- Asset count: `37` across `1` source labels and `1` source contract values.
- WKT: `37` assets with WKT (100.0%), `37` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 48.6%, criticality 48.6%, risk 0.0%, source classification 94.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 48.6%.
- Custom attributes: `185` attribute rows, `5` distinct attribute names, covering `37` assets (100.0%). Examples: Compliant Status; Length; Material; Terminal Type; Warranty/Defect Liability Date.
- Operations/evidence: `8` linked jobs (0.22 per asset), `0` open-overdue job proxy records, `12` linked inspections (0.32 per asset), `0` open-overdue inspection proxy records, `0` capital works, `77` direct asset photos, `39` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 37 | Impact Absorbtion Terminals |

### Fence

- Category: Barriers / Safety Devices / Fencing.
- Raw source asset types: Fences.
- Asset count: `465` across `1` source labels and `1` source contract values.
- WKT: `465` assets with WKT (100.0%), `465` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 84.7%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 84.7%, construction cost 0.0%, useful life 0.0%, condition date 84.7%.
- Custom attributes: `23,578` attribute rows, `53` distinct attribute names, covering `465` assets (100.0%). Examples: Asset Description; Asset ID; Centreline; Chainage Point; Condition/Grade; Confidence Grade; Construction Year; Control Line; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Drop Protection; End Chainage; End Offset; End X Coord; End Y Coord; Estimated Residual Life; Fence Type; +35 more.
- Operations/evidence: `2,267` linked jobs (4.88 per asset), `777` open-overdue job proxy records, `1,753` linked inspections (3.77 per asset), `191` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `1,775` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 465 | Fences |

### Fence Gate

- Category: Barriers / Safety Devices / Fencing.
- Raw source asset types: Fence Gates.
- Asset count: `153` across `1` source labels and `1` source contract values.
- WKT: `153` assets with WKT (100.0%), `153` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `2,292` attribute rows, `15` distinct attribute names, covering `153` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Gate Description; Gate Width; Height; Information Source; Inspection Zone; Joint Ownership; Length; Material; Ownership; Prev. AV ID; QGIS fid; Road Section; Verification Notes.
- Operations/evidence: `3` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `603` linked inspections (3.94 per asset), `72` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `4` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 153 | Fence Gates |

### Fencing

- Category: Barriers / Safety Devices / Fencing.
- Raw source asset types: Fencing.
- Asset count: `358` across `1` source labels and `4` source contract values.
- WKT: `358` assets with WKT (100.0%), `358` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 79.9%, criticality 91.1%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `85.547` km proxy, construction date 96.6%, construction cost 0.0%, useful life 72.3%, condition date 79.3%.
- Custom attributes: `8,786` attribute rows, `27` distinct attribute names, covering `358` assets (100.0%). Examples: Additional Length (m); Asset Age; Asset Height/Depth (M); Asset Length (M); Asset Length (M) - calculated; Asset Location; Asset Offset to Traffic Lane (Start); Asset Support Type; Asset Width (M); DTP Asset ID; Drop Protection; Fence Function; Fence Height; Fence Material; Fence Side Location; Fence Type; Function; LGA; +9 more.
- Operations/evidence: `355` linked jobs (0.99 per asset), `8` open-overdue job proxy records, `871` linked inspections (2.43 per asset), `0` open-overdue inspection proxy records, `0` capital works, `721` direct asset photos, `2,045` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 249 | Fencing |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 77 | Fencing |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 26 | Fencing |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 6 | Fencing |

### Railing

- Category: Barriers / Safety Devices / Railings.
- Raw source asset types: Railings.
- Asset count: `919` across `1` source labels and `1` source contract values.
- WKT: `919` assets with WKT (100.0%), `919` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.5%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `35,841` attribute rows, `39` distinct attribute names, covering `919` assets (100.0%). Examples: Asset Design Life; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Barrier Type; Contract Asset Mapping; Document Link; End_m; Geometry; Ground Fix Method; Has Motorcycle Attachment?; Height; Installation Date; Lane Location; Length; Motorcycle Attachment; Mounted On; Mounted On Asset ID; +21 more.
- Operations/evidence: `5` linked jobs (0.01 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `7` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 919 | Railings |

### Guardrail

- Category: Barriers / Safety Devices / Safety Barriers / Guardrail.
- Raw source asset types: Guardrail.
- Asset count: `307` across `1` source labels and `1` source contract values.
- WKT: `307` assets with WKT (100.0%), `307` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `4,298` attribute rows, `13` distinct attribute names, covering `307` assets (100.0%). Examples: Classifica; Conditio_1; Easting; End Terminals; Failure_Co; Guardrail; Length; Maintenanc; Material; Northing; OBJECTID; Side of Road; UID.
- Operations/evidence: `22` linked jobs (0.07 per asset), `9` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `4` capital works, `0` direct asset photos, `88` linked job photos.
- Classification examples: Arterial; Collector; District; Local Street; Motorway; Passenger; Sub Arterial.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 307 | Guardrail |

### Road Barrier

- Category: Barriers / Safety Devices / Safety Barriers / Guardrail.
- Raw source asset types: Road Barrier.
- Asset count: `605` across `1` source labels and `1` source contract values.
- WKT: `605` assets with WKT (100.0%), `605` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 79.2%, criticality 0.0%, risk 0.0%, source classification 99.7%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 89.4%, construction cost 0.0%, useful life 79.2%, condition date 79.2%.
- Custom attributes: `34,874` attribute rows, `58` distinct attribute names, covering `605` assets (100.0%). Examples: Asset Description; Asset ID; Attachments; Barrier End ID; Barrier End Style; Barrier End Type; Barrier Start ID; Barrier Start Style; Barrier Start Type; Coating System; Condition/Grade; Confidence Grade; Construction Year; Control Line; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; End Chainage; +40 more.
- Operations/evidence: `55` linked jobs (0.09 per asset), `0` open-overdue job proxy records, `1,864` linked inspections (3.08 per asset), `200` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `278` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 605 | Road Barrier |

### Safety Barrier

- Category: Barriers / Safety Devices / Safety Barriers / Guardrail.
- Raw source asset types: Safety Barrier.
- Asset count: `4,048` across `2` source labels and `3` source contract values.
- WKT: `4,035` assets with WKT (99.7%), `4,035` with a valid-Australia first coordinate (99.7%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `445.669` km proxy, construction date 96.5%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `185,423` attribute rows, `46` distinct attribute names, covering `4,048` assets (100.0%). Examples: Asset Identification Date; Barrier Id; Colour; Conops_Rank; Hierarchy String; OBJECTID; Other Barrier Type; Other Terminal End; Other Terminal Start; Purpose; Side; Tender Asset; Terminal - End; Terminal - Start; Type; asset_cate; barrier__1; barrier_pu; +28 more.
- Operations/evidence: `2,345` linked jobs (0.58 per asset), `541` open-overdue job proxy records, `3,421` linked inspections (0.85 per asset), `115` open-overdue inspection proxy records, `4` capital works, `632` direct asset photos, `9,200` linked job photos.
- Classification examples: SN 1; SN 1, SN 2, SN 3, SN 4, SN 6; SN 1, SN 2, SN 3, SN 5, SN 6; SN 1, SN 3, SN 6; SN 1, SN 6; SN 2; SN 2, SN 3; SN 2, SN 3, SN 4; SN 2, SN 4; SN 3; SN 3, SN 4; SN 3, SN 4, SN 6; +3 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS new / SRAP-C | 1,977 | Safety Barrier |
| RMS / SRAP-C | 1,689 | Safety Barrier |
| RMS new / SRAP-C OOC | 161 | Safety Barrier |
| RMS / SRAP-C OOC | 156 | Safety Barrier |
| RMS new / SRAP-C, SRAP-C OOC | 39 | Safety Barrier |
| RMS / SRAP-C, SRAP-C OOC | 26 | Safety Barrier |

### Vehicle Barrier

- Category: Barriers / Safety Devices / Safety Barriers / Guardrail.
- Raw source asset types: Vehicle Barriers.
- Asset count: `1,242` across `1` source labels and `4` source contract values.
- WKT: `1,242` assets with WKT (100.0%), `1,242` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 81.0%, criticality 66.9%, risk 0.0%, source classification 99.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `3162.666` km proxy, construction date 32.0%, construction cost 0.0%, useful life 70.0%, condition date 86.1%.
- Custom attributes: `72,233` attribute rows, `68` distinct attribute names, covering `1,242` assets (100.0%). Examples: Ambient Temperature (Degree Celsius); Approaching  Terminal Serial Number; Approaching Barrier Comments; Approaching Terminal Compliance; Approaching Terminal Condition Rating; Approaching Terminal Product Name; Attachments on the barrier; Barrier End style Type; Barrier Start Type; Barrier end style; Barrier number of posts; Barrier posts Material; Barrier rail Material; Barrier start style; Barrier start type; Coating System (List); Coating system; Compliant Status; +50 more.
- Operations/evidence: `3,139` linked jobs (2.53 per asset), `56` open-overdue job proxy records, `3,172` linked inspections (2.55 per asset), `1` open-overdue inspection proxy records, `0` capital works, `2,904` direct asset photos, `14,927` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 587 | Vehicle Barriers |
| VicRoads / Western Roads Upgrade (WRU) | 560 | Vehicle Barriers |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 58 | Vehicle Barriers |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 37 | Vehicle Barriers |

### Arrestor Bed

- Category: Barriers / Safety Devices / Safety Ramps / Arrestor Beds.
- Raw source asset types: Arrestor Bed.
- Asset count: `2` across `1` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `34` attribute rows, `17` distinct attribute names, covering `2` assets (100.0%). Examples: Area of pavement; Area of surfacing; Arrestor Bed Material Condition; Asset ID; Asset description; Control Line; Drawing Ref.; End chainage; Inspection Zone; Pavement type; Road section; Sequence; Start Chainage; Winch Point Condition; X Coord; Y coord; Z Coord.
- Operations/evidence: `15` linked jobs (7.50 per asset), `4` open-overdue job proxy records, `3` linked inspections (1.50 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `27` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 2 | Arrestor Bed |

### Safety Ramp

- Category: Barriers / Safety Devices / Safety Ramps / Arrestor Beds.
- Raw source asset types: Safety Ramp.
- Asset count: `2` across `2` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `48` attribute rows, `25` distinct attribute names, covering `2` assets (100.0%). Examples: Asset Identification Date; OBJECTID; Tender Asset; asset_cate; be_materia; bed_depth_; bed_length; bed_width_; begin_offs; comments; constructi; current_zo; device_typ; end_offset; geometry_t; lc_unique; proposed_z; ramp_lengt; +7 more.
- Operations/evidence: `8` linked jobs (4.00 per asset), `4` open-overdue job proxy records, `22` linked inspections (11.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `68` linked job photos.
- Classification examples: SN 2, SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | Safety Ramp |
| RMS new / SRAP-C | 1 | Safety Ramp |

### Communication Node

- Category: Communications / Monitoring / Communications Systems.
- Raw source asset types: Communication Node.
- Asset count: `94` across `1` source labels and `1` source contract values.
- WKT: `94` assets with WKT (100.0%), `94` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `376` attribute rows, `4` distinct attribute names, covering `94` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `420` linked jobs (4.47 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `91` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 94 | Communication Node |

### Data Communication System

- Category: Communications / Monitoring / Communications Systems.
- Raw source asset types: Data Communication Systems.
- Asset count: `12` across `1` source labels and `1` source contract values.
- WKT: `12` assets with WKT (100.0%), `12` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `852` attribute rows, `71` distinct attribute names, covering `12` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +53 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 12 | Data Communication Systems |

### Motorway Network Communication System

- Category: Communications / Monitoring / Communications Systems.
- Raw source asset types: Motorway Network Communication System.
- Asset count: `123` across `1` source labels and `1` source contract values.
- WKT: `123` assets with WKT (100.0%), `123` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 98.4%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 98.4%.
- Custom attributes: `9,215` attribute rows, `75` distinct attribute names, covering `123` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; Asset Maintainer Third Party; Asset Operator; Asset Owner; Asset Status; Asset Status Date; +57 more.
- Operations/evidence: `13` linked jobs (0.11 per asset), `0` open-overdue job proxy records, `397` linked inspections (3.23 per asset), `12` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `48` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 123 | Motorway Network Communication System |

### Voice Communication System

- Category: Communications / Monitoring / Communications Systems.
- Raw source asset types: Voice Communication Systems.
- Asset count: `317` across `1` source labels and `1` source contract values.
- WKT: `317` assets with WKT (100.0%), `317` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 40.1%, criticality 21.1%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 40.1%.
- Custom attributes: `23,472` attribute rows, `78` distinct attribute names, covering `317` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `26` linked jobs (0.08 per asset), `0` open-overdue job proxy records, `926` linked inspections (2.92 per asset), `77` open-overdue inspection proxy records, `2` capital works, `0` direct asset photos, `52` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 317 | Voice Communication Systems |

### Fibre

- Category: Communications / Monitoring / Fibre / Communications Conduits.
- Raw source asset types: Fibre.
- Asset count: `15` across `1` source labels and `1` source contract values.
- WKT: `15` assets with WKT (100.0%), `15` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `60` attribute rows, `4` distinct attribute names, covering `15` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 15 | Fibre |

### ITS Conduit

- Category: Communications / Monitoring / Fibre / Communications Conduits.
- Raw source asset types: ITS - Conduits.
- Asset count: `603` across `1` source labels and `1` source contract values.
- WKT: `603` assets with WKT (100.0%), `603` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.8%, parent asset 99.8%, stage 100.0%.
- Linear/lifecycle attributes: chainage 99.8% with `0.000` km proxy, construction date 99.8%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `27,115` attribute rows, `46` distinct attribute names, covering `603` assets (100.0%). Examples: Asset Description; Asset ID; Cable Size (mm); Cable Type; Chainage End; Chainage Start; Condition/Grade; Conduit Configuration; Conduit Length; Conduit Material; Confidence Grade; Construction Year; Control Line; Cores; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; ELV(C)-LV(E); End  X Coordinate; +28 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 603 | ITS - Conduits |

### Control and Monitoring System

- Category: Communications / Monitoring / Monitoring / Control Systems.
- Raw source asset types: Control and Monitorings.
- Asset count: `37` across `1` source labels and `1` source contract values.
- WKT: `37` assets with WKT (100.0%), `37` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 24.3%, criticality 64.9%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 24.3%.
- Custom attributes: `2,572` attribute rows, `71` distinct attribute names, covering `37` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +53 more.
- Operations/evidence: `40` linked jobs (1.08 per asset), `0` open-overdue job proxy records, `73` linked inspections (1.97 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `86` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 37 | Control and Monitorings |

### Kurloo Monitoring Point

- Category: Communications / Monitoring / Monitoring / Control Systems.
- Raw source asset types: Kurloo Monitoring points.
- Asset count: `11` across `1` source labels and `1` source contract values.
- WKT: `11` assets with WKT (100.0%), `11` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `22` attribute rows, `2` distinct attribute names, covering `11` assets (100.0%). Examples: Date of Install; Device ID.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `118` linked inspections (10.73 per asset), `118` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 11 | Kurloo Monitoring points |

### Operations Management Control System

- Category: Communications / Monitoring / Monitoring / Control Systems.
- Raw source asset types: Operations Management Control Systems.
- Asset count: `78` across `1` source labels and `1` source contract values.
- WKT: `78` assets with WKT (100.0%), `78` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 98.7%, criticality 98.7%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 1.3%, construction cost 0.0%, useful life 0.0%, condition date 98.7%.
- Custom attributes: `5,832` attribute rows, `75` distinct attribute names, covering `78` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; Asset Maintainer Third Party; Asset Operator; Asset Owner; Asset Status; Asset Status Date; +57 more.
- Operations/evidence: `6` linked jobs (0.08 per asset), `0` open-overdue job proxy records, `53` linked inspections (0.68 per asset), `6` open-overdue inspection proxy records, `0` capital works, `4` direct asset photos, `10` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 78 | Operations Management Control Systems |

### Plant Monitoring and Control System

- Category: Communications / Monitoring / Monitoring / Control Systems.
- Raw source asset types: Plant Monitoring and Control Systems.
- Asset count: `146` across `1` source labels and `1` source contract values.
- WKT: `146` assets with WKT (100.0%), `146` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 39.7%, criticality 91.1%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 39.7%.
- Custom attributes: `10,314` attribute rows, `71` distinct attribute names, covering `146` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +53 more.
- Operations/evidence: `18` linked jobs (0.12 per asset), `0` open-overdue job proxy records, `226` linked inspections (1.55 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `18` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 146 | Plant Monitoring and Control Systems |

### Warning System

- Category: Communications / Monitoring / Monitoring / Control Systems.
- Raw source asset types: Warning Systems.
- Asset count: `150` across `1` source labels and `1` source contract values.
- WKT: `150` assets with WKT (100.0%), `150` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `600` attribute rows, `4` distinct attribute names, covering `150` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `515` linked jobs (3.43 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `148` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 150 | Warning Systems |

### Surveillance and Detection System

- Category: Communications / Monitoring / Surveillance Systems.
- Raw source asset types: Surveillance and Detection Systems.
- Asset count: `373` across `1` source labels and `1` source contract values.
- WKT: `373` assets with WKT (100.0%), `373` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 70.8%, criticality 54.4%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 70.8%.
- Custom attributes: `27,343` attribute rows, `83` distinct attribute names, covering `373` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +65 more.
- Operations/evidence: `41` linked jobs (0.11 per asset), `0` open-overdue job proxy records, `1,206` linked inspections (3.23 per asset), `42` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `119` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 373 | Surveillance and Detection Systems |

### Bridge or Major Culvert

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Bridge/Major Culvert.
- Asset count: `192` across `1` source labels and `7` source contract values.
- WKT: `192` assets with WKT (100.0%), `192` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 52.6%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `21,792` attribute rows, `115` distinct attribute names, covering `192` assets (100.0%). Examples: As-built Drawings (IFC); Asset Owner; Bridge Function; Bridge Type; Bridge Widening Construction Date; Bridge Widening Traffic Design Load; Cathodic Protection System; Clear Width (m); Colloquial Name (Power BI value); Colloquial Name 1; Colloquial Name 2; Colloquial Name 3; Construction Description; Culvert Cell Height (m); Current L2 Inspection Status; DTP Asset ID; Date Asset was Identified; Date of Last Level 2 Inspection; +97 more.
- Operations/evidence: `4,745` linked jobs (24.71 per asset), `5` open-overdue job proxy records, `1,929` linked inspections (10.05 per asset), `3` open-overdue inspection proxy records, `295` capital works, `16` direct asset photos, `30,984` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 93 | Bridge/Major Culvert |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 25 | Bridge/Major Culvert |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA) | 24 | Bridge/Major Culvert |
| VicRoads / Proposed Work Applications (PWA) | 19 | Bridge/Major Culvert |
| VicRoads / Western Roads Upgrade (WRU) | 16 | Bridge/Major Culvert |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 14 | Bridge/Major Culvert |
| VicRoads / Initial Rehabilitation Works (IRW) | 1 | Bridge/Major Culvert |

### Bridge-size Culvert

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Bridge Size Culvert.
- Asset count: `232` across `2` source labels and `2` source contract values.
- WKT: `232` assets with WKT (100.0%), `232` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 89.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 84.5%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `22,040` attribute rows, `95` distinct attribute names, covering `232` assets (100.0%). Examples: A1___SEMI_TRAILER___45_5T; A2___B_DOUBLE___68T; A4___B_TRIPLE___90_5T; A5___AB_TRIPLE___113T; A6___ROAD_TRAIN___85T; ADDITIONAL_NOTES; ARL; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BHI_DESCR; BORDER_BRDG_YN; BRDG_TYPE_CODE; BRIDGE_COMMENT; BRIDGE_RD_CLASS; +77 more.
- Operations/evidence: `238` linked jobs (1.03 per asset), `128` open-overdue job proxy records, `762` linked inspections (3.28 per asset), `20` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `1,378` linked job photos.
- Classification examples: SN 1, SN 3; SN 1, SN 4; SN 1, SN 6; SN 2; SN 2, SN 3; SN 2, SN 4; SN 2, SN 5; SN 2, SN 6; SN 3; SN 3, SN 4; SN 3, SN 6; SN 4; +3 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 114 | Bridge Size Culvert |
| RMS new / SRAP-C | 114 | Bridge Size Culvert |
| RMS / SRAP-C, SRAP-C OOC | 2 | Bridge Size Culvert |
| RMS new / SRAP-C, SRAP-C OOC | 2 | Bridge Size Culvert |

### Culvert

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Culvert.
- Asset count: `20,936` across `4` source labels and `6` source contract values.
- WKT: `20,935` assets with WKT (100.0%), `20,935` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString; Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 1.8%.
- Custom attributes: `1,996,500` attribute rows, `212` distinct attribute names, covering `20,936` assets (100.0%). Examples: ARL; Access Method; Access Notes; Additional Service; Age; Area; Asset Code; Asset Design Life; Asset Identification Date; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Asset Type; Barre-Plastic Corrugated; Barrel-Aluminim Spiral Wound; Barrel-Aluminium Multi Plate Corrugated; Barrel-Concrete Fibre Reo; Barrel-Concrete Steel Reo; +194 more.
- Operations/evidence: `1,478` linked jobs (0.07 per asset), `439` open-overdue job proxy records, `3,327` linked inspections (0.16 per asset), `694` open-overdue inspection proxy records, `2` capital works, `6,788` direct asset photos, `8,770` linked job photos.
- Classification examples: GR8; RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; +24 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS new / SRAP-C | 7,576 | Culvert |
| RMS / SRAP-C | 6,127 | Culvert |
| VNZ / Auckland West Transport | 6,077 | Culvert |
| RMS / SRAP-C, SRAP-C OOC | 248 | Culvert |
| RMS new / SRAP-C, SRAP-C OOC | 248 | Culvert |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 241 | Culvert |
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 233 | Culvert |
| RMS new / SRAP-C OOC | 94 | Culvert |
| RMS / SRAP-C OOC | 92 | Culvert |

### Major Culvert

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Major Culvert; Major Culverts.
- Asset count: `44` across `1` source labels and `2` source contract values.
- WKT: `44` assets with WKT (100.0%), `44` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 11.4%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 88.6%, stage 100.0%.
- Linear/lifecycle attributes: chainage 88.6% with `0.000` km proxy, construction date 84.1%, construction cost 0.0%, useful life 0.0%, condition date 11.4%.
- Custom attributes: `3,825` attribute rows, `107` distinct attribute names, covering `44` assets (100.0%). Examples: AEP Immunity; Asset Description; Asset ID; Austroads Major Culvert Definition?; Base slab thickness; Bat Roosting Mesh; Bearing (AP1 to AP2); Bedding; Carriageway; Centroid X Coord; Centroid Y Coord; Chainage; Componenent Width; Component Class; Component Diameter; Component Height; Component Joint; Component material; +89 more.
- Operations/evidence: `101` linked jobs (2.30 per asset), `35` open-overdue job proxy records, `84` linked inspections (1.91 per asset), `8` open-overdue inspection proxy records, `0` capital works, `7` direct asset photos, `446` linked job photos.
- Classification examples: Port Of Brisbane; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 39 | Major Culvert |
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 5 | Major Culverts |

### Minor Culvert

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Minor Culvert; Minor Culverts.
- Asset count: `2,572` across `2` source labels and `5` source contract values.
- WKT: `2,564` assets with WKT (99.7%), `2,564` with a valid-Australia first coordinate (99.7%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString; Point.
- Core attributes: condition 98.4%, criticality 76.3%, risk 0.0%, source classification 99.8%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `413.284` km proxy, construction date 99.5%, construction cost 0.0%, useful life 46.3%, condition date 98.4%.
- Custom attributes: `142,336` attribute rows, `109` distinct attribute names, covering `2,572` assets (100.0%). Examples: 2nd Pipe Diameter; 2nd pipe diameter (mm); Asset Criticality; Asset Description; Asset ID; CUL_DI_WID; CUL_HEI; CUL_LEN; CUL_TYPE; Centroid Chainage; Centroid X Coordinate; Centroid Y Coordinate; Condition Based Remaining Life; Condition/Grade; Confidence Grade; Consequence - RMC Rating Score; Consequence - Urban and Rural Score; Construction Year; +91 more.
- Operations/evidence: `1,115` linked jobs (0.43 per asset), `45` open-overdue job proxy records, `1,720` linked inspections (0.67 per asset), `60` open-overdue inspection proxy records, `0` capital works, `1,915` direct asset photos, `3,573` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4; RMC 5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 1,917 | Minor Culverts |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 341 | Minor Culvert |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 245 | Minor Culverts |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 52 | Minor Culverts |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 17 | Minor Culverts |

### Watercourse Crossing

- Category: Drainage / Stormwater / Culverts / Watercourse Crossings.
- Raw source asset types: Water Course Crossings.
- Asset count: `96` across `1` source labels and `1` source contract values.
- WKT: `96` assets with WKT (100.0%), `96` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `864` attribute rows, `9` distinct attribute names, covering `96` assets (100.0%). Examples: CROSSING DESCRIPTION; CROSSING TYPE; Drawing Ref.; Inspection Zone; LINING TYPE; Maintenance Track ID; QGIS fid; SECTION; SIDE SLOPE.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 96 | Water Course Crossings |

### Airside Drainage

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Airside Drainage.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: Airside.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 1 | Airside Drainage |

### Drainage

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Drainage.
- Asset count: `1,606` across `1` source labels and `1` source contract values.
- WKT: `1,606` assets with WKT (100.0%), `1,606` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 98.4%.
- Custom attributes: `19,272` attribute rows, `12` distinct attribute names, covering `1,606` assets (100.0%). Examples: Condition Rating; Shape_Leng; Verified; category; comments; elem_id; network; no; precinct_2; size; spid; type.
- Operations/evidence: `24` linked jobs (0.01 per asset), `20` open-overdue job proxy records, `1,547` linked inspections (0.96 per asset), `0` open-overdue inspection proxy records, `13` capital works, `2,725` direct asset photos, `12` linked job photos.
- Classification examples: Collector; Local Street; Passenger; T1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 1,606 | Drainage |

### Drainage Line

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Drainage Lines.
- Asset count: `5,055` across `1` source labels and `2` source contract values.
- WKT: `5,055` assets with WKT (100.0%), `5,055` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.5%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `455.948` km proxy, construction date 94.1%, construction cost 0.0%, useful life 94.3%, condition date 0.0%.
- Custom attributes: `86,344` attribute rows, `23` distinct attribute names, covering `5,055` assets (100.0%). Examples: Carrying; LGA; Length (m); Pipe Diameter; Pipe Material; Pipe Size; Pit From Code; Pit To Code; Section Dimension; Third Party Site; Warranty/Defect Liability Date; Year Built; built; diameter; dnstr_pit; form; globalid; length; +5 more.
- Operations/evidence: `10` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `57` linked job photos.
- Classification examples: RMC 2; RMC 2, RMC 3; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 4,942 | Drainage Lines |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 113 | Drainage Lines |

### Drainage System

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Drainage Systems.
- Asset count: `612` across `1` source labels and `1` source contract values.
- WKT: `612` assets with WKT (100.0%), `612` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 97.1%, criticality 0.3%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 97.1%.
- Custom attributes: `50,116` attribute rows, `82` distinct attribute names, covering `612` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Condition; Asset Condition Date; Asset Criticality; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; +64 more.
- Operations/evidence: `15` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `1,343` linked inspections (2.19 per asset), `117` open-overdue inspection proxy records, `3` capital works, `0` direct asset photos, `36` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 612 | Drainage Systems |

### Open Drainage

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Open Drainage.
- Asset count: `38` across `2` source labels and `1` source contract values.
- WKT: `38` assets with WKT (100.0%), `38` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `4.130` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,482` attribute rows, `40` distinct attribute names, covering `38` assets (100.0%). Examples: ASSET_CATEGORY; AVERAGE_WIDTH_M; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BEGIN_OFFSET; COMMENTS; CURRENT_ZONE; Conops_Rank; Conops_Score; END_OFFSET; GEOMETRY_TYPE; INLET_INVERT_M; INLET_LATITUDE; INLET_LONGITUDE; +22 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 2, SN 3, SN 4; SN 2, SN 4; SN 3, SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 19 | Open Drainage |
| RMS new / SRAP-C | 19 | Open Drainage |

### Subsoil Drain

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Subsoil Drains.
- Asset count: `2,607` across `1` source labels and `1` source contract values.
- WKT: `2,607` assets with WKT (100.0%), `2,607` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 37.4%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 37.4%, construction cost 0.0%, useful life 0.0%, condition date 37.4%.
- Custom attributes: `91,565` attribute rows, `37` distinct attribute names, covering `2,607` assets (100.0%). Examples: Asset Description; Asset ID; Centreline; Chainage; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Drain Length; Drain Type; Drain Type Description; Drawing Ref.; End Chainage; Estimated Residual Life; Information Source; Inspection Zone; Latitude (End); +19 more.
- Operations/evidence: `63` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `5,845` linked inspections (2.24 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `222` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 2,607 | Subsoil Drains |

### Subsoil Drain Outlet

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Subsoil Drain Outlets.
- Asset count: `1,634` across `1` source labels and `1` source contract values.
- WKT: `1,634` assets with WKT (100.0%), `1,634` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 99.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 99.9%, condition date 99.9%.
- Custom attributes: `24,510` attribute rows, `15` distinct attribute names, covering `1,634` assets (100.0%). Examples: Batter Condition; Centreline; Data Confidence (L)ow, (M)edium, (H)igh; Drain Type; Drain Type Description; Drawing Ref.; Headwall Condition; Information Source; Inspection Zone; Point X Coord; Point Y Coord; Point Z Coord; Prev. AV Code; QGIS fid; Road Section.
- Operations/evidence: `4` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `3,324` linked inspections (2.03 per asset), `699` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `11` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1,634 | Subsoil Drain Outlets |

### Table Drain

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Table Drain.
- Asset count: `1,364` across `2` source labels and `6` source contract values.
- WKT: `1,364` assets with WKT (100.0%), `1,364` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; LINESTRING; MULTILINESTRING; MULTIPOLYGON; POLYGON. Source `SpatialType` values: MultiLineString; Polygon; Polyline.
- Core attributes: condition 62.2%, criticality 60.3%, risk 0.0%, source classification 98.5%, parent asset 65.6%, stage 100.0%.
- Linear/lifecycle attributes: chainage 65.6% with `2.200` km proxy, construction date 62.8%, construction cost 0.0%, useful life 34.9%, condition date 62.3%.
- Custom attributes: `18,828` attribute rows, `51` distinct attribute names, covering `1,364` assets (100.0%). Examples: Area; Area (sqm); Asset Code; Asset Type; Authority Responsible For Maintenance; Billing Classification; Carriageway Code; Chainage; Condition Rating; Consequence - RMC Rating Score; Consequence - Urban and Rural Score; Contract Area; Contract Cost Code; Customer; Depth (m); Drain Lined; Drain Lining; Drain Lining Other; +33 more.
- Operations/evidence: `800` linked jobs (0.59 per asset), `339` open-overdue job proxy records, `2,090` linked inspections (1.53 per asset), `12` open-overdue inspection proxy records, `0` capital works, `1,777` direct asset photos, `3,101` linked job photos.
- Classification examples: Arterial; Collector; District; Local Street; Motorway; Passenger; RMC 1; RMC 2; RMC 3; RMC 4; RMC 5; Sub Arterial; +1 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 773 | Table Drain |
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 469 | Table Drain |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 93 | Table Drain |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 23 | Table Drain |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 4 | Table Drain |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 2 | Table Drain |

### Table Drain - AGAZ

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Table Drain-AGAZ.
- Asset count: `826` across `1` source labels and `1` source contract values.
- WKT: `826` assets with WKT (100.0%), `826` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `394.891` km proxy, construction date 0.4%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `24,772` attribute rows, `29` distinct attribute names, covering `826` assets (100.0%). Examples: Asset Code; Asset Type; Billing Classification; Carriageway Code; Chainage; Condition Rating; Contract Area; Contract Cost Code; Customer; Distance for road side (m); Embankment Condition; End Chainage; Flood Risk; Gazettal; Invert Condition - Blockage; Invert Condition - Scour; LGA; Length (M); +11 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: GR8; T1; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 826 | Table Drain-AGAZ |

### Table Drain - GAZ

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Table Drain-GAZ.
- Asset count: `1,757` across `1` source labels and `1` source contract values.
- WKT: `1,757` assets with WKT (100.0%), `1,757` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.1%, criticality 0.1%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `816.212` km proxy, construction date 0.6%, construction cost 0.0%, useful life 0.0%, condition date 43.0%.
- Custom attributes: `54,471` attribute rows, `31` distinct attribute names, covering `1,757` assets (100.0%). Examples: Area; Asset Code; Asset Type; Billing Classification; Carriageway Code; Chainage; Condition Rating; Contract Area; Contract Cost Code; Council; Customer; Distance for road side (m); Embankment Condition; End Chainage; Flood Risk; Gazettal; Invert Condition - Blockage; Invert Condition - Scour; +13 more.
- Operations/evidence: `277` linked jobs (0.16 per asset), `14` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `2,004` direct asset photos, `2,787` linked job photos.
- Classification examples: GR8; T1; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 1,757 | Table Drain-GAZ |

### Table Drain - TSRC

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Table Drain (TSRC).
- Asset count: `1,750` across `1` source labels and `1` source contract values.
- WKT: `1,750` assets with WKT (100.0%), `1,750` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 99.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 99.9%, condition date 99.9%.
- Custom attributes: `104,187` attribute rows, `60` distinct attribute names, covering `1,750` assets (100.0%). Examples: Asset Description; Asset ID; Authority; Base Width; Chainage End; Chainage Start; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; Cross fall of drain base; Data Confidence (L)ow, (M)edium, (H)igh; Design lining depth; Drainage Risk Rating; Drawing Ref.; End Offset; End X Coord; End Y Coord; +42 more.
- Operations/evidence: `669` linked jobs (0.38 per asset), `6` open-overdue job proxy records, `5,911` linked inspections (3.38 per asset), `473` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `5,259` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1,750 | Table Drain (TSRC) |

### Trench Drain

- Category: Drainage / Stormwater / Drains / Channels.
- Raw source asset types: Trench Drain.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `5` attribute rows, `5` distinct attribute names, covering `1` assets (100.0%). Examples: Contract Cost Code; Length; Notes; Side Of Road; Survey Date.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `1` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 1 | Trench Drain |

### Penstock

- Category: Drainage / Stormwater / Pipes / Valves.
- Raw source asset types: Penstock.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `3` linked jobs (3.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `12` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 1 | Penstock |

### Pipe

- Category: Drainage / Stormwater / Pipes / Valves.
- Raw source asset types: Pipe.
- Asset count: `3,632` across `1` source labels and `2` source contract values.
- WKT: `3,632` assets with WKT (100.0%), `3,632` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.1%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.3%, construction cost 0.0%, useful life 0.0%, condition date 83.0%.
- Custom attributes: `187,625` attribute rows, `58` distinct attribute names, covering `3,632` assets (100.0%). Examples: Additional Service; Area; Asset Code; Asset Type; Billing Classification; CCTV Required; Carriageway Code; Chainage; Construction Material; Construction Material (1); Construction Type; Contract Area; Contract Cost Code; Culvert Blockage; Culvert Material Condition (Pipe Condition); Customer; Depth of fill (mm); Flood Risk; +40 more.
- Operations/evidence: `2,012` linked jobs (0.55 per asset), `235` open-overdue job proxy records, `40` linked inspections (0.01 per asset), `0` open-overdue inspection proxy records, `1` capital works, `32,568` direct asset photos, `10,717` linked job photos.
- Classification examples: GR8; T1; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 1,923 | Pipe |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 1,709 | Pipe |

### Valve

- Category: Drainage / Stormwater / Pipes / Valves.
- Raw source asset types: Valves.
- Asset count: `5` across `1` source labels and `1` source contract values.
- WKT: `5` assets with WKT (100.0%), `5` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `25` attribute rows, `5` distinct attribute names, covering `5` assets (100.0%). Examples: Backflow ID Number; Description; Location; Serial Number; Valve Type.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 5 | Valves |

### Field Inlet

- Category: Drainage / Stormwater / Pits / Inlets.
- Raw source asset types: Field Inlet.
- Asset count: `397` across `1` source labels and `3` source contract values.
- WKT: `397` assets with WKT (100.0%), `397` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.5%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.5%, construction cost 0.0%, useful life 0.0%, condition date 90.9%.
- Custom attributes: `9,131` attribute rows, `23` distinct attribute names, covering `397` assets (100.0%). Examples: Area; Asset Code; Asset Type; Billing Classification; Carriageway Code; Chainage; Contract Area; Contract Cost Code; Customer; Depth (mm); Flood Risk; Gazettal; Grate Type; Inlet Chainage; Length (m); Notes; Road Section; Side Of Road; +5 more.
- Operations/evidence: `409` linked jobs (1.03 per asset), `1` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `482` direct asset photos, `1,675` linked job photos.
- Classification examples: T1; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 274 | Field Inlet |
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 121 | Field Inlet |
| RAMC / BAC / PoB / TSRC group / Demo Contract | 2 | Field Inlet |

### Gully Pit

- Category: Drainage / Stormwater / Pits / Inlets.
- Raw source asset types: Gully Pit.
- Asset count: `4,659` across `1` source labels and `3` source contract values.
- WKT: `4,658` assets with WKT (100.0%), `4,658` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.1%, criticality 0.0%, risk 0.0%, source classification 99.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.3%, construction cost 0.0%, useful life 0.0%, condition date 93.8%.
- Custom attributes: `102,498` attribute rows, `22` distinct attribute names, covering `4,659` assets (100.0%). Examples: Area; Asset Code; Asset Type; Billing Classification; Carriageway Code; Chainage; Contract Area; Contract Cost Code; Customer; Depth (mm); Flood Risk; Gazettal; Grate Type; Inlet Chainage; Length (m); Road Section; Side of Road; Site; +4 more.
- Operations/evidence: `6,150` linked jobs (1.32 per asset), `19` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `4,744` direct asset photos, `21,035` linked job photos.
- Classification examples: T1; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 3,375 | Gully Pit |
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 1,275 | Gully Pit |
| RAMC / BAC / PoB / TSRC group / Demo Contract | 9 | Gully Pit |

### Pit

- Category: Drainage / Stormwater / Pits / Inlets.
- Raw source asset types: Pit.
- Asset count: `27,321` across `2` source labels and `5` source contract values.
- WKT: `27,321` assets with WKT (100.0%), `27,321` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 85.7%, criticality 68.2%, risk 0.0%, source classification 99.5%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 98.6%, construction cost 0.0%, useful life 35.6%, condition date 85.8%.
- Custom attributes: `1,172,816` attribute rows, `88` distinct attribute names, covering `27,321` assets (100.0%). Examples: Asset Description; Asset ID; Asset Sub-Type; Asset_Sub-Type; Chainage; Condition/Grade; Confidence Grade; Consequence - RMC Rating Score; Consequence - Urban and Rural Score; Construction Type; Construction Year; Control Line; Criticality Criteria; DTP Asset ID; Data Capture Date; Data Capture Method; Data Confidence (L)ow, (M)edium, (H)igh; Data Source; +70 more.
- Operations/evidence: `14,737` linked jobs (0.54 per asset), `116` open-overdue job proxy records, `15,753` linked inspections (0.58 per asset), `671` open-overdue inspection proxy records, `3` capital works, `34,298` direct asset photos, `42,005` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 4; RMC 5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 22,200 | Pit |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 4,121 | Pit |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 401 | Pit |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 358 | Pit |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 241 | Pit |

### Gross Pollutant Trap

- Category: Drainage / Stormwater / Pollution / Debris Capture.
- Raw source asset types: Gross Pollutant Traps.
- Asset count: `20` across `1` source labels and `1` source contract values.
- WKT: `20` assets with WKT (100.0%), `20` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `80` attribute rows, `4` distinct attribute names, covering `20` assets (100.0%). Examples: Location Description; Model/Type; Previous Asset ID; Public Access/Tenant Control.
- Operations/evidence: `40` linked jobs (2.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `282` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 20 | Gross Pollutant Traps |

### Spill Capture

- Category: Drainage / Stormwater / Pollution / Debris Capture.
- Raw source asset types: Spill Captures.
- Asset count: `5` across `1` source labels and `1` source contract values.
- WKT: `5` assets with WKT (100.0%), `5` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `15` attribute rows, `3` distinct attribute names, covering `5` assets (100.0%). Examples: Model/Type; Previous Asset ID; Public Access/Tenant Control.
- Operations/evidence: `9` linked jobs (1.80 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `50` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 5 | Spill Captures |

### Trash Rack

- Category: Drainage / Stormwater / Pollution / Debris Capture.
- Raw source asset types: Trash Racks.
- Asset count: `14` across `1` source labels and `1` source contract values.
- WKT: `14` assets with WKT (100.0%), `14` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `56` attribute rows, `4` distinct attribute names, covering `14` assets (100.0%). Examples: Location Description; Model; Previous Asset ID; Road Name.
- Operations/evidence: `79` linked jobs (5.64 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `294` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 14 | Trash Racks |

### Hydraulic Treatment and Pumping System

- Category: Drainage / Stormwater / Pumps / Hydraulic Controls.
- Raw source asset types: Hydraulic Treatment and Pumping Systems.
- Asset count: `66` across `1` source labels and `1` source contract values.
- WKT: `66` assets with WKT (100.0%), `66` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 74.2%, criticality 28.8%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 75.8%.
- Custom attributes: `5,124` attribute rows, `78` distinct attribute names, covering `66` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `83` linked jobs (1.26 per asset), `0` open-overdue job proxy records, `904` linked inspections (13.70 per asset), `41` open-overdue inspection proxy records, `1` capital works, `0` direct asset photos, `149` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 66 | Hydraulic Treatment and Pumping Systems |

### Pump Station

- Category: Drainage / Stormwater / Pumps / Hydraulic Controls.
- Raw source asset types: Pump Station.
- Asset count: `2` across `2` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 100.0%, condition date 100.0%.
- Custom attributes: `94` attribute rows, `47` distinct attribute names, covering `2` assets (100.0%). Examples: Acquisition Cost ($); Asset Complex; Asset Complex Zone; Asset Condition; Asset Condition Date; Asset Maint Prim; Asset Maint Prim Contract ID; Asset Maint Third Party; Asset Operator; Asset Owner; Asset Specification TMC; Asset Status; Asset Status Date; Asset Sys; Asset Technical Object; Base Code; Batch No; CA51115759; +29 more.
- Operations/evidence: `4` linked jobs (2.00 per asset), `0` open-overdue job proxy records, `64` linked inspections (32.00 per asset), `2` open-overdue inspection proxy records, `0` capital works, `8` direct asset photos, `38` linked job photos.
- Classification examples: SN 2.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | Pump Station |
| RMS new / SRAP-C | 1 | Pump Station |

### Stormwater Rain Garden

- Category: Drainage / Stormwater / Rain Gardens.
- Raw source asset types: SW Rain Gardens.
- Asset count: `169` across `1` source labels and `1` source contract values.
- WKT: `169` assets with WKT (100.0%), `169` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 98.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,014` attribute rows, `6` distinct attribute names, covering `169` assets (100.0%). Examples: Contract Asset Mapping; Document Link; bio_struct_type; end_m; id; start_m.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Urban; RMC 3 - Urban; RMC 4 - Urban; RMC 5 - Urban; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 169 | SW Rain Gardens |

### Stormwater

- Category: Drainage / Stormwater / Stormwater Systems / Treatment.
- Raw source asset types: Storm Waters.
- Asset count: `18,596` across `1` source labels and `1` source contract values.
- WKT: `18,596` assets with WKT (100.0%), `18,596` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 98.5%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `92,980` attribute rows, `5` distinct attribute names, covering `18,596` assets (100.0%). Examples: Contract Asset Mapping; Document Link; id; location; material.
- Operations/evidence: `60` linked jobs (0.00 per asset), `1` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `258` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 18,596 | Storm Waters |

### Stormwater Quality Improvement

- Category: Drainage / Stormwater / Stormwater Systems / Treatment.
- Raw source asset types: Stormwater Quality Improvement.
- Asset count: `62` across `2` source labels and `1` source contract values.
- WKT: `62` assets with WKT (100.0%), `62` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,684` attribute rows, `28` distinct attribute names, covering `62` assets (100.0%). Examples: ASSET_CATEGORY; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BACKOE_TRUCK_ACCESS; Conops_Rank; Conops_Score; LOCATION_APPROXIMATED; LOCATION_DESCRIPTION; MAINTENANCE_DEPOT; MAINTENANCE_ZONE; OBJECTID; TYPE_OF_ASSET; Tender Asset; UBD_MAP_REFERENCE; +10 more.
- Operations/evidence: `170` linked jobs (2.74 per asset), `32` open-overdue job proxy records, `240` linked inspections (3.87 per asset), `10` open-overdue inspection proxy records, `0` capital works, `4` direct asset photos, `1,350` linked job photos.
- Classification examples: SN 2; SN 2, SN 4; SN 3; SN 3, SN 4; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 31 | Stormwater Quality Improvement |
| RMS new / SRAP-C | 31 | Stormwater Quality Improvement |

### Embankment

- Category: Earthworks / Geotechnical / Slopes / Embankments.
- Raw source asset types: Embankments.
- Asset count: `168` across `1` source labels and `1` source contract values.
- WKT: `168` assets with WKT (100.0%), `168` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 100.0%, criticality 100.0%, risk 0.0%, source classification 99.4%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 29.2%, construction cost 0.0%, useful life 63.7%, condition date 100.0%.
- Custom attributes: `840` attribute rows, `5` distinct attribute names, covering `168` assets (100.0%). Examples: Height (m); Length (m); Material; Volume (m3); Width (m).
- Operations/evidence: `9` linked jobs (0.05 per asset), `0` open-overdue job proxy records, `32` linked inspections (0.19 per asset), `0` open-overdue inspection proxy records, `0` capital works, `138` direct asset photos, `47` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 168 | Embankments |

### Embankment Monitoring

- Category: Earthworks / Geotechnical / Slopes / Embankments.
- Raw source asset types: Embankment Monitoring.
- Asset count: `721` across `1` source labels and `1` source contract values.
- WKT: `721` assets with WKT (100.0%), `721` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `26,476` attribute rows, `40` distinct attribute names, covering `721` assets (100.0%). Examples: Asset Condition; Asset Criticality; Asset Description; Asset ID; Centreline; Chainage; Condition Based Remaining Life; Condition/Grade; Confidence Grade; Construction Year; Cost of Construction; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Date of Construction; Drawing Ref.; Estimated Residual Life; Geotechnical monitoring equipment; Information Source; +22 more.
- Operations/evidence: `17` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `655` linked inspections (0.91 per asset), `46` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `16` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 721 | Embankment Monitoring |

### Slope

- Category: Earthworks / Geotechnical / Slopes / Embankments.
- Raw source asset types: Slope.
- Asset count: `2,220` across `3` source labels and `4` source contract values.
- WKT: `2,194` assets with WKT (98.8%), `2,194` with a valid-Australia first coordinate (98.8%). Geometry tokens observed: GEOMETRYCOLLECTION; LINESTRING; MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon; Polyline.
- Core attributes: condition 11.3%, criticality 0.1%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `398.337` km proxy, construction date 1.7%, construction cost 0.0%, useful life 0.0%, condition date 11.3%.
- Custom attributes: `102,632` attribute rows, `116` distinct attribute names, covering `2,220` assets (100.0%). Examples: ARL Rating; Anchor Type; Area of Slope Face; Asset Description; Asset ID; Asset Identification Date; Average Height; Bank foundation material; Batter 1; Batter 1 Surface Protection; Batter 10; Batter 10 Surface Protection; Batter 2; Batter 2 Surface Protection; Batter 3; Batter 3 Surface Protection; Batter 4; Batter 4 Surface Protection; +98 more.
- Operations/evidence: `454` linked jobs (0.20 per asset), `141` open-overdue job proxy records, `3,284` linked inspections (1.48 per asset), `151` open-overdue inspection proxy records, `7` capital works, `44` direct asset photos, `2,295` linked job photos.
- Classification examples: SN 1; SN 1, SN 2, SN 3, SN 4, SN 5; SN 1, SN 2, SN 4; SN 1, SN 6; SN 2; SN 2, SN 3; SN 2, SN 3, SN 4; SN 2, SN 4; SN 3; SN 3, SN 4; SN 3, SN 4, SN 6; SN 4; +1 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS new / SRAP-C | 926 | Slope |
| RMS / SRAP-C | 923 | Slope |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 280 | Slope |
| RMS new / SRAP-C OOC | 43 | Slope |
| RMS / SRAP-C OOC | 26 | Slope |
| RMS new / SRAP-C, SRAP-C OOC | 13 | Slope |
| RMS / SRAP-C, SRAP-C OOC | 9 | Slope |

### Air Monitoring System

- Category: Environment / Monitoring / Air Monitoring.
- Raw source asset types: Air Monitoring Systems.
- Asset count: `27` across `1` source labels and `1` source contract values.
- WKT: `27` assets with WKT (100.0%), `27` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 33.3%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `2,025` attribute rows, `75` distinct attribute names, covering `27` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +57 more.
- Operations/evidence: `8` linked jobs (0.30 per asset), `0` open-overdue job proxy records, `114` linked inspections (4.22 per asset), `7` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `18` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 27 | Air Monitoring Systems |

### Water Quality

- Category: Environment / Monitoring / Water Quality.
- Raw source asset types: Water Quality.
- Asset count: `32` across `1` source labels and `1` source contract values.
- WKT: `32` assets with WKT (100.0%), `32` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 100.0%, condition date 100.0%.
- Custom attributes: `2,496` attribute rows, `78` distinct attribute names, covering `32` assets (100.0%). Examples: Area at Sed Basin Floor; Asset Description; Asset ID; Bio-Basin Crest RL; Bio-Basin Extended Detention RL; Bio-Basin Filter Area; Bio-Basin Surface RL; Bio-Basin Under Drainage Collect Pipe DN; Bio-Basin Under Drainage Collector Pipe Outlet RL; Bio-Basin Under Drainage Slotted Pipe DN; Chainage; Channel Outflow Control Line; Channel Outflow Control Line (2); Channel Outflow D50; Channel Outflow D50 (2); Channel Outflow Design Lining Depth; Channel Outflow Design Lining Depth (2); Channel Outflow End Chainage; +60 more.
- Operations/evidence: `19` linked jobs (0.59 per asset), `0` open-overdue job proxy records, `64` linked inspections (2.00 per asset), `1` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `114` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 32 | Water Quality |

### Door and Frame

- Category: Facilities / Buildings / Building Components.
- Raw source asset types: Doors and Frames.
- Asset count: `4` across `1` source labels and `1` source contract values.
- WKT: `4` assets with WKT (100.0%), `4` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `24` attribute rows, `6` distinct attribute names, covering `4` assets (100.0%). Examples: AED Asset Number; AED Asset Tag; Asset Location; Description; Location; Seal Type.
- Operations/evidence: `20` linked jobs (5.00 per asset), `8` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 4 | Doors and Frames |

### Building

- Category: Facilities / Buildings / Buildings / Depots.
- Raw source asset types: Building; Buildings.
- Asset count: `2` across `2` source labels and `2` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 50.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 50.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `130` attribute rows, `129` distinct attribute names, covering `2` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset ID; Asset Lessee; Asset Maintainer Primary; +111 more.
- Operations/evidence: `10` linked jobs (5.00 per asset), `0` open-overdue job proxy records, `27` linked inspections (13.50 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `29` linked job photos.
- Classification examples: T7; Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Building |
| VNS / Sydney Harbour Tunnel (SHT) | 1 | Buildings |

### Depot

- Category: Facilities / Buildings / Buildings / Depots.
- Raw source asset types: Depot.
- Asset count: `9` across `3` source labels and `2` source contract values.
- WKT: `9` assets with WKT (100.0%), `9` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 11.1%, stage 100.0%.
- Linear/lifecycle attributes: chainage 11.1% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `24` attribute rows, `4` distinct attribute names, covering `8` assets (88.9%). Examples: Address; Asset Identification Date; Contract Region; Tender Asset.
- Operations/evidence: `7,968` linked jobs (885.33 per asset), `6` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `5,262` linked job photos.
- Classification examples: RMC 1 - Urban; SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 4 | Depot |
| RMS new / SRAP-C | 4 | Depot |
| VNZ / Auckland West Transport | 1 | Depot |

### Disaster Recovery Building

- Category: Facilities / Buildings / Buildings / Depots.
- Raw source asset types: Disaster recovery building.
- Asset count: `12` across `1` source labels and `1` source contract values.
- WKT: `12` assets with WKT (100.0%), `12` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `36` attribute rows, `3` distinct attribute names, covering `12` assets (100.0%). Examples: Asset Category; Manufacturer; Serial Number.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 12 | Disaster recovery building |

### Other Building Asset

- Category: Facilities / Buildings / Buildings / Depots.
- Raw source asset types: Other Building Assets.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1` attribute rows, `1` distinct attribute names, covering `1` assets (100.0%). Examples: Description.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Other Building Assets |

### TCC Operation Room

- Category: Facilities / Buildings / Control Rooms.
- Raw source asset types: TCC Operation Room.
- Asset count: `14` across `1` source labels and `1` source contract values.
- WKT: `14` assets with WKT (100.0%), `14` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `42` attribute rows, `3` distinct attribute names, covering `14` assets (100.0%). Examples: Asset Category; Manufacturer; Serial Number.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 14 | TCC Operation Room |

### TCC Server Room

- Category: Facilities / Buildings / Control Rooms.
- Raw source asset types: TCC Server Room.
- Asset count: `22` across `1` source labels and `1` source contract values.
- WKT: `22` assets with WKT (100.0%), `22` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `70` attribute rows, `5` distinct attribute names, covering `22` assets (100.0%). Examples: Asset Category; Manufacturer; Road Section; Serial Number; UPS Component Type.
- Operations/evidence: `3` linked jobs (0.14 per asset), `0` open-overdue job proxy records, `5` linked inspections (0.23 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 22 | TCC Server Room |

### Compound Yard/Outer Grounds

- Category: Facilities / Buildings / Yards / Wash Bays.
- Raw source asset types: Compound Yard/Outer Grounds.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1` attribute rows, `1` distinct attribute names, covering `1` assets (100.0%). Examples: Drawing Ref..
- Operations/evidence: `5` linked jobs (5.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `23` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Compound Yard/Outer Grounds |

### Wash Bay

- Category: Facilities / Buildings / Yards / Wash Bays.
- Raw source asset types: Wash Bay.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `2` linked jobs (2.00 per asset), `0` open-overdue job proxy records, `4` linked inspections (4.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `8` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Wash Bay |

### Access Point

- Category: Footpath / Pedestrian / Access / Access Points.
- Raw source asset types: AP - Access Points.
- Asset count: `34` across `2` source labels and `1` source contract values.
- WKT: `34` assets with WKT (100.0%), `34` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,244` attribute rows, `68` distinct attribute names, covering `34` assets (100.0%). Examples: 01 Cabinet - Comms Medium; 01 Cabinet - Comms Service Provider; 01 Cabinet - Electricity Provider; 01.01 Flex AP -  Part No.; 01.01 Flex AP - Address; 01.01 Flex AP - Installation Date; 01.01 Flex AP - Manufacturer; 01.01 Flex AP - Serial No.; 01.02 POE Injector -  Installation Date; 01.02 POE Injector -  Manufacturer; 01.02 POE Injector -  Part No.; 01.03 Modem -  Installation Date; 01.03 Modem -  Manufacturer; 01.03 Modem -  Part No.; 01.04 Antenna -  Installation Date; 01.04 Antenna -  Manufacturer; 01.04 Antenna -  Part No.; 01.05 Solar Controller -  Installation Date; +50 more.
- Operations/evidence: `18` linked jobs (0.53 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `18` linked job photos.
- Classification examples: SN 2; SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 17 | AP - Access Points |
| RMS new / SRAP-C | 17 | AP - Access Points |

### Boat Ramp

- Category: Footpath / Pedestrian / Access / Access Ramps.
- Raw source asset types: Boat Ramps.
- Asset count: `3` across `1` source labels and `1` source contract values.
- WKT: `3` assets with WKT (100.0%), `3` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3` attribute rows, `1` distinct attribute names, covering `3` assets (100.0%). Examples: Previous Asset ID.
- Operations/evidence: `19` linked jobs (6.33 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `70` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 3 | Boat Ramps |

### Crossing

- Category: Footpath / Pedestrian / Access / Crossings.
- Raw source asset types: Crossings.
- Asset count: `16,629` across `1` source labels and `1` source contract values.
- WKT: `16,629` assets with WKT (100.0%), `16,629` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 56.1%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `731,676` attribute rows, `44` distinct attribute names, covering `16,629` assets (100.0%). Examples: Asset Design Life; Asset Manager Organisation; Asset Owner Organisation; Asset Status; Contract Asset Mapping; Document Link; Durability; End; Geometry; House_no; Individual Length; Installation Date; Is Reflective?; Left Hand Side Offset; Length; Marking Colour; Marking Count; Marking Group; +26 more.
- Operations/evidence: `1` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 16,629 | Crossings |

### Vehicle Crossing

- Category: Footpath / Pedestrian / Access / Crossings.
- Raw source asset types: Vehicle Crossings.
- Asset count: `8` across `2` source labels and `2` source contract values.
- WKT: `8` assets with WKT (100.0%), `8` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `252` attribute rows, `32` distinct attribute names, covering `8` assets (100.0%). Examples: Adjacent Stopping Bays; Asset Description; Asset ID; Chainage; Condition/Grade; Confidence Grade; Construction Year; Control Line; Criticality Criteria; Crossing Length; Crossing width; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Estimated Residual Life; Information Source; Inspection Zone; Latitude; Longitude; +14 more.
- Operations/evidence: `4` linked jobs (0.50 per asset), `0` open-overdue job proxy records, `7` linked inspections (0.88 per asset), `1` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 4 | Vehicle Crossings |
| VNZ / Auckland West Transport | 4 | Vehicle Crossings |

### Cycleway

- Category: Footpath / Pedestrian / Access / Cycleways.
- Raw source asset types: Cycleway.
- Asset count: `2` across `2` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `6.840` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `72` attribute rows, `36` distinct attribute names, covering `2` assets (100.0%). Examples: Asset Identification Date; OBJECTID; SHAPE_Length; SHAPE_Length_1; Tender Asset; alt_name; area_m2; asset_category; base; class; const_date; difficulty; expansion_; geometry; grade; inrdres; isdirectio; length; +18 more.
- Operations/evidence: `16` linked jobs (8.00 per asset), `0` open-overdue job proxy records, `2` linked inspections (1.00 per asset), `2` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `124` linked job photos.
- Classification examples: SN 1, SN 6.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | Cycleway |
| RMS new / SRAP-C | 1 | Cycleway |

### Footpath

- Category: Footpath / Pedestrian / Access / Footpaths / Pathways.
- Raw source asset types: Footpath; Footpaths.
- Asset count: `10,184` across `2` source labels and `2` source contract values.
- WKT: `10,184` assets with WKT (100.0%), `10,184` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; MULTIPOLYGON. Source `SpatialType` values: MultiLineString; Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 98.1%, parent asset 93.8%, stage 100.0%.
- Linear/lifecycle attributes: chainage 93.8% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `436,894` attribute rows, `55` distinct attribute names, covering `10,184` assets (100.0%). Examples: Area; Asset Design Life; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Average Condition Rating; Average Width; BAC Sub Asset ID; Basecourse Date; Basecourse Depth; Bridge UUID; Chip Grade; Comment; Construction Date; Contract Asset Mapping; Document Link; Footpath On Bridge?; Footpath Type; +37 more.
- Operations/evidence: `95` linked jobs (0.01 per asset), `6` open-overdue job proxy records, `28` linked inspections (0.00 per asset), `26` open-overdue inspection proxy records, `5` capital works, `0` direct asset photos, `346` linked job photos.
- Classification examples: Perimeter; RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; +1 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 9,555 | Footpath |
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 629 | Footpaths |

### Pathway

- Category: Footpath / Pedestrian / Access / Footpaths / Pathways.
- Raw source asset types: Pathway; Pathways.
- Asset count: `190` across `2` source labels and `2` source contract values.
- WKT: `190` assets with WKT (100.0%), `190` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING; MULTILINESTRING. Source `SpatialType` values: MultiLineString; Polyline.
- Core attributes: condition 98.4%, criticality 87.9%, risk 0.0%, source classification 100.0%, parent asset 98.4%, stage 100.0%.
- Linear/lifecycle attributes: chainage 95.8% with `23.576` km proxy, construction date 98.4%, construction cost 0.0%, useful life 98.4%, condition date 98.4%.
- Custom attributes: `5,211` attribute rows, `72` distinct attribute names, covering `190` assets (100.0%). Examples: Asset Description; Asset ID; Base Depth; Base Depth (mm); Base Type; BaseType; Centreline; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; Crossing Material; Crossing Type; Crossing Type - Bevelled; Crossing Width; DTP Asset ID; Data Confidence (L)ow, (M)edium, (H)igh; Depth Crossing; +54 more.
- Operations/evidence: `631` linked jobs (3.32 per asset), `4` open-overdue job proxy records, `761` linked inspections (4.01 per asset), `5` open-overdue inspection proxy records, `0` capital works, `16` direct asset photos, `4,151` linked job photos.
- Classification examples: RMC 1; RMC 5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 169 | Pathway |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 21 | Pathways |

### Bluetooth Beacon

- Category: ITS / Traffic Control / Bluetooth / Tolling.
- Raw source asset types: Bluetooth Beacon.
- Asset count: `829` across `1` source labels and `1` source contract values.
- WKT: `829` assets with WKT (100.0%), `829` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,316` attribute rows, `4` distinct attribute names, covering `829` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `3,020` linked jobs (3.64 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `866` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 829 | Bluetooth Beacon |

### Bluetooth Device

- Category: ITS / Traffic Control / Bluetooth / Tolling.
- Raw source asset types: ITS - Bluetooth Device.
- Asset count: `10` across `1` source labels and `1` source contract values.
- WKT: `10` assets with WKT (100.0%), `10` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `100` attribute rows, `10` distinct attribute names, covering `10` assets (100.0%). Examples: Bluetooth ID; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV Asset ID; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 10 | ITS - Bluetooth Device |

### Tolling Point

- Category: ITS / Traffic Control / Bluetooth / Tolling.
- Raw source asset types: ITS - Tolling Point.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `8` attribute rows, `8` distinct attribute names, covering `1` assets (100.0%). Examples: Control Line; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `1` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | ITS - Tolling Point |

### Closed Circuit Television

- Category: ITS / Traffic Control / Cameras / CCTV.
- Raw source asset types: Close Circuit Television; ITS - CCTV.
- Asset count: `1,041` across `2` source labels and `2` source contract values.
- WKT: `1,041` assets with WKT (100.0%), `1,041` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 1.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 1.9%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 1.9%, construction cost 0.0%, useful life 0.0%, condition date 1.9%.
- Custom attributes: `4,284` attribute rows, `14` distinct attribute names, covering `1,041` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); CCTV ID; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV ID; Service Status; Suburb; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate; Zone.
- Operations/evidence: `3,799` linked jobs (3.65 per asset), `0` open-overdue job proxy records, `187` linked inspections (0.18 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2,746` linked job photos.
- Classification examples: ITS; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 1,021 | Close Circuit Television |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 20 | ITS - CCTV |

### QPS Camera

- Category: ITS / Traffic Control / Cameras / CCTV.
- Raw source asset types: ITS - QPS Camera.
- Asset count: `10` across `1` source labels and `1` source contract values.
- WKT: `10` assets with WKT (100.0%), `10` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `110` attribute rows, `11` distinct attribute names, covering `10` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV ID; Site Name; Type; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `1` linked jobs (0.10 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 10 | ITS - QPS Camera |

### Webcam

- Category: ITS / Traffic Control / Cameras / CCTV.
- Raw source asset types: ITS - Webcam.
- Asset count: `4` across `1` source labels and `1` source contract values.
- WKT: `4` assets with WKT (100.0%), `4` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `40` attribute rows, `10` distinct attribute names, covering `4` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV Asset ID; Verification Comments; Webcam ID; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `1` linked jobs (0.25 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 4 | ITS - Webcam |

### Infrared Traffic Logger

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: TIRTL - Infra Red Traffic Logger.
- Asset count: `38` across `2` source labels and `1` source contract values.
- WKT: `38` assets with WKT (100.0%), `38` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,166` attribute rows, `59` distinct attribute names, covering `38` assets (100.0%). Examples: 01 Cabinet - Comms Medium; 01 Cabinet - Comms Service Provider; 01 Cabinet - Electricity Provider; 01.01 Power Supply -  Part No.; 01.01 Power Supply - Installation Date; 01.01 Power Supply - Manufacturer; 01.02 Modem -  Part No.; 01.02 Modem - Installation Date; 01.02 Modem - Manufacturer; 01.03 Antenna -  Part No.; 01.03 Antenna - Installation Date; 01.03 Antenna - Manufacturer; 01.04 Solar Controller -  Installation Date; 01.04 Solar Controller -  Manufacturer; 01.04 Solar Controller -  Part No.; 01.05 Battery Charger -  Installation Date; 01.05 Battery Charger -  Manufacturer; 01.05 Battery Charger -  Part No.; +41 more.
- Operations/evidence: `176` linked jobs (4.63 per asset), `0` open-overdue job proxy records, `38` linked inspections (1.00 per asset), `38` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `352` linked job photos.
- Classification examples: SN 2; SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 19 | TIRTL - Infra Red Traffic Logger |
| RMS new / SRAP-C | 19 | TIRTL - Infra Red Traffic Logger |

### Over-height Detection System

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: OHDS - Over Height Detection Systems.
- Asset count: `32` across `2` source labels and `1` source contract values.
- WKT: `32` assets with WKT (100.0%), `32` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,496` attribute rows, `78` distinct attribute names, covering `32` assets (100.0%). Examples: 01.01 Controller - Battery Installation Date; 01.01 Controller - Battery Type; 01.01 Controller - Comms Medium; 01.01 Controller - Comms Provider; 01.01 Controller - Electricity Provider; 01.01 Controller - Installation Date; 01.01 Controller - Manuals (Hyperlink); 01.01 Controller - Manufacturer; 01.01 Controller - Number of batteries; 01.01 Controller - Part No.; 01.01 Controller - Solar; 01.02 Sensor - Installation Date; 01.02 Sensor - Manuals (Hyperlink); 01.02 Sensor - Manufacturer; 01.02 Sensor - Part No.; 02.01 Controller - Battery Installation Date; 02.01 Controller - Battery Type; 02.01 Controller - Comms Medium; +60 more.
- Operations/evidence: `48` linked jobs (1.50 per asset), `0` open-overdue job proxy records, `26` linked inspections (0.81 per asset), `14` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `432` linked job photos.
- Classification examples: SN 1; SN 2; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 16 | OHDS - Over Height Detection Systems |
| RMS new / SRAP-C | 16 | OHDS - Over Height Detection Systems |

### Over-speed Detection System

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: OSDS - Over Speed Detection Systems.
- Asset count: `170` across `2` source labels and `1` source contract values.
- WKT: `170` assets with WKT (100.0%), `170` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `9,744` attribute rows, `58` distinct attribute names, covering `170` assets (100.0%). Examples: 01 Controller - Battery Installation Date; 01 Controller - Battery Type; 01 Controller - Comms Medium; 01 Controller - Comms Provider; 01 Controller - Electricity Provider; 01 Controller - Installation Date; 01 Controller - Manuals (Hyperlink); 01 Controller - Manufacturer; 01 Controller - Number of batteries; 01 Controller - Part No.; 01 Controller - Solar; 02 Sensor 1 - Installation Date; 02 Sensor 1 - Manuals (Hyperlink); 02 Sensor 1 - Manufacturer; 02 Sensor 1 - Part No.; 03 Sensor 2 - Installation Date; 03 Sensor 2 - Manuals (Hyperlink); 03 Sensor 2 - Manufacturer; +40 more.
- Operations/evidence: `156` linked jobs (0.92 per asset), `0` open-overdue job proxy records, `162` linked inspections (0.95 per asset), `0` open-overdue inspection proxy records, `4` capital works, `0` direct asset photos, `1,162` linked job photos.
- Classification examples: SN 2; SN 3; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 85 | OSDS - Over Speed Detection Systems |
| RMS new / SRAP-C | 85 | OSDS - Over Speed Detection Systems |

### Traffic Measurement System

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: Traffic Measurement System.
- Asset count: `2` across `1` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 100.0%, condition date 100.0%.
- Custom attributes: `20` attribute rows, `10` distinct attribute names, covering `2` assets (100.0%). Examples: Area; Existing Lanes; Location; Locations; PowerBI Data Link; Project Road; Speed Zone; TMD Material; Traffic Management Type; Traffic Measurement Type.
- Operations/evidence: `2` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `39` linked job photos.
- Classification examples: RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 2 | Traffic Measurement System |

### Traffic Monitoring Unit

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: TMU - Traffic Monitoring Unit.
- Asset count: `126` across `2` source labels and `1` source contract values.
- WKT: `126` assets with WKT (100.0%), `126` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `9,984` attribute rows, `65` distinct attribute names, covering `126` assets (100.0%). Examples: 01 Counter - Installation Date; 01 Counter - Manufacturer; 01 Counter - Serial No.; 01 Counter - System Integration; 01 Counter - Traffic Counter Controller Y/N; 01 Counter - Type; 02 Cabinet - Cabinet ID; 02 Cabinet - Comms Medium; 02 Cabinet - Comms Service Provider; 02 Cabinet - Comms Services; 02 Cabinet - Electricity Provider; 02.01 Controller -  Part No.; 02.01 Controller - Address; 02.01 Controller - Firmware Ver; 02.01 Controller - Installation Date; 02.01 Controller - Serial No.; 02.02 Modem -  Installation Date; 02.02 Modem -  Manufacturer; +47 more.
- Operations/evidence: `530` linked jobs (4.21 per asset), `10` open-overdue job proxy records, `100` linked inspections (0.79 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `4,422` linked job photos.
- Classification examples: SN 1; SN 2.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 63 | TMU - Traffic Monitoring Unit |
| RMS new / SRAP-C | 63 | TMU - Traffic Monitoring Unit |

### Vehicle Detection Station

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: Vehicle Detection Station.
- Asset count: `745` across `1` source labels and `1` source contract values.
- WKT: `745` assets with WKT (100.0%), `745` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,980` attribute rows, `4` distinct attribute names, covering `745` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `1,894` linked jobs (2.54 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `650` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 745 | Vehicle Detection Station |

### Vehicle Detection and Classification System

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: VDCS - Vehicle Detection & Classification System.
- Asset count: `624` across `2` source labels and `1` source contract values.
- WKT: `624` assets with WKT (100.0%), `624` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `41,184` attribute rows, `66` distinct attribute names, covering `624` assets (100.0%). Examples: 01 Counter - Installation Date; 01 Counter - Serial No.; 01 Counter - System Integration; 01 Counter - Traffic Counter Controller Y/N; 01 Counter - Type; 01 Sign - Manufacturer; 02 Cabinet - Comms Medium; 02 Cabinet - Comms Service Provider; 02 Cabinet - Comms Services; 02 Cabinet - Electricity Provider; 02.01 Controller -  Part No.; 02.01 Controller - Address; 02.01 Controller - Firmware Ver; 02.01 Controller - Installation Date; 02.01 Controller - Serial No.; 02.02 Modem -  Installation Date; 02.02 Modem -  Manufacturer; 02.02 Modem -  Part No.; +48 more.
- Operations/evidence: `272` linked jobs (0.44 per asset), `0` open-overdue job proxy records, `334` linked inspections (0.54 per asset), `0` open-overdue inspection proxy records, `0` capital works, `6` direct asset photos, `2,894` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 312 | VDCS - Vehicle Detection & Classification System |
| RMS new / SRAP-C | 312 | VDCS - Vehicle Detection & Classification System |

### Vehicle Detector and Classifier

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: ITS - Vehicle Detector and Classifier.
- Asset count: `21` across `1` source labels and `1` source contract values.
- WKT: `21` assets with WKT (100.0%), `21` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `231` attribute rows, `11` distinct attribute names, covering `21` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV ID; VD ID; VD Type; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `119` linked jobs (5.67 per asset), `42` open-overdue job proxy records, `67` linked inspections (3.19 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `3` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 21 | ITS - Vehicle Detector and Classifier |

### Weigh in Motion

- Category: ITS / Traffic Control / Detection / Classification.
- Raw source asset types: WIM - Weigh in Motion.
- Asset count: `26` across `2` source labels and `1` source contract values.
- WKT: `26` assets with WKT (100.0%), `26` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,748` attribute rows, `70` distinct attribute names, covering `26` assets (100.0%). Examples: 01 Cabinet - Comms Medium; 01 Cabinet - Comms Service Provider; 01 Cabinet - Electricity Provider; 01.01 Data Logger -  Part No.; 01.01 Data Logger - Address; 01.01 Data Logger - Firmware Ver; 01.01 Data Logger - Installation Date; 01.01 Data Logger - Manufacturer; 01.01 Data Logger - Serial No.; 01.02 Modem -  Part No.; 01.02 Modem - Installation Date; 01.02 Modem - Manufacturer; 01.03 Power Supply -  Part No.; 01.03 Power Supply - Installation Date; 01.03 Power Supply - Manufacturer; 01.04 Battery Charger -  Installation Date; 01.04 Battery Charger -  Manufacturer; 01.04 Battery Charger -  Part No.; +52 more.
- Operations/evidence: `62` linked jobs (2.38 per asset), `0` open-overdue job proxy records, `28` linked inspections (1.08 per asset), `6` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `458` linked job photos.
- Classification examples: SN 2; SN 3; SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 13 | WIM - Weigh in Motion |
| RMS new / SRAP-C | 13 | WIM - Weigh in Motion |

### Emergency Phone

- Category: ITS / Traffic Control / Emergency Phones.
- Raw source asset types: METS - Emergency Phones.
- Asset count: `792` across `2` source labels and `1` source contract values.
- WKT: `792` assets with WKT (100.0%), `792` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `29,630` attribute rows, `38` distinct attribute names, covering `792` assets (100.0%). Examples: 01 Telephone - Battery Installation Date; 01 Telephone - Battery Type; 01 Telephone - Comms Medium; 01 Telephone - Comms Provider; 01 Telephone - Electricity Provider; 01 Telephone - Handset Upgrade Date; 01 Telephone - Handset Upgrade Manuf.; 01 Telephone - Handset Upgrade Model; 01 Telephone - Installation Date; 01 Telephone - Manuals (Hyperlink); 01 Telephone - Manufacturer; 01 Telephone - Model; 01 Telephone - Number of batteries; 01 Telephone - Phone Number; 01 Telephone - Solar; 02 Solar Panel - Manufacturer; 03 Solar Panel - Part No.; 04 Solar Panel - Installation  Date; +20 more.
- Operations/evidence: `2,040` linked jobs (2.58 per asset), `132` open-overdue job proxy records, `634` linked inspections (0.80 per asset), `2` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `6,414` linked job photos.
- Classification examples: SN 1; SN 2; SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 396 | METS - Emergency Phones |
| RMS new / SRAP-C | 396 | METS - Emergency Phones |

### Help Phone

- Category: ITS / Traffic Control / Emergency Phones.
- Raw source asset types: Help Phone.
- Asset count: `614` across `1` source labels and `1` source contract values.
- WKT: `614` assets with WKT (100.0%), `614` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,456` attribute rows, `4` distinct attribute names, covering `614` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `2,166` linked jobs (3.53 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `74` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 614 | Help Phone |

### ITS Electrical and Communications Pit

- Category: ITS / Traffic Control / ITS Field Infrastructure.
- Raw source asset types: ITS - Elec & Coms Pits.
- Asset count: `1,211` across `1` source labels and `1` source contract values.
- WKT: `1,211` assets with WKT (100.0%), `1,211` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `23,001` attribute rows, `19` distinct attribute names, covering `1,211` assets (100.0%). Examples: Access; Control Line; Control System Type; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Housing Type; Information Source; Installer; Maint; Manufacturer; Offset; Prev. AV Asset ID; Side; Site Name; Type; Verification Comments; X Coordinate; Y Coordinate; +1 more.
- Operations/evidence: `5` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `7` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1,211 | ITS - Elec & Coms Pits |

### ITS Field Cabinet

- Category: ITS / Traffic Control / ITS Field Infrastructure.
- Raw source asset types: ITS - Field Cabinet.
- Asset count: `48` across `1` source labels and `1` source contract values.
- WKT: `48` assets with WKT (100.0%), `48` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `1,728` attribute rows, `36` distinct attribute names, covering `48` assets (100.0%). Examples: Access; Comm Method; Control Line; Controller ID (Switchboard); Controller System Type; Data Confidence (L)ow, (M)edium, (H)igh; Defect End; Defect Start; Drawing Ref.; Field Network; Housing Type; IP Address; Information Source; Installer; Maint; Manufacturer; Model Number; Mounting Type; +18 more.
- Operations/evidence: `22` linked jobs (0.46 per asset), `0` open-overdue job proxy records, `238` linked inspections (4.96 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `35` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 48 | ITS - Field Cabinet |

### Lane Use Management System

- Category: ITS / Traffic Control / Traffic Control Systems.
- Raw source asset types: Lane Use Management System.
- Asset count: `36` across `1` source labels and `1` source contract values.
- WKT: `36` assets with WKT (100.0%), `36` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `144` attribute rows, `4` distinct attribute names, covering `36` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 36 | Lane Use Management System |

### Ramp Metering Control Signal

- Category: ITS / Traffic Control / Traffic Control Systems.
- Raw source asset types: RMCS - Ramp Metering Control Signals.
- Asset count: `16` across `2` source labels and `1` source contract values.
- WKT: `16` assets with WKT (100.0%), `16` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `288` attribute rows, `19` distinct attribute names, covering `16` assets (100.0%). Examples: Additional Notes; Asset Identification Date; Conops Rank; Contract Region; Design Document (Hyperlink); EWP Required?; Equipment ID; Maintainer; Manuals (Hyperlink); Nearest Cross Road; Primary Road; Region; Road Code; SWMS Link; Service Schedule Link; Sub-Zone; TM Reqd?; TMP Link; +1 more.
- Operations/evidence: `2` linked jobs (0.12 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `24` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 8 | RMCS - Ramp Metering Control Signals |
| RMS new / SRAP-C | 8 | RMCS - Ramp Metering Control Signals |

### Traffic Facilities

- Category: ITS / Traffic Control / Traffic Control Systems.
- Raw source asset types: Traffic Facilities.
- Asset count: `626` across `1` source labels and `1` source contract values.
- WKT: `626` assets with WKT (100.0%), `626` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `22,536` attribute rows, `36` distinct attribute names, covering `626` assets (100.0%). Examples: Asset Design Life; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Attached to Asset ID; Background Colour; Connection Details; Connection Mode; Contract Asset Mapping; Critical Clearance Requirements?; Document Link; Geometry; Has Reverse Legend?; Height; Installation Date; Is TCD Sign Type?; Legend Text; Mounting Height To Underside Of Sign; +18 more.
- Operations/evidence: `1` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `7` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 626 | Traffic Facilities |

### Traffic Management Device

- Category: ITS / Traffic Control / Traffic Control Systems.
- Raw source asset types: Traffic Management Device.
- Asset count: `34` across `1` source labels and `1` source contract values.
- WKT: `34` assets with WKT (100.0%), `34` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 82.4%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 82.4%, construction cost 0.0%, useful life 82.4%, condition date 82.4%.
- Custom attributes: `1,799` attribute rows, `54` distinct attribute names, covering `34` assets (100.0%). Examples: Asset Description; Asset ID; Bedding Sand Depth; Chainage; Concrete Depth; Concrete Strength; Condition/Grade; Confidence Grade; Construction Year; Control Line; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Diameter of roundabout; Drawing Ref.; Estimated Residual Life; Finish; Infill Area; Information Source; +36 more.
- Operations/evidence: `9` linked jobs (0.26 per asset), `0` open-overdue job proxy records, `40` linked inspections (1.18 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `5` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 34 | Traffic Management Device |

### Traffic Management System

- Category: ITS / Traffic Control / Traffic Control Systems.
- Raw source asset types: Traffic Management System.
- Asset count: `18` across `1` source labels and `1` source contract values.
- WKT: `18` assets with WKT (100.0%), `18` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 94.4%, condition date 100.0%.
- Custom attributes: `126` attribute rows, `7` distinct attribute names, covering `18` assets (100.0%). Examples: Area; Existing Lanes; Locations; PowerBI Data Link; Speed Zone; TMD Material; Traffic Management Type.
- Operations/evidence: `21` linked jobs (1.17 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `8` capital works, `0` direct asset photos, `279` linked job photos.
- Classification examples: RMC 2; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 18 | Traffic Management System |

### Road Weather Information System

- Category: ITS / Traffic Control / Traffic Monitoring / Weather.
- Raw source asset types: RWIS - Road Weather Info Systems.
- Asset count: `8` across `2` source labels and `1` source contract values.
- WKT: `8` assets with WKT (100.0%), `8` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 4 | RWIS - Road Weather Info Systems |
| RMS new / SRAP-C | 4 | RWIS - Road Weather Info Systems |

### Road Weather Monitoring System

- Category: ITS / Traffic Control / Traffic Monitoring / Weather.
- Raw source asset types: ITS - Road Weather Monitoring System.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `10` attribute rows, `10` distinct attribute names, covering `1` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV ID; RWMS ID; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `1` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `22` linked inspections (22.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | ITS - Road Weather Monitoring System |

### Ramp Signal Controller

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: Ramp Signal Controller.
- Asset count: `31` across `1` source labels and `1` source contract values.
- WKT: `31` assets with WKT (100.0%), `31` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `124` attribute rows, `4` distinct attribute names, covering `31` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 31 | Ramp Signal Controller |

### Traffic Control Signal

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: TCS - Traffic Control Signals.
- Asset count: `1,894` across `2` source labels and `1` source contract values.
- WKT: `1,894` assets with WKT (100.0%), `1,894` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `154,245` attribute rows, `82` distinct attribute names, covering `1,894` assets (100.0%). Examples: 01 Cabinet - Comms Medium; 01 Cabinet - Comms Provider; 01 Cabinet - Electricity Provider; 01 Cabinet - Installation Date; 01 Cabinet - Post Mount; 01 Cabinet - SCATS Linked; 01 Cabinet - Size; 01 Cabinet - Top Hat (VEN); 01.01 Logic Rack - Address; 01.01 Logic Rack - Comms Type (VEN); 01.01 Logic Rack - Installation Date; 01.01 Logic Rack - Logic Rack Detectors; 01.01 Logic Rack - Manuals (Hyperlink); 01.01 Logic Rack - Manufacturer; 01.01 Logic Rack - Model; 01.01 Logic Rack - Modem Type (VEN); 01.01 Logic Rack - Personality ID; 01.01 Logic Rack - Power Supply; +64 more.
- Operations/evidence: `57,652` linked jobs (30.44 per asset), `666` open-overdue job proxy records, `2,776` linked inspections (1.47 per asset), `1,000` open-overdue inspection proxy records, `48` capital works, `10` direct asset photos, `380,021` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 947 | TCS - Traffic Control Signals |
| RMS new / SRAP-C | 947 | TCS - Traffic Control Signals |

### Traffic Control Signal Lantern

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: TCS (Lanterns).
- Asset count: `5,506` across `2` source labels and `1` source contract values.
- WKT: `5,506` assets with WKT (100.0%), `5,506` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Inherited.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `396,432` attribute rows, `73` distinct attribute names, covering `5,506` assets (100.0%). Examples: Asset Identification Date; Lantern 1 (Type); Lantern 1 - If Not, List Issues (VEN); Lantern 1 Aspect Manufacturer (VEN); Lantern 1 CCTV (VEN); Lantern 1 Insert Install Date; Lantern 1 Insert Part No; Lantern 1 Louvre Qty; Lantern 1 Louvre Type; Lantern 1 Regulatory Signs As Per Drawing (VEN); Lantern 1 Visor Type; Lantern 2 (Type); Lantern 2 - If Not, List Issues (VEN); Lantern 2 Aspect Manufacturer (VEN); Lantern 2 CCTV (VEN); Lantern 2 Insert Install Date; Lantern 2 Insert Part No; Lantern 2 Louvre Qty; +55 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 2,753 | TCS (Lanterns) |
| RMS new / SRAP-C | 2,753 | TCS (Lanterns) |

### Traffic Control Signal Loop

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: TCS (Loops).
- Asset count: `2,690` across `2` source labels and `1` source contract values.
- WKT: `2,690` assets with WKT (100.0%), `2,690` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Inherited.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `16,140` attribute rows, `7` distinct attribute names, covering `2,690` assets (100.0%). Examples: Asset Identification Date; Configuration; Installation Date; Loop No.; Priority; Tender Asset; Type.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1,345 | TCS (Loops) |
| RMS new / SRAP-C | 1,345 | TCS (Loops) |

### Traffic Control Signal Post

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: TCS (Post).
- Asset count: `3,942` across `2` source labels and `1` source contract values.
- WKT: `3,942` assets with WKT (100.0%), `3,942` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Inherited.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `94,608` attribute rows, `25` distinct attribute names, covering `3,942` assets (100.0%). Examples: Asset Identification Date; Certified Structural Inspection Required?; Footing; Height; Mast Arm Type; Outreach Distance; Post No.; Pushbutton 1 - Manuals (Hyperlink); Pushbutton 1 - Pushbutton Install Date; Pushbutton 1 - Pushbutton Manuf; Pushbutton 1 - Pushbutton Part No; Pushbutton 1 - Pushbutton Type; Pushbutton 1 - TA Driver Install Date; Pushbutton 1 - TA Driver Part No; Pushbutton 1 - TA Driver Type; Pushbutton 2 - Manuals (Hyperlink); Pushbutton 2 - Pushbutton Install Date; Pushbutton 2 - Pushbutton Manuf; +7 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1,971 | TCS (Post) |
| RMS new / SRAP-C | 1,971 | TCS (Post) |

### Traffic Signal

- Category: ITS / Traffic Control / Traffic Signals.
- Raw source asset types: Traffic Signals.
- Asset count: `1,318` across `2` source labels and `2` source contract values.
- WKT: `1,318` assets with WKT (100.0%), `1,318` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 10.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 10.9%, stage 100.0%.
- Linear/lifecycle attributes: chainage 10.9% with `0.000` km proxy, construction date 10.9%, construction cost 0.0%, useful life 0.0%, condition date 10.9%.
- Custom attributes: `14,810` attribute rows, `76` distinct attribute names, covering `1,318` assets (100.0%). Examples: Access to Asset; Asset Description; Asset ID; Associated Site (Bluetooth Beacon); Attachments Type Present on the Poles; Call Box Model Number; Chainage; Condition/Grade; Conduit Details; Confidence Grade; Construction Year; Control Line; Control System Type; Controller ID; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Data Logger Present; Defects Liability End Date; +58 more.
- Operations/evidence: `5,835` linked jobs (4.43 per asset), `315` open-overdue job proxy records, `278` linked inspections (0.21 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `8,283` linked job photos.
- Classification examples: ITS; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 1,174 | Traffic Signals |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 144 | Traffic Signals |

### Channel

- Category: Kerb / Channel / Road Edge / Kerb and Channel.
- Raw source asset types: Channel.
- Asset count: `11,639` across `1` source labels and `1` source contract values.
- WKT: `11,639` assets with WKT (100.0%), `11,639` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.4%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `465,560` attribute rows, `40` distinct attribute names, covering `11,639` assets (100.0%). Examples: Asset Design Life; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Base Width; Channel Material; Channel Type; Construction Method; Contract Asset Mapping; Document Link; Geometry; Geotech Channel Type; Has Drainage Chip?; Has Geotextile?; Installation Date; Is Heritage?; Is Subsoil Pipe Included?; Length; +22 more.
- Operations/evidence: `154` linked jobs (0.01 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `1,035` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 11,639 | Channel |

### Kerb

- Category: Kerb / Channel / Road Edge / Kerb and Channel.
- Raw source asset types: Kerbs.
- Asset count: `898` across `1` source labels and `1` source contract values.
- WKT: `898` assets with WKT (100.0%), `898` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING; MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `10,776` attribute rows, `12` distinct attribute names, covering `898` assets (100.0%). Examples: Asset Type; Block No; Comment; From Street; Inspector; Kerb Profile; Length; Material; Parent Asset; Side; Suburb; To Street.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `3` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: Local Street; T1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 898 | Kerbs |

### Kerb and Channel

- Category: Kerb / Channel / Road Edge / Kerb and Channel.
- Raw source asset types: Kerb and Channel.
- Asset count: `27,898` across `2` source labels and `2` source contract values.
- WKT: `27,898` assets with WKT (100.0%), `27,898` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 82.4%, criticality 96.0%, risk 0.0%, source classification 85.3%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `3.933` km proxy, construction date 97.2%, construction cost 0.0%, useful life 82.7%, condition date 82.4%.
- Custom attributes: `274,959` attribute rows, `58` distinct attribute names, covering `27,898` assets (100.0%). Examples: Asset Description; Asset ID; Back of Kerb; Centreline; Chainage End; Chainage Start; Channel; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; DTP Asset ID; Data Confidence (L)ow, (M)edium, (H)igh; Depth; Drawing Ref.; End X Coord; End Y Coord; Estimated Residual Life; +40 more.
- Operations/evidence: `3,860` linked jobs (0.14 per asset), `110` open-overdue job proxy records, `901` linked inspections (0.03 per asset), `59` open-overdue inspection proxy records, `0` capital works, `238` direct asset photos, `14,853` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 27,670 | Kerb and Channel |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 228 | Kerb and Channel |

### Berm

- Category: Kerb / Channel / Road Edge / Shoulders / Berms.
- Raw source asset types: Berms.
- Asset count: `8,843` across `1` source labels and `1` source contract values.
- WKT: `8,843` assets with WKT (100.0%), `8,843` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 98.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `123,802` attribute rows, `14` distinct attribute names, covering `8,843` assets (100.0%). Examples: Asset Owner; Contract Asset Mapping; Document Link; End; Length; Length Adjust Reason; Start; Width; berm_cover; berm_type; id; offset; side; trees.
- Operations/evidence: `6` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `13` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 8,843 | Berms |

### Road Shoulder

- Category: Kerb / Channel / Road Edge / Shoulders / Berms.
- Raw source asset types: Road Shoulder.
- Asset count: `581` across `1` source labels and `1` source contract values.
- WKT: `581` assets with WKT (100.0%), `581` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 98.3%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `79.780` km proxy, construction date 98.3%, construction cost 0.0%, useful life 98.3%, condition date 98.3%.
- Custom attributes: `4,061` attribute rows, `7` distinct attribute names, covering `581` assets (100.0%). Examples: DTP Asset ID; Road_Section_ID; Shoulder Length (m); Shoulder Location; Shoulder Material; Shoulder Width (m); Third Party Site.
- Operations/evidence: `839` linked jobs (1.44 per asset), `6` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `86` direct asset photos, `5,162` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 3, RMC 4; RMC 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 581 | Road Shoulder |

### Shoulder

- Category: Kerb / Channel / Road Edge / Shoulders / Berms.
- Raw source asset types: Shoulders.
- Asset count: `323` across `1` source labels and `1` source contract values.
- WKT: `323` assets with WKT (100.0%), `323` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `16,150` attribute rows, `49` distinct attribute names, covering `323` assets (100.0%). Examples: Additive Details; Additive Used?; Adhesion Agent Details; Adhesion Agent Used?; Application Rate; Asset Design Life; Calculated Thickness; Construction Date; Contract Asset Mapping; Cutter; Cutter Quantity; Document Link; Flux Quantity; From Distance; Geometry; Includes Recycled Aggregate?; Is Cutter Used?; Is Flux Used?; +31 more.
- Operations/evidence: `5` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `27` linked job photos.
- Classification examples: RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 323 | Shoulders |

### Distribution Board

- Category: Lighting / Electrical / Mechanical / Electrical Distribution.
- Raw source asset types: Distribution Boards.
- Asset count: `32` across `1` source labels and `1` source contract values.
- WKT: `32` assets with WKT (100.0%), `32` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `32` attribute rows, `1` distinct attribute names, covering `32` assets (100.0%). Examples: Location Description.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 32 | Distribution Boards |

### Electrical

- Category: Lighting / Electrical / Mechanical / Electrical Distribution.
- Raw source asset types: Electrical.
- Asset count: `3` across `1` source labels and `1` source contract values.
- WKT: `3` assets with WKT (100.0%), `3` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 33.3%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `23` attribute rows, `8` distinct attribute names, covering `3` assets (100.0%). Examples: AED Asset Number; AED Asset Tag; Asset Description; Asset Manufacturer/Brand; Description; Electrical Asset Type; Location; Road Section.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `12` linked inspections (4.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 3 | Electrical |

### ITS Switchboard

- Category: Lighting / Electrical / Mechanical / Electrical Distribution.
- Raw source asset types: ITS - Switchboard.
- Asset count: `27` across `1` source labels and `1` source contract values.
- WKT: `27` assets with WKT (100.0%), `27` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `814` attribute rows, `32` distinct attribute names, covering `27` assets (100.0%). Examples: Access; Cabinet Type; Control Line; Data Confidence (L)ow, (M)edium, (H)igh; Defect Start; Defects End; Drawing Ref.; Field Network; Information Source; Installer; Layout Drawing; Maint; Manufacturer; Mounting type; Offset; Power Source; Power Source Type; QGIS fid; +14 more.
- Operations/evidence: `4` linked jobs (0.15 per asset), `0` open-overdue job proxy records, `25` linked inspections (0.93 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `4` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 27 | ITS - Switchboard |

### Low Voltage System

- Category: Lighting / Electrical / Mechanical / Electrical Distribution.
- Raw source asset types: Low Voltage Systems.
- Asset count: `251` across `1` source labels and `1` source contract values.
- WKT: `251` assets with WKT (100.0%), `251` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 87.3%, criticality 41.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 87.3%.
- Custom attributes: `18,918` attribute rows, `78` distinct attribute names, covering `251` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `17` linked jobs (0.07 per asset), `0` open-overdue job proxy records, `1,715` linked inspections (6.83 per asset), `127` open-overdue inspection proxy records, `1` capital works, `3` direct asset photos, `27` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 251 | Low Voltage Systems |

### Fire Detection and Suppression System

- Category: Lighting / Electrical / Mechanical / Fire Systems.
- Raw source asset types: Fire Detection and Suppression Systems.
- Asset count: `1,859` across `1` source labels and `1` source contract values.
- WKT: `1,859` assets with WKT (100.0%), `1,859` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 70.3%, criticality 58.6%, risk 0.0%, source classification 99.9%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 70.3%.
- Custom attributes: `144,315` attribute rows, `80` distinct attribute names, covering `1,859` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +62 more.
- Operations/evidence: `69` linked jobs (0.04 per asset), `0` open-overdue job proxy records, `9,892` linked inspections (5.32 per asset), `501` open-overdue inspection proxy records, `6` capital works, `2` direct asset photos, `199` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 1,859 | Fire Detection and Suppression Systems |

### Fire System

- Category: Lighting / Electrical / Mechanical / Fire Systems.
- Raw source asset types: Fire Systems.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Fire Systems |

### Operations and Maintenance Fire System

- Category: Lighting / Electrical / Mechanical / Fire Systems.
- Raw source asset types: O&M Fire Systems.
- Asset count: `6` across `1` source labels and `1` source contract values.
- WKT: `6` assets with WKT (100.0%), `6` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `40` attribute rows, `8` distinct attribute names, covering `6` assets (100.0%). Examples: AED Asset Number; AED Asset Tag; Asset Description; Asset Location; Asset Manufacturer/Brand; Description; Fire System Type; Location.
- Operations/evidence: `65` linked jobs (10.83 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 6 | O&M Fire Systems |

### Passive Fire System

- Category: Lighting / Electrical / Mechanical / Fire Systems.
- Raw source asset types: Passive Fire Systems.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `4` attribute rows, `4` distinct attribute names, covering `1` assets (100.0%). Examples: Asset Description; Asset Manufacturer/Brand; Fire System Type; Location.
- Operations/evidence: `10` linked jobs (10.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Passive Fire Systems |

### Portable Fire Equipment

- Category: Lighting / Electrical / Mechanical / Fire Systems.
- Raw source asset types: Portable Fire Equipment.
- Asset count: `31` across `1` source labels and `1` source contract values.
- WKT: `31` assets with WKT (100.0%), `31` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `302` attribute rows, `10` distinct attribute names, covering `31` assets (100.0%). Examples: AED Asset Number; AED Asset Tag; Asset Material Type; Asset size; Equipment Asset Type; Extinguisher Location; Extinguisher Material Type; Extinguisher age; Extinguisher size; Location.
- Operations/evidence: `536` linked jobs (17.29 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 31 | Portable Fire Equipment |

### Lighting

- Category: Lighting / Electrical / Mechanical / Lighting Assets.
- Raw source asset types: Lighting.
- Asset count: `548` across `1` source labels and `1` source contract values.
- WKT: `548` assets with WKT (100.0%), `548` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 100.0%, condition date 100.0%.
- Custom attributes: `34,518` attribute rows, `62` distinct attribute names, covering `548` assets (100.0%). Examples: Alignment; Asset Description; Asset ID; Bracket Angle; Bracket Height; Bracket Length; Bracket Material; Bracket Mounting Type; Bracket Orientation; Bracket type; Bulk Circuit Connection; Chainage; Condition/Grade; Confidence Grade; Connection Type; Construction Year; Control Line; Control Point Number; +44 more.
- Operations/evidence: `8` linked jobs (0.01 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `25` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 548 | Lighting |

### Lighting and Switching System

- Category: Lighting / Electrical / Mechanical / Lighting Assets.
- Raw source asset types: Lighting and Switching Systems.
- Asset count: `674` across `1` source labels and `1` source contract values.
- WKT: `674` assets with WKT (100.0%), `674` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 90.9%, criticality 56.2%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 91.1%.
- Custom attributes: `51,724` attribute rows, `78` distinct attribute names, covering `674` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `27` linked jobs (0.04 per asset), `0` open-overdue job proxy records, `3,020` linked inspections (4.48 per asset), `46` open-overdue inspection proxy records, `3` capital works, `0` direct asset photos, `104` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 674 | Lighting and Switching Systems |

### Road Lighting

- Category: Lighting / Electrical / Mechanical / Lighting Assets.
- Raw source asset types: Road Lighting.
- Asset count: `825` across `1` source labels and `1` source contract values.
- WKT: `825` assets with WKT (100.0%), `825` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,300` attribute rows, `4` distinct attribute names, covering `825` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `3,283` linked jobs (3.98 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `2` capital works, `11` direct asset photos, `5,286` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 825 | Road Lighting |

### Street and Area Lighting

- Category: Lighting / Electrical / Mechanical / Lighting Assets.
- Raw source asset types: Street & Area Lighting.
- Asset count: `637` across `1` source labels and `1` source contract values.
- WKT: `637` assets with WKT (100.0%), `637` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `16,556` attribute rows, `26` distinct attribute names, covering `637` assets (100.0%). Examples: Asset ID; Base; Base Dia (mm); Energex Number; Fitting Type; Joint Fuse Size (A); Joint type; Lamp Supply Cable Size (mm); Lamp Type (SON MV MH); Lamp size (w); Main Supply Cable Size (mm); Manufacturer; Metadata; ModelNumber; Mounting Height (m); Outreach size (m); Outreach type; PE Cell (Group or Ind); +8 more.
- Operations/evidence: `38` linked jobs (0.06 per asset), `13` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `143` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 637 | Street & Area Lighting |

### Streetlight

- Category: Lighting / Electrical / Mechanical / Lighting Assets.
- Raw source asset types: Streetlight.
- Asset count: `15,332` across `2` source labels and `1` source contract values.
- WKT: `15,332` assets with WKT (100.0%), `15,332` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `979,939` attribute rows, `65` distinct attribute names, covering `15,332` assets (100.0%). Examples: Additional Notes; Asset Configuration Change; Asset ID; Asset Identification Date; Asset Type; Asset Type Attrib.; Base Zone Condition; Coating Type; Comments; Conops Rank; Contract Region; Control Gear Fuse/Circuit Breaker Part No.; Control Gear Installation Date; Control Gear Manufacturer; Control Gear Model; Control Gear Type; Direction; EWP Required?; +47 more.
- Operations/evidence: `5,360` linked jobs (0.35 per asset), `152` open-overdue job proxy records, `974` linked inspections (0.06 per asset), `590` open-overdue inspection proxy records, `14` capital works, `1,190` direct asset photos, `39,768` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 7,666 | Streetlight |
| RMS new / SRAP-C | 7,666 | Streetlight |

### HVAC

- Category: Lighting / Electrical / Mechanical / Mechanical / HVAC / Ventilation.
- Raw source asset types: HVAC.
- Asset count: `126` across `1` source labels and `1` source contract values.
- WKT: `126` assets with WKT (100.0%), `126` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 42.1%, criticality 81.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 42.9%.
- Custom attributes: `9,241` attribute rows, `78` distinct attribute names, covering `126` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `20` linked jobs (0.16 per asset), `0` open-overdue job proxy records, `1,163` linked inspections (9.23 per asset), `20` open-overdue inspection proxy records, `2` capital works, `1` direct asset photos, `57` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 126 | HVAC |

### Mechanical

- Category: Lighting / Electrical / Mechanical / Mechanical / HVAC / Ventilation.
- Raw source asset types: Mechanical.
- Asset count: `35` across `1` source labels and `1` source contract values.
- WKT: `35` assets with WKT (100.0%), `35` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `342` attribute rows, `10` distinct attribute names, covering `35` assets (100.0%). Examples: AC Asset Type; AC Type; AED Asset Tag; AED Asset UI; AED Description; AED Number; Asset Description; Asset Manufacturer/Brand; Location; Mechanical Asset Type.
- Operations/evidence: `322` linked jobs (9.20 per asset), `124` open-overdue job proxy records, `291` linked inspections (8.31 per asset), `31` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 35 | Mechanical |

### Ventilation System

- Category: Lighting / Electrical / Mechanical / Mechanical / HVAC / Ventilation.
- Raw source asset types: Ventilation Systems.
- Asset count: `237` across `1` source labels and `1` source contract values.
- WKT: `237` assets with WKT (100.0%), `237` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 84.0%, criticality 81.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 84.0%.
- Custom attributes: `18,164` attribute rows, `78` distinct attribute names, covering `237` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `24` linked jobs (0.10 per asset), `0` open-overdue job proxy records, `2,973` linked inspections (12.54 per asset), `30` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `81` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 237 | Ventilation Systems |

### Operations and Maintenance Building Generator

- Category: Lighting / Electrical / Mechanical / UPS / Generators.
- Raw source asset types: O&M Building Generator.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3` attribute rows, `3` distinct attribute names, covering `1` assets (100.0%). Examples: AED Asset ID; Asset Description; Manufacturer.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `1` linked inspections (1.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | O&M Building Generator |

### UPS and Generator System

- Category: Lighting / Electrical / Mechanical / UPS / Generators.
- Raw source asset types: UPS and Generator Systems.
- Asset count: `21` across `1` source labels and `1` source contract values.
- WKT: `21` assets with WKT (100.0%), `21` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `1,638` attribute rows, `78` distinct attribute names, covering `21` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `16` linked jobs (0.76 per asset), `0` open-overdue job proxy records, `631` linked inspections (30.05 per asset), `17` open-overdue inspection proxy records, `2` capital works, `0` direct asset photos, `37` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 21 | UPS and Generator Systems |

### Uninterruptible Power Supply

- Category: Lighting / Electrical / Mechanical / UPS / Generators.
- Raw source asset types: ITS - UPS.
- Asset count: `10` across `1` source labels and `1` source contract values.
- WKT: `10` assets with WKT (100.0%), `10` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `100` attribute rows, `10` distinct attribute names, covering `10` assets (100.0%). Examples: Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; Information Source; Manufacturer; Prev. AV ID; UPS No.; Verification Comments; X Coordinate; Y Coordinate; Z Coordinate.
- Operations/evidence: `53` linked jobs (5.30 per asset), `20` open-overdue job proxy records, `132` linked inspections (13.20 per asset), `1` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `5` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 10 | ITS - UPS |

### Line Marking

- Category: Line Marking / Delineation / General Line Marking.
- Raw source asset types: Linemarking; Markings.
- Asset count: `29,158` across `3` source labels and `3` source contract values.
- WKT: `29,158` assets with WKT (100.0%), `29,158` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 78.1%, criticality 68.4%, risk 0.0%, source classification 99.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 10.1%, construction cost 0.0%, useful life 0.0%, condition date 78.1%.
- Custom attributes: `638,347` attribute rows, `94` distinct attribute names, covering `29,158` assets (100.0%). Examples: Application Rate; Asset Description; Asset Design Life; Asset ID; Asset Manager Organisation; Asset Owner Organisation; Asset Status; Audible; Centroid Chainage; Centroid Offset; Colour; Condition/Grade; Confidence Grade; Construction Year; Contract Asset Mapping; Control Line; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; +76 more.
- Operations/evidence: `7,178` linked jobs (0.25 per asset), `92` open-overdue job proxy records, `1,135` linked inspections (0.04 per asset), `0` open-overdue inspection proxy records, `0` capital works, `3` direct asset photos, `27,988` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2; RMC 2 - Urban; RMC 3; RMC 3 - Urban; RMC 4; RMC 4 - Rural; RMC 4 - Urban; RMC 5; RMC 5 - Rural; RMC 5 - Urban; +2 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 23,471 | Linemarking |
| VNZ / Auckland West Transport | 2,979 | Markings |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 2,708 | Linemarking |

### Linemarking Condition

- Category: Line Marking / Delineation / Line Marking Condition.
- Raw source asset types: Linemarking Condition.
- Asset count: `72,637` across `1` source labels and `1` source contract values.
- WKT: `72,637` assets with WKT (100.0%), `72,637` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.8%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `719.682` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,832,843` attribute rows, `39` distinct attribute names, covering `72,637` assets (100.0%). Examples: Central Markings; Central Pavement Marking Average RL; Combined_Rating; Daytime Contrast (Left); Daytime Contrast (Right); Effective Line Width Left (cm); Effective Line Width Right (cm); End Chainage; Event Code; Humidity %; Lane; Leftmost Line Type (Left); Leftmost Line Type (Right); Length; Line Count (Left); Line Count (Right); Min Rating; RL (Left); +21 more.
- Operations/evidence: `2` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `12` linked job photos.
- Classification examples: RMC 2; RMC 2, RMC 3; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 72,637 | Linemarking Condition |

### Raised Reflective Pavement Marker

- Category: Line Marking / Delineation / Raised Pavement Markers.
- Raw source asset types: Linemarking RRPMs.
- Asset count: `47,531` across `1` source labels and `1` source contract values.
- WKT: `47,531` assets with WKT (100.0%), `47,531` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 99.8%, criticality 0.0%, risk 0.0%, source classification 99.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 99.8%.
- Custom attributes: `190,124` attribute rows, `4` distinct attribute names, covering `47,531` assets (100.0%). Examples: Data Capture Date; Data Captured By; EE Asset ID; EE Image Link.
- Operations/evidence: `1` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `4` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 47,531 | Linemarking RRPMs |

### Line Marking Symbol

- Category: Line Marking / Delineation / Symbols / School Zone Markings.
- Raw source asset types: Linemarking Symbols.
- Asset count: `15,051` across `2` source labels and `2` source contract values.
- WKT: `15,051` assets with WKT (100.0%), `15,051` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 92.6%, criticality 47.5%, risk 0.0%, source classification 99.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 2.2%, construction cost 0.0%, useful life 0.0%, condition date 92.6%.
- Custom attributes: `260,596` attribute rows, `34` distinct attribute names, covering `15,051` assets (100.0%). Examples: Application Rate; Audible; Colour; Control Line; Data Capture Date; Data Captured By; Data Confidence (L)ow, (M)edium, (H)igh; Drawing Ref.; EE Image Link; Information Source; Inspection Zone; Lane Location; Length; Linemarking Description; Manufacturer; Material Type; Paint Brand; Prev. AV ID.; +16 more.
- Operations/evidence: `311` linked jobs (0.02 per asset), `11` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `917` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 4; RMC 5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 14,808 | Linemarking Symbols |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 243 | Linemarking Symbols |

### School Zone 40 Patch

- Category: Line Marking / Delineation / Symbols / School Zone Markings.
- Raw source asset types: SZ 40 Patch.
- Asset count: `3,184` across `2` source labels and `1` source contract values.
- WKT: `3,184` assets with WKT (100.0%), `3,184` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `25,472` attribute rows, `9` distinct attribute names, covering `3,184` assets (100.0%). Examples: Asset ID; Local or State Road; Location Description; Quantity (EA); Road Name; S40 - Asset ID; SRAPC Parkland or Regional; School Name; Ventia School ID.
- Operations/evidence: `4` linked jobs (0.00 per asset), `4` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `4` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1,592 | SZ 40 Patch |
| RMS new / SRAP-C | 1,592 | SZ 40 Patch |

### School Zone Dragons Teeth

- Category: Line Marking / Delineation / Symbols / School Zone Markings.
- Raw source asset types: SZ Dragons Teeth.
- Asset count: `2,496` across `2` source labels and `1` source contract values.
- WKT: `2,496` assets with WKT (100.0%), `2,496` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `19,968` attribute rows, `9` distinct attribute names, covering `2,496` assets (100.0%). Examples: Asset ID; Local or State Road; Location Description; Quantity (EA); Road Name; SRAPC Parkland or Regional; SZD - Asset ID; School Name; Ventia School ID.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1,248 | SZ Dragons Teeth |
| RMS new / SRAP-C | 1,248 | SZ Dragons Teeth |

### School Zone Raised Zebra Crossing

- Category: Line Marking / Delineation / Symbols / School Zone Markings.
- Raw source asset types: SZ Raised Zebra Crossing.
- Asset count: `622` across `2` source labels and `1` source contract values.
- WKT: `622` assets with WKT (100.0%), `622` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `4,976` attribute rows, `9` distinct attribute names, covering `622` assets (100.0%). Examples: Asset ID; Local or State Road; Location Description; Quantity (EA); Road Name; SRAPC Parkland or Regional; SZEB - Asset ID; School Name; Ventia School ID.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 311 | SZ Raised Zebra Crossing |
| RMS new / SRAP-C | 311 | SZ Raised Zebra Crossing |

### Symbolic Pavement Marking

- Category: Line Marking / Delineation / Symbols / School Zone Markings.
- Raw source asset types: Symbolic Pavement Marking.
- Asset count: `748` across `2` source labels and `1` source contract values.
- WKT: `748` assets with WKT (100.0%), `748` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `6,732` attribute rows, `9` distinct attribute names, covering `748` assets (100.0%). Examples: Comments; Marking Beads; Marking Category; Marking Condition; Marking Description; Marking Description - If Other; Marking Material; Marking Measure; Marking Type.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 374 | Symbolic Pavement Marking |
| RMS new / SRAP-C | 374 | Symbolic Pavement Marking |

### Carpark

- Category: Pavement / Surfacing / Paved Areas / Parking.
- Raw source asset types: Carparks.
- Asset count: `343` across `1` source labels and `1` source contract values.
- WKT: `343` assets with WKT (100.0%), `343` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,401` attribute rows, `7` distinct attribute names, covering `343` assets (100.0%). Examples: Area; Asset Type; From Street; Rated; Street Name; Suburb; To Street.
- Operations/evidence: `453` linked jobs (1.32 per asset), `362` open-overdue job proxy records, `42` linked inspections (0.12 per asset), `0` open-overdue inspection proxy records, `31` capital works, `0` direct asset photos, `684` linked job photos.
- Classification examples: Airside; Collector; Local Street.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 343 | Carparks |

### Off-road Paved Area

- Category: Pavement / Surfacing / Paved Areas / Parking.
- Raw source asset types: Offroad Paved Area.
- Asset count: `83` across `2` source labels and `1` source contract values.
- WKT: `83` assets with WKT (100.0%), `83` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `7.644` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,570` attribute rows, `44` distinct attribute names, covering `83` assets (100.0%). Examples: ASSET_CATEGORY; AVERAGE_WIDTH_M; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BASE_MATERIAL; BEGIN_OFFSET; BEGIN_UNIQUE; CLASS_DESCRIPTION; COST_CODE_REFERENCE; CURRENT_ZONE; Conops_Rank; Conops_Score; END_LATITUDE; END_LONGITUTE; +26 more.
- Operations/evidence: `4` linked jobs (0.05 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2` linked job photos.
- Classification examples: SN 2; SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS new / SRAP-C | 42 | Offroad Paved Area |
| RMS / SRAP-C | 41 | Offroad Paved Area |

### Parking

- Category: Pavement / Surfacing / Paved Areas / Parking.
- Raw source asset types: Parking.
- Asset count: `51` across `1` source labels and `1` source contract values.
- WKT: `51` assets with WKT (100.0%), `51` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `1,920` attribute rows, `38` distinct attribute names, covering `51` assets (100.0%). Examples: Asset Description; Asset ID; Barrier Opening Width; Chainage End; Chainage Start; Condition/Grade; Confidence Grade; Construction Year; Control Line; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Defined Stopping Bay Length; Drawing Ref.; Estimated Residual Life; Information Source; Inspection Zone; Latitude; Longitude; +20 more.
- Operations/evidence: `16` linked jobs (0.31 per asset), `0` open-overdue job proxy records, `540` linked inspections (10.59 per asset), `109` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `123` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 51 | Parking |

### Parking Area

- Category: Pavement / Surfacing / Paved Areas / Parking.
- Raw source asset types: Parking Areas.
- Asset count: `216` across `1` source labels and `1` source contract values.
- WKT: `216` assets with WKT (100.0%), `216` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,944` attribute rows, `9` distinct attribute names, covering `216` assets (100.0%). Examples: Bay Number; Council; Metered Parking; Permit Availability; Purpose; Type; Warranty/Defect Liability Date; st_area_sh; st_perimet.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 216 | Parking Areas |

### Paved Area

- Category: Pavement / Surfacing / Paved Areas / Parking.
- Raw source asset types: Paved Areas.
- Asset count: `4,139` across `1` source labels and `5` source contract values.
- WKT: `4,139` assets with WKT (100.0%), `4,139` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; LINESTRING; MULTIPOLYGON; POINT; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 51.6%, criticality 43.6%, risk 0.0%, source classification 95.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `679.434` km proxy, construction date 96.4%, construction cost 0.0%, useful life 96.9%, condition date 51.6%.
- Custom attributes: `47,622` attribute rows, `15` distinct attribute names, covering `4,139` assets (100.0%). Examples: Area; Area (sqm); Fence Code; Fence Present; Paved Type; Pedestrian Zone; Perimeter; Perimeter (m); Safety Rail Present; Tactile Qty; Tactile Unit Exist; Tactile Unit Material; Tactile Unit Type; Third Party Site; Warranty/Defect Liability Date.
- Operations/evidence: `4,316` linked jobs (1.04 per asset), `42` open-overdue job proxy records, `4,959` linked inspections (1.20 per asset), `2` open-overdue inspection proxy records, `0` capital works, `1,012` direct asset photos, `20,463` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 2,289 | Paved Areas |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1,554 | Paved Areas |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 153 | Paved Areas |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 137 | Paved Areas |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA) | 6 | Paved Areas |

### Pavement Inventory

- Category: Pavement / Surfacing / Pavement Inventory / Condition.
- Raw source asset types: Pavement Inventory.
- Asset count: `7,919` across `1` source labels and `1` source contract values.
- WKT: `7,919` assets with WKT (100.0%), `7,919` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `802.175` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `126,704` attribute rows, `16` distinct attribute names, covering `7,919` assets (100.0%). Examples: Data Reset; ID 100m; IRI Description; Impacted By 3rd Party Works; Lane; Length; Measured IRI; Measured RUT; PavRepID; Pavement Surface; RUT Description; Raw IRI; Raw RUT; SecEnd; SecStart; WGT Haulage Route.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 2; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / WRU - DTP Reporting | 7,919 | Pavement Inventory |

### Road in Good Condition

- Category: Pavement / Surfacing / Pavement Inventory / Condition.
- Raw source asset types: Roads in Good Condition.
- Asset count: `88` across `1` source labels and `1` source contract values.
- WKT: `88` assets with WKT (100.0%), `88` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `704` attribute rows, `8` distinct attribute names, covering `88` assets (100.0%). Examples: Approval Expiry Date; Approval TB Ref; Approved Category; Current Status; End Chainage; Lane; Site No; Start Chainage.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 2; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 88 | Roads in Good Condition |

### Roughness

- Category: Pavement / Surfacing / Pavement Inventory / Condition.
- Raw source asset types: Roughness.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 0.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `10` attribute rows, `10` distinct attribute names, covering `1` assets (100.0%). Examples: Date of Collection; Direction; End Chainage; IRI KPI Bin; IRI_Lane; IRI_Left; IRI_Right; Lane; Road Number; Start Chainage.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: none supplied.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Ventia - Custom Asset Registers | 1 | Roughness |

### Pavement Structures

- Category: Pavement / Surfacing / Pavement Structure / Formation.
- Raw source asset types: Pavement Structures.
- Asset count: `4,182` across `1` source labels and `1` source contract values.
- WKT: `4,182` assets with WKT (100.0%), `4,182` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.5%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `62,730` attribute rows, `15` distinct attribute names, covering `4,182` assets (100.0%). Examples: Contract Asset Mapping; Document Link; age; area; end_m; id; layer_no; length_m; offset; pave_material; start_depth; start_m; thickness; volume; width.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 4,182 | Pavement Structures |

### Pavement

- Category: Pavement / Surfacing / Pavement Surface.
- Raw source asset types: Pavement; Pavements.
- Asset count: `5,476` across `3` source labels and `3` source contract values.
- WKT: `5,476` assets with WKT (100.0%), `5,476` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING; MULTILINESTRING; MULTIPOLYGON; POLYGON. Source `SpatialType` values: MultiLineString; Polygon; Polyline.
- Core attributes: condition 1.8%, criticality 0.0%, risk 0.0%, source classification 57.4%, parent asset 98.2%, stage 100.0%.
- Linear/lifecycle attributes: chainage 98.2% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 1.8%.
- Custom attributes: `166,360` attribute rows, `155` distinct attribute names, covering `5,476` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Area of Pavement; Asset Comments; Asset Custodian; Asset Description; Asset Design Life; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset ID; +137 more.
- Operations/evidence: `453` linked jobs (0.08 per asset), `2` open-overdue job proxy records, `819` linked inspections (0.15 per asset), `0` open-overdue inspection proxy records, `3` capital works, `0` direct asset photos, `1,321` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban; +2 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 4,991 | Pavement |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 387 | Pavement |
| VNS / Sydney Harbour Tunnel (SHT) | 98 | Pavements |

### Pavement Surfacing

- Category: Pavement / Surfacing / Pavement Surface.
- Raw source asset types: Pavement Surfacing; Surfacing.
- Asset count: `9,524` across `2` source labels and `2` source contract values.
- WKT: `9,524` assets with WKT (100.0%), `9,524` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; MULTIPOLYGON; POLYGON. Source `SpatialType` values: MultiLineString; Polygon.
- Core attributes: condition 3.8%, criticality 0.0%, risk 0.0%, source classification 75.7%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 3.8%, construction cost 0.0%, useful life 0.0%, condition date 3.8%.
- Custom attributes: `438,830` attribute rows, `93` distinct attribute names, covering `9,524` assets (100.0%). Examples: Additive Details; Additive Used?; Adhesion Agent Details; Adhesion Agent Used?; Application Rate; Area of Surfacing; Asset Description; Asset Design Life; Asset ID; Calculated Thickness; Carriageway; Centreline; Chainage End; Chainage Start; Condition/Grade; Confidence Grade; Construction Date; Construction Year; +75 more.
- Operations/evidence: `27` linked jobs (0.00 per asset), `1` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `114` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban; +1 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 9,159 | Surfacing |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 365 | Pavement Surfacing |

### Road

- Category: Pavement / Surfacing / Road Carriageway.
- Raw source asset types: Road; Roads.
- Asset count: `2,983` across `5` source labels and `13` source contract values.
- WKT: `2,935` assets with WKT (98.4%), `2,935` with a valid-Australia first coordinate (98.4%). Geometry tokens observed: LINESTRING; MULTILINESTRING. Source `SpatialType` values: MultiLineString; Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.3%, parent asset 4.7%, stage 100.0%.
- Linear/lifecycle attributes: chainage 4.7% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `20,070` attribute rows, `41` distinct attribute names, covering `2,940` assets (98.6%). Examples: Access_Res; Asset Identification Date; BAC_RD_REG; BAC_RD_R_1; BAC_RD_R_2; BAC_RD_R_4; Billing_Cl; Class; Conditio_1; Condition; Contract Asset Mapping; Contract Cost Code; DTP Asset ID; DTP Road Code; Document Link; Exclude from TAP; Failure_Co; Length; +23 more.
- Operations/evidence: `335,151` linked jobs (112.35 per asset), `20,952` open-overdue job proxy records, `125,599` linked inspections (42.10 per asset), `4,054` open-overdue inspection proxy records, `729` capital works, `20` direct asset photos, `1,322,533` linked job photos.
- Classification examples: Arterial; Collector; District; GR8; GR8, T5; Local Street; Motorway; Passenger; Port Of Brisbane; RMC 1 - Rural; RMC 1 - Urban; RMC 1, RMC 2, RMC 3; +47 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 2,378 | Roads |
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 130 | Road |
| RMS new / SRAP-C | 124 | Road |
| RMS / SRAP-C | 67 | Road |
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 56 | Road |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 52 | Road |
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 50 | Road |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU), WRU - DTP Reporting | 43 | Road |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - North | 38 | Road |
| RMS new / SRAP-C, SRAP-C OOC | 24 | Road |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 6 | Road |
| VicRoads / Initial Capital Projects (ICP), Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU), WRU - DTP Reporting | 6 | Road |

### Unsealed Pavement

- Category: Pavement / Surfacing / Unsealed Pavement.
- Raw source asset types: Unsealed.
- Asset count: `55` across `1` source labels and `1` source contract values.
- WKT: `55` assets with WKT (100.0%), `55` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,540` attribute rows, `28` distinct attribute names, covering `55` assets (100.0%). Examples: Asset Design Life; Construction Date; Contract Asset Mapping; Document Link; From Distance; Geometry; Layer Average Width; Layer Lane Coverage; Left Hand Side Offset; Original Cost; Pavement Design Specification; Pavement Layer Removed?; Pavement Traffic Design Loading; Primary Material; Primary Material Source; Removal Date; Road UUID; Secondary Material; +10 more.
- Operations/evidence: `6` linked jobs (0.11 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `39` linked job photos.
- Classification examples: RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 55 | Unsealed |

### Tools

- Category: Plant / Vehicles / Equipment / Tools.
- Raw source asset types: Tools.
- Asset count: `83` across `1` source labels and `1` source contract values.
- WKT: `0` assets with WKT (0.0%), `0` with a valid-Australia first coordinate (0.0%). Geometry tokens observed: none observed. Source `SpatialType` values: None.
- Core attributes: condition 34.9%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 34.9%.
- Custom attributes: `6,172` attribute rows, `78` distinct attribute names, covering `83` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `7` linked jobs (0.08 per asset), `0` open-overdue job proxy records, `207` linked inspections (2.49 per asset), `25` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `13` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 83 | Tools |

### Vehicle

- Category: Plant / Vehicles / Equipment / Vehicles.
- Raw source asset types: Vehicles.
- Asset count: `56` across `2` source labels and `2` source contract values.
- WKT: `0` assets with WKT (0.0%), `0` with a valid-Australia first coordinate (0.0%). Geometry tokens observed: none observed. Source `SpatialType` values: None.
- Core attributes: condition 23.2%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 25.0%.
- Custom attributes: `1,215` attribute rows, `77` distinct attribute names, covering `56` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +59 more.
- Operations/evidence: `1` linked jobs (0.02 per asset), `0` open-overdue job proxy records, `816` linked inspections (14.57 per asset), `1` open-overdue inspection proxy records, `1` capital works, `0` direct asset photos, `1` linked job photos.
- Classification examples: Resource; T7; Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 41 | Vehicles |
| VNS / Sydney Harbour Tunnel (SHT) | 15 | Vehicles |

### AED Linear Asset

- Category: Road Network / Geometry / AED Spatial Assets.
- Raw source asset types: AED - Linear Assets.
- Asset count: `5,593` across `1` source labels and `1` source contract values.
- WKT: `5,593` assets with WKT (100.0%), `5,593` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `22,373` attribute rows, `5` distinct attribute names, covering `5,593` assets (100.0%). Examples: AED Asset ID; Asset Classification; Asset Description; Asset ID; Asset Tag.
- Operations/evidence: `536` linked jobs (0.10 per asset), `0` open-overdue job proxy records, `39,008` linked inspections (6.97 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 5,593 | AED - Linear Assets |

### AED Point Asset

- Category: Road Network / Geometry / AED Spatial Assets.
- Raw source asset types: AED - Point Assets.
- Asset count: `10,950` across `1` source labels and `1` source contract values.
- WKT: `10,950` assets with WKT (100.0%), `10,950` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `43,801` attribute rows, `5` distinct attribute names, covering `10,950` assets (100.0%). Examples: AED Asset ID; Asset Classification; Asset Description; Asset ID; Asset Tag.
- Operations/evidence: `1,521` linked jobs (0.14 per asset), `0` open-overdue job proxy records, `81,984` linked inspections (7.49 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 10,950 | AED - Point Assets |

### AED Polygon Asset

- Category: Road Network / Geometry / AED Spatial Assets.
- Raw source asset types: AED - Polygon Assets.
- Asset count: `5,134` across `1` source labels and `1` source contract values.
- WKT: `5,134` assets with WKT (100.0%), `5,134` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `20,537` attribute rows, `5` distinct attribute names, covering `5,134` assets (100.0%). Examples: AED Asset ID; Asset Classification; Asset Description; Asset ID; Asset Tag.
- Operations/evidence: `227` linked jobs (0.04 per asset), `0` open-overdue job proxy records, `3,871` linked inspections (0.75 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 5,134 | AED - Polygon Assets |

### Airside

- Category: Road Network / Geometry / Carriageway / Airside Network.
- Raw source asset types: Airside.
- Asset count: `13` across `1` source labels and `1` source contract values.
- WKT: `13` assets with WKT (100.0%), `13` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `127` linked jobs (9.77 per asset), `13` open-overdue job proxy records, `3` linked inspections (0.23 per asset), `0` open-overdue inspection proxy records, `168` capital works, `0` direct asset photos, `417` linked job photos.
- Classification examples: Airside.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 13 | Airside |

### Link Carriageway

- Category: Road Network / Geometry / Carriageway / Airside Network.
- Raw source asset types: Link Carriageway.
- Asset count: `1,538` across `2` source labels and `3` source contract values.
- WKT: `1,484` assets with WKT (96.5%), `1,484` with a valid-Australia first coordinate (96.5%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 97.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `2125.194` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `11,257` attribute rows, `8` distinct attribute names, covering `1,538` assets (100.0%). Examples: Asset Identifiction Date; Carriageway Code; ConOps_Rank; Link No; Reverse Parent Chainage From; Reverse Parent Chainage To; Road Link Code; Tender Asset.
- Operations/evidence: `80,885` linked jobs (52.59 per asset), `9,895` open-overdue job proxy records, `206` linked inspections (0.13 per asset), `0` open-overdue inspection proxy records, `55` capital works, `0` direct asset photos, `454,935` linked job photos.
- Classification examples: SN 1, SN 2, SN 3; SN 1, SN 2, SN 3, SN 4; SN 1, SN 2, SN 3, SN 4, SN 5; SN 1, SN 2, SN 3, SN 4, SN 5, SN 6; SN 1, SN 2, SN 3, SN 4, SN 6; SN 1, SN 2, SN 3, SN 5, SN 6; SN 1, SN 2, SN 4; SN 1, SN 2, SN 6; SN 1, SN 3; SN 1, SN 3, SN 4; SN 1, SN 3, SN 6; SN 1, SN 4; +23 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS new / SRAP-C | 787 | Link Carriageway |
| RMS / SRAP-C | 685 | Link Carriageway |
| RMS new / SRAP-C OOC | 29 | Link Carriageway |
| RMS new / SRAP-C, SRAP-C OOC | 19 | Link Carriageway |
| RMS / SRAP-C OOC | 12 | Link Carriageway |
| RMS / SRAP-C, SRAP-C OOC | 6 | Link Carriageway |

### Feature

- Category: Road Network / Geometry / Geometric Features.
- Raw source asset types: Feature.
- Asset count: `3,706` across `1` source labels and `1` source contract values.
- WKT: `3,695` assets with WKT (99.7%), `3,695` with a valid-Australia first coordinate (99.7%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString; Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.8%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `20,092` attribute rows, `7` distinct attribute names, covering `3,706` assets (100.0%). Examples: End Chainage (km); Feature Type; Lane; Last Review FY; Length (m); Start Chainage (km); Status.
- Operations/evidence: `24` linked jobs (0.01 per asset), `1` open-overdue job proxy records, `1,170` linked inspections (0.32 per asset), `0` open-overdue inspection proxy records, `0` capital works, `979` direct asset photos, `147` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 3,706 | Feature |

### Feature - Old Shape Version

- Category: Road Network / Geometry / Geometric Features.
- Raw source asset types: Feature - Old Shape Version.
- Asset count: `335` across `1` source labels and `1` source contract values.
- WKT: `331` assets with WKT (98.8%), `331` with a valid-Australia first coordinate (98.8%). Geometry tokens observed: MULTIPOLYGON; POINT. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 88.4%, risk 0.0%, source classification 74.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.260` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,675` attribute rows, `5` distinct attribute names, covering `335` assets (100.0%). Examples: End Chainage (KM); Feature Type; Lane; Length (m); Start Chainage (km).
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `298` linked inspections (0.89 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 2; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 335 | Feature - Old Shape Version |

### Strip Map Geometric Feature

- Category: Road Network / Geometry / Geometric Features.
- Raw source asset types: Strip Map - Geometric Features.
- Asset count: `607` across `1` source labels and `1` source contract values.
- WKT: `607` assets with WKT (100.0%), `607` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `11.559` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,644` attribute rows, `8` distinct attribute names, covering `607` assets (100.0%). Examples: Comments; Description; Feature Type; Geometric Feature Description; Geometric Feature Length; Geometric Feature Type; Lane Affected; Structure Over Freeway.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 607 | Strip Map - Geometric Features |

### PCAS 100m Segment

- Category: Road Network / Geometry / Network Segments / Sections.
- Raw source asset types: PCAS 100m Segments.
- Asset count: `9,065` across `1` source labels and `1` source contract values.
- WKT: `9,065` assets with WKT (100.0%), `9,065` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `913.339` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `774,579` attribute rows, `86` distinct attribute names, covering `9,065` assets (100.0%). Examples: Chainage End; Chainage Start; Comment; Crack Sealing present; Crack treatment failed; Cracking Validation Comments; Cracking present on site; Crocodile Cracking (%); D&C Control or Defect; Def_N0; Def_N1500; Def_N200; Def_N900; Deflection Air Temperature (Celsius); Deflection Surface Temperature (Celsius); Geometric Feature; Geometric Feature - Description; Historical Works - Comments; +68 more.
- Operations/evidence: `217` linked jobs (0.02 per asset), `98` open-overdue job proxy records, `173` linked inspections (0.02 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 9,065 | PCAS 100m Segments |

### Section

- Category: Road Network / Geometry / Network Segments / Sections.
- Raw source asset types: Sections.
- Asset count: `5,106` across `1` source labels and `1` source contract values.
- WKT: `5,106` assets with WKT (100.0%), `5,106` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.8%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `998.038` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `153,180` attribute rows, `30` distinct attribute names, covering `5,106` assets (100.0%). Examples: Contract Asset Mapping; Document Link; aadt; asset_owner; carr_way_no; carrway_end_m; carrway_start_m; controlled_by; cway_area; cway_hierarchy; cway_sub_area_desc; end_name; heavy; length_m; maintained_by; managed_by; onrc_category; owner_type; +12 more.
- Operations/evidence: `47,578` linked jobs (9.32 per asset), `4,647` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `58,248` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 5,106 | Sections |

### Segment

- Category: Road Network / Geometry / Network Segments / Sections.
- Raw source asset types: Segment; Segments.
- Asset count: `15,783` across `4` source labels and `7` source contract values.
- WKT: `15,689` assets with WKT (99.4%), `15,689` with a valid-Australia first coordinate (99.4%). Geometry tokens observed: LINESTRING; MULTILINESTRING; MULTIPOLYGON. Source `SpatialType` values: Polygon; Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.9%, parent asset 99.2%, stage 100.0%.
- Linear/lifecycle attributes: chainage 99.2% with `3707.782` km proxy, construction date 13.2%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,233,427` attribute rows, `158` distinct attribute names, covering `15,783` assets (100.0%). Examples: % Heavy Vehicles; AADT; AADT Annual Perc Change 1 Year; ACD Crack Croc %; ACD Crack Long %; ACD Crack Trans %; ADMIN_UNIT_CODE; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BEGIN_OFFSET; Billing Classification; CHANGE_REASON; CHANGE_REASON_DESCRIPTION; CONSTRUCTION_YEAR; +140 more.
- Operations/evidence: `139,922` linked jobs (8.87 per asset), `12,350` open-overdue job proxy records, `486` linked inspections (0.03 per asset), `0` open-overdue inspection proxy records, `2` capital works, `1` direct asset photos, `689,230` linked job photos.
- Classification examples: GR8; Port Of Brisbane; RMC 2; RMC 3; SN 1, SN 2, SN 3; SN 1, SN 2, SN 3, SN 4; SN 1, SN 2, SN 3, SN 4, SN 5; SN 1, SN 2, SN 3, SN 4, SN 5, SN 6; SN 1, SN 2, SN 3, SN 4, SN 6; SN 1, SN 2, SN 3, SN 5, SN 6; SN 1, SN 2, SN 4; SN 1, SN 3; +32 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 11,751 | Segment |
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 1,474 | Segment |
| RMS new / SRAP-C | 983 | Segment |
| RMS / SRAP-C | 905 | Segment |
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 256 | Segments |
| VicRoads / Western Roads Upgrade (WRU) | 220 | Segments |
| RMS new / SRAP-C OOC | 69 | Segment |
| RMS / SRAP-C OOC | 52 | Segment |
| RMS new / SRAP-C, SRAP-C OOC | 40 | Segment |
| RMS / SRAP-C, SRAP-C OOC | 33 | Segment |

### PSDR Additional Area

- Category: Road Network / Geometry / Operational Areas.
- Raw source asset types: PSDR Additional Areas.
- Asset count: `174` across `1` source labels and `1` source contract values.
- WKT: `174` assets with WKT (100.0%), `174` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.6%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `15289.588` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.6%.
- Custom attributes: `1,044` attribute rows, `6` distinct attribute names, covering `174` assets (100.0%). Examples: Length; Material Type; Service Asset Sub-Type; Traffic Management Required; Tram Line Present?; Width.
- Operations/evidence: `21` linked jobs (0.12 per asset), `1` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `45` direct asset photos, `158` linked job photos.
- Classification examples: RMC 1, RMC 2, RMC 3; RMC 2; RMC 2, RMC 3; RMC 3; RMC 3, RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 174 | PSDR Additional Areas |

### Maintenance Track

- Category: Road Network / Geometry / Ramps / Maintenance Tracks.
- Raw source asset types: Maintenance Tracks.
- Asset count: `525` across `1` source labels and `1` source contract values.
- WKT: `525` assets with WKT (100.0%), `525` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING; MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `27,219` attribute rows, `54` distinct attribute names, covering `525` assets (100.0%). Examples: Asset Description; Asset ID; Base Depth; Base Type; Centreline; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; Crossing Material; Crossing Type; Crossing Width; Data Confidence (L)ow, (M)edium, (H)igh; Depth Crossing; Depth Pathway; Drawing Ref.; End Chainage; End Offset; +36 more.
- Operations/evidence: `123` linked jobs (0.23 per asset), `0` open-overdue job proxy records, `674` linked inspections (1.28 per asset), `37` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `1,070` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 525 | Maintenance Tracks |

### Ramp

- Category: Road Network / Geometry / Ramps / Maintenance Tracks.
- Raw source asset types: Ramp.
- Asset count: `1,854` across `1` source labels and `3` source contract values.
- WKT: `1,854` assets with WKT (100.0%), `1,854` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 97.4%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `321.931` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `70,452` attribute rows, `38` distinct attribute names, covering `1,854` assets (100.0%). Examples: CARRIAGE00; CARRIAGEWA; CARRIAGE_1; CARRIAGE_2; CLINELEN; CLINELEN_1; Contract Cost Code; DISTRICT_1; DISTRICT_I; DRIVEN_LEN; DRIVEN_L_1; END_RPC; END_RPC_1; OBJ_ID; OBJ_ID_1; OID_; OWNER_ID; OWNER_ID_1; +20 more.
- Operations/evidence: `624` linked jobs (0.34 per asset), `47` open-overdue job proxy records, `18,741` linked inspections (10.11 per asset), `440` open-overdue inspection proxy records, `3` capital works, `0` direct asset photos, `2,589` linked job photos.
- Classification examples: GR8; T2; T3; T4; T5; T6; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Demo Contract, RAMC - Gen 2 - 2019-2024 | 1,725 | Ramp |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - North | 116 | Ramp |
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - 2019-2024 | 13 | Ramp |

### Litter Basket

- Category: Roadside Furniture / Amenities / Litter Baskets.
- Raw source asset types: Litter Baskets.
- Asset count: `166` across `1` source labels and `1` source contract values.
- WKT: `166` assets with WKT (100.0%), `166` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 5.4%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 5.4%.
- Custom attributes: `1,161` attribute rows, `7` distinct attribute names, covering `166` assets (100.0%). Examples: Bypass Flaps; Location Description; Model/Type; Old Asset ID; Road Name; Size - L; Size - W.
- Operations/evidence: `1,441` linked jobs (8.68 per asset), `2` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `30` direct asset photos, `3,049` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 166 | Litter Baskets |

### Public Art

- Category: Roadside Furniture / Amenities / Public Art.
- Raw source asset types: Public Art.
- Asset count: `24` across `1` source labels and `1` source contract values.
- WKT: `24` assets with WKT (100.0%), `24` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 95.8%, criticality 87.5%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 4.2%, construction cost 0.0%, useful life 4.2%, condition date 95.8%.
- Custom attributes: `673` attribute rows, `14` distinct attribute names, covering `24` assets (100.0%). Examples: Artist Name only; Artwork material; Construction Cost or Value (AUS/NZD); Description of Artwork; Donated by; Electrical Certification (Electrical/Lighting); Engineering report author; Height (m); Plaque description; Third Party Site; Type; Warranty/Defect Liability Date; Who undertook the Safety or Risk Assessment.; Width (m).
- Operations/evidence: `3` linked jobs (0.12 per asset), `0` open-overdue job proxy records, `4` linked inspections (0.17 per asset), `0` open-overdue inspection proxy records, `0` capital works, `62` direct asset photos, `15` linked job photos.
- Classification examples: RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 24 | Public Art |

### Roadside Furniture

- Category: Roadside Furniture / Amenities / Roadside Furniture.
- Raw source asset types: Roadside Furnitures.
- Asset count: `105` across `1` source labels and `1` source contract values.
- WKT: `105` assets with WKT (100.0%), `105` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 89.5%, criticality 3.8%, risk 0.0%, source classification 93.3%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 89.5%.
- Custom attributes: `8,076` attribute rows, `78` distinct attribute names, covering `105` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `8` linked jobs (0.08 per asset), `0` open-overdue job proxy records, `524` linked inspections (4.99 per asset), `30` open-overdue inspection proxy records, `0` capital works, `7` direct asset photos, `23` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 105 | Roadside Furnitures |

### Rest Area

- Category: Roadside Furniture / Amenities / Shelters / Rest Areas.
- Raw source asset types: Rest Area.
- Asset count: `84` across `2` source labels and `2` source contract values.
- WKT: `84` assets with WKT (100.0%), `84` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 45.2%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `12,804` attribute rows, `154` distinct attribute names, covering `84` assets (100.0%). Examples: AC Area; Access Direction; Adj Stockpile Site; Asset Identification Date; BBQ Electric; BBQ Fireplace; BBQ Gas; Baby Change Facilities; Boat Ramp; CC Area; Camp Prohibited Signs; Caravan Disposal; Category; Coments to User; Cway Configuration; Distance From; Driver Reviver; Emergency Phones; +136 more.
- Operations/evidence: `31` linked jobs (0.37 per asset), `2` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `391` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 3, SN 4; SN 4; SN 6.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 39 | Rest Area |
| RMS new / SRAP-C | 39 | Rest Area |
| RMS / SRAP-C, SRAP-C OOC | 3 | Rest Area |
| RMS new / SRAP-C, SRAP-C OOC | 3 | Rest Area |

### Shelter

- Category: Roadside Furniture / Amenities / Shelters / Rest Areas.
- Raw source asset types: Shelters.
- Asset count: `954` across `1` source labels and `1` source contract values.
- WKT: `954` assets with WKT (100.0%), `954` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `41,976` attribute rows, `44` distinct attribute names, covering `954` assets (100.0%). Examples: Area; Artwork Title; Asset Design Life; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Average Width; Bus Stop Number; Capacity; Clearance; Coating System; Colour; Construction Date; Contract Asset Mapping; Criticality; Document Link; Geometry; Has Integrated Bike Rack?; +26 more.
- Operations/evidence: `24` linked jobs (0.03 per asset), `5` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `48` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 5 - Rural; RMC 5 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 954 | Shelters |

### Changeable Message Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: CMS - Changeable Message Signs.
- Asset count: `2` across `2` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `102` attribute rows, `51` distinct attribute names, covering `2` assets (100.0%). Examples: 01 Sign - Installation Date; 01 Sign - Manuals (Hyperlink); 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Type; 02 Cabinet - Comms Medium; 02 Cabinet - Comms Service Provider; 02 Cabinet - Comms Services; 02 Cabinet - Electricity Provider; 02.01 Controller -  Part No.; 02.01 Controller - Address; 02.01 Controller - Firmware Ver; 02.01 Controller - Installation Date; 02.01 Controller - Serial No.; 02.02 Modem -  Installation Date; 02.02 Modem -  Manufacturer; +33 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | CMS - Changeable Message Signs |
| RMS new / SRAP-C | 1 | CMS - Changeable Message Signs |

### Electronic Regulatory Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: RC4 - Electronic Regulatory Signs.
- Asset count: `20` across `2` source labels and `1` source contract values.
- WKT: `20` assets with WKT (100.0%), `20` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `300` attribute rows, `16` distinct attribute names, covering `20` assets (100.0%). Examples: Additional Notes; Asset Identification Date; Conops Rank; Contract Region; Design Document (Hyperlink); EWP Required?; Equipment ID; Manuals (Hyperlink); Nearest Cross Road; Primary Road; Region; SWMS Link; Service Schedule Link; TM Reqd?; TMP Link; Tender Asset.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 10 | RC4 - Electronic Regulatory Signs |
| RMS new / SRAP-C | 10 | RC4 - Electronic Regulatory Signs |

### Electronic Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: RC1 - Electronic Signs.
- Asset count: `18` across `2` source labels and `1` source contract values.
- WKT: `18` assets with WKT (100.0%), `18` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,536` attribute rows, `86` distinct attribute names, covering `18` assets (100.0%). Examples: 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Texr / Graphic; 01 Sign - Type; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Ver; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Part No.; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part No.; 01.02 LED Board - Serial No.; 01.03 Light Sensor - Light Sensor 1  Install Date; 01.03 Light Sensor - Light Sensor 1 Manufacturer; 01.03 Light Sensor - Light Sensor 1 Part No.; +68 more.
- Operations/evidence: `94` linked jobs (5.22 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `618` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 9 | RC1 - Electronic Signs |
| RMS new / SRAP-C | 9 | RC1 - Electronic Signs |

### Electronic Signage System

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: Electronic Signage Systems.
- Asset count: `380` across `1` source labels and `1` source contract values.
- WKT: `380` assets with WKT (100.0%), `380` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 100.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `29,605` attribute rows, `78` distinct attribute names, covering `380` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `41` linked jobs (0.11 per asset), `0` open-overdue job proxy records, `2,593` linked inspections (6.82 per asset), `292` open-overdue inspection proxy records, `2` capital works, `0` direct asset photos, `75` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 380 | Electronic Signage Systems |

### Electronic Speed Limit Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: ESLS(VSS).
- Asset count: `979` across `1` source labels and `1` source contract values.
- WKT: `979` assets with WKT (100.0%), `979` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,916` attribute rows, `4` distinct attribute names, covering `979` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `4,174` linked jobs (4.26 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `730` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 979 | ESLS(VSS) |

### Flasher Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: RC2 - Flasher Signs.
- Asset count: `4` across `2` source labels and `1` source contract values.
- WKT: `4` assets with WKT (100.0%), `4` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `328` attribute rows, `84` distinct attribute names, covering `4` assets (100.0%). Examples: 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Texr / Graphic; 01 Sign - Type; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Ver; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Part No.; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part No.; 01.02 LED Board - Serial No.; 01.03 Light Sensor - Light Sensor 1 Install Date; 01.03 Light Sensor - Light Sensor 1 Manufacturer; 01.03 Light Sensor - Light Sensor 1 Part No.; +66 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 2 | RC2 - Flasher Signs |
| RMS new / SRAP-C | 2 | RC2 - Flasher Signs |

### Integrated Speed Limit and Lane Usage Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: ISLUS - Integrated Speed Limit & Lane Usage Sign.
- Asset count: `252` across `2` source labels and `1` source contract values.
- WKT: `252` assets with WKT (100.0%), `252` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `16,128` attribute rows, `64` distinct attribute names, covering `252` assets (100.0%). Examples: 01 Sign - Gantry ID; 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Text / Graphic; 01 Sign - Type; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Ver; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Part No.; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part No.; 01.02 LED Board - Serial No.; 01.03 Light Sensor - Light Sensor 1 Install Date; 01.03 Light Sensor - Light Sensor 1 Manufacturer; +46 more.
- Operations/evidence: `418` linked jobs (1.66 per asset), `6` open-overdue job proxy records, `252` linked inspections (1.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2,058` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 126 | ISLUS - Integrated Speed Limit & Lane Usage Sign |
| RMS new / SRAP-C | 126 | ISLUS - Integrated Speed Limit & Lane Usage Sign |

### Variable Message Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: ITS - Variable Message Sign; VMS - Variable Message Signs; Variable Message Sign.
- Asset count: `473` across `4` source labels and `3` source contract values.
- WKT: `473` assets with WKT (100.0%), `473` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 1.5%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 1.5%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 1.9%, construction cost 0.0%, useful life 0.0%, condition date 1.5%.
- Custom attributes: `18,594` attribute rows, `82` distinct attribute names, covering `473` assets (100.0%). Examples: 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - System Integration; 01 Sign - Text/Graphic; 01 Sign - Type; 01.01 - Sign Controller - Part No.; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Version; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part Number; 01.02 LED Board - Serial No.; 02 Cabinet - Cabinet Label; 02 Cabinet - Comms Medium; 02 Cabinet - Comms Service Provider; 02 Cabinet - Comms Services; +64 more.
- Operations/evidence: `2,938` linked jobs (6.21 per asset), `8` open-overdue job proxy records, `232` linked inspections (0.49 per asset), `78` open-overdue inspection proxy records, `0` capital works, `2` direct asset photos, `18,749` linked job photos.
- Classification examples: ITS; SN 1; SN 2; SN 3; SN 4; SN 5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 202 | Variable Message Sign |
| RMS / SRAP-C | 132 | VMS - Variable Message Signs |
| RMS new / SRAP-C | 132 | VMS - Variable Message Signs |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 7 | ITS - Variable Message Sign |

### Variable Message Sign Gantry

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: Gantries & VMS Signs.
- Asset count: `2` across `1` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `8` attribute rows, `4` distinct attribute names, covering `2` assets (100.0%). Examples: Construction Type/Details; Level 1 Structure?; Previous Asset ID; Structure Dimensions.
- Operations/evidence: `2` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 2 | Gantries & VMS Signs |

### Variable Message Sign Type A

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: RC3 - Electronic message signs (VMS type A).
- Asset count: `18` across `2` source labels and `1` source contract values.
- WKT: `18` assets with WKT (100.0%), `18` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,476` attribute rows, `83` distinct attribute names, covering `18` assets (100.0%). Examples: 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Texr / Graphic; 01 Sign - Type; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Ver; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Part No.; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part No.; 01.02 LED Board - Serial No.; 01.03 Light Sensor - Light Sensor 1 Install Date; 01.03 Light Sensor - Light Sensor 1 Manufacturer; 01.03 Light Sensor - Light Sensor 1 Part No.; +65 more.
- Operations/evidence: `94` linked jobs (5.22 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `634` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 9 | RC3 - Electronic message signs (VMS type A) |
| RMS new / SRAP-C | 9 | RC3 - Electronic message signs (VMS type A) |

### Variable Speed Limit Sign

- Category: Signs / Roadside Information / Electronic / Dynamic Signs.
- Raw source asset types: VSLS - Variable Speed Limit Signs.
- Asset count: `206` across `2` source labels and `1` source contract values.
- WKT: `206` assets with WKT (100.0%), `206` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `13,440` attribute rows, `65` distinct attribute names, covering `206` assets (100.0%). Examples: 01 Sign - Gantry ID; 01 Sign - Installation Date; 01 Sign - Manufacturer; 01 Sign - Master Controller Y/N; 01 Sign - Serial No.; 01 Sign - System Integration; 01 Sign - Text / Graphic; 01 Sign - Type; 01.01 Sign Controller - Address; 01.01 Sign Controller - Firmware Ver; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Part No.; 01.01 Sign Controller - Serial No.; 01.02 LED Board - Installation Date; 01.02 LED Board - Part No.; 01.02 LED Board - Serial No.; 01.03 Light Sensor - Light Sensor  1  Install Date; 01.03 Light Sensor - Light Sensor 1 Manufacturer; +47 more.
- Operations/evidence: `116` linked jobs (0.56 per asset), `12` open-overdue job proxy records, `32` linked inspections (0.16 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2,024` linked job photos.
- Classification examples: SN 1; SN 2.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 103 | VSLS - Variable Speed Limit Signs |
| RMS new / SRAP-C | 103 | VSLS - Variable Speed Limit Signs |

### Advanced Warning Sign

- Category: Signs / Roadside Information / Guide / Warning Signs.
- Raw source asset types: AWS - Advanced Warning Signs.
- Asset count: `58` across `2` source labels and `1` source contract values.
- WKT: `58` assets with WKT (100.0%), `58` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 3.4%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `2,901` attribute rows, `51` distinct attribute names, covering `58` assets (100.0%). Examples: 01 Sign - Battery Intallation Date; 01 Sign - Battery Type; 01 Sign - Comms Medium; 01 Sign - Comms Provider; 01 Sign - Electricity Provider; 01 Sign - Installation Date; 01 Sign - Manuals (Hyperlink); 01 Sign - Manufacturer; 01 Sign - Number of batteries; 01 Sign - Part No.; 01 Sign - Solar; 01.01 Controller - Battery Type; 01.01 Controller - Comms Medium; 01.01 Controller - Comms Provider; 01.01 Controller - Electricity Provider; 01.01 Controller - Installation Date; 01.01 Controller - Manuals (Hyperlink); 01.01 Controller - Manufacturer; +33 more.
- Operations/evidence: `182` linked jobs (3.14 per asset), `2` open-overdue job proxy records, `42` linked inspections (0.72 per asset), `0` open-overdue inspection proxy records, `0` capital works, `6` direct asset photos, `1,866` linked job photos.
- Classification examples: SN 2; SN 3; SN 4; SN 5; SN 6.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 29 | AWS - Advanced Warning Signs |
| RMS new / SRAP-C | 29 | AWS - Advanced Warning Signs |

### Flood Route Sign

- Category: Signs / Roadside Information / Guide / Warning Signs.
- Raw source asset types: Flood Route Signs.
- Asset count: `104` across `2` source labels and `1` source contract values.
- WKT: `104` assets with WKT (100.0%), `104` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 96.2%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 96.2%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `1,356` attribute rows, `14` distinct attribute names, covering `104` assets (100.0%). Examples: Area; Arrow Direction; Asset Identification Date; Evacuation Route; Height (mm); Minor Sign Support Type; Off Network Street Name; Sign Drawing ID; Sign ID; Sign Ownership; Static/Folding; Tender Asset; Text / Graphic; Width (mm).
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 52 | Flood Route Signs |
| RMS new / SRAP-C | 52 | Flood Route Signs |

### Guide Sign

- Category: Signs / Roadside Information / Guide / Warning Signs.
- Raw source asset types: Guide Signs.
- Asset count: `437` across `1` source labels and `1` source contract values.
- WKT: `437` assets with WKT (100.0%), `437` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 99.3%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 99.3%.
- Custom attributes: `3,059` attribute rows, `7` distinct attribute names, covering `437` assets (100.0%). Examples: Failure Code; Maintenance Group; Maximo Code; Maximo Description; Number of Posts; Post Size; Side of Road.
- Operations/evidence: `49` linked jobs (0.11 per asset), `9` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `167` linked job photos.
- Classification examples: Collector; District; Local Street; Motorway; Passenger; Sub Arterial.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 437 | Guide Signs |

### Guidepost

- Category: Signs / Roadside Information / Guide / Warning Signs.
- Raw source asset types: Guideposts.
- Asset count: `2,185` across `1` source labels and `1` source contract values.
- WKT: `2,185` assets with WKT (100.0%), `2,185` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `9,468` attribute rows, `5` distinct attribute names, covering `2,185` assets (100.0%). Examples: Colour; Drawing Ref.; Inspection Zone; QGIS fid; Section.
- Operations/evidence: `9` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `121` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 2,185 | Guideposts |

### School Zone

- Category: Signs / Roadside Information / School Zone Signs.
- Raw source asset types: School Zone.
- Asset count: `744` across `2` source labels and `1` source contract values.
- WKT: `744` assets with WKT (100.0%), `744` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `29,016` attribute rows, `39` distinct attribute names, covering `744` assets (100.0%). Examples: AECG region; ASGS remoteness; Age ID (Commonwealth Issued School Location ID); Assets unit; Date 1st teacher; Date extracted; Distance education; Electorate; FACS district; Fax; Fed electorate; Healthy canteen; ICSEA value; Indigenous pct; LBOTE pct; LGA; Late opening school; Level of schooling; +21 more.
- Operations/evidence: `54` linked jobs (0.07 per asset), `4` open-overdue job proxy records, `878` linked inspections (1.18 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `162` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 372 | School Zone |
| RMS new / SRAP-C | 372 | School Zone |

### School Zone Sign

- Category: Signs / Roadside Information / School Zone Signs.
- Raw source asset types: SZAS - School Zone Signs.
- Asset count: `8,808` across `2` source labels and `1` source contract values.
- WKT: `8,808` assets with WKT (100.0%), `8,808` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.7%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `652,811` attribute rows, `75` distinct attribute names, covering `8,808` assets (100.0%). Examples: 01 Controller - Battery Installation Date; 01 Controller - Battery Type; 01 Controller - Comms Medium; 01 Controller - Comms Provider; 01 Controller - Electricity Provider; 01 Controller - Installation Date; 01 Controller - Manuals (Hyperlink); 01 Controller - Manufacturer; 01 Controller - Model; 01 Controller - Number of batteries; 01 Controller - Power Source; 01.01 Sign Controller - Firmware Version; 01.01 Sign Controller - Installation Date; 01.01 Sign Controller - Manufacturer; 01.01 Sign Controller - Model; 01.02 Power Controller - Installation Date; 01.02 Power Controller - Manufacturer; 01.02 Power Controller - Model; +57 more.
- Operations/evidence: `58,750` linked jobs (6.67 per asset), `142` open-overdue job proxy records, `9,096` linked inspections (1.03 per asset), `5,802` open-overdue inspection proxy records, `54` capital works, `0` direct asset photos, `176,594` linked job photos.
- Classification examples: SN 1; SN 2; SN 3; SN 4; SN 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 4,404 | SZAS - School Zone Signs |
| RMS new / SRAP-C | 4,404 | SZAS - School Zone Signs |

### School Zone Static Sign

- Category: Signs / Roadside Information / School Zone Signs.
- Raw source asset types: SZ Static Sign.
- Asset count: `10,458` across `2` source labels and `1` source contract values.
- WKT: `10,458` assets with WKT (100.0%), `10,458` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `83,664` attribute rows, `9` distinct attribute names, covering `10,458` assets (100.0%). Examples: Asset ID; Local or State Road; Location Description; Quantity (EA); Road Name; SRAPC Parkland or Regional; SZS - Asset ID; School Name; Ventia School ID.
- Operations/evidence: `26` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `458` linked inspections (0.04 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `106` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 5,229 | SZ Static Sign |
| RMS new / SRAP-C | 5,229 | SZ Static Sign |

### Major Sign Structure

- Category: Signs / Roadside Information / Sign Structures.
- Raw source asset types: Major Sign Structure; Major Sign Structures.
- Asset count: `55` across `2` source labels and `6` source contract values.
- WKT: `55` assets with WKT (100.0%), `55` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 20.0%, criticality 29.1%, risk 0.0%, source classification 100.0%, parent asset 98.2%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 21.8%, construction cost 0.0%, useful life 0.0%, condition date 20.0%.
- Custom attributes: `2,092` attribute rows, `65` distinct attribute names, covering `55` assets (100.0%). Examples: As-built Drawings (IFC); Asset Owner; Bearing (AP1 to AP2); Carriageway; Clear Width (m); Colloquial Name; Construciton Material; Construction Description; Construction Type; Crossing; Culvert Cell Height (m); Current L2 Inspection Status; DTP Asset ID; Data Confidence (L)ow, (M)edium, (H)igh; Date Asset was Identified; Date of Last Level 2 Inspection; Design Life (Yrs); Design Life Expiry (Actual); +47 more.
- Operations/evidence: `189` linked jobs (3.44 per asset), `3` open-overdue job proxy records, `374` linked inspections (6.80 per asset), `0` open-overdue inspection proxy records, `28` capital works, `30` direct asset photos, `613` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 20 | Major Sign Structure |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA) | 15 | Major Sign Structure |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 12 | Major Sign Structures |
| VicRoads / Proposed Work Applications (PWA) | 4 | Major Sign Structure |
| VicRoads / Western Roads Upgrade (WRU) | 3 | Major Sign Structure |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1 | Major Sign Structure |

### Minor Sign

- Category: Signs / Roadside Information / Static Signs.
- Raw source asset types: Minor Sign.
- Asset count: `60,077` across `3` source labels and `6` source contract values.
- WKT: `60,077` assets with WKT (100.0%), `60,077` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 38.6%, criticality 22.9%, risk 0.0%, source classification 99.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 51.4%, construction cost 0.0%, useful life 28.1%, condition date 38.6%.
- Custom attributes: `2,186,615` attribute rows, `78` distinct attribute names, covering `60,077` assets (100.0%). Examples: Asset Identification Date; Asset Shape; Australian Standard Reference; Background Colour; Background Material; DTP Asset ID; Data Capture Date; Data Captured By; EE Asset ID; EE Image Link; EE Sign Type; Footing Type; Frame Material; Ground Height (m); Hierarchy String; Legend Colour; Legend Material; Local Sign Reference Number; +60 more.
- Operations/evidence: `28,149` linked jobs (0.47 per asset), `200` open-overdue job proxy records, `2` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `495` direct asset photos, `73,781` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 4; RMC 5; SN 1; SN 1, SN 3; SN 1, SN 6; SN 2; SN 2, SN 3; SN 2, SN 4; SN 2, SN 6; +6 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 17,512 | Minor Sign |
| RMS new / SRAP-C | 14,084 | Minor Sign |
| RMS / SRAP-C | 13,712 | Minor Sign |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 12,419 | Minor Sign |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 1,176 | Minor Sign |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1,106 | Minor Sign |
| RMS new / SRAP-C, SRAP-C OOC | 68 | Minor Sign |

### Sign

- Category: Signs / Roadside Information / Static Signs.
- Raw source asset types: Sign; Signage; Signs.
- Asset count: `27,448` across `2` source labels and `3` source contract values.
- WKT: `27,444` assets with WKT (100.0%), `27,444` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 11.3%, criticality 0.0%, risk 0.0%, source classification 97.1%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 91.2% with `0.000` km proxy, construction date 2.8%, construction cost 0.0%, useful life 2.8%, condition date 11.4%.
- Custom attributes: `1,114,639` attribute rows, `114` distinct attribute names, covering `27,448` assets (100.0%). Examples: AUS Standard Reference; Asset Description; Asset Design Life; Asset ID; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Attached to Asset ID; Background Colour; Background Material; Chainage; Collision Risk; Condition/Grade; Confidence Grade; Connection Details; Connection Mode; Construction Year; Contract Asset Mapping; +96 more.
- Operations/evidence: `600` linked jobs (0.02 per asset), `96` open-overdue job proxy records, `713` linked inspections (0.03 per asset), `0` open-overdue inspection proxy records, `0` capital works, `25` direct asset photos, `1,886` linked job photos.
- Classification examples: Arterial; Collector; District; Local Street; Motorway; Passenger; RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Rural; RMC 3 - Urban; +8 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 24,254 | Signage |
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 2,427 | Signs |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 767 | Sign |

### Bridge

- Category: Structures / Bridges / Tunnels / Bridges.
- Raw source asset types: Bridge; Bridges.
- Asset count: `868` across `4` source labels and `6` source contract values.
- WKT: `858` assets with WKT (98.8%), `858` with a valid-Australia first coordinate (98.8%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString; Point.
- Core attributes: condition 3.6%, criticality 0.0%, risk 0.0%, source classification 99.4%, parent asset 86.6%, stage 100.0%.
- Linear/lifecycle attributes: chainage 86.6% with `0.000` km proxy, construction date 71.8%, construction cost 0.0%, useful life 0.0%, condition date 3.6%.
- Custom attributes: `22,158` attribute rows, `150` distinct attribute names, covering `868` assets (100.0%). Examples: Abutment Material; Access Method; Access Notes; Asset Description; Asset Design Life; Asset ID; Asset Identification Date; Asset Managing Organisation; Asset Owner Organisation; Asset Status; Axle Weight Limit; Beam Material; Beam Type; Bearing; Bearing (AP1 to AP2); Bearing Type; Bridge Name; Bridge Structure Number; +132 more.
- Operations/evidence: `2,027` linked jobs (2.34 per asset), `874` open-overdue job proxy records, `1,627` linked inspections (1.87 per asset), `88` open-overdue inspection proxy records, `9` capital works, `0` direct asset photos, `14,625` linked job photos.
- Classification examples: Port Of Brisbane; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5 - Rural; RMC 5 - Urban; RMC 6 - Rural; RMC 6 - Urban; SN 1; +4 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 331 | Bridge |
| RMS new / SRAP-C | 311 | Bridge |
| VNZ / Auckland West Transport | 162 | Bridges |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 31 | Bridge |
| RMS new / SRAP-C OOC | 18 | Bridge |
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 8 | Bridges |
| RMS new / SRAP-C, SRAP-C OOC | 6 | Bridge |
| RMS / SRAP-C OOC | 1 | Bridge |

### Lift Bridge

- Category: Structures / Bridges / Tunnels / Bridges.
- Raw source asset types: Lift Bridges.
- Asset count: `2` across `2` source labels and `1` source contract values.
- WKT: `2` assets with WKT (100.0%), `2` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `36` attribute rows, `18` distinct attribute names, covering `2` assets (100.0%). Examples: Asset Identification Date; OBJECTID; Tender Asset; address; asset_cate; current_zo; geometryty; last_upgra; latitude; location; longitude; no_of_lift; owner; plain_brid; proposed_z; road; sourceseq; systempk.
- Operations/evidence: `20` linked jobs (10.00 per asset), `0` open-overdue job proxy records, `224` linked inspections (112.00 per asset), `42` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `28` linked job photos.
- Classification examples: SN 1, SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | Lift Bridges |
| RMS new / SRAP-C | 1 | Lift Bridges |

### Gantry

- Category: Structures / Bridges / Tunnels / Gantries.
- Raw source asset types: Gantries.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `1` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `1` direct asset photos, `12` linked job photos.
- Classification examples: Arterial.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 1 | Gantries |

### Airside Major Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Major Structure Airside.
- Asset count: `16` across `1` source labels and `1` source contract values.
- WKT: `16` assets with WKT (100.0%), `16` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `144` attribute rows, `9` distinct attribute names, covering `16` assets (100.0%). Examples: Asset Sub Code; Asset Sub Name; Asset Type; Direction; Location; Material; Maximo Description; Maximo ID; Street Name.
- Operations/evidence: `1` linked jobs (0.06 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `1` capital works, `0` direct asset photos, `19` linked job photos.
- Classification examples: Airside.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 16 | Major Structure Airside |

### Art Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Art Structure.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `63` attribute rows, `63` distinct attribute names, covering `1` assets (100.0%). Examples: ASSET_CATEGORY; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; CODE_LOOKUP_VALUE; COMMENTS; COMMISSION_DATE; COMPONENT_COUNT; COMPONENT_LIST; CONDITION_RATING; CROSS_STREET; Conops_Rank; Conops_Score; DRAWING_NUMBER; GEOMETRYTYPE; +45 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 1 | Art Structure |

### Landside Major Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Major Structure Landside.
- Asset count: `51` across `1` source labels and `1` source contract values.
- WKT: `51` assets with WKT (100.0%), `51` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `459` attribute rows, `9` distinct attribute names, covering `51` assets (100.0%). Examples: Asset Sub Code; Asset Sub Name; Asset Type; Direction; Location; Material; Maximo Description; Maximo ID; Street Name.
- Operations/evidence: `22` linked jobs (0.43 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `6` capital works, `0` direct asset photos, `128` linked job photos.
- Classification examples: Arterial; Collector; District; Local Street; Motorway; Passenger; Sub Arterial.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Brisbane Airport | 51 | Major Structure Landside |

### Minor Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Minor Structures.
- Asset count: `763` across `1` source labels and `1` source contract values.
- WKT: `763` assets with WKT (100.0%), `763` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 99.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `5,341` attribute rows, `7` distinct attribute names, covering `763` assets (100.0%). Examples: Contract Asset Mapping; Document Link; Start_m; end_m; ms_material; ms_subtype; ms_type.
- Operations/evidence: `1` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2 - Rural; RMC 2 - Urban; RMC 3 - Urban; RMC 4 - Urban; RMC 5 - Urban; RMC 6 - Urban.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 763 | Minor Structures |

### Structural Component

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Structural Component.
- Asset count: `2,087` across `1` source labels and `1` source contract values.
- WKT: `2,087` assets with WKT (100.0%), `2,087` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Inherited.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `56,820` attribute rows, `62` distinct attribute names, covering `2,087` assets (100.0%). Examples: Activity No.; Asset Description; Asset ID; Bridge ID; Bridge Name; Comments; Component; Component Comments; Component Unit; Component Unit Name; Component code; Component material; Component type; Condition State 1; Condition State 2; Condition State 3; Condition State 4; Condition/Grade; +44 more.
- Operations/evidence: `2` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `7` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 2,087 | Structural Component |

### Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Structures.
- Asset count: `266` across `2` source labels and `2` source contract values.
- WKT: `266` assets with WKT (100.0%), `266` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 93.6%, criticality 15.8%, risk 0.0%, source classification 100.0%, parent asset 0.4%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.4% with `0.000` km proxy, construction date 0.4%, construction cost 0.0%, useful life 0.0%, condition date 93.6%.
- Custom attributes: `20,870` attribute rows, `148` distinct attribute names, covering `266` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset ID; Asset Lessee; Asset Maintainer Primary; +130 more.
- Operations/evidence: `98` linked jobs (0.37 per asset), `0` open-overdue job proxy records, `5,794` linked inspections (21.78 per asset), `176` open-overdue inspection proxy records, `10` capital works, `1` direct asset photos, `252` linked job photos.
- Classification examples: T7; Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 265 | Structures |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 1 | Structures |

### Structure Component

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Structure Components.
- Asset count: `1,893` across `1` source labels and `1` source contract values.
- WKT: `0` assets with WKT (0.0%), `0` with a valid-Australia first coordinate (0.0%). Geometry tokens observed: none observed. Source `SpatialType` values: None.
- Core attributes: condition 92.0%, criticality 0.0%, risk 0.0%, source classification 99.9%, parent asset 99.9%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 99.9%.
- Custom attributes: `72,407` attribute rows, `39` distinct attribute names, covering `1,893` assets (100.0%). Examples: Component Code; Component Condition 3 Defect 2006 Treatment Code; Component Condition 3 Defect 2018 Treatment Code; Component Condition 3 Defect Treatment Code; Component Condition 3 Defect Treatment Option; Component Condition 3 Defect Treatment Urgency; Component Condition 4 Defect 2006 Treatment Code; Component Condition 4 Defect 2018 Treatment Code; Component Condition 4 Defect Treatment Code; Component Condition 4 Defect Treatment Option; Component Condition 4 Defect Treatment Urgency; ComponentDescription; ComponentType; Condition Comments; Condition Origin; Defect Condition 3 Code; Defect Condition 3 Option; Defect Condition 3 Urgency; +21 more.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: RMC 1; RMC 2; RMC 3; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 1,893 | Structure Components |

### Support Structure

- Category: Structures / Bridges / Tunnels / Structures / Components.
- Raw source asset types: Support Structure.
- Asset count: `1,332` across `2` source labels and `2` source contract values.
- WKT: `1,332` assets with WKT (100.0%), `1,332` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 86.9%, parent asset 98.3%, stage 100.0%.
- Linear/lifecycle attributes: chainage 98.3% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `83,916` attribute rows, `63` distinct attribute names, covering `1,332` assets (100.0%). Examples: ASSET_CATEGORY; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; CODE_LOOKUP_VALUE; COMMENTS; COMMISSION_DATE; COMPONENT_COUNT; COMPONENT_LIST; CONDITION_RATING; CROSS_STREET; Conops_Rank; Conops_Score; DRAWING_NUMBER; GEOMETRYTYPE; +45 more.
- Operations/evidence: `544` linked jobs (0.41 per asset), `110` open-overdue job proxy records, `1,958` linked inspections (1.47 per asset), `100` open-overdue inspection proxy records, `0` capital works, `576` direct asset photos, `2,164` linked job photos.
- Classification examples: SN 1, SN 3; SN 1, SN 4; SN 1, SN 6; SN 2; SN 2, SN 3; SN 2, SN 4; SN 2, SN 5; SN 2, SN 6; SN 3; SN 3, SN 4; SN 3, SN 5; SN 3, SN 6; +4 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 665 | Support Structure |
| RMS new / SRAP-C | 665 | Support Structure |
| RMS / SRAP-C, SRAP-C OOC | 1 | Support Structure |
| RMS new / SRAP-C, SRAP-C OOC | 1 | Support Structure |

### Tunnel

- Category: Structures / Bridges / Tunnels / Tunnels.
- Raw source asset types: Tunnels.
- Asset count: `1,499` across `1` source labels and `1` source contract values.
- WKT: `1,499` assets with WKT (100.0%), `1,499` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTILINESTRING. Source `SpatialType` values: MultiLineString.
- Core attributes: condition 6.1%, criticality 79.7%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.7%, construction cost 0.0%, useful life 0.0%, condition date 6.1%.
- Custom attributes: `107,660` attribute rows, `77` distinct attribute names, covering `1,499` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +59 more.
- Operations/evidence: `147` linked jobs (0.10 per asset), `0` open-overdue job proxy records, `3,494` linked inspections (2.33 per asset), `92` open-overdue inspection proxy records, `6` capital works, `0` direct asset photos, `142` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 1,499 | Tunnels |

### Tunnel Structure

- Category: Structures / Bridges / Tunnels / Tunnels.
- Raw source asset types: Tunnel Structure.
- Asset count: `4` across `2` source labels and `1` source contract values.
- WKT: `4` assets with WKT (100.0%), `4` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `372` attribute rows, `95` distinct attribute names, covering `4` assets (100.0%). Examples: A1___SEMI_TRAILER___45_5T; A2___B_DOUBLE___68T; A4___B_TRIPLE___90_5T; A5___AB_TRIPLE___113T; A6___ROAD_TRAIN___85T; ASSET_CATEGORY; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BHI_CODE; BHI_DESCR; BORDER_BRDG_YN; BRDG_TYPE_CODE; BRDG_TYPE_DESC; BRIDGE_COMMENT; +77 more.
- Operations/evidence: `52` linked jobs (13.00 per asset), `8` open-overdue job proxy records, `116` linked inspections (29.00 per asset), `44` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `252` linked job photos.
- Classification examples: SN 2; SN 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 2 | Tunnel Structure |
| RMS new / SRAP-C | 2 | Tunnel Structure |

### Noise Wall

- Category: Structures / Bridges / Tunnels / Walls.
- Raw source asset types: Noise Wall.
- Asset count: `288` across `3` source labels and `3` source contract values.
- WKT: `288` assets with WKT (100.0%), `288` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 9.7%, stage 100.0%.
- Linear/lifecycle attributes: chainage 9.7% with `3.513` km proxy, construction date 10.4%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `18,563` attribute rows, `112` distinct attribute names, covering `288` assets (100.0%). Examples: ASSET_CATEGORY; AVERAG_HEIGHT_M; Actual Asset Length (M); As-built Drawings (IFC); Asset Identification Date; Asset Owner; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; BASE_POSITION; BEGIN_OFFSET; Base Position; Begin Unique; CONNECTION_TO_FOUNDATION; CONSTRUCTION_TYPE; CURRENT_ZONE; +94 more.
- Operations/evidence: `442` linked jobs (1.53 per asset), `126` open-overdue job proxy records, `727` linked inspections (2.52 per asset), `54` open-overdue inspection proxy records, `11` capital works, `4` direct asset photos, `2,531` linked job photos.
- Classification examples: RMC 2; RMC 3; SN 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 130 | Noise Wall |
| RMS new / SRAP-C | 130 | Noise Wall |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 23 | Noise Wall |
| VicRoads / Western Roads Upgrade (WRU) | 5 | Noise Wall |

### Retaining Wall

- Category: Structures / Bridges / Tunnels / Walls.
- Raw source asset types: Retaining Wall.
- Asset count: `869` across `3` source labels and `7` source contract values.
- WKT: `869` assets with WKT (100.0%), `869` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING; MULTILINESTRING; POINT. Source `SpatialType` values: MultiLineString; Point; Polyline.
- Core attributes: condition 0.6%, criticality 0.6%, risk 0.0%, source classification 99.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `3.208` km proxy, construction date 0.6%, construction cost 0.0%, useful life 0.6%, condition date 0.6%.
- Custom attributes: `37,040` attribute rows, `138` distinct attribute names, covering `869` assets (100.0%). Examples: Above Wall; Access Method; Access Notes; Age; Anchoring system; Area; As-built Drawings (IFC); Asset Age Risk (Urgent Attention Required); Asset Description; Asset Design Life; Asset ID; Asset Location; Asset Managing Organisation; Asset Offset to Traffic Lane (Start); Asset Owner Organisation; Asset Status; Back Tilt Angle; Back tilt angle; +120 more.
- Operations/evidence: `510` linked jobs (0.59 per asset), `1` open-overdue job proxy records, `422` linked inspections (0.49 per asset), `5` open-overdue inspection proxy records, `41` capital works, `50` direct asset photos, `4,034` linked job photos.
- Classification examples: RMC 1; RMC 1 - Rural; RMC 1 - Urban; RMC 2; RMC 2 - Rural; RMC 2 - Urban; RMC 3; RMC 3 - Rural; RMC 3 - Urban; RMC 4 - Rural; RMC 4 - Urban; RMC 5; +5 more.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNZ / Auckland West Transport | 828 | Retaining Wall |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 24 | Retaining Wall |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 5 | Retaining Wall |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA) | 5 | Retaining Wall |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 3 | Retaining Wall |
| VicRoads / Western Roads Upgrade (WRU) | 3 | Retaining Wall |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1 | Retaining Wall |

### Miscellaneous

- Category: Third Party / Temporary / Other / Miscellaneous / Other.
- Raw source asset types: Miscellaneous.
- Asset count: `5` across `1` source labels and `1` source contract values.
- WKT: `5` assets with WKT (100.0%), `5` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `20` attribute rows, `4` distinct attribute names, covering `5` assets (100.0%). Examples: Associated Site (Bluetooth Beacon); Service Status; Suburb; Zone.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `0` linked job photos.
- Classification examples: ITS.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VentureSmart / VentureSmart | 5 | Miscellaneous |

### Other Item

- Category: Third Party / Temporary / Other / Miscellaneous / Other.
- Raw source asset types: Other Items.
- Asset count: `23` across `1` source labels and `1` source contract values.
- WKT: `23` assets with WKT (100.0%), `23` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 65.2%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 65.2%.
- Custom attributes: `1,734` attribute rows, `78` distinct attribute names, covering `23` assets (100.0%). Examples: Accumulated Depreciation ($); Acquisition Cost ($); Asset Comments; Asset Custodian; Asset Description; Asset Handover Date; Asset Hierarchy Code; Asset Hierarchy Level 1; Asset Hierarchy Level 1 - Discipline; Asset Hierarchy Level 2; Asset Hierarchy Level 2 - Class; Asset Hierarchy Level 3; Asset Hierarchy Level 3 - Function; Asset Hierarchy Level 4; Asset Hierarchy Level 4 - Type; Asset Lessee; Asset Maintainer Primary; Asset Maintainer Primary Contract ID; +60 more.
- Operations/evidence: `7` linked jobs (0.30 per asset), `0` open-overdue job proxy records, `348` linked inspections (15.13 per asset), `16` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `9` linked job photos.
- Classification examples: Tunnel.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VNS / Sydney Harbour Tunnel (SHT) | 23 | Other Items |

### Bid Site

- Category: Third Party / Temporary / Other / Sites / Stockpiles.
- Raw source asset types: Bid Site.
- Asset count: `1` across `1` source labels and `1` source contract values.
- WKT: `1` assets with WKT (100.0%), `1` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `0` attribute rows, `0` distinct attribute names, covering `0` assets (0.0%). Examples: none observed.
- Operations/evidence: `1` linked jobs (1.00 per asset), `0` open-overdue job proxy records, `1` linked inspections (1.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2` linked job photos.
- Classification examples: Class 1.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Melton City Council | 1 | Bid Site |

### Stockpile Site

- Category: Third Party / Temporary / Other / Sites / Stockpiles.
- Raw source asset types: Stockpile Sites.
- Asset count: `42` across `1` source labels and `1` source contract values.
- WKT: `42` assets with WKT (100.0%), `42` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 78.6%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `630` attribute rows, `15` distinct attribute names, covering `42` assets (100.0%). Examples: Description; Size; TMR - Fenced; TMR - Illegal Dumping; TMR - Locked; TMR - Percentage Full; TMR - Status; TMR - Useable; TMR General Comments; Ventia - Fenced; Ventia - Locked; Ventia - Percentage Full; Ventia - Useable; Ventia General Comments; Ventia Inspection Date.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `106` direct asset photos, `0` linked job photos.
- Classification examples: T2; T3; T4; T5; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / RAMC - Gen 2 - North | 42 | Stockpile Sites |

### Temporary Asset

- Category: Third Party / Temporary / Other / Temporary Assets.
- Raw source asset types: Temporary Asset.
- Asset count: `82` across `2` source labels and `1` source contract values.
- WKT: `82` assets with WKT (100.0%), `82` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: POINT. Source `SpatialType` values: Point.
- Core attributes: condition 7.3%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 7.3%.
- Custom attributes: `741` attribute rows, `10` distinct attribute names, covering `82` assets (100.0%). Examples: Asset Condition; Asset Description; Asset Name; Asset Type; Asset Type Attrib.; Critical asset; Location; Nearest street; Suburb; Within SRAPC.
- Operations/evidence: `0` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `64` direct asset photos, `0` linked job photos.
- Classification examples: SN 2.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 41 | Temporary Asset |
| RMS new / SRAP-C | 41 | Temporary Asset |

### Third Party Work - Consent

- Category: Third Party / Temporary / Other / Third Party Works.
- Raw source asset types: Third Party Works (Consents).
- Asset count: `11` across `1` source labels and `1` source contract values.
- WKT: `11` assets with WKT (100.0%), `11` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 9.1%, risk 0.0%, source classification 90.9%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `493` attribute rows, `49` distinct attribute names, covering `11` assets (100.0%). Examples: ASSETS ADDED TO SYSTEM; Actual effect of works on road as observed; Applicant/Contractor Name; Applicant/Contractor Phone Number; Contract Details; Contractor Name; Contractor Phone Number; DATE PWA NOTICE RECEIVED; DATE PWA UPDATED; DEVELOPER; Date of Consent Approval; Date of Consent Approval.; Date of completion of the works; Direction; End Chainage; Extent of works; Inspection ID; Intersecting Road 1; +31 more.
- Operations/evidence: `4` linked jobs (0.36 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `11` direct asset photos, `21` linked job photos.
- Classification examples: RMC 2; RMC 3.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 11 | Third Party Works (Consents) |

### Third Party Work - PWA

- Category: Third Party / Temporary / Other / Third Party Works.
- Raw source asset types: Third Party Works (PWAs).
- Asset count: `197` across `1` source labels and `1` source contract values.
- WKT: `197` assets with WKT (100.0%), `197` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 1.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `5,690` attribute rows, `49` distinct attribute names, covering `197` assets (100.0%). Examples: ASSETS ADDED TO SYSTEM; Contract Details; DATE PWA NOTICE RECEIVED; DATE PWA UPDATED; DEVELOPER; Date PWA Notice Received; Defects Liability Period End Date; Defects Liability Period Start Date; Direction; End Chainage; Final Completion Date; Inspection ID; Intersecting Road 1; Intersecting Road 1 - Direction; Intersecting Road 1 - End Chainage; Intersecting Road 1 - Lanes Affected; Intersecting Road 1 - Start Chainage; Intersecting Road 2; +31 more.
- Operations/evidence: `183` linked jobs (0.93 per asset), `49` open-overdue job proxy records, `134` linked inspections (0.68 per asset), `0` open-overdue inspection proxy records, `0` capital works, `19` direct asset photos, `695` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 197 | Third Party Works (PWAs) |

### Grass and Landscaping

- Category: Vegetation / Landscaping / Landscaping / Grass.
- Raw source asset types: Grass & Landscaping.
- Asset count: `3,716` across `1` source labels and `4` source contract values.
- WKT: `3,716` assets with WKT (100.0%), `3,716` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 50.2%, risk 0.0%, source classification 95.2%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.021` km proxy, construction date 0.1%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `54,243` attribute rows, `19` distinct attribute names, covering `3,716` assets (100.0%). Examples: Area (sqm); Depth (m); LGA; Length (m); Material; Perimeter (m); Position; Roundabout; Third Party Site; Type Of Landscaping; Urbanclass; Warranty/Defect Liability Date; Width (m); entry; globalid; st_area_sh; st_perimet; sys_attr_l; +1 more.
- Operations/evidence: `6,040` linked jobs (1.63 per asset), `8` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `3` direct asset photos, `19,310` linked job photos.
- Classification examples: RMC 2; RMC 3; RMC 4; RMC 5.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 2,200 | Grass & Landscaping |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1,226 | Grass & Landscaping |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 203 | Grass & Landscaping |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 87 | Grass & Landscaping |

### Landscape Area

- Category: Vegetation / Landscaping / Landscaping / Grass.
- Raw source asset types: Landscape Areas.
- Asset count: `57` across `1` source labels and `1` source contract values.
- WKT: `57` assets with WKT (100.0%), `57` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 86.0%, parent asset 0.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 0.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `341` attribute rows, `6` distinct attribute names, covering `57` assets (100.0%). Examples: FolderPath; OID; Previous Asset ID; Shape_Area; Shape_Length; SymbolID.
- Operations/evidence: `48` linked jobs (0.84 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `17` linked job photos.
- Classification examples: Port Of Brisbane.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Port of Brisbane | 57 | Landscape Areas |

### Landscaping

- Category: Vegetation / Landscaping / Landscaping / Grass.
- Raw source asset types: Landscaping.
- Asset count: `3,775` across `1` source labels and `1` source contract values.
- WKT: `3,775` assets with WKT (100.0%), `3,775` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `135,121` attribute rows, `37` distinct attribute names, covering `3,775` assets (100.0%). Examples: Application Method Code; Application Method Description; Application Method Detail; Area; Asset Description; Asset ID; Carriageway Location; Centreline; Chainage End; Chainage Start; Condition/Grade; Confidence Grade; Construction Year; Criticality Criteria; Data Confidence (L)ow, (M)edium, (H)igh; Estimated Residual Life; Information Source; Inspection Zone; +19 more.
- Operations/evidence: `238` linked jobs (0.06 per asset), `3` open-overdue job proxy records, `180` linked inspections (0.05 per asset), `30` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `2,312` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 3,775 | Landscaping |

### Landscaping Design Polygon

- Category: Vegetation / Landscaping / Landscaping / Grass.
- Raw source asset types: Landscaping - Design Polygons.
- Asset count: `3,745` across `1` source labels and `1` source contract values.
- WKT: `3,745` assets with WKT (100.0%), `3,745` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: GEOMETRYCOLLECTION; MULTIPOLYGON; POLYGON. Source `SpatialType` values: Polygon.
- Core attributes: condition 100.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 0.0% with `0.000` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 100.0%.
- Custom attributes: `71,155` attribute rows, `19` distinct attribute names, covering `3,745` assets (100.0%). Examples: Application Method Code; Application Method Description; Application Method Detail; Area; Centreline; Data Confidence (L)ow, (M)edium, (H)igh; Information Source; Landscape Depth; Landscape Width; Landscaping Code; Landscaping Description; Material; Offset; Road Section; Side; Verification Notes; X Coord; Y Coord; +1 more.
- Operations/evidence: `13` linked jobs (0.00 per asset), `0` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `153` linked job photos.
- Classification examples: T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 3,745 | Landscaping - Design Polygons |

### Roadside Landscaping

- Category: Vegetation / Landscaping / Landscaping / Grass.
- Raw source asset types: Roadside Landscaping.
- Asset count: `100` across `2` source labels and `1` source contract values.
- WKT: `100` assets with WKT (100.0%), `100` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: LINESTRING. Source `SpatialType` values: Polyline.
- Core attributes: condition 0.0%, criticality 0.0%, risk 0.0%, source classification 100.0%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `18.160` km proxy, construction date 100.0%, construction cost 0.0%, useful life 0.0%, condition date 0.0%.
- Custom attributes: `3,100` attribute rows, `32` distinct attribute names, covering `100` assets (100.0%). Examples: ASSET_CATEGORY; AVERAGE_WIDTH_M; Asset Identification Date; Asset_Cycle; Asset_Freight; Asset_GV; Asset_Transit; Asset_Walk; Conops_Rank; Conops_Score; GEOMETRYTYPE; MAINTAINING_AGENT; MATERIAL_OTHER_COMMENTS; OBJECTID; ROAD_NUMBER; SHAPE_Length_1; Tender Asset; area_m2; +14 more.
- Operations/evidence: `48` linked jobs (0.48 per asset), `2` open-overdue job proxy records, `0` linked inspections (0.00 per asset), `0` open-overdue inspection proxy records, `0` capital works, `0` direct asset photos, `158` linked job photos.
- Classification examples: SN 1, SN 2, SN 3, SN 4; SN 2, SN 3, SN 4; SN 2, SN 4; SN 3, SN 4.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| RMS / SRAP-C | 50 | Roadside Landscaping |
| RMS new / SRAP-C | 50 | Roadside Landscaping |

### Tree

- Category: Vegetation / Landscaping / Trees.
- Raw source asset types: Tree; Trees.
- Asset count: `12,763` across `3` source labels and `6` source contract values.
- WKT: `12,763` assets with WKT (100.0%), `12,763` with a valid-Australia first coordinate (100.0%). Geometry tokens observed: MULTIPOLYGON; POINT. Source `SpatialType` values: Point; Polygon.
- Core attributes: condition 59.9%, criticality 57.9%, risk 0.0%, source classification 94.4%, parent asset 100.0%, stage 100.0%.
- Linear/lifecycle attributes: chainage 100.0% with `5404.819` km proxy, construction date 7.7%, construction cost 0.0%, useful life 0.0%, condition date 59.9%.
- Custom attributes: `398,387` attribute rows, `90` distinct attribute names, covering `12,763` assets (100.0%). Examples: Age_Class; Arborist; Asset Description; Asset ID; Carriageway; Centreline; Chainage; Comments; Common Name; Common name; Condition Origin; Condition/Grade; Conflicting Wires?; Construction Year; Contract Asset Mapping; Crown Attention?; Crown Diameter; DBH; +72 more.
- Operations/evidence: `1,875` linked jobs (0.15 per asset), `2` open-overdue job proxy records, `334` linked inspections (0.03 per asset), `13` open-overdue inspection proxy records, `0` capital works, `33` direct asset photos, `3,548` linked job photos.
- Classification examples: RMC 1 - Rural; RMC 1 - Urban; RMC 2; RMC 3; RMC 5; RMC 6 - Urban; T7.
- Mapping method: manual_asset_type_mapping_v5.

| Rows by source/contract | Assets | Raw asset types in that source/contract |
|---|---:|---|
| VicRoads / Western Roads Upgrade (WRU) | 8,018 | Trees |
| VNZ / Auckland West Transport | 2,042 | Trees |
| VicRoads / Initial Rehabilitation Works (IRW), Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 1,938 | Trees |
| VicRoads / Initial Rehabilitation Works (IRW), Western Roads Upgrade (WRU) | 336 | Trees |
| VicRoads / Proposed Work Applications (PWA), Western Roads Upgrade (WRU) | 277 | Trees |
| RAMC / BAC / PoB / TSRC group / Toowoomba Second Range Crossing | 152 | Tree |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
