const SOURCE_TABLE = "ext_mssql_asset_vision_vsm_gen7.dbo.vjob";
const SELECTED_CONTRACT = "VentureSmart";
const REPORT_NOW = new Date("2022-07-31T00:00:00+08:00");

const sourceRows = [
  {
    id: 38383,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-01-12",
    dueDate: "2022-01-21",
    completedDate: "2022-01-25",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.850,
    lat: -32.061,
  },
  {
    id: 38386,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-01-28",
    dueDate: "2022-02-07",
    completedDate: "2022-02-04",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.852,
    lat: -32.058,
  },
  {
    id: 38391,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-02-14",
    dueDate: "2022-02-23",
    completedDate: "2022-02-28",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.5,
    remainingQuantity: -0.5,
    lon: 115.846,
    lat: -32.063,
  },
  {
    id: 38402,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-03-03",
    dueDate: "2022-03-14",
    completedDate: "2022-03-19",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.856,
    lat: -32.060,
  },
  {
    id: 38416,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-03-29",
    dueDate: "2022-04-07",
    completedDate: "2022-04-12",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 2.5,
    remainingQuantity: -1.5,
    lon: 115.858,
    lat: -32.064,
  },
  {
    id: 38429,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-04-11",
    dueDate: "2022-04-21",
    completedDate: "2022-04-26",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.851,
    lat: -32.066,
  },
  {
    id: 38437,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-04-30",
    dueDate: "2022-05-09",
    completedDate: "2022-05-17",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.849,
    lat: -32.059,
  },
  {
    id: 38445,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-16",
    dueDate: "2022-05-27",
    completedDate: "2022-06-09",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.5,
    remainingQuantity: -0.5,
    lon: 115.854,
    lat: -32.057,
  },
  {
    id: 38451,
    area: "South St / Benningfield Rd",
    assetCode: "CCTV00070",
    assetName: "South St and Benningfield Rd (East Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMCC.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-28",
    dueDate: "2022-06-08",
    completedDate: "",
    completedStatus: "In Progress",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 0.0,
    remainingQuantity: 1.0,
    lon: 115.847,
    lat: -32.065,
  },
  {
    id: 38384,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-01-08",
    dueDate: "2022-01-18",
    completedDate: "2022-01-20",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.792,
    lat: -32.043,
  },
  {
    id: 38389,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-02-04",
    dueDate: "2022-02-14",
    completedDate: "2022-02-12",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.795,
    lat: -32.045,
  },
  {
    id: 38397,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-02-19",
    dueDate: "2022-03-01",
    completedDate: "2022-03-05",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.5,
    remainingQuantity: -0.5,
    lon: 115.789,
    lat: -32.046,
  },
  {
    id: 38404,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-03-12",
    dueDate: "2022-03-22",
    completedDate: "2022-03-20",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.797,
    lat: -32.041,
  },
  {
    id: 38419,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-04-05",
    dueDate: "2022-04-15",
    completedDate: "2022-04-23",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.791,
    lat: -32.039,
  },
  {
    id: 38431,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-03",
    dueDate: "2022-05-13",
    completedDate: "2022-05-12",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.794,
    lat: -32.047,
  },
  {
    id: 38447,
    area: "Stock Rd / Leach Hwy",
    assetCode: "CCTV00076",
    assetName: "Stock Rd and Leach Hwy (West Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMES.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-24",
    dueDate: "2022-06-03",
    completedDate: "2022-06-09",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 2.5,
    remainingQuantity: -1.5,
    lon: 115.788,
    lat: -32.044,
  },
  {
    id: 38385,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-01-20",
    dueDate: "2022-01-30",
    completedDate: "2022-01-27",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.944,
    lat: -31.973,
  },
  {
    id: 38393,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-02-10",
    dueDate: "2022-02-20",
    completedDate: "2022-02-24",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.5,
    remainingQuantity: -0.5,
    lon: 115.949,
    lat: -31.976,
  },
  {
    id: 38405,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-03-08",
    dueDate: "2022-03-18",
    completedDate: "2022-03-17",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.942,
    lat: -31.980,
  },
  {
    id: 38418,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-04-02",
    dueDate: "2022-04-13",
    completedDate: "2022-04-21",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.952,
    lat: -31.978,
  },
  {
    id: 38435,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-11",
    dueDate: "2022-05-22",
    completedDate: "2022-05-24",
    completedStatus: "Complete",
    compliant: "No",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.947,
    lat: -31.970,
  },
  {
    id: 38449,
    area: "Roe Hwy / Orrong Rd",
    assetCode: "CCTV00078",
    assetName: "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
    contract: "VentureSmart",
    region: "Western Australia",
    state: "WA",
    hazardDefectCode: "PMHP.PM",
    activityName: "Preventative Maintenance",
    priority: "Medium",
    createdDate: "2022-05-29",
    dueDate: "2022-06-09",
    completedDate: "2022-06-02",
    completedStatus: "Complete",
    compliant: "Yes",
    madeSafe: null,
    actualQuantity: 1.0,
    remainingQuantity: 0.0,
    lon: 115.940,
    lat: -31.975,
  },
].map((row) => ({ ...row, wkt: `POINT (${row.lon} ${row.lat})` }));

