---
name: update-tables-md
description: Document Ventia Transport sector database tables and view SQL as curated wiki pages under content/wiki/Ventia/Data Tables. Use when the user provides table names, Databricks metadata JSON, schemas, DDL, view queries, SQL definitions, column lists, or business context and asks Codex to add, append, catalog, sort, refresh, deduplicate, or clean up Transport table documentation. Treat Transport contract schemas as contract contexts, but keep generic source database schemas such as dbo as source metadata unless contract/client identity is explicit.
---

# Update Table Wiki Docs

## Purpose

Maintain Ventia Transport sector table documentation inside the wiki, not in a
root `tables.md` file. Create and update curated markdown pages under
`content/wiki/Ventia/Data Tables/` with a structure that scales by sector,
contract/schema or source context, source system, and individual table.

This is documentation-only: edit markdown directly and do not create helper
scripts or programming functions.

## Target Structure

Use this folder layout:

```text
content/wiki/Ventia/Data Tables/
  Transport/
    Transport Data Tables.md
    <context>/
      Transport Contract Tables - <contract-schema>.md
      Transport Source Tables - <source-context>.md
      Transport Table - <contract-schema> - <table_name>.md
      Transport Source Table - <source-context> - <table_name>.md
```

Rules:

- Use `Transport Data Tables.md` as the sector-level catalog.
- Use one contract/schema folder per curated Transport schema, for example
  `transport`, `wru`, `srapc`, `finance`, `nzlnno`, or the exact schema name
  supplied.
- Use one source-context folder per external source catalog/context when the
  database schema is generic, for example `asset_vision_vsm_gen7` for
  `ext_mssql_asset_vision_vsm_gen7.dbo`.
- Use one table page per table.
- Name contract table pages as
  `Transport Table - <contract-schema> - <table_name>.md`.
- Name external source table pages as
  `Transport Source Table - <source-context> - <table_name>.md`.
  Use unique page names so Obsidian wikilinks remain unique when table names
  repeat across contracts or source contexts.
- Keep pages connected with wikilinks to [[Transport Data Landscape]],
  [[Ventia Databricks Platform]], and [[Transport Contract Portfolio]] where
  relevant.

## Workflow

1. Read existing wiki table docs before editing:
   - `content/wiki/Ventia/Data Tables/Transport/Transport Data Tables.md`
   - the relevant contract/schema index page, if it exists
   - existing table pages for matching `full_name` or `table_name`
2. Parse every table supplied by the user. The user may paste a single object,
   a JSON-like list of objects, Databricks metadata, DDL, view SQL, or a plain
   column list.
3. Derive `catalog.schema.table` values from `full_name` when available.
4. Treat the schema/database component as the Transport contract/schema context
   only when it is a Transport contract schema or a supplied source says so.
   For raw/federated source tables, generic database schemas such as `dbo` are
   source metadata, not contractor/client names.
5. Create or update:
   - the sector catalog page
   - the relevant contract/schema or source-context catalog page
   - one table page per complete table object
6. Update an existing table page when normalized `full_name` matches. If
   `full_name` is missing, match by contract/schema or source context plus
   `table_name`.
7. Sort catalog tables by context, then source system when known, then table
   name.
8. Preserve column order exactly as supplied.
9. For view tables, preserve any supplied view query exactly in a dedicated
   `## View Query` section.
10. Do not invent descriptions, business meanings, relationships, keys, owners,
   joins, data quality claims, or usage notes.

## What To Capture

Always capture these when available:

- Table identity: table name, full name, catalog, schema/database, table type,
  and contract/schema.
- Documentation date: current date as `date-updated` and `Last documented`.
- Schema: column name, data type, nullable flag, and supplied column comments.
- View SQL: for `VIEW` table types, capture supplied SQL from fields such as
  `view_query`, `view_definition`, `query`, `sql`, `definition`, or `ddl`.
- Counts: column count, and row count only when explicitly supplied.
- Source details: source system, environment, workspace, layer, or provider.

Capture these optional fields only when supplied:

- Business purpose or table description.
- Grain: what one row represents.
- Contract name if it is more specific than the schema identifier and is
  explicitly supplied or supported by source evidence.
- Data domain, such as finance, asset, job, timesheet, inspection, defect,
  hazard, KPI, fleet, telematics, GIS, or SAP. Use this only when supplied or
  conservatively inferable from the table/column names; leave blank when unsure.
