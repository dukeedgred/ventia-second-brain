import fs from "node:fs/promises";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = ".";
const workbook = Workbook.create();

const matrixRows = [
  {
    contract: "RAMC / RAMCSC",
    kpis: "Routine maintenance; hazards; safety; jobs/work orders; backlog; lane openings; stakeholder relations; projects",
    av: "Partial",
    activityTable: "Jobs/activity/asset type/open/overdue/cost/hours only",
    notes: "Asset Vision likely covers jobs, work orders, assets, defects/hazards, due dates and completion dates. Stakeholder, projects and lane openings need contract-specific/reporting data.",
  },
  {
    contract: "BAC / Brisbane Airport",
    kpis: "Corrective maintenance completion; planned maintenance completion",
    av: "Yes, for job/work-order completion if captured in Asset Vision",
    activityTable: "Yes, if planned/corrective is represented in activity_type or activity mapping",
    notes: "Good candidate for the silver activity table if activity mapping separates planned versus corrective maintenance.",
  },
  {
    contract: "Port of Brisbane",
    kpis: "Corrective maintenance completion; planned maintenance completion",
    av: "Yes, for job/work-order completion if captured in Asset Vision",
    activityTable: "Yes, same as BAC",
    notes: "Good candidate for the silver activity table if activity mapping separates planned versus corrective maintenance.",
  },
  {
    contract: "WRU",
    kpis: "KPI 1 inspections; KPI 1 non-compliance; KPI 2 jobs; lane access",
    av: "Partial",
    activityTable: "KPI 2/job style metrics yes; inspection KPI no unless inspections are added",
    notes: "Inspection/job KPIs are Asset Vision-backed. Lane access uses extra WRU tables rather than raw Asset Vision.",
  },
  {
    contract: "SRAPC",
    kpis: "Monthly report; TfNSW defect/intervention; subcontractor reporting; TACP",
    av: "Partial",
    activityTable: "Defect/job/activity side only; not subcontractor or TACP",
    notes: "Defect/intervention likely has Asset Vision lineage. Subcontractor/Formitize/TACP reporting requires other sources.",
  },
  {
    contract: "TSRC",
    kpis: "Road safety; incidents; ITS uptime/jobs; CCTV; noise; stakeholder events; PCAS; asset performance KPI 25; maintenance compliance; lane closure",
    av: "Mostly no for raw Asset Vision",
    activityTable: "Only asset/job/activity cost/open/overdue slice",
    notes: "Asset Vision can support asset/job/inspection/work-order components. Incidents, PCAS, lane closure, traffic, abatement, noise and stakeholder reporting need TSRC-specific tables/views.",
  },
  {
    contract: "SHT / WHT",
    kpis: "Inspection/job/critical assets; weather",
    av: "Unclear",
    activityTable: "Only if SHT/WHT data is loaded into the same bronze views",
    notes: "Tunnel context is Maximo-oriented in stakeholder notes, despite an Asset Vision source-system mapping existing. Weather is not Asset Vision.",
  },
  {
    contract: "NEL",
    kpis: "KPI assets; KPI work orders; system/AV devices",
    av: "No current raw Asset Vision",
    activityTable: "No",
    notes: "Current NEL KPI data is synthetic/manual or future Maximo-oriented.",
  },
  {
    contract: "Auckland West",
    kpis: "No explicit KPI table found; operational Asset Vision views exist",
    av: "Yes, operational data exists",
    activityTable: "Potentially yes if included in bronze source views",
    notes: "Operational views cover assets, jobs, inspections, capital works, workflow and timesheets, but no dedicated KPI table is documented.",
  },
  {
    contract: "VentureSmart",
    kpis: "No explicit KPI table found; asset/photo view only",
    av: "Limited",
    activityTable: "Limited or no",
    notes: "Current evidence is too thin for KPI coverage beyond asset/photo availability.",
  },
];

const capabilityRows = [
  ["Job/work-order counts", "Asset Vision job and jobasset tables", "Yes", "Covered by silver_asset_type_activity"],
  ["Open/completed/overdue jobs", "Job due date and completed date", "Yes", "Covered by silver_asset_type_activity"],
  ["Actual hours/cost/timesheet quantity", "Timesheet item records joined to jobs", "Yes", "Covered by silver_asset_type_activity"],
  ["Asset type and category reporting", "Asset table plus asset type mapping", "Yes", "Covered by silver_asset_type_activity"],
  ["Inspection completion KPI", "Inspection/vinspection tables", "Yes, but not in current activity table", "Needs separate inspection KPI table"],
  ["Defect/hazard response timing", "Asset Vision job/defect configuration and due dates", "Partial", "Field mapping still needs validation"],
  ["Condition ratings", "Asset condition and inspection records", "Partial", "Contract wording differs; current activity table does not cover inspections"],
  ["Lane access", "WRU/TSRC lane tables", "No, mostly adjacent tables", "Not covered"],
  ["Incidents", "TSRC incident tables/views", "No, mostly adjacent tables", "Not covered"],
  ["PCAS/pavement", "TSRC PCAS/pavement tables/views", "No, adjacent source", "Not covered"],
  ["Subcontractor/Formitize reporting", "Formitize and SRAPC monthly tables", "No", "Not covered"],
  ["Weather/traffic", "Weather, traffic and tunnel segment tables", "No", "Not covered"],
];

