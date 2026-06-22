# Transport Asset Geography Overview

This analysis unions documented Transport Asset Vision source asset data in Databricks, aggregates it before download, and writes a simple map/report.

## Open

Open `output/transport_asset_geo_map.html`.

## Outputs

- `output/transport_asset_geo_map.html`: interactive full-view Australian map and project/class comparison.
- `output/transport_asset_geo_aggregated.json`: aggregated grid, source and class counts embedded in the HTML.
- `output/transport_asset_geo_query.sql`: SQL used for Databricks aggregation.

## Scope

Included source contexts:
- `asset_vision_ven_gen7` / `ext_mssql_asset_vision_ven_gen7` / RAMC / BAC / PoB / TSRC group
- `asset_vision_ven_rms` / `ext_mssql_asset_vision_ven_rms` / RMS
- `asset_vision_ven_rms_new` / `ext_mssql_asset_vision_ven_rms_new` / RMS new
- `asset_vision_ven_vicroads` / `ext_mssql_asset_vision_ven_vicroads` / VicRoads
- `asset_vision_vns_gen7` / `ext_mssql_asset_vision_vns_gen7` / VNS
- `asset_vision_vnz_gen7` / `ext_mssql_asset_vision_vnz_gen7` / VNZ
- `asset_vision_vsm_gen7` / `ext_mssql_asset_vision_vsm_gen7` / VentureSmart

Skipped source contexts:
- `asset_vision_ven_rms_old` / `ext_mssql_asset_vision_ven_rms_old`: Statement failed: [TABLE_OR_VIEW_NOT_FOUND] The table or view `ext_mssql_asset_vision_ven_rms_old`.`information_schema`.`tables` cannot be found. Verify the spelling and correctness of the schema and catalog.

## Notes

- Generated at 2026-06-11T01:25:12+00:00.
- Data is aggregated in Databricks before being written locally.
- Map coordinates use the first coordinate found in each WKT geometry as a representative point.
- Asset class comparison uses Asset Vision `AssetType`.
