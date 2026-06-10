param(
  [string]$OutputDir = ".\analysis\databricks-validation\four-vs-out",
  [string]$Profile = "ventia-transport",
  [string]$DatabricksExe = "",
  [string[]]$SourceCatalogs = @(
    "ext_mssql_asset_vision_ven_gen7",
    "ext_mssql_asset_vision_ven_rms",
    "ext_mssql_asset_vision_ven_vicroads",
    "ext_mssql_asset_vision_vns_gen7",
    "ext_mssql_asset_vision_vnz_gen7",
    "ext_mssql_asset_vision_vsm_gen7"
  ),
  [string]$ContractCatalog = "transport_dev",
  [string[]]$ContractSchemas = @(
    "transport",
    "transport_aklw",
    "transport_fndc",
    "transport_nel",
    "transport_ramc",
    "transport_sht",
    "transport_srapc",
    "transport_tsrc",
    "transport_wru"
  )
)

$ErrorActionPreference = "Stop"

function Require-Env($Name) {
  $value = [Environment]::GetEnvironmentVariable($Name)
  if ([string]::IsNullOrWhiteSpace($value)) {
    throw "Missing environment variable $Name"
  }
  return $value
}

function Resolve-DatabricksExe {
  if (-not [string]::IsNullOrWhiteSpace($DatabricksExe)) {
    return $DatabricksExe
  }

  $cmd = Get-Command databricks -ErrorAction SilentlyContinue
  if ($cmd) {
    return $cmd.Source
  }

  $wingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages\Databricks.DatabricksCLI_Microsoft.Winget.Source_8wekyb3d8bbwe\databricks.exe"
  if (Test-Path $wingetPath) {
    return $wingetPath
  }

  throw "Databricks CLI was not found. Install it or pass -DatabricksExe."
}

function Safe-FileName($Value) {
  return ($Value -replace "[^a-zA-Z0-9_.-]", "_")
}

function Quote-SqlName($Name) {
  $escaped = $Name.Replace('`', '``')
  return ('`' + $escaped + '`')
}

function Sql-String($Value) {
  return "'" + ($Value -replace "'", "''") + "'"
}

function Result-Rows($Payload) {
  if (-not $Payload.result -or -not $Payload.result.data_array) {
    return @()
  }

  $columns = @($Payload.manifest.schema.columns | Sort-Object position | ForEach-Object { $_.name })
  return @($Payload.result.data_array | ForEach-Object {
    $row = [ordered]@{}
    for ($i = 0; $i -lt $columns.Count; $i++) {
      $row[$columns[$i]] = $_[$i]
    }
    [pscustomobject]$row
  })
}

function Invoke-DatabricksSql {
  param(
    [Parameter(Mandatory = $true)][string]$Statement,
    [Parameter(Mandatory = $true)][string]$Name
  )

  $body = @{
    warehouse_id = $warehouseId
    statement = $Statement
    wait_timeout = "30s"
    disposition = "INLINE"
    format = "JSON_ARRAY"
  } | ConvertTo-Json -Depth 8

  $uri = "$hostName/api/2.0/sql/statements/"
  $response = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $body
  $statementId = $response.statement_id

  while ($response.status.state -in @("PENDING", "RUNNING")) {
    Start-Sleep -Seconds 2
    $response = Invoke-RestMethod -Method Get -Uri "$uri$statementId" -Headers $headers
  }

  $payload = [ordered]@{
    name = $Name
    statement = $Statement
    status = $response.status
    manifest = $response.manifest
    result = $response.result
  }

  $file = Join-Path $OutputDir "$(Safe-FileName $Name).json"
  $payload | ConvertTo-Json -Depth 30 | Set-Content -Encoding utf8 -Path $file

  if ($response.status.state -ne "SUCCEEDED") {
    $message = if ($response.status.error) { $response.status.error.message } else { "Statement failed" }
    throw "$Name failed: $message"
  }

  return $payload
}