const sources = [
  ["Transport Contractor KPI Inventory", "KPI inventory and Databricks table/view evidence"],
  ["Asset Vision", "Transport Asset Vision role, source-system scope and limitations"],
  ["Transport Asset Condition Inspections", "Condition inspection, defects, hazards and KPI reporting context"],
  ["Transport Data Beyond Asset Vision", "Tables/views that sit outside raw Asset Vision"],
  ["Databricks Source Systems", "Asset Vision source catalog to contract/context mapping"],
];

const coverageCounts = new Map();
for (const row of matrixRows) {
  let bucket = row.av;
  if (bucket.startsWith("Yes")) bucket = "Yes";
  if (bucket.startsWith("No")) bucket = "No";
  if (bucket.startsWith("Mostly no")) bucket = "Mostly no";
  coverageCounts.set(bucket, (coverageCounts.get(bucket) ?? 0) + 1);
}

const summary = workbook.worksheets.add("Summary");
const matrix = workbook.worksheets.add("KPI Coverage Matrix");
const capabilities = workbook.worksheets.add("AV Capability Map");
const notes = workbook.worksheets.add("Sources & Caveats");

for (const sheet of [summary, matrix, capabilities, notes]) {
  sheet.showGridLines = false;
}

function styleTitle(range) {
  range.format = {
    fill: "#1F4E79",
    font: { bold: true, color: "#FFFFFF", size: 15 },
    wrapText: true,
  };
}

function styleHeader(range) {
  range.format = {
    fill: "#D9EAF7",
    font: { bold: true, color: "#1F1F1F" },
    wrapText: true,
  };
}

function styleBody(range) {
  range.format = {
    wrapText: true,
    verticalAlignment: "top",
  };
}

summary.getRange("A1:F1").merge();
summary.getRange("A1").values = [["Transport KPI Availability vs Asset Vision"]];
styleTitle(summary.getRange("A1:F1"));

summary.getRange("A3:F5").values = [
  ["Purpose", "Quick contract-by-contract view of KPI/reporting areas and whether they are available from Asset Vision-style tables or the current silver_asset_type_activity table.", null, null, null, null],
  ["Best use", "Use silver_asset_type_activity for job/work-order activity reporting by asset type. Add inspection and contract-specific KPI views for formal KPI reporting.", null, null, null, null],
  ["Main gap", "Inspection KPIs, lane access, incidents, PCAS/pavement, stakeholder/noise/CCTV, abatement and subcontractor reporting are outside the current silver activity table.", null, null, null, null],
];
summary.getRange("A3:A5").format = { font: { bold: true }, fill: "#F2F2F2" };
summary.getRange("B3:F5").merge(true);
styleBody(summary.getRange("A3:F5"));

summary.getRange("A7:B7").values = [["Asset Vision availability", "Contract/context count"]];
styleHeader(summary.getRange("A7:B7"));
const countRows = Array.from(coverageCounts.entries()).sort((a, b) => a[0].localeCompare(b[0]));
summary.getRangeByIndexes(7, 0, countRows.length, 2).values = countRows;
summary.getRange("A7:B13").format = { wrapText: true };
summary.getRange("B8:B13").format = { numberFormat: "0" };

const chart = summary.charts.add("bar", summary.getRangeByIndexes(6, 0, countRows.length + 1, 2));
chart.title = "Asset Vision Coverage by Contract Context";
chart.hasLegend = false;
chart.xAxis = { axisType: "textAxis" };
chart.yAxis = { numberFormatCode: "0" };
chart.setPosition("D7", "J22");

summary.getRange("A16:F16").merge();
summary.getRange("A16").values = [["Recommendation"]];
styleHeader(summary.getRange("A16:F16"));
summary.getRange("A17:F19").merge();
summary.getRange("A17").values = [[
  "Keep silver_asset_type_activity focused on Asset Vision job/work-order activity. Build a sister inspection KPI table from inspection/vinspection, asset and location tables. For WRU/TSRC/SRAPC, keep contract-specific KPI views separate and join them only where the KPI lineage is validated.",
]];
styleBody(summary.getRange("A17:F19"));

summary.getRange("A:A").format.columnWidthPx = 180;
summary.getRange("B:B").format.columnWidthPx = 180;
summary.getRange("C:C").format.columnWidthPx = 24;
summary.getRange("D:J").format.columnWidthPx = 110;
summary.getRange("1:1").format.rowHeightPx = 34;
summary.getRange("3:5").format.rowHeightPx = 42;
summary.getRange("17:19").format.rowHeightPx = 30;