const months = ["2022-01", "2022-02", "2022-03", "2022-04", "2022-05"];
let selectedArea = "";

const formatNumber = new Intl.NumberFormat("en-AU");
const formatPercent = new Intl.NumberFormat("en-AU", {
  maximumFractionDigits: 0,
  style: "percent",
});
const formatDate = new Intl.DateTimeFormat("en-AU", {
  day: "2-digit",
  month: "2-digit",
  year: "numeric",
});

let badAreaMap = null;
let mapState = {
  zoom: 11,
  center: { lat: -31.99, lon: 115.88 },
  dragging: false,
  dragStart: null,
  centerStart: null,
  popup: null,
};
const jobElementById = new Map();
let selectedJobId = null;

function parseDate(value) {
  if (!value) return null;
  const date = new Date(`${value}T00:00:00+08:00`);
  return Number.isNaN(date.getTime()) ? null : date;
}

function daysBetween(start, end) {
  return Math.round((end.getTime() - start.getTime()) / 86400000);
}

function isOverdue(row) {
  const due = parseDate(row.dueDate);
  const completed = parseDate(row.completedDate);
  if (!due) return false;
  if (!completed) return due < REPORT_NOW;
  return completed > due;
}

function daysLate(row) {
  const due = parseDate(row.dueDate);
  const completed = parseDate(row.completedDate) || REPORT_NOW;
  if (!due || completed <= due) return 0;
  return daysBetween(due, completed);
}

function isNonCompliant(row) {
  return String(row.compliant || "").toLowerCase() === "no";
}

function isBad(row) {
  return isOverdue(row) || isNonCompliant(row);
}

function monthKey(value) {
  const date = parseDate(value);
  if (!date) return "";
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
}

function byArea() {
  const map = new Map();
  for (const row of sourceRows) {
    if (!map.has(row.area)) map.set(row.area, []);
    map.get(row.area).push(row);
  }
  return Array.from(map, ([area, rows]) => {
    const badRows = rows.filter(isBad);
    const overdueRows = rows.filter(isOverdue);
    const nonCompliantRows = rows.filter(isNonCompliant);
    const avgDaysLate = overdueRows.length
      ? overdueRows.reduce((sum, row) => sum + daysLate(row), 0) / overdueRows.length
      : 0;
    const monthly = months.map((month) =>
      rows.filter((row) => monthKey(row.createdDate) === month && isBad(row)).length,
    );
    const forecast = forecastMonthly(monthly);
    const centre = centroid(rows);
    const badRate = badRows.length / rows.length;
    return {
      area,
      rows,
      totalJobs: rows.length,
      badJobs: badRows.length,
      overdueJobs: overdueRows.length,
      nonCompliantJobs: nonCompliantRows.length,
      avgDaysLate,
      badRate,
      centre,
      monthly,
      forecast,
      trend: trendLabel(forecast.slope),
      riskBand: riskBand(badRows.length, badRate),
      topDriver: topDriver(rows),
    };
  }).sort((a, b) => {
    if (b.badJobs !== a.badJobs) return b.badJobs - a.badJobs;
    if (b.badRate !== a.badRate) return b.badRate - a.badRate;
    return b.avgDaysLate - a.avgDaysLate;
  });
}

function centroid(rows) {
  return {
    lon: rows.reduce((sum, row) => sum + row.lon, 0) / rows.length,
    lat: rows.reduce((sum, row) => sum + row.lat, 0) / rows.length,
  };
}

