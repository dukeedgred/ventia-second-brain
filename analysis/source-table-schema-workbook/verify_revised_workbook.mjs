import path from "node:path";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const root = process.cwd();
const workbookPath = path.join(root, "outputs", "source-table-schema-workbook", "transport-source-schema-high-level-summary.xlsx");
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
  range: "Schema Summary!A1:K8",
  include: "values",
  tableMaxRows: 8,
  tableMaxCols: 11,
  maxChars: 5000,
});
console.log(schema.ndjson);

const assets = await workbook.inspect({
  kind: "table",
  range: "Contractor Assets!A1:K10",
  include: "values",
  tableMaxRows: 10,
  tableMaxCols: 11,
  maxChars: 5000,
});
console.log(assets.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  summary: "exported workbook error scan",
});
console.log(errors.ndjson);
