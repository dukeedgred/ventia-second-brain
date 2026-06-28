import path from "node:path";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const root = process.cwd();
const workbookPath = path.join(root, "outputs", "source-table-schema-workbook", "transport-source-table-schema-asset-summary.xlsx");
const blob = await FileBlob.load(workbookPath);
const workbook = await SpreadsheetFile.importXlsx(blob);

const sheets = await workbook.inspect({
  kind: "sheet",
  include: "id,name",
  maxChars: 2000,
});
console.log(sheets.ndjson);

const schema = await workbook.inspect({
  kind: "table",
  range: "Schema Summary!A1:K4",
  include: "values",
  tableMaxRows: 4,
  tableMaxCols: 11,
  maxChars: 4000,
});
console.log(schema.ndjson);

const assets = await workbook.inspect({
  kind: "table",
  range: "Contractor Assets!A1:H4",
  include: "values",
  tableMaxRows: 4,
  tableMaxCols: 8,
  maxChars: 4000,
});
console.log(assets.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  summary: "exported workbook error scan",
});
console.log(errors.ndjson);