function topDriver(rows) {
  const counts = new Map();
  for (const row of rows.filter(isBad)) {
    const key = `${row.hazardDefectCode} | ${row.activityName}`;
    counts.set(key, (counts.get(key) || 0) + 1);
  }
  return Array.from(counts, ([label, count]) => ({ label, count })).sort(
    (a, b) => b.count - a.count,
  )[0];
}

function riskBand(badJobs, badRate) {
  if (badJobs >= 5 || badRate >= 0.72) return "high";
  if (badJobs >= 3 || badRate >= 0.55) return "medium";
  return "low";
}

function trendLabel(slope) {
  if (slope >= 0.35) return "Increasing";
  if (slope <= -0.35) return "Reducing";
  return "Flat or noisy";
}

function forecastMonthly(values) {
  const n = values.length;
  const xMean = (n - 1) / 2;
  const yMean = values.reduce((sum, value) => sum + value, 0) / n;
  let numerator = 0;
  let denominator = 0;
  values.forEach((value, index) => {
    numerator += (index - xMean) * (value - yMean);
    denominator += (index - xMean) ** 2;
  });
  const slope = denominator ? numerator / denominator : 0;
  const intercept = yMean - slope * xMean;
  const next = Math.max(0, intercept + slope * n);
  const fitted = values.map((_, index) => intercept + slope * index);
  const residual =
    values.reduce((sum, value, index) => sum + Math.abs(value - fitted[index]), 0) / n;
  const uncertainty = Math.max(1, Math.ceil(residual + Math.abs(slope) * 1.2));
  return {
    next,
    lower: Math.max(0, next - uncertainty),
    upper: next + uncertainty,
    slope,
    confidence: n >= 6 && residual < 1 ? "Medium" : "Low",
  };
}

function render() {
  const areas = byArea();
  if (!selectedArea) selectedArea = areas[0].area;
  renderKpis(areas);
  renderMap(areas);
  renderSelected(areas);
  renderRanking(areas);
  renderForecast(areas);
}

function renderKpis(areas) {
  const totalRows = sourceRows.length;
  const badRows = sourceRows.filter(isBad).length;
  const overdueRows = sourceRows.filter(isOverdue).length;
  const nonCompliantRows = sourceRows.filter(isNonCompliant).length;
  const nextTotal = areas.reduce((sum, area) => sum + area.forecast.next, 0);
  const kpis = [
    ["Source rows", formatNumber.format(totalRows), "Prototype vjob records"],
    ["Bad jobs", formatNumber.format(badRows), `${formatPercent.format(badRows / totalRows)} of jobs`],
    ["Bad areas", formatNumber.format(areas.length), "WKT clusters in WA"],
    ["Overdue / non-compliant", `${overdueRows} / ${nonCompliantRows}`, "Source field flags"],
    ["Next month projection", nextTotal.toFixed(1), "Bad jobs, low confidence"],
  ];
  document.getElementById("kpi-grid").innerHTML = kpis
    .map(
      ([label, value, note]) => `
        <div class="kpi-card">
          <span>${escapeHtml(label)}</span>
          <strong>${escapeHtml(value)}</strong>
          <small>${escapeHtml(note)}</small>
        </div>
      `,
    )
    .join("");
}

function renderMap(areas) {
  ensureTileMap(areas);
  drawTileMap(areas);
}

function ensureTileMap(areas) {
  if (badAreaMap) return;

  const el = document.getElementById("bad-area-map");
  el.innerHTML = `
    <div class="tile-layer" aria-hidden="true"></div>
    <div class="tile-fallback">Loading OpenStreetMap tiles...</div>
    <div class="map-overlay"></div>
    <div class="map-control-stack" aria-label="Map zoom controls">
      <button type="button" data-zoom="in" aria-label="Zoom in">+</button>
      <button type="button" data-zoom="out" aria-label="Zoom out">-</button>
    </div>
    <div class="map-attribution">&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors</div>
  `;

  badAreaMap = {
    el,
    tileLayer: el.querySelector(".tile-layer"),
    fallback: el.querySelector(".tile-fallback"),
    overlay: el.querySelector(".map-overlay"),
  };

  el.querySelector('[data-zoom="in"]').addEventListener("click", () => {
    setZoom(mapState.zoom + 1);
    drawTileMap(byArea());
  });
  el.querySelector('[data-zoom="out"]').addEventListener("click", () => {
    setZoom(mapState.zoom - 1);
    drawTileMap(byArea());
  });
  el.addEventListener("wheel", onMapWheel, { passive: false });
  el.addEventListener("pointerdown", onMapPointerDown);
  window.addEventListener("pointermove", onMapPointerMove);
  window.addEventListener("pointerup", onMapPointerUp);

  document.getElementById("fit-contract").addEventListener("click", () => {
    fitContract(byArea());
    drawTileMap(byArea());
  });
  document.getElementById("fit-selected").addEventListener("click", () => {
    fitSelectedArea(byArea());
    drawTileMap(byArea());
  });

  fitContract(areas);
}