- Key columns, primary keys, natural keys, foreign keys, and join keys.
- Related tables, upstream/downstream dependencies, reports, dashboards, or
  semantic models.
- Owner, steward, SME, accountable team, or support channel.
- Refresh cadence, last refresh, creation date, last altered date, freshness
  notes, or promotion status.
- Partitioning, clustering, storage format/provider, location, or
  materialization details.
- Access constraints, data sensitivity, PII, commercial sensitivity, or security
  notes.
- Known caveats, quality warnings, reconciliation issues, and open questions.

Ignore low-level Spark/Databricks `metadata` fields such as `signed`, `scale`,
and `isTimestampNTZ` unless the user asks to retain them or they add meaning not
already present in the data type.

## View Query Rule

For table objects where `table_type` is `VIEW`, preserve the supplied view SQL
as source text when available.

Accepted query fields include:

- `view_query`
- `view_definition`
- `query`
- `sql`
- `definition`
- `ddl`

Write the SQL under `## View Query` in a fenced `sql` block. Do not reformat,
rewrite, summarize, or infer the query. If the query is a JSON string with `\n`
escapes, render it as readable multi-line SQL. If no query is supplied, omit the
section rather than adding a placeholder.

## Transport Schema Rule

When `full_name` follows `catalog.schema.table`, derive:

- **Catalog:** first component.
- **Schema:** second component.
- **Contract/schema:** second component for curated Transport schemas when the
  schema is meaningful as a Transport contract/context identifier.
- **Table:** remaining component.

If multiple curated Transport schemas are pasted together, group them under
separate contract/schema folders. Do not expand schema acronyms into contract
names unless the pasted data or user notes provide the expanded name.

## Source Context Rule

For external or federated source tables, especially `FOREIGN` tables whose
`full_name` looks like `ext_mssql_<system>_<context>.dbo.<table>`, do not treat
generic source schemas such as `dbo`, `public`, `default`, or `staging` as
contractors, clients, or Transport contracts.

Instead, derive a source context from explicit evidence, in this priority order:

1. Supplied contract/client name, owner notes, comments, or user instructions.
2. View filters or source SQL, such as `WHERE Contract = 'Auckland West Transport'`.
3. Column values explicitly supplied by the user, such as values from a `Contract`
   or `Client` column.
4. A validated catalog or table naming convention.
5. A conservative source context from the catalog name, with an open question.

For `ext_mssql_asset_vision_vsm_gen7.dbo.asset`, the catalog is
`ext_mssql_asset_vision_vsm_gen7`, the source schema is `dbo`, and the source
context may be documented as `asset_vision_vsm_gen7` with a caveat to confirm
whether `vsm_gen7` maps to a client, contract, or environment. Never document
`dbo` as the client/contract context.

## Sector Catalog Template

Path:
`content/wiki/Ventia/Data Tables/Transport/Transport Data Tables.md`

```markdown
---
type: table-catalog
topic: Ventia
sector: Transport
date-created: YYYY-MM-DD
date-updated: YYYY-MM-DD
tags: [transport, data-tables, databricks]
---

# Transport Data Tables

This page catalogs known Transport sector table documentation. Contract-specific
schemas are treated as contract or contract-group contexts.

## Contract/schema Index

| Contract/schema | Tables | Notes |
|---|---:|---|
| [[Transport Contract Tables - contract_schema]] | 3 | Supplied notes, if known |

## Table Index

| Contract/schema | Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---|---:|---|---|
| `contract_schema` | [[Transport Table - contract_schema - example_table]] | `transport_dev.contract_schema.example_table` | MANAGED | 3 |  |  |

## Related Pages

- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
```

## Contract Catalog Template

Path:
`content/wiki/Ventia/Data Tables/Transport/<contract-schema>/Transport Contract Tables - <contract-schema>.md`

```markdown
---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: contract_schema
date-created: YYYY-MM-DD
date-updated: YYYY-MM-DD
tags: [transport, data-tables, contract-schema]
---

# Transport Contract Tables - contract_schema

This page catalogs table documentation for the `contract_schema` Transport
schema. In Transport, schema differences usually indicate different contracts or
contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - contract_schema - example_table]] | `transport_dev.contract_schema.example_table` | MANAGED | 3 |  |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
```

