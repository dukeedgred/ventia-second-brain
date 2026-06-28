import fs from "node:fs/promises";
import path from "node:path";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const root = process.cwd();
const analysisDir = path.join(root, "analysis", "source-table-schema-workbook");
const dataPath = path.join(analysisDir, "data", "source_table_workbook_revised_data.json");
const outputDir = path.join(root, "outputs", "source-table-schema-workbook");
const outputPath = path.join(outputDir, "transport-source-schema-high-level-summary.xlsx");

const data = JSON.parse(await fs.readFile(dataPath, "utf8"));

const schemaHeaders = [
  "Source Schema",
  "Contract / Source Context",
  "Source Tables Reviewed",
  "Asset Count",
  "Asset Type Count",
  "Asset Category Count",
  "Business Domains Covered",
  "Useful Existing Metrics / Signals",
  "Useful Dimensions",
  "Potential Metrics",
  "Data Gaps / Assumptions",
];

const assetHeaders = [
  "Contractor / Source Contract",
  "Source Schema(s)",
  "Total Assets",
  "Asset Type Count",
  "Asset Category Count",
  "Dominant Asset Family",
  "Asset Family Mix",
  "Top Asset Types",
  "Top Source Asset Categories",
  "Location / Region Coverage",
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

function rangeAddress(rowCount, colCount) {
  return `A1:${colName(colCount - 1)}${rowCount}`;
}

function rowsFor(headers, records) {
  return [headers, ...records.map((record) => headers.map((header) => record[header] ?? ""))];
}

function setColumnWidths(sheet, widthsPx) {
  widthsPx.forEach((width, index) => {
    const column = colName(index);
    sheet.getRange(`${column}:${column}`).format.columnWidthPx = width;
  });
}

function styleTable(sheet, rowCount, colCount, tableName, numericCols = [], percentCols = []) {
  sheet.showGridLines = false;
  sheet.freezePanes.freezeRows(1);
  const range = sheet.getRange(rangeAddress(rowCount, colCount));
  range.format = {
    font: { name: "Aptos", size: 10, color: "#172033" },
    wrapText: true,
    verticalAlignment: "Top",
  };
  const header = sheet.getRange(`A1:${colName(colCount - 1)}1`);
  header.format = {
    fill: "#14324A",
    font: { bold: true, color: "#FFFFFF", name: "Aptos", size: 10 },
    wrapText: true,
    verticalAlignment: "Middle",
  };
  header.format.rowHeightPx = 45;
  const table = sheet.tables.add(rangeAddress(rowCount, colCount), true, tableName);
  table.style = "TableStyleMedium2";
  table.showFilterButton = true;
  numericCols.forEach((index) => {
    const column = colName(index);
    sheet.getRange(`${column}2:${column}${rowCount}`).format.numberFormat = "#,##0";
  });
  percentCols.forEach((index) => {
    const column = colName(index);
    sheet.getRange(`${column}2:${column}${rowCount}`).format.numberFormat = "0.0%";
  });
}

const workbook = Workbook.create();
const schemaSheet = workbook.worksheets.add("Schema Summary");
const assetSheet = workbook.worksheets.add("Contractor Assets");

const schemaValues = rowsFor(schemaHeaders, data.schema_summary);
const assetValues = rowsFor(assetHeaders, data.contractor_assets);

schemaSheet.getRange(rangeAddress(schemaValues.length, schemaHeaders.length)).values = schemaValues;
assetSheet.getRange(rangeAddress(assetValues.length, assetHeaders.length)).values = assetValues;

styleTable(schemaSheet, schemaValues.length, schemaHeaders.length, "SchemaSummaryTable", [2, 3, 4, 5]);
styleTable(assetSheet, assetValues.length, assetHeaders.length, "ContractorAssetsTable", [2, 3, 4]);

setColumnWidths(schemaSheet, [180, 210, 120, 125, 115, 125, 330, 520, 350, 360, 430]);
setColumnWidths(assetSheet, [300, 230, 115, 110, 125, 245, 390, 520, 390, 300, 420]);

schemaSheet.getRange(`A2:K${schemaValues.length}`).format.rowHeightPx = 92;
assetSheet.getRange(`A2:K${assetValues.length}`).format.rowHeightPx = 82;

schemaSheet.getRange(`H2:K${schemaValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };
assetSheet.getRange(`F2:K${assetValues.length}`).format = { wrapText: true, verticalAlignment: "Top" };

await fs.mkdir(outputDir, { recursive: true });

const schemaPreview = await workbook.render({
  sheetName: "Schema Summary",
  range: "A1:K8",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  path.join(outputDir, "revised-schema-summary-preview.png"),
  new Uint8Array(await schemaPreview.arrayBuffer()),
);

const assetPreview = await workbook.render({
  sheetName: "Contractor Assets",
  range: "A1:K18",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  path.join(outputDir, "revised-contractor-assets-preview.png"),
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
  range: "Schema Summary!A1:K8",
  include: "values",
  tableMaxRows: 8,
  tableMaxCols: 11,
  maxChars: 6000,
});
console.log(schemaInspect.ndjson);

const assetInspect = await workbook.inspect({
  kind: "table",
  range: "Contractor Assets!A1:K8",
  include: "values",
  tableMaxRows: 8,
  tableMaxCols: 11,
  maxChars: 6000,
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
  schemaRows: data.validation.schema_rows,
  contractorRows: data.validation.contractor_rows,
  totalAssets: data.validation.total_assets,
}, null, 2));
