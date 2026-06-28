import fs from "node:fs/promises";
import path from "node:path";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const root = process.cwd();
const analysisDir = path.join(root, "analysis", "source-table-schema-workbook");
const dataPath = path.join(analysisDir, "data", "source_table_workbook_data.json");
const outputDir = path.join(root, "outputs", "source-table-schema-workbook");
const outputPath = path.join(outputDir, "transport-source-table-schema-asset-summary.xlsx");

const data = JSON.parse(await fs.readFile(dataPath, "utf8"));

const schemaHeaders = [
  "Schema Name",
  "Table Name",
  "Business Area / Subject",
  "Attribute Cluster",
  "Dimension Attributes",
  "Metric Attributes",
  "Example Values or Field Examples",
  "Potential Additional Metrics",
  "Notes / Assumptions",
  "Cached Row Count",
  "Cached Freshness / Velocity",
];

const assetHeaders = [
  "Contractor",
  "Asset Type",
  "Asset Category",
  "Asset Count",
  "Location / Region / State if available",
  "Source Schema",
  "Source Table",
  "Notes / Data Quality Issues",
];

function colName(index) {
  let dividend = index + 1;
  let name = "";
  while (dividend > 0) {
    const modulo = (dividend - 1) % 26;
    name = String.fromCharCode(65 + modulo) + name;
    dividend = Math.floor((dividend - modulo) / 26);
  }
  return name;
}

function tableRange(rowCount, colCount) {
  return `A1:${colName(colCount - 1)}${rowCount}`;
}

function rowsFor(headers, records) {
  return [
    headers,
    ...records.map((record) => headers.map((header) => record[header] ?? "")),
  ];
}

function setColumnWidths(sheet, widthsPx) {
  widthsPx.forEach((width, index) => {
    const column = colName(index);
    sheet.getRange(`${column}:${column}`).format.columnWidthPx = width;
  });
}

function styleSheet(sheet, rowCount, colCount, tableName, countColumnIndexes = []) {
  sheet.showGridLines = false;
  sheet.freezePanes.freezeRows(1);
  const usedRange = sheet.getRange(tableRange(rowCount, colCount));
  usedRange.format = {
    font: { name: "Aptos", size: 10, color: "#172033" },
    wrapText: true,
    verticalAlignment: "Top",
  };
  const header = sheet.getRange(`A1:${colName(colCount - 1)}1`);
  header.format = {
    fill: "#17324D",
    font: { bold: true, color: "#FFFFFF", name: "Aptos", size: 10 },
    wrapText: true,
    verticalAlignment: "Middle",
  };
  header.format.rowHeightPx = 42;
  const table = sheet.tables.add(tableRange(rowCount, colCount), true, tableName);
  table.style = "TableStyleMedium2";
  table.showFilterButton = true;
  countColumnIndexes.forEach((index) => {
    const column = colName(index);
    sheet.getRange(`${column}2:${column}${rowCount}`).format.numberFormat = "#,##0";
  });
}

const workbook = Workbook.create();
const schemaSheet = workbook.worksheets.add("Schema Summary");
const assetSheet = workbook.worksheets.add("Contractor Assets");

const schemaValues = rowsFor(schemaHeaders, data.schema_summary);
const assetValues = rowsFor(assetHeaders, data.contractor_assets);

schemaSheet.getRange(tableRange(schemaValues.length, schemaHeaders.length)).values = schemaValues;
assetSheet.getRange(tableRange(assetValues.length, assetHeaders.length)).values = assetValues;

styleSheet(schemaSheet, schemaValues.length, schemaHeaders.length, "SchemaSummaryTable", [9]);
styleSheet(assetSheet, assetValues.length, assetHeaders.length, "ContractorAssetsTable", [3]);

setColumnWidths(schemaSheet, [155, 135, 210, 175, 350, 330, 330, 360, 430, 120, 220]);
setColumnWidths(assetSheet, [250, 220, 185, 110, 290, 190, 115, 430]);

schemaSheet.getRange(`I2:I${schemaValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };
schemaSheet.getRange(`H2:H${schemaValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };
assetSheet.getRange(`H2:H${assetValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };
assetSheet.getRange(`E2:E${assetValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };

// Keep high-level summary readable rather than over-tall.
schemaSheet.getRange(`A2:K${schemaValues.length}`).format.rowHeightPx = 58;
assetSheet.getRange(`A2:H${assetValues.length}`).format.rowHeightPx = 50;

await fs.mkdir(outputDir, { recursive: true });

const schemaPreview = await workbook.render({
  sheetName: "Schema Summary",
  range: "A1:K24",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  path.join(outputDir, "schema-summary-preview.png"),
  new Uint8Array(await schemaPreview.arrayBuffer()),
);

const assetPreview = await workbook.render({
  sheetName: "Contractor Assets",
  range: "A1:H24",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  path.join(outputDir, "contractor-assets-preview.png"),
  new Uint8Array(await assetPreview.arrayBuffer()),
);

const sheetInspect = await workbook.inspect({
  kind: "sheet",
  include: "id,name",
  maxChars: 2000,
});
console.log(sheetInspect.ndjson);

const schemaInspect = await workbook.inspect({
  kind: "table",
  range: "Schema Summary!A1:K6",
  include: "values",
  tableMaxRows: 6,
  tableMaxCols: 11,
  maxChars: 5000,
});
console.log(schemaInspect.ndjson);

const assetInspect = await workbook.inspect({
  kind: "table",
  range: "Contractor Assets!A1:H6",
  include: "values",
  tableMaxRows: 6,
  tableMaxCols: 8,
  maxChars: 5000,
});
console.log(assetInspect.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  summary: "formula error scan",
});
console.log(errors.ndjson);

const xlsx = await SpreadsheetFile.exportXlsx(workbook);
await xlsx.save(outputPath);
console.log(JSON.stringify({
  outputPath,
  schemaRows: data.schema_summary.length,
  contractorAssetRows: data.contractor_assets.length,
  assetCountTotal: data.validation.asset_count_total,
}, null, 2));