function drawTileMap(areas) {
  if (!badAreaMap) return;
  const rect = badAreaMap.el.getBoundingClientRect();
  if (!rect.width || !rect.height) return;
  const zoom = Math.round(mapState.zoom);
  const centrePx = lonLatToPixel(mapState.center.lon, mapState.center.lat, zoom);
  const topLeft = {
    x: centrePx.x - rect.width / 2,
    y: centrePx.y - rect.height / 2,
  };
  drawTiles(rect, zoom, topLeft);
  drawOverlays(areas, rect, zoom, topLeft);
}

function drawTiles(rect, zoom, topLeft) {
  const maxTile = 2 ** zoom;
  const startX = Math.floor(topLeft.x / 256);
  const endX = Math.floor((topLeft.x + rect.width) / 256);
  const startY = Math.floor(topLeft.y / 256);
  const endY = Math.floor((topLeft.y + rect.height) / 256);
  const parts = [];
  for (let x = startX; x <= endX; x += 1) {
    for (let y = startY; y <= endY; y += 1) {
      if (y < 0 || y >= maxTile) continue;
      const wrappedX = ((x % maxTile) + maxTile) % maxTile;
      const left = x * 256 - topLeft.x;
      const top = y * 256 - topLeft.y;
      parts.push(
        `<img alt="" draggable="false" style="left:${left}px;top:${top}px" src="https://tile.openstreetmap.org/${zoom}/${wrappedX}/${y}.png">`,
      );
    }
  }
  badAreaMap.tileLayer.innerHTML = parts.join("");
  badAreaMap.fallback.textContent =
    "Map tiles need browser internet access; overlays still show the selected source-table bad areas.";
  badAreaMap.fallback.style.display = "grid";
  badAreaMap.tileLayer.querySelectorAll("img").forEach((img) => {
    if (img.complete && img.naturalWidth > 0) {
      badAreaMap.fallback.style.display = "none";
    } else {
      img.addEventListener("load", () => {
        badAreaMap.fallback.style.display = "none";
      }, { once: true });
    }
  });
}

function drawOverlays(areas, rect, zoom, topLeft) {
  jobElementById.clear();
  const selected = areas.find((area) => area.area === selectedArea) || areas[0];
  const selectedBounds = pixelBoundsForRows(selected.rows, zoom, topLeft);
  const html = [];

  if (selectedBounds) {
    const pad = 24;
    html.push(
      `<div class="selected-extent" style="left:${selectedBounds.minX - pad}px;top:${selectedBounds.minY - pad}px;width:${selectedBounds.maxX - selectedBounds.minX + pad * 2}px;height:${selectedBounds.maxY - selectedBounds.minY + pad * 2}px"></div>`,
    );
  }

  for (const area of areas) {
    const point = screenPoint(area.centre.lon, area.centre.lat, zoom, topLeft);
    const colour = colourForRisk(area.riskBand);
    const selectedClass = area.area === selectedArea ? " selected" : "";
    const size = 74 + area.badJobs * 13;
    html.push(
      `<button type="button" class="area-bubble${selectedClass}" data-area="${escapeAttr(area.area)}" style="left:${point.x}px;top:${point.y}px;width:${size}px;height:${size}px;background:${radialHeat(colour)}" aria-label="${escapeAttr(area.area)} heat area"></button>`,
    );
    if (area.area === selectedArea || rect.width > 780) {
      html.push(
        `<div class="area-label-custom" style="left:${point.x}px;top:${point.y - size / 2}px">${escapeHtml(area.area)}</div>`,
      );
    }
  }

  for (const row of selected.rows.filter(isBad)) {
    const point = screenPoint(row.lon, row.lat, zoom, topLeft);
    html.push(
      `<button type="button" class="job-dot ${row.id === selectedJobId ? "selected" : ""}" data-job-id="${row.id}" style="left:${point.x}px;top:${point.y}px" aria-label="Bad job ${row.id}"></button>`,
    );
  }

  const popup = popupHtml(areas, zoom, topLeft);
  if (popup) html.push(popup);
  badAreaMap.overlay.innerHTML = html.join("");
  wireOverlayEvents(areas);
}