function Get-Domain($TableName) {
  $t = $TableName.ToLowerInvariant()
  switch -Regex ($t) {
    '^v?asset|assetarea|assetattribute|assetclassification|assetlocation|assetvaluation|assethierarchy' { return "Asset register / hierarchy" }
    '^v?job|jobasset|jobcomment' { return "Jobs / work orders / defects" }
    '^v?inspection|inspectionrelationship|inspectionstatus' { return "Inspections" }
    '^v?capitalwork|capitalworktask|utbl_capitalwork' { return "Capital works" }
    '^photo' { return "Photos / evidence" }
    '^module|^vmodule|formfield|custommoduleitem' { return "Forms / modules" }
    '^workflowstatus|^vworkflowstatus' { return "Workflow / status" }
    '^resource|plannedresourceitem|timesheet|uvw_timesheet' { return "Resources / timesheets" }
    'counter|counts|traffic' { return "Traffic counts" }
    'date_table|eot|reference|contractreference' { return "Reference / contract support" }
    'laneaccess' { return "Lane access" }
    'log|exportdate|sqlserverversions' { return "Audit / export / system" }
    default { return "Other / contract-specific" }
  }
}

function Get-VelocityBucket($LatestTimestamp) {
  if ([string]::IsNullOrWhiteSpace($LatestTimestamp)) {
    return "No timestamp signal"
  }

  try {
    $latest = [datetime]$LatestTimestamp
  } catch {
    return "Timestamp parse failed"
  }

  $days = ([datetime]::Now - $latest).TotalDays
  if ($days -lt -1) { return "Future-dated data present" }
  if ($days -le 1) { return "Current: latest data within 1 day" }
  if ($days -le 7) { return "Active: latest data within 7 days" }
  if ($days -le 31) { return "Recent: latest data within 31 days" }
  if ($days -le 180) { return "Stale: latest data within 180 days" }
  return "Historical: latest data older than 180 days"
}

function Get-FreshnessExpression($Columns) {
  $dateColumns = @($Columns | Where-Object {
    $dt = [string]$_.data_type
    $name = [string]$_.column_name
    $dt -match 'DATE|TIMESTAMP' -or $name -match '(?i)date|time|created|updated|modified|completed|scheduled|start|finish|due|export'
  } | Select-Object -ExpandProperty column_name -Unique)

  if ($dateColumns.Count -eq 0) {
    return @{
      Latest = "CAST(NULL AS TIMESTAMP) AS latest_observed_ts"
      Earliest = "CAST(NULL AS TIMESTAMP) AS earliest_observed_ts"
      DateColumns = ""
    }
  }

  $maxes = @($dateColumns | ForEach-Object {
    $cast = "try_cast($(Quote-SqlName $_) AS TIMESTAMP)"
    "MAX(CASE WHEN $cast <= current_timestamp() + INTERVAL 1 DAY THEN $cast END)"
  })
  $mins = @($dateColumns | ForEach-Object {
    $cast = "try_cast($(Quote-SqlName $_) AS TIMESTAMP)"
    "MIN(CASE WHEN $cast >= TIMESTAMP '1900-01-01 00:00:00' AND $cast <= current_timestamp() + INTERVAL 1 DAY THEN $cast END)"
  })
  $latest = if ($maxes.Count -eq 1) { "$($maxes[0]) AS latest_observed_ts" } else { "GREATEST($($maxes -join ", ")) AS latest_observed_ts" }
  $earliest = if ($mins.Count -eq 1) { "$($mins[0]) AS earliest_observed_ts" } else { "LEAST($($mins -join ", ")) AS earliest_observed_ts" }

  return @{
    Latest = $latest
    Earliest = $earliest
    DateColumns = ($dateColumns -join "|")
  }
}

New-Item -ItemType Directory -Force $OutputDir | Out-Null

$hostName = (Require-Env "DATABRICKS_HOST").TrimEnd("/")
$warehouseId = Require-Env "DATABRICKS_WAREHOUSE_ID"
$token = [Environment]::GetEnvironmentVariable("DATABRICKS_TOKEN")
if ([string]::IsNullOrWhiteSpace($token)) {
  $dbx = Resolve-DatabricksExe
  $rawToken = & $dbx auth token $Profile -o json
  if ($LASTEXITCODE -ne 0) {
    throw "Could not acquire Databricks OAuth token for profile $Profile"
  }
  $tokenPayload = $rawToken | ConvertFrom-Json
  $token = $tokenPayload.access_token
}

$headers = @{
  "Authorization" = "Bearer $token"
  "Content-Type" = "application/json"
}