## Table Page Template

Path:
`content/wiki/Ventia/Data Tables/Transport/<contract-schema>/Transport Table - <contract-schema> - <table_name>.md`

```markdown
---
type: data-table
topic: Ventia
sector: Transport
contract-schema: contract_schema
table-name: example_table
full-name: transport_dev.contract_schema.example_table
date-created: YYYY-MM-DD
date-updated: YYYY-MM-DD
tags: [transport, data-table, databricks]
---

# Transport Table - contract_schema - example_table

## Identity

| Field | Value |
|---|---|
| Table name | `example_table` |
| Full name | `transport_dev.contract_schema.example_table` |
| Catalog | `transport_dev` |
| Schema | `contract_schema` |
| Contract/schema | `contract_schema` |
| Table type | MANAGED |
| Column count | 3 |
| Last documented | YYYY-MM-DD |

## Context

| Field | Value |
|---|---|
| Contract name | Supplied contract name, if known |
| Business purpose | Supplied purpose, if known |
| Data domain | Supplied or conservatively inferred from table/column names, if known |
| Grain | Supplied row grain, if known |
| Source system | Supplied source, if known |
| Owner/SME | Supplied owner, if known |
| Refresh/freshness | Supplied refresh details, if known |
| Key columns | Supplied keys, if known |
| Related tables/reports | Supplied relationships, if known |
| Sensitivity/access | Supplied sensitivity or access notes, if known |
| Caveats/open questions | Supplied caveats, if known |

## View Query

```sql
SELECT ...
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Contract` | `StringType()` | Yes |  |
| `RecordID` | `IntegerType()` | Yes |  |
| `Job_CompletedDate` | `TimestampType()` | Yes |  |

## Related Pages

- [[Transport Contract Tables - contract_schema]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
```

Omit rows from `## Context` when no value is supplied. Keep the `## Columns`
table even when only partial schema details are available. Omit `## View Query`
unless the table type is `VIEW` and a query was supplied.

## Parsing Databricks Metadata

The user may paste one object or an array shaped like:

```json
{
  "table_name": "utbl_job_costing_timesheets_all_contracts",
  "full_name": "transport_dev.transport.utbl_job_costing_timesheets_all_contracts",
  "table_type": "MANAGED",
  "columns": [
    {
      "column_name": "Contract",
      "data_type": "StringType()",
      "nullable": true,
      "metadata": {}
    }
  ]
}
```

For this managed-table example:

- Catalog is `transport_dev`.
- Schema and contract/schema are `transport`.
- Table page is `Transport Table - transport - utbl_job_costing_timesheets_all_contracts.md`.

View metadata may include SQL:

```json
{
  "table_name": "uvw_fw_forward_work_view",
  "full_name": "transport_dev.transport_fndc.uvw_fw_forward_work_view",
  "table_type": "VIEW",
  "columns": [
    { "column_name": "programme_hdr_name", "data_type": "string", "nullable": true }
  ],
  "view_query": "SELECT\n    programme_hdr_id AS programme_hdr_name\nFROM\n    staged_dev.stg_api_amds_fndc_test.fw_forward_work_view"
}
```

For this view example, create/update
`Transport Table - transport_fndc - uvw_fw_forward_work_view.md`, record
`transport_fndc` as the contract/schema, and add a `## View Query` section with
the supplied SQL.

Convert `nullable: true` to `Yes`, `nullable: false` to `No`, and missing
nullable values to blank. If pasted JSON is truncated, document only complete
objects and tell the user which trailing object was incomplete.

## Cleanup Rules

- Do not update or create root `tables.md`.
- Keep sector, contract, and source-context catalogs sorted in the same order as
  table pages.
- Keep one page per normalized `full_name`.
- Keep page titles and filenames unique across schemas.
- Keep column names and data types wrapped in backticks.
- Preserve supplied view SQL in fenced `sql` blocks on table pages.
- Avoid markdown inside table cells except backticks around identifiers/types.
- Update `content/index.md` with concise rows for new catalog pages and important
  table pages; for very large batches, prioritize the sector and contract
  catalog rows and mention table pages are listed in the wiki catalog pages.
- Mention in the final response how many table pages were added, updated, or
  skipped because pasted data was incomplete.
