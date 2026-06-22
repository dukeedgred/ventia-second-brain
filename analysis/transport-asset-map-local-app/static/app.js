const state = {
  overview: null,
  filters: null,
  overviewLayer: null,
  detailLayer: null,
  selectedContext: "",
  mapMode: "overview",
};

const fmt = new Intl.NumberFormat("en-AU");
const palette = [
  "#235e9f",
  "#17847d",
  "#287a43",
  "#aa5a00",
  "#7b4ea3",
  "#b72f56",
  "#52606d",
  "#006d9c",
  "#6f6a00",
  "#bf4f24",
];

const map = L.map("map", { preferCanvas: true }).setView([-28.2, 137.4], 4);
L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution: "&copy; OpenStreetMap contributors",
}).addTo(map);

state.overviewLayer = L.layerGroup().addTo(map);
state.detailLayer = L.geoJSON(null, {
  style: (feature) => ({
    color: geometryColor(feature.properties),
    weight: feature.geometry.type.includes("Line") ? 4 : 2,
    opacity: 0.9,
    fillOpacity: 0.28,
  }),
  pointToLayer: (feature, latlng) => L.circleMarker(latlng, {
    radius: 5,
    color: geometryColor(feature.properties),
    fillColor: geometryColor(feature.properties),
    fillOpacity: 0.85,
    weight: 1,
  }),
  onEachFeature: (feature, layer) => {
    const p = feature.properties || {};
    layer.bindTooltip(`
      <strong>${escapeHtml(p.asset_type || "Asset")}</strong><br>
      ${escapeHtml(p.project || "Project not supplied")}<br>
      Condition: ${escapeHtml(p.asset_condition || "Not supplied")}<br>
      Risk: ${escapeHtml(p.asset_risk || "Not supplied")}<br>
      ID: ${escapeHtml(p.asset_id || "")}
    `, { sticky: true });
  },
});

function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function geometryColor(properties) {
  const condition = String(properties?.asset_condition || "").toLowerCase();
  const risk = String(properties?.asset_risk || "").toLowerCase();
  if (condition.includes("poor") || condition.includes("bad") || risk.includes("high")) return "#b42318";
  if (condition.includes("fair") || risk.includes("medium")) return "#a85a00";
  if (condition.includes("good") || risk.includes("low")) return "#287a43";
  return "#235e9f";
}

function contextColor(context) {
  const contexts = state.overview?.summary?.map((row) => row.source_context) || [];
  const index = Math.max(0, contexts.indexOf(context));
  return palette[index % palette.length];
}

function setStatus(message) {
  document.getElementById("mapStatus").textContent = message;
}

function setMapMode(mode) {
  const select = document.getElementById("mapMode");
  state.mapMode = mode;
  if (select && select.value !== mode) {
    select.value = mode;
  }
  applyLayerVisibility();
}

function applyLayerVisibility() {
  const select = document.getElementById("mapMode");
  const mode = select?.value || state.mapMode || "overview";
  state.mapMode = mode;

  const showOverview = mode === "overview" || mode === "both";
  const showDetail = mode === "exact" || mode === "both";

  if (showOverview && !map.hasLayer(state.overviewLayer)) {
    state.overviewLayer.addTo(map);
  } else if (!showOverview && map.hasLayer(state.overviewLayer)) {
    map.removeLayer(state.overviewLayer);
  }

  if (showDetail && !map.hasLayer(state.detailLayer)) {
    state.detailLayer.addTo(map);
  } else if (!showDetail && map.hasLayer(state.detailLayer)) {
    map.removeLayer(state.detailLayer);
  }

  const label = mode === "overview"
    ? "Showing aggregated overview cells"
    : mode === "exact"
      ? "Showing exact Databricks WKT geometry"
      : "Showing aggregate cells and exact geometry";
  document.getElementById("layerBadge").textContent = label;
}

function option(value, label = value) {
  const opt = document.createElement("option");
  opt.value = value;
  opt.textContent = label;
  return opt;
}

function fillSelect(select, rows, placeholder) {
  select.innerHTML = "";
  select.appendChild(option("", placeholder));
  rows.forEach((row) => select.appendChild(option(row)));
}

function overviewSourceLabel() {
  return state.overview?.data_source === "databricks-live-refresh" ? "Databricks" : "Local cache";
}

function renderKpis() {
  const totals = state.overview.totals;
  const generated = state.overview.generated_at_utc
    ? new Date(state.overview.generated_at_utc).toLocaleString("en-AU")
    : "Not supplied";
  const cards = [
    ["Overview source", overviewSourceLabel(), `Generated ${generated}`],
    ["Assets counted", totals.assets, "Distinct source asset IDs, summed by context"],
    ["Valid geo rows", totals.valid_geo_rows, "Rows with valid ANZ lon/lat"],
    ["Overview cells", totals.grid_cells, `${state.overview.grid_degrees || 0.05} degree aggregate grid`],
    ["Class rows", totals.class_rows, "Project by asset class groups"],
    ["Skipped contexts", totals.skipped_contexts, "Unavailable in current Databricks"],
  ];
  document.getElementById("kpis").innerHTML = cards.map(([label, value, note]) => {
    const rendered = typeof value === "number" ? fmt.format(value || 0) : escapeHtml(value);
    return `
      <article class="card">
        <div class="label">${label}</div>
        <div class="value">${rendered}</div>
        <div class="note">${escapeHtml(note)}</div>
      </article>
    `;
  }).join("");
}