Write-Host "Collecting source inventory"
$sourceInventory = @()
$sourceColumns = @()
foreach ($catalog in $SourceCatalogs) {
  $qCatalog = Quote-SqlName $catalog
  $tablesPayload = Invoke-DatabricksSql -Name "01_inventory_source_$catalog" -Statement @"
SELECT
  'source' AS table_family,
  $(Sql-String $catalog) AS catalog_name,
  table_schema AS schema_name,
  table_name,
  table_type
FROM $qCatalog.information_schema.tables
WHERE table_schema = 'dbo'
ORDER BY table_name
"@
  $sourceInventory += Result-Rows $tablesPayload

  $columnsPayload = Invoke-DatabricksSql -Name "02_columns_source_$catalog" -Statement @"
SELECT
  'source' AS table_family,
  $(Sql-String $catalog) AS catalog_name,
  table_schema AS schema_name,
  table_name,
  column_name,
  data_type,
  ordinal_position
FROM $qCatalog.information_schema.columns
WHERE table_schema = 'dbo'
ORDER BY table_name, ordinal_position
"@
  $sourceColumns += Result-Rows $columnsPayload
}

Write-Host "Collecting contract inventory"
$schemaList = ($ContractSchemas | ForEach-Object { Sql-String $_ }) -join ", "
$contractPayload = Invoke-DatabricksSql -Name "03_inventory_contract_tables" -Statement @"
SELECT
  'contract' AS table_family,
  table_catalog AS catalog_name,
  table_schema AS schema_name,
  table_name,
  table_type
FROM $(Quote-SqlName $ContractCatalog).information_schema.tables
WHERE table_schema IN ($schemaList)
ORDER BY table_schema, table_name
"@
$contractInventory = Result-Rows $contractPayload

$contractColumnsPayload = Invoke-DatabricksSql -Name "04_columns_contract_tables" -Statement @"
SELECT
  'contract' AS table_family,
  table_catalog AS catalog_name,
  table_schema AS schema_name,
  table_name,
  column_name,
  data_type,
  ordinal_position
FROM $(Quote-SqlName $ContractCatalog).information_schema.columns
WHERE table_schema IN ($schemaList)
ORDER BY table_schema, table_name, ordinal_position
"@
$contractColumns = Result-Rows $contractColumnsPayload

$inventory = @($sourceInventory + $contractInventory)
$columns = @($sourceColumns + $contractColumns)
$inventory | Export-Csv -NoTypeInformation -Encoding utf8 -Path (Join-Path $OutputDir "table_inventory.csv")
$columns | Export-Csv -NoTypeInformation -Encoding utf8 -Path (Join-Path $OutputDir "table_columns.csv")

Write-Host "Counting rows and freshness by schema/catalogue"
$metrics = @()
$groups = $inventory | Group-Object table_family, catalog_name, schema_name
foreach ($group in $groups) {
  $first = $group.Group[0]
  $family = [string]$first.table_family
  $catalog = [string]$first.catalog_name
  $schema = [string]$first.schema_name
  $selects = @()

  foreach ($table in $group.Group) {
    $tableName = [string]$table.table_name
    $tableColumns = @($columns | Where-Object {
      $_.catalog_name -eq $catalog -and $_.schema_name -eq $schema -and $_.table_name -eq $tableName
    })
    $freshness = Get-FreshnessExpression $tableColumns
    $selects += @"
SELECT
  $(Sql-String $family) AS table_family,
  $(Sql-String $catalog) AS catalog_name,
  $(Sql-String $schema) AS schema_name,
  $(Sql-String $tableName) AS table_name,
  $(Sql-String ([string]$table.table_type)) AS table_type,
  COUNT(*) AS row_count,
  COUNT(*) > 0 AS has_rows,
  $($freshness.Latest),
  $($freshness.Earliest),
  $(Sql-String $freshness.DateColumns) AS freshness_columns
FROM $(Quote-SqlName $catalog).$(Quote-SqlName $schema).$(Quote-SqlName $tableName)
"@
  }

  if ($selects.Count -gt 0) {
    $sql = $selects -join "`nUNION ALL`n"
    try {
      $payload = Invoke-DatabricksSql -Name "05_metrics_${family}_${catalog}_${schema}" -Statement $sql
      $metrics += Result-Rows $payload
    } catch {
      Write-Warning "Metrics failed for $($catalog).$($schema): $($_.Exception.Message)"
      foreach ($table in $group.Group) {
        $tableName = [string]$table.table_name
        if ($family -eq "contract" -and ([string]$table.table_type).ToUpperInvariant() -eq "VIEW") {
          $metrics += [pscustomobject]@{
            table_family = $family
            catalog_name = $catalog
            schema_name = $schema
            table_name = $table.table_name
            table_type = $table.table_type
            row_count = $null
            has_rows = $null
            latest_observed_ts = $null
            earliest_observed_ts = $null
            freshness_columns = ""
          }
          continue
        }

        $tableColumns = @($columns | Where-Object {
          $_.catalog_name -eq $catalog -and $_.schema_name -eq $schema -and $_.table_name -eq $tableName
        })
        $freshness = Get-FreshnessExpression $tableColumns
        $singleSql = @"
SELECT
  $(Sql-String $family) AS table_family,
  $(Sql-String $catalog) AS catalog_name,
  $(Sql-String $schema) AS schema_name,
  $(Sql-String $tableName) AS table_name,
  $(Sql-String ([string]$table.table_type)) AS table_type,
  COUNT(*) AS row_count,
  COUNT(*) > 0 AS has_rows,
  $($freshness.Latest),
  $($freshness.Earliest),
  $(Sql-String $freshness.DateColumns) AS freshness_columns
FROM $(Quote-SqlName $catalog).$(Quote-SqlName $schema).$(Quote-SqlName $tableName)
"@
        try {
          $singlePayload = Invoke-DatabricksSql -Name "05_metrics_single_${family}_${catalog}_${schema}_${tableName}" -Statement $singleSql
          $metrics += Result-Rows $singlePayload
        } catch {
          Write-Warning "Metrics failed for $($catalog).$($schema).$($tableName): $($_.Exception.Message)"
          $metrics += [pscustomobject]@{
            table_family = $family
            catalog_name = $catalog
            schema_name = $schema
            table_name = $table.table_name
            table_type = $table.table_type
            row_count = $null
            has_rows = $null
            latest_observed_ts = $null
            earliest_observed_ts = $null
            freshness_columns = ""
          }
        }
      }
    }
  }
}