function wireOverlayEvents(areas) {
  badAreaMap.overlay.querySelectorAll(".area-bubble").forEach((node) => {
    node.addEventListener("click", (event) => {
      event.stopPropagation();
      selectedArea = node.getAttribute("data-area") || selectedArea;
      selectedJobId = null;
      mapState.popup = { type: "area", area: selectedArea };
      render();
    });
  });

  badAreaMap.overlay.querySelectorAll(".job-dot").forEach((node) => {
    const jobId = Number(node.getAttribute("data-job-id"));
    jobElementById.set(jobId, node);
    node.addEventListener("click", (event) => {
      event.stopPropagation();
      selectedJobId = jobId;
      mapState.popup = { type: "job", jobId };
      updateJobMarkerStyles();
      renderSelected(areas);
      drawTileMap(areas);
    });
  });

  const close = badAreaMap.overlay.querySelector(".map-popup-close");
  if (close) {
    close.addEventListener("click", (event) => {
      event.stopPropagation();
      mapState.popup = null;
      drawTileMap(areas);
    });
  }
}

function popupHtml(areas, zoom, topLeft) {
  if (!mapState.popup) return "";
  if (mapState.popup.type === "area") {
    const area = areas.find((item) => item.area === mapState.popup.area);
    if (!area) return "";
    const point = screenPoint(area.centre.lon, area.centre.lat, zoom, topLeft);
    return `<div class="map-popup" style="left:${point.x}px;top:${point.y}px"><button type="button" class="map-popup-close" aria-label="Close popup">x</button>${areaPopup(area)}</div>`;
  }
  const row = sourceRows.find((item) => item.id === mapState.popup.jobId);
  if (!row) return "";
  const point = screenPoint(row.lon, row.lat, zoom, topLeft);
  return `<div class="map-popup" style="left:${point.x}px;top:${point.y}px"><button type="button" class="map-popup-close" aria-label="Close popup">x</button>${jobPopup(row)}</div>`;
}

function onMapWheel(event) {
  event.preventDefault();
  const delta = event.deltaY < 0 ? 1 : -1;
  zoomAt(event.offsetX, event.offsetY, mapState.zoom + delta);
  drawTileMap(byArea());
}

function onMapPointerDown(event) {
  if (event.target.closest("button")) return;
  const centre = lonLatToPixel(mapState.center.lon, mapState.center.lat, mapState.zoom);
  mapState.dragging = true;
  mapState.dragStart = { x: event.clientX, y: event.clientY };
  mapState.centerStart = centre;
  badAreaMap.el.classList.add("dragging");
  badAreaMap.el.setPointerCapture(event.pointerId);
}

function onMapPointerMove(event) {
  if (!mapState.dragging || !mapState.dragStart || !mapState.centerStart) return;
  const dx = event.clientX - mapState.dragStart.x;
  const dy = event.clientY - mapState.dragStart.y;
  mapState.center = pixelToLonLat(mapState.centerStart.x - dx, mapState.centerStart.y - dy, mapState.zoom);
  drawTileMap(byArea());
}

function onMapPointerUp() {
  if (!badAreaMap) return;
  mapState.dragging = false;
  mapState.dragStart = null;
  mapState.centerStart = null;
  badAreaMap.el.classList.remove("dragging");
}

function fitContract(areas) {
  if (!badAreaMap) return;
  fitRows(areas.flatMap((area) => area.rows), 12, 0.32);
  mapState.popup = null;
}

function fitSelectedArea(areas) {
  if (!badAreaMap) return;
  const area = areas.find((item) => item.area === selectedArea) || areas[0];
  fitRows(area.rows, 15, 0.42);
  mapState.popup = { type: "area", area: area.area };
}