function initialiseFilters() {
  const contextSelect = document.getElementById("sourceContext");
  contextSelect.innerHTML = "";
  state.filters.source_contexts.forEach((row) => {
    contextSelect.appendChild(option(row.source_context, `${row.source_label} - ${row.source_context}`));
  });
  state.selectedContext = contextSelect.value;
  refreshDependentFilters();
}

function clearExactGeometry(options = {}) {
  const resetMode = options.resetMode !== false;
  state.detailLayer.clearLayers();
  renderDetailMeta(null);
  if (resetMode) {
    setMapMode("overview");
  } else {
    applyLayerVisibility();
  }
  renderOverview();
}

function refreshDependentFilters() {
  const context = document.getElementById("sourceContext").value;
  state.selectedContext = context;
  fillSelect(
    document.getElementById("projectFilter"),
    state.filters.projects_by_context[context] || [],
    "All projects in context",
  );
  fillSelect(
    document.getElementById("assetTypeFilter"),
    state.filters.asset_types_by_context[context] || [],
    "All asset classes in context",
  );
  clearExactGeometry({ resetMode: true });
  renderClassRows();
}

function selectedValues() {
  return {
    source_context: document.getElementById("sourceContext").value,
    project: document.getElementById("projectFilter").value,
    asset_type: document.getElementById("assetTypeFilter").value,
    condition: document.getElementById("conditionFilter").value.trim(),
    risk: document.getElementById("riskFilter").value.trim(),
    spatial: document.getElementById("spatialFilter").value,
    limit: document.getElementById("limitInput").value || "1200",
    stride: document.getElementById("strideInput").value || "3",
  };
}

function filteredOverviewPoints() {
  const values = selectedValues();
  return state.overview.grid.filter((row) => {
    if (values.source_context && row.source_context !== values.source_context) return false;
    if (values.project && row.project !== values.project) return false;
    if (values.asset_type && row.asset_type !== values.asset_type) return false;
    return true;
  });
}

function renderOverview() {
  state.overviewLayer.clearLayers();
  const rows = filteredOverviewPoints();
  const bounds = [];
  rows.forEach((row) => {
    const radius = Math.max(4, Math.min(24, 3 + Math.sqrt(row.asset_count) * 1.08));
    const color = contextColor(row.source_context);
    const marker = L.circleMarker([row.lat, row.lon], {
      radius,
      color,
      weight: 1,
      fillColor: color,
      fillOpacity: 0.34,
    });
    marker.bindTooltip(`
      <strong>Aggregated overview cell</strong><br>
      ${escapeHtml(row.project)}<br>
      ${escapeHtml(row.asset_type)}<br>
      ${fmt.format(row.asset_count)} assets<br>
      ${escapeHtml(row.source_context)}
    `, { sticky: true });
    marker.addTo(state.overviewLayer);
    bounds.push([row.lat, row.lon]);
  });

  applyLayerVisibility();
  const shouldFitOverview = state.mapMode !== "exact" || state.detailLayer.getLayers().length === 0;
  if (bounds.length && shouldFitOverview) {
    map.fitBounds(bounds, { padding: [28, 28], maxZoom: 9 });
  }

  const detailCount = state.detailLayer.getLayers().length;
  setStatus(
    `Overview: ${fmt.format(rows.length)} aggregate cells from ${overviewSourceLabel()}. `
    + `Exact layer: ${fmt.format(detailCount)} Databricks WKT features.`,
  );
}

function renderClassRows() {
  const values = selectedValues();
  const rows = state.overview.classes.filter((row) => {
    if (values.source_context && row.source_context !== values.source_context) return false;
    if (values.project && row.project !== values.project) return false;
    if (values.asset_type && row.asset_type !== values.asset_type) return false;
    return true;
  }).slice(0, 220);
  document.getElementById("classRows").innerHTML = rows.map((row) => `
    <tr>
      <td>${escapeHtml(row.project)}<br><span>${escapeHtml(row.source_context)}</span></td>
      <td>${escapeHtml(row.asset_type)}</td>
      <td>${fmt.format(row.asset_count)}</td>
      <td>${fmt.format(row.geocoded_rows)}</td>
    </tr>
  `).join("");
}

function renderSkippedSources() {
  const rows = state.overview.skipped_contexts || [];
  document.getElementById("skippedSources").innerHTML = rows.length
    ? `<ul class="skip-list">${rows.map((row) => `<li><strong>${escapeHtml(row.source_context)}</strong>: ${escapeHtml(row.reason)}</li>`).join("")}</ul>`
    : `<p class="muted">None skipped.</p>`;
}