Write-Host "Trying Databricks system table-lineage usage"
$usageRows = @()
$lineageAvailable = $true
try {
  $values = @($inventory | ForEach-Object {
    "(" + (Sql-String $_.table_family) + ", " +
      (Sql-String $_.catalog_name) + ", " +
      (Sql-String $_.schema_name) + ", " +
      (Sql-String $_.table_name) + ", " +
      (Sql-String "$($_.catalog_name).$($_.schema_name).$($_.table_name)") + ")"
  })

  $chunks = @()
  for ($i = 0; $i -lt $values.Count; $i += 150) {
    $end = [Math]::Min($i + 149, $values.Count - 1)
    $chunks += ,@($values[$i..$end])
  }

  foreach ($chunk in $chunks) {
    $valueSql = $chunk -join ",`n"
    $usagePayload = Invoke-DatabricksSql -Name "06_usage_lineage_chunk_$($usageRows.Count)" -Statement @"
WITH target_tables(table_family, catalog_name, schema_name, table_name, full_name) AS (
  VALUES
  $valueSql
),
lineage AS (
  SELECT
    lower(source_table_full_name) AS full_name,
    event_time
  FROM system.access.table_lineage
  WHERE event_date >= date_sub(current_date(), 90)
    AND source_table_full_name IS NOT NULL
  UNION ALL
  SELECT
    lower(target_table_full_name) AS full_name,
    event_time
  FROM system.access.table_lineage
  WHERE event_date >= date_sub(current_date(), 90)
    AND target_table_full_name IS NOT NULL
)
SELECT
  t.table_family,
  t.catalog_name,
  t.schema_name,
  t.table_name,
  COUNT(l.event_time) AS usage_events_90d,
  MAX(l.event_time) AS last_usage_event_ts
FROM target_tables t
LEFT JOIN lineage l
  ON lower(t.full_name) = l.full_name
GROUP BY t.table_family, t.catalog_name, t.schema_name, t.table_name
"@
    $usageRows += Result-Rows $usagePayload
  }
} catch {
  $lineageAvailable = $false
  Write-Warning "Table lineage usage was not available: $($_.Exception.Message)"
}

if ($usageRows.Count -gt 0) {
  $usageRows | Export-Csv -NoTypeInformation -Encoding utf8 -Path (Join-Path $OutputDir "table_usage_90d.csv")
}

$columnLookup = @{}
foreach ($columnGroup in ($columns | Group-Object table_family, catalog_name, schema_name, table_name)) {
  $sample = $columnGroup.Group[0]
  $key = "$($sample.table_family)|$($sample.catalog_name)|$($sample.schema_name)|$($sample.table_name)"
  $columnLookup[$key] = $columnGroup.Group
}

