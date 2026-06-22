# Transport Asset Map Local App

Local drill-down prototype for Transport Asset Vision geography.

## Run

```powershell
python analysis\transport-asset-map-local-app\server.py
```

Open:

```text
http://127.0.0.1:8791/
```

## What This Adds

- Serves an aggregated overview cache for the full map so the first load stays fast.
- Can refresh that overview cache from Databricks with `/api/refresh-overview`.
- Fetches exact WKT geometry from Databricks only after filters are selected.
- Converts filtered WKT to GeoJSON in the local Python backend.
- Caps exact geometry rows to avoid freezing the browser.
- Supports simplification, source context, project, asset class, spatial type, condition text and risk text filters.
- Lets the user switch between aggregate-only, exact-only and combined map layers.

## Important Map Behaviour

The overview dots are aggregate grid cells, not exact assets. They use the first coordinate in each WKT value and a 0.05-degree grid so the whole estate can be scanned quickly.

The exact layer is different: it queries filtered rows from Databricks, converts WKT to GeoJSON locally, and draws the selected lines, polygons or points. After loading exact geometry, the UI switches to exact-only mode so the aggregate dots do not obscure the road geometry.

## Why This Is Better Than One Static HTML

The full asset estate has hundreds of thousands of assets and many geometry rows. Rendering all exact road/asset geometry in one static file is likely to be slow or unusable. This app keeps the first view aggregated, then loads detailed geometry only for a narrowed slice.

## Files

- `server.py`: local Python backend.
- `static/index.html`: frontend shell.
- `static/app.js`: Leaflet map and API client.
- `static/styles.css`: report styling.
- `data/transport_asset_geo_aggregated.json`: local copy of aggregated overview data.