matrix.getRange("A1:E1").values = [[
  "Contract / context",
  "KPI or reporting areas found",
  "Available from Asset Vision-style tables?",
  "Available from silver_asset_type_activity?",
  "Notes / gaps",
]];
styleHeader(matrix.getRange("A1:E1"));
matrix.getRangeByIndexes(1, 0, matrixRows.length, 5).values = matrixRows.map((row) => [
  row.contract,
  row.kpis,
  row.av,
  row.activityTable,
  row.notes,
]);
styleBody(matrix.getRangeByIndexes(0, 0, matrixRows.length + 1, 5));
const coverageTable = matrix.tables.add(`A1:E${matrixRows.length + 1}`, true, "KpiCoverageMatrix");
coverageTable.style = "TableStyleMedium2";
matrix.freezePanes.freezeRows(1);
matrix.getRange("A:A").format.columnWidthPx = 160;
matrix.getRange("B:B").format.columnWidthPx = 280;
matrix.getRange("C:C").format.columnWidthPx = 220;
matrix.getRange("D:D").format.columnWidthPx = 250;
matrix.getRange("E:E").format.columnWidthPx = 360;
matrix.getRange(`A2:E${matrixRows.length + 1}`).format.rowHeightPx = 72;
matrix.getRange(`C2:C${matrixRows.length + 1}`).conditionalFormats.add("containsText", {
  text: "Yes",
  format: { fill: "#E2F0D9", font: { color: "#375623" } },
});
matrix.getRange(`C2:C${matrixRows.length + 1}`).conditionalFormats.add("containsText", {
  text: "Partial",
  format: { fill: "#FFF2CC", font: { color: "#7F6000" } },
});
matrix.getRange(`C2:C${matrixRows.length + 1}`).conditionalFormats.add("containsText", {
  text: "No",
  format: { fill: "#FCE4D6", font: { color: "#9E480E" } },
});
matrix.getRange(`C2:C${matrixRows.length + 1}`).conditionalFormats.add("containsText", {
  text: "Unclear",
  format: { fill: "#E7E6E6", font: { color: "#404040" } },
});

capabilities.getRange("A1:D1").values = [["KPI / metric type", "Source in or near Asset Vision", "Asset Vision coverage", "Current table coverage"]];
styleHeader(capabilities.getRange("A1:D1"));
capabilities.getRangeByIndexes(1, 0, capabilityRows.length, 4).values = capabilityRows;
styleBody(capabilities.getRangeByIndexes(0, 0, capabilityRows.length + 1, 4));
const capabilityTable = capabilities.tables.add(`A1:D${capabilityRows.length + 1}`, true, "AssetVisionCapabilityMap");
capabilityTable.style = "TableStyleMedium4";
capabilities.freezePanes.freezeRows(1);
capabilities.getRange("A:A").format.columnWidthPx = 210;
capabilities.getRange("B:B").format.columnWidthPx = 270;
capabilities.getRange("C:C").format.columnWidthPx = 210;
capabilities.getRange("D:D").format.columnWidthPx = 270;
capabilities.getRange(`A2:D${capabilityRows.length + 1}`).format.rowHeightPx = 54;

notes.getRange("A1:B1").values = [["Source / caveat", "How it was used"]];
styleHeader(notes.getRange("A1:B1"));
notes.getRangeByIndexes(1, 0, sources.length, 2).values = sources;
notes.getRangeByIndexes(sources.length + 3, 0, 5, 2).values = [
  ["Evidence boundary", "This workbook is based on the current wiki/table-documentation synthesis, not authoritative contract KPI schedules."],
  ["Contract schedules", "Formal KPI definitions still need validation against each contract appendix or monthly report template."],
  ["Asset Vision boundary", "Asset Vision supports operational asset/job/inspection data, but several KPI areas rely on adjacent contract-specific tables and curated views."],
  ["Current table boundary", "silver_asset_type_activity is a job/work-order activity table, not an inspection, incident, lane-access, PCAS, abatement or subcontractor table."],
  ["Recommended next model", "Create a sister inspection KPI table and keep WRU/TSRC/SRAPC contract-specific KPI views separate until lineage is validated."],
];
styleBody(notes.getRangeByIndexes(0, 0, sources.length + 8, 2));
notes.getRange("A:A").format.columnWidthPx = 230;
notes.getRange("B:B").format.columnWidthPx = 650;
notes.getRange(`A2:B${sources.length + 8}`).format.rowHeightPx = 48;

const inspection = await workbook.inspect({
  kind: "table",
  range: "KPI Coverage Matrix!A1:E11",
  include: "values,formulas",
  tableMaxRows: 12,
  tableMaxCols: 6,
});
console.log(inspection.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 300 },
  summary: "final formula error scan",
});
console.log(errors.ndjson);

for (const sheetName of ["Summary", "KPI Coverage Matrix", "AV Capability Map", "Sources & Caveats"]) {
  const preview = await workbook.render({ sheetName, autoCrop: "all", scale: 1, format: "png" });
  await fs.writeFile(`${outputDir}/${sheetName.replace(/[^A-Za-z0-9]+/g, "_").toLowerCase()}.png`, new Uint8Array(await preview.arrayBuffer()));
}

const xlsx = await SpreadsheetFile.exportXlsx(workbook);
await xlsx.save(`${outputDir}/transport_kpi_asset_vision_coverage.xlsx`);