function fitRows(rows, maxZoom, padRatio) {
  if (!rows.length || !badAreaMap) return;
  const rect = badAreaMap.el.getBoundingClientRect();
  const minLon = Math.min(...rows.map((row) => row.lon));
  const maxLon = Math.max(...rows.map((row) => row.lon));
  const minLat = Math.min(...rows.map((row) => row.lat));
  const maxLat = Math.max(...rows.map((row) => row.lat));
  const centre = { lon: (minLon + maxLon) / 2, lat: (minLat + maxLat) / 2 };
  let targetZoom = 15;
  for (let z = 15; z >= 3; z -= 1) {
    const a = lonLatToPixel(minLon, maxLat, z);
    const b = lonLatToPixel(maxLon, minLat, z);
    const width = Math.abs(b.x - a.x);
    const height = Math.abs(b.y - a.y);
    if (width <= rect.width * (1 - padRatio) && height <= rect.height * (1 - padRatio)) {
      targetZoom = z;
      break;
    }
  }
  mapState.zoom = Math.min(maxZoom, Math.max(5, targetZoom));
  mapState.center = centre;
}

function setZoom(nextZoom) {
  mapState.zoom = Math.min(18, Math.max(5, Math.round(nextZoom)));
}

function zoomAt(offsetX, offsetY, nextZoom) {
  const rect = badAreaMap.el.getBoundingClientRect();
  const oldZoom = mapState.zoom;
  const boundedZoom = Math.min(18, Math.max(5, Math.round(nextZoom)));
  if (boundedZoom === oldZoom) return;
  const oldCentre = lonLatToPixel(mapState.center.lon, mapState.center.lat, oldZoom);
  const oldTopLeft = { x: oldCentre.x - rect.width / 2, y: oldCentre.y - rect.height / 2 };
  const cursorWorld = { x: oldTopLeft.x + offsetX, y: oldTopLeft.y + offsetY };
  const cursorLonLat = pixelToLonLat(cursorWorld.x, cursorWorld.y, oldZoom);
  const newCursor = lonLatToPixel(cursorLonLat.lon, cursorLonLat.lat, boundedZoom);
  const newCentrePx = {
    x: newCursor.x - offsetX + rect.width / 2,
    y: newCursor.y - offsetY + rect.height / 2,
  };
  mapState.zoom = boundedZoom;
  mapState.center = pixelToLonLat(newCentrePx.x, newCentrePx.y, boundedZoom);
}

function lonLatToPixel(lon, lat, zoom) {
  const sin = Math.sin((lat * Math.PI) / 180);
  const scale = 256 * 2 ** zoom;
  return {
    x: ((lon + 180) / 360) * scale,
    y: (0.5 - Math.log((1 + sin) / (1 - sin)) / (4 * Math.PI)) * scale,
  };
}

function pixelToLonLat(x, y, zoom) {
  const scale = 256 * 2 ** zoom;
  const lon = (x / scale) * 360 - 180;
  const n = Math.PI - (2 * Math.PI * y) / scale;
  const lat = (180 / Math.PI) * Math.atan(0.5 * (Math.exp(n) - Math.exp(-n)));
  return { lon, lat };
}

function screenPoint(lon, lat, zoom, topLeft) {
  const point = lonLatToPixel(lon, lat, zoom);
  return { x: point.x - topLeft.x, y: point.y - topLeft.y };
}

function pixelBoundsForRows(rows, zoom, topLeft) {
  if (!rows.length) return null;
  const points = rows.map((row) => screenPoint(row.lon, row.lat, zoom, topLeft));
  return {
    minX: Math.min(...points.map((point) => point.x)),
    maxX: Math.max(...points.map((point) => point.x)),
    minY: Math.min(...points.map((point) => point.y)),
    maxY: Math.max(...points.map((point) => point.y)),
  };
}

function radialHeat(colour) {
  return `radial-gradient(circle, ${colour} 0%, ${colour}99 42%, ${colour}22 68%, ${colour}00 100%)`;
}

function colourForRisk(risk) {
  if (risk === "high") return "#b42318";
  if (risk === "medium") return "#dc6803";
  return "#0e9384";
}

function areaPopup(area) {
  return `
    <div class="area-popup">
      <strong>${escapeHtml(area.area)}</strong>
      <div class="popup-grid">
        <span>Bad jobs</span><b>${area.badJobs} of ${area.totalJobs}</b>
        <span>Bad rate</span><b>${formatPercent.format(area.badRate)}</b>
        <span>Overdue</span><b>${area.overdueJobs}</b>
        <span>Non-compliant</span><b>${area.nonCompliantJobs}</b>
        <span>Projection</span><b>${area.forecast.next.toFixed(1)}</b>
      </div>
    </div>
  `;
}