$usageLookup = @{}
foreach ($usage in $usageRows) {
  $key = "$($usage.table_family)|$($usage.catalog_name)|$($usage.schema_name)|$($usage.table_name)"
  $usageLookup[$key] = $usage
}

$tableMetrics = @($metrics | ForEach-Object {
  $key = "$($_.table_family)|$($_.catalog_name)|$($_.schema_name)|$($_.table_name)"
  $tableColumns = if ($columnLookup.ContainsKey($key)) { @($columnLookup[$key]) } else { @() }
  $usage = if ($usageLookup.ContainsKey($key)) { $usageLookup[$key] } else { $null }
  $rowCount = if ([string]::IsNullOrWhiteSpace([string]$_.row_count)) { $null } else { [int64]$_.row_count }
  $usageCount = if ($usage -and -not [string]::IsNullOrWhiteSpace([string]$usage.usage_events_90d)) { [int64]$usage.usage_events_90d } else { $null }
  [pscustomobject]@{
    table_family = $_.table_family
    catalog_name = $_.catalog_name
    schema_name = $_.schema_name
    table_name = $_.table_name
    table_type = $_.table_type
    domain = Get-Domain $_.table_name
    row_count = $rowCount
    column_count = $tableColumns.Count
    latest_observed_ts = $_.latest_observed_ts
    earliest_observed_ts = $_.earliest_observed_ts
    inferred_velocity = Get-VelocityBucket $_.latest_observed_ts
    freshness_columns = $_.freshness_columns
    usage_events_90d = $usageCount
    last_usage_event_ts = if ($usage) { $usage.last_usage_event_ts } else { $null }
    lineage_usage_available = $lineageAvailable
  }
})

$tableMetrics | Sort-Object table_family, catalog_name, schema_name, table_name |
  Export-Csv -NoTypeInformation -Encoding utf8 -Path (Join-Path $OutputDir "four_vs_table_metrics.csv")

$schemaSummary = @()
foreach ($summaryGroup in ($tableMetrics | Group-Object table_family, catalog_name, schema_name)) {
  $sample = $summaryGroup.Group[0]
  $rowsKnown = @($summaryGroup.Group | Where-Object { $null -ne $_.row_count })
  $rowTotal = ($rowsKnown | Measure-Object -Property row_count -Sum).Sum
  $latestValues = @($summaryGroup.Group | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_.latest_observed_ts) } | ForEach-Object { [datetime]$_.latest_observed_ts })
  $latest = if ($latestValues.Count -gt 0) { ($latestValues | Sort-Object -Descending | Select-Object -First 1).ToString("yyyy-MM-dd HH:mm:ss") } else { $null }
  $usageKnown = @($summaryGroup.Group | Where-Object { $null -ne $_.usage_events_90d })
  $usageTotal = if ($usageKnown.Count -gt 0) { ($usageKnown | Measure-Object -Property usage_events_90d -Sum).Sum } else { $null }
  $usedTables = if ($usageKnown.Count -gt 0) { @($usageKnown | Where-Object { $_.usage_events_90d -gt 0 }).Count } else { $null }
  $domains = @($summaryGroup.Group | Select-Object -ExpandProperty domain -Unique | Sort-Object)

  $schemaSummary += [pscustomobject]@{
    table_family = $sample.table_family
    catalog_name = $sample.catalog_name
    schema_name = $sample.schema_name
    table_count = $summaryGroup.Group.Count
    total_row_count_across_objects = [int64]$rowTotal
    latest_observed_ts = $latest
    inferred_velocity = Get-VelocityBucket $latest
    variety_domain_count = $domains.Count
    variety_domains = ($domains -join "; ")
    usage_events_90d = $usageTotal
    tables_used_90d = $usedTables
    lineage_usage_available = $lineageAvailable
  }
}

$schemaSummary | Sort-Object table_family, catalog_name, schema_name |
  Export-Csv -NoTypeInformation -Encoding utf8 -Path (Join-Path $OutputDir "four_vs_schema_summary.csv")

$sourceSummary = @($schemaSummary | Where-Object { $_.table_family -eq "source" })
$contractSummary = @($schemaSummary | Where-Object { $_.table_family -eq "contract" })

function Format-Int($Value) {
  if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) { return "n/a" }
  return ([int64]$Value).ToString("N0")
}

