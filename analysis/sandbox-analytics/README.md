# VentureSmart Bad-Area Analytics Prototype

Run the Python generator, then open `index.html` in a browser to view the report.

```powershell
python .\sandbox_analytics_report.py
```

## Summary

- Selected contract: `VentureSmart`, because the documented Asset Vision source examples are Australian, with `Region = Western Australia`.
- Source table used: `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` only.
- Transport table usage: none. The included `source-query.sql` is source-table-only.
- Bad-area definition: a mapped `vjob` cluster with a high count of jobs where `Compliant = No` or `CompletedDate` is after `DueDate`. Open overdue work is counted when `CompletedDate` is blank and the due date has passed.
- Map approach: Python parses WKT longitude/latitude, validates mappable points, and renders an actual Leaflet street map with dark CARTO/OpenStreetMap tiles, bad-area circles, and individual bad-job markers.
- Forecast approach: monthly bad-job counts are projected per area with a simple least-squares trend. Confidence is low because the local workspace has source-table metadata and live column examples, not a full live row extract.
- UI design choices: darker operational report layout, validation panel, KPI cards, granular issue/location matrix, asset-type breakdown, root-cause driver analysis, specific bad-job table, and explicit data-quality notes.

## Data Notes

The dashboard currently uses source-table-shaped prototype rows for the documented VentureSmart `vjob` fields so the analytics and UI can be exercised offline. Production use can run the Python generator against either:

- a CSV exported from `source-query.sql`:

```powershell
python .\sandbox_analytics_report.py --input-csv .\venture_smart_vjob_extract.csv
```

- or live Databricks SQL connector browser OAuth:

```powershell
python .\sandbox_analytics_report.py --live
```

Live mode expects `DATABRICKS_SERVER_HOSTNAME` or `DATABRICKS_HOST`, plus
`DATABRICKS_HTTP_PATH`. It uses browser-based OAuth user-to-machine auth through
the Databricks SQL connector, not a personal access token or `DATABRICKS_TOKEN`.

No SLA breach metric is asserted because the source table documentation does not provide a contract SLA threshold. The prototype uses overdue and compliance fields that are present in `vjob`.

The generated report includes a validation panel. In offline mode it validates the source-shaped sample rows and clearly marks that live Databricks execution was not used.

The root-cause driver section is association-based. It identifies over-indexed
source-table factors against the selected-contract baseline, but does not claim
causation unless the source data would support it.

The actual map uses public map tiles in the browser, so it needs internet access when you open `index.html`.