function jobPopup(row) {
  const due = parseDate(row.dueDate);
  const completed = parseDate(row.completedDate);
  return `
    <div class="job-popup">
      <strong>Job ${row.id}</strong>
      <div class="popup-grid">
        <span>Asset</span><b>${escapeHtml(row.assetCode)}</b>
        <span>Area</span><b>${escapeHtml(row.area)}</b>
        <span>Due</span><b>${due ? formatDate.format(due) : "n/a"}</b>
        <span>Completed</span><b>${completed ? formatDate.format(completed) : "Open"}</b>
        <span>Compliant</span><b>${escapeHtml(row.compliant || "n/a")}</b>
        <span>Days late</span><b>${daysLate(row)}</b>
      </div>
    </div>
  `;
}

function renderSelected(areas) {
  const area = areas.find((item) => item.area === selectedArea) || areas[0];
  if (selectedJobId && !area.rows.some((row) => row.id === selectedJobId)) selectedJobId = null;
  document.getElementById("selected-title").textContent = area.area;
  const sample = area.rows[0];
  const recentBad = area.rows.filter(isBad).sort((a, b) => parseDate(b.createdDate) - parseDate(a.createdDate))[0];
  document.getElementById("selected-area").innerHTML = `
    <div class="selected-stat-grid">
      ${miniStat("Bad jobs", `${area.badJobs} / ${area.totalJobs}`)}
      ${miniStat("Bad rate", formatPercent.format(area.badRate))}
      ${miniStat("Avg days late", area.avgDaysLate.toFixed(1))}
      ${miniStat("Trend", area.trend)}
    </div>
    <h3>Source-table geography</h3>
    <p class="lead-small">${escapeHtml(sample.assetName)}</p>
    <ul class="driver-list">
      <li>Contract: ${escapeHtml(sample.contract)}</li>
      <li>Region/state: ${escapeHtml(sample.region)} / ${escapeHtml(sample.state)}</li>
      <li>WKT centroid: ${area.centre.lon.toFixed(3)}, ${area.centre.lat.toFixed(3)}</li>
    </ul>
    <h3 class="section-spacer">Primary driver</h3>
    <ul class="driver-list">
      <li>${escapeHtml(area.topDriver ? area.topDriver.label : "No bad jobs")} (${area.topDriver ? area.topDriver.count : 0} bad jobs)</li>
      <li>Latest bad job created: ${recentBad ? formatDate.format(parseDate(recentBad.createdDate)) : "n/a"}</li>
      <li>Forecast range: ${area.forecast.lower.toFixed(1)} to ${area.forecast.upper.toFixed(1)} bad jobs next month</li>
    </ul>
  `;
  renderSpecificJobs(area);
}

function renderSpecificJobs(area) {
  const badRows = area.rows
    .filter(isBad)
    .sort((a, b) => {
      if (daysLate(b) !== daysLate(a)) return daysLate(b) - daysLate(a);
      return parseDate(b.createdDate) - parseDate(a.createdDate);
    });

  document.getElementById("specific-job-list").innerHTML = `
    <div class="job-card-list">
      ${badRows
        .map((row) => {
          const reasons = badReasons(row);
          const due = parseDate(row.dueDate);
          const completed = parseDate(row.completedDate);
          return `
            <button type="button" class="job-card ${row.id === selectedJobId ? "selected" : ""}" data-job-id="${row.id}">
              <div class="job-card-top">
                <strong>Job ${row.id}</strong>
                <span class="risk-tag ${daysLate(row) >= 7 ? "high" : "medium"}">${daysLate(row)} days late</span>
              </div>
              <small>${escapeHtml(row.assetName)}</small>
              <small>Due ${due ? formatDate.format(due) : "n/a"} | Completed ${completed ? formatDate.format(completed) : "Open"} | ${escapeHtml(row.compliant || "n/a")}</small>
              <div class="reason-list">
                ${reasons.map((reason) => `<span class="reason-pill">${escapeHtml(reason)}</span>`).join("")}
              </div>
            </button>
          `;
        })
        .join("")}
    </div>
  `;

  document.querySelectorAll(".job-card").forEach((card) => {
    card.addEventListener("click", () => {
      const jobId = Number(card.getAttribute("data-job-id"));
      selectedJobId = jobId;
      updateJobMarkerStyles();
      document.querySelectorAll(".job-card").forEach((item) => item.classList.remove("selected"));
      card.classList.add("selected");
      const row = sourceRows.find((item) => item.id === jobId);
      if (row && badAreaMap) {
        mapState.zoom = Math.max(mapState.zoom, 15);
        mapState.center = { lat: row.lat, lon: row.lon };
        mapState.popup = { type: "job", jobId };
        drawTileMap(byArea());
      }
    });
  });
}