function renderDetailMeta(meta) {
  if (!meta) {
    document.getElementById("detailMeta").innerHTML = `<p class="muted">No exact geometry loaded yet.</p>`;
    return;
  }
  document.getElementById("detailMeta").innerHTML = `
    <div class="meta-grid">
      <div class="meta-item"><span>Returned</span><strong>${fmt.format(meta.returned_features)}</strong></div>
      <div class="meta-item"><span>Total match</span><strong>${fmt.format(meta.total_matching || 0)}</strong></div>
      <div class="meta-item"><span>Raw points</span><strong>${fmt.format(meta.raw_coordinate_points)}</strong></div>
      <div class="meta-item"><span>Rendered points</span><strong>${fmt.format(meta.rendered_coordinate_points)}</strong></div>
    </div>
    <p class="note">Source: Databricks WKT query on ${escapeHtml(meta.catalog)}. ${meta.limited ? "Result was capped. Narrow the filters or increase row cap if the browser can handle it." : "All matching rows were returned within the current cap."}</p>
  `;
}

async function loadExactGeometry() {
  const values = selectedValues();
  if (!values.source_context || (!values.project && !values.asset_type)) {
    alert("Select a source context and at least a project or asset class first.");
    return;
  }
  const button = document.getElementById("loadGeometry");
  button.disabled = true;
  setStatus("Loading exact WKT geometry from Databricks...");
  try {
    const params = new URLSearchParams(values);
    const response = await fetch(`/api/geometry?${params.toString()}`);
    const data = await response.json();
    if (!response.ok) {
      throw new Error(data.error || "Geometry request failed.");
    }
    state.detailLayer.clearLayers();
    state.detailLayer.addData(data);
    renderDetailMeta(data.meta);
    setMapMode("exact");
    const bounds = state.detailLayer.getBounds();
    if (bounds.isValid()) {
      map.fitBounds(bounds, { padding: [28, 28], maxZoom: 16 });
    }
    setStatus(
      `Exact-only view: ${fmt.format(data.meta.returned_features)} WKT features loaded from Databricks `
      + `out of ${fmt.format(data.meta.total_matching || 0)} matching rows. Aggregate cells are hidden.`,
    );
  } catch (error) {
    setStatus(`Geometry load failed: ${error.message}`);
    alert(error.message);
  } finally {
    button.disabled = false;
  }
}

async function refreshOverviewFromDatabricks() {
  const button = document.getElementById("refreshOverview");
  button.disabled = true;
  setStatus("Refreshing aggregated overview from Databricks. This can take about a minute...");
  try {
    const response = await fetch("/api/refresh-overview");
    const overview = await response.json();
    if (!response.ok) {
      throw new Error(overview.error || "Overview refresh failed.");
    }
    const filters = await fetch("/api/filters").then((res) => res.json());
    state.overview = overview;
    state.filters = filters;
    renderKpis();
    initialiseFilters();
    renderSkippedSources();
    renderOverview();
    setStatus(`Overview refreshed from Databricks: ${fmt.format(overview.totals.grid_cells)} aggregate cells.`);
  } catch (error) {
    setStatus(`Overview refresh failed: ${error.message}`);
    alert(error.message);
  } finally {
    button.disabled = false;
  }
}

async function init() {
  const [overview, filters] = await Promise.all([
    fetch("/api/overview").then((res) => res.json()),
    fetch("/api/filters").then((res) => res.json()),
  ]);
  state.overview = overview;
  state.filters = filters;
  renderKpis();
  initialiseFilters();
  renderSkippedSources();
  renderOverview();

  document.getElementById("sourceContext").addEventListener("change", refreshDependentFilters);
  ["projectFilter", "assetTypeFilter"].forEach((id) => {
    document.getElementById(id).addEventListener("change", () => {
      clearExactGeometry({ resetMode: true });
      renderClassRows();
    });
  });
  document.getElementById("spatialFilter").addEventListener("change", () => {
    clearExactGeometry({ resetMode: true });
    setStatus("Spatial type applies to the exact Databricks geometry query.");
  });
  document.getElementById("mapMode").addEventListener("change", () => {
    applyLayerVisibility();
    renderOverview();
  });
  ["conditionFilter", "riskFilter"].forEach((id) => {
    document.getElementById(id).addEventListener("input", () => {
      setStatus("Condition/risk filters apply when loading exact Databricks geometry.");
    });
  });
  document.getElementById("loadGeometry").addEventListener("click", loadExactGeometry);
  document.getElementById("refreshOverview").addEventListener("click", refreshOverviewFromDatabricks);
  document.getElementById("clearGeometry").addEventListener("click", () => clearExactGeometry({ resetMode: true }));
}

init().catch((error) => {
  setStatus(`Failed to initialise app: ${error.message}`);
});