function Markdown-Table($Rows) {
  $lines = @()
  $lines += "| Family | Schema/catalogue | Tables | Row count across objects | Velocity | Variety | Usage |"
  $lines += "|---|---|---:|---:|---|---|---:|"
  foreach ($row in $Rows) {
    $name = if ($row.table_family -eq "source") { $row.catalog_name } else { "$($row.catalog_name).$($row.schema_name)" }
    $displayName = ('`' + $name + '`')
    $usage = if ($row.lineage_usage_available -and $null -ne $row.usage_events_90d) { Format-Int $row.usage_events_90d } else { "not available" }
    $lines += "| $($row.table_family) | $displayName | $($row.table_count) | $(Format-Int $row.total_row_count_across_objects) | $($row.inferred_velocity) | $($row.variety_domains) | $usage |"
  }
  return $lines
}

$sourceRows = ($sourceSummary | Measure-Object -Property total_row_count_across_objects -Sum).Sum
$contractRows = ($contractSummary | Measure-Object -Property total_row_count_across_objects -Sum).Sum
$sourceTables = ($sourceSummary | Measure-Object -Property table_count -Sum).Sum
$contractTables = ($contractSummary | Measure-Object -Property table_count -Sum).Sum
$sourceUsage = if ($lineageAvailable) { ($sourceSummary | Measure-Object -Property usage_events_90d -Sum).Sum } else { $null }
$contractUsage = if ($lineageAvailable) { ($contractSummary | Measure-Object -Property usage_events_90d -Sum).Sum } else { $null }

$md = @()
$md += "# Transport Four Vs Summary"
$md += ""
$md += "Generated: $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
$md += ""
$md += 'Scope: Asset Vision source catalogues and `transport_dev` contract schemas currently visible in Databricks.'
$md += ""
$md += "Important caveat: row counts are table-object counts. Views and base tables may overlap, so totals are not deduplicated counts of unique assets, jobs, inspections or events."
$md += ""
$md += "## Executive summary"
$md += ""
$md += "| Area | Volume | Velocity | Variety | Veracity / usage |"
$md += "|---|---:|---|---|---:|"
$md += "| Source tables | $(Format-Int $sourceRows) rows across $(Format-Int $sourceTables) table objects | Latest timestamp signal across source tables: $(($sourceSummary | Sort-Object latest_observed_ts -Descending | Select-Object -First 1).inferred_velocity) | Asset, job, inspection, capital work, photos, forms/modules, workflow, resource/timesheet, reference/system | $(if ($lineageAvailable) { Format-Int $sourceUsage } else { 'not available' }) |"
$md += "| Contract tables | $(Format-Int $contractRows) rows across $(Format-Int $contractTables) table objects | Latest timestamp signal across contract tables: $(($contractSummary | Sort-Object latest_observed_ts -Descending | Select-Object -First 1).inferred_velocity) | Traffic counts, job exports, timesheets, capital work, reference/date/EOT, tunnel-specific contract outputs | $(if ($lineageAvailable) { Format-Int $contractUsage } else { 'not available' }) |"
$md += ""
$md += "## Source table summary"
$md += ""
$md += Markdown-Table ($sourceSummary | Sort-Object catalog_name)
$md += ""
$md += "## Contract table summary"
$md += ""
$md += Markdown-Table ($contractSummary | Sort-Object schema_name)
$md += ""
$md += "## Definitions used"
$md += ""
$md += '- Volume: `COUNT(*)` by table, summed to schema/catalogue level.'
$md += "- Velocity: inferred from the latest timestamp/date-like value found in each table. This is latest observed data freshness, not a confirmed pipeline schedule."
$md += "- Variety: classified from table names and column inventory into business/data domains."
$md += '- Veracity / usage: Databricks `system.access.table_lineage` usage events over the last 90 days when accessible.'
$md += ""
$md += "## Output files"
$md += ""
$md += '- `four_vs_schema_summary.csv`: boss-level schema/catalogue summary.'
$md += '- `four_vs_table_metrics.csv`: table-level row count, freshness, variety and usage details.'
$md += '- `table_inventory.csv`: Databricks table inventory used.'
$md += '- `table_columns.csv`: Databricks column inventory used.'

$summaryPath = Join-Path $OutputDir "transport-four-vs-summary.md"
$md | Set-Content -Encoding utf8 -Path $summaryPath

Write-Host "Wrote $summaryPath"