function badReasons(row) {
  const reasons = [];
  if (isNonCompliant(row)) reasons.push("Non-compliant");
  if (isOverdue(row)) reasons.push(parseDate(row.completedDate) ? "Completed late" : "Open overdue");
  return reasons;
}

function updateJobMarkerStyles() {
  for (const [jobId, marker] of jobElementById.entries()) {
    const selected = jobId === selectedJobId;
    marker.classList.toggle("selected", selected);
  }
}

function miniStat(label, value) {
  return `
    <div class="mini-stat">
      <span>${escapeHtml(label)}</span>
      <strong>${escapeHtml(value)}</strong>
    </div>
  `;
}

function renderRanking(areas) {
  document.getElementById("ranking-body").innerHTML = areas
    .map(
      (area, index) => `
        <tr class="area-row ${area.area === selectedArea ? "selected" : ""}" data-area="${escapeAttr(area.area)}">
          <td><span class="rank-pill">${index + 1}</span>${escapeHtml(area.area)}</td>
          <td><span class="risk-tag ${area.riskBand}">${area.badJobs}</span></td>
          <td>${formatPercent.format(area.badRate)}</td>
          <td>${area.overdueJobs}</td>
          <td>${area.nonCompliantJobs}</td>
          <td>${area.avgDaysLate.toFixed(1)}</td>
          <td>${escapeHtml(area.trend)}</td>
        </tr>
      `,
    )
    .join("");

  document.querySelectorAll(".area-row").forEach((row) => {
    row.addEventListener("click", () => {
      selectedArea = row.getAttribute("data-area") || selectedArea;
      selectedJobId = null;
      render();
      fitSelectedArea(areas);
    });
  });
}

function renderForecast(areas) {
  document.getElementById("forecast-list").innerHTML = areas
    .map(
      (area) => `
        <div class="forecast-item">
          <div class="forecast-top">
            <div>
              <h3>${escapeHtml(area.area)}</h3>
              <p>${escapeHtml(area.trend)} | ${area.forecast.confidence} confidence | projection uses monthly bad-job count</p>
            </div>
            <div class="forecast-number">${area.forecast.next.toFixed(1)}</div>
          </div>
          ${sparkline(area)}
        </div>
      `,
    )
    .join("");
}

function sparkline(area) {
  const values = area.monthly;
  const forecastValue = area.forecast.next;
  const allValues = [...values, forecastValue, area.forecast.upper];
  const max = Math.max(3, ...allValues);
  const width = 420;
  const height = 76;
  const padX = 24;
  const padY = 12;
  const step = (width - padX * 2) / values.length;
  const point = (value, index) => {
    const x = padX + index * step;
    const y = height - padY - (value / max) * (height - padY * 2);
    return { x, y };
  };
  const actualPoints = values.map(point);
  const forecastPoint = point(forecastValue, values.length);
  const poly = actualPoints.map((p) => `${p.x.toFixed(1)},${p.y.toFixed(1)}`).join(" ");
  const last = actualPoints[actualPoints.length - 1];
  return `
    <svg class="sparkline" viewBox="0 0 ${width} ${height}" role="img" aria-label="${escapeAttr(area.area)} monthly bad-job forecast">
      <line class="axis" x1="${padX}" y1="${height - padY}" x2="${width - padX}" y2="${height - padY}" />
      <polyline class="actual" points="${poly}" />
      <line class="forecast" x1="${last.x.toFixed(1)}" y1="${last.y.toFixed(1)}" x2="${forecastPoint.x.toFixed(1)}" y2="${forecastPoint.y.toFixed(1)}" />
      ${actualPoints.map((p) => `<circle cx="${p.x.toFixed(1)}" cy="${p.y.toFixed(1)}" r="3.5" />`).join("")}
      <circle cx="${forecastPoint.x.toFixed(1)}" cy="${forecastPoint.y.toFixed(1)}" r="4" fill="#dc6803" />
      <text x="${padX}" y="11" fill="#657386" font-size="11">Jan-May 2022</text>
      <text x="${width - 118}" y="11" fill="#657386" font-size="11">Jun projection</text>
    </svg>
  `;
}

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function escapeAttr(value) {
  return escapeHtml(value).replaceAll("`", "&#096;");
}

render();
