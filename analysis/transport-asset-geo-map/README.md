# Where Our Transport Assets Are

This report shows where Transport Asset Vision records are located, which projects have the most assets, and which asset types dominate.

## Open

Open `output/transport_asset_geo_map.html`.

## Outputs

- `output/transport_asset_geo_map.html`: interactive map and project/asset type summary.
- `output/transport_asset_geo_aggregated.json`: source data used by the HTML page.
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
- `asset_vision_ven_rms_old` / `ext_mssql_asset_vision_ven_rms_old`: source table was not available in the current Databricks environment.

## Notes

- Generated at 2026-06-11T01:25:12+00:00.
- This is a location overview, not an exact engineering drawing.
- Nearby assets are grouped into circles so the browser stays fast.
- Some line or polygon assets are shown using a representative point.
- Asset type comes from Asset Vision `AssetType`.
