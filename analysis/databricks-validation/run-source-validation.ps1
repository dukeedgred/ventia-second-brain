param(
  [string[]]$Catalogs = @(
    "ext_mssql_asset_vision_ven_gen7",
    "ext_mssql_asset_vision_ven_rms",
    "ext_mssql_asset_vision_ven_rms_old",
    "ext_mssql_asset_vision_ven_vicroads",
    "ext_mssql_asset_vision_vns_gen7",
    "ext_mssql_asset_vision_vnz_gen7",
    "ext_mssql_asset_vision_vsm_gen7",
    "ext_mssql_assetvisionreporting_av_ven_gen7",
    "ext_mssql_assetvisionreporting_av_ven_vicroads"
  ),
  [string]$OutputDir = ".\out",
  [string]$Profile = "",
  [string]$DatabricksExe = ""
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

$hostName = (Require-Env "DATABRICKS_HOST").TrimEnd("/")
$token = [Environment]::GetEnvironmentVariable("DATABRICKS_TOKEN")
if ([string]::IsNullOrWhiteSpace($token) -and -not [string]::IsNullOrWhiteSpace($Profile)) {
  $dbx = Resolve-DatabricksExe
  $rawToken = & $dbx auth token $Profile -o json
  if ($LASTEXITCODE -ne 0) {
    throw "Could not acquire Databricks OAuth token for profile $Profile"
  }
  $tokenPayload = $rawToken | ConvertFrom-Json
  $token = $tokenPayload.access_token
}
if ([string]::IsNullOrWhiteSpace($token)) {
  throw "Missing authentication. Set DATABRICKS_TOKEN or pass -Profile for Databricks CLI OAuth."
}
$warehouseId = Require-Env "DATABRICKS_WAREHOUSE_ID"
$headers = @{
  "Authorization" = "Bearer $token"
  "Content-Type" = "application/json"
}

New-Item -ItemType Directory -Force $OutputDir | Out-Null

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
  return $payload
}

$keyTables = @(
  "asset",
  "vassetlocation",
  "job",
  "vjob",
  "jobasset",
  "jobcomment",
  "inspection",
  "vinspection",
  "inspectionstatus",
  "photo",
  "formfield",
  "module",
  "workflowstatus",
  "contractreference",
  "capitalwork",
  "capitalworktask",
  "resource",
  "plannedresourceitem",
  "timesheetitem"
)

$validationTerms = "omcs|aid|retina|dash|camera|video|gps|jet|fan|dtims|telemetry|vehicle|alarm|as-built|geojson|handover|ai"
$summary = @()

foreach ($catalog in $Catalogs) {
  $quotedCatalog = "``$catalog``"
  Write-Host "Validating $catalog"

  $queries = [ordered]@{
    "01_tables_$catalog" = @"
SELECT table_catalog, table_schema, table_name, table_type
FROM $quotedCatalog.information_schema.tables
WHERE table_schema = 'dbo'
ORDER BY table_name
"@
    "02_key_columns_$catalog" = @"
SELECT table_catalog, table_schema, table_name, column_name, data_type, ordinal_position
FROM $quotedCatalog.information_schema.columns
WHERE table_schema = 'dbo'
  AND lower(table_name) IN ($(($keyTables | ForEach-Object { "'$($_.ToLower())'" }) -join ", "))
ORDER BY table_name, ordinal_position
"@
    "03_contracts_asset_$catalog" = @"
SELECT '$catalog' AS catalog_name, 'asset' AS table_name, Contract, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.asset
WHERE Deleted = false OR Deleted IS NULL
GROUP BY Contract
ORDER BY row_count DESC
LIMIT 100
"@
    "04_contracts_job_$catalog" = @"
SELECT '$catalog' AS catalog_name, 'job' AS table_name, Contract, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.job
WHERE Deleted = false OR Deleted IS NULL
GROUP BY Contract
ORDER BY row_count DESC
LIMIT 100
"@
    "05_contracts_inspection_$catalog" = @"
SELECT '$catalog' AS catalog_name, 'inspection' AS table_name, Contract, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.inspection
WHERE Deleted = false OR Deleted IS NULL
GROUP BY Contract
ORDER BY row_count DESC
LIMIT 100
"@
    "06_vjob_coverage_$catalog" = @"
SELECT
  '$catalog' AS catalog_name,
  COUNT(*) AS rows_total,
  SUM(CASE WHEN Contract IS NOT NULL AND Contract <> '' THEN 1 ELSE 0 END) AS rows_with_contract,
  SUM(CASE WHEN AssetID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_asset_id,
  SUM(CASE WHEN HazardDefectCode IS NOT NULL AND HazardDefectCode <> '' THEN 1 ELSE 0 END) AS rows_with_hazard_defect_code,
  SUM(CASE WHEN HazardCode IS NOT NULL AND HazardCode <> '' THEN 1 ELSE 0 END) AS rows_with_hazard_code,
  SUM(CASE WHEN DueDate IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_due_date,
  SUM(CASE WHEN CompletedDate IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_completed_date,
  SUM(CASE WHEN Compliant IS NOT NULL AND Compliant <> '' THEN 1 ELSE 0 END) AS rows_with_compliant,
  SUM(CASE WHEN MadeSafe IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_made_safe,
  SUM(CASE WHEN WKT IS NOT NULL AND WKT <> '' THEN 1 ELSE 0 END) AS rows_with_wkt,
  MIN(CreatedDate) AS min_created_date,
  MAX(CreatedDate) AS max_created_date
FROM $quotedCatalog.dbo.vjob
WHERE Deleted = false OR Deleted IS NULL
"@
    "07_inspection_coverage_$catalog" = @"
SELECT
  '$catalog' AS catalog_name,
  COUNT(*) AS rows_total,
  SUM(CASE WHEN Contract IS NOT NULL AND Contract <> '' THEN 1 ELSE 0 END) AS rows_with_contract,
  SUM(CASE WHEN AssetID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_asset_id,
  SUM(CASE WHEN ScheduledDate IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_scheduled_date,
  SUM(CASE WHEN CompletedDate IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_completed_date,
  SUM(CASE WHEN JobID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_job_id,
  SUM(CASE WHEN CapitalWorkID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_capital_work_id,
  SUM(CASE WHEN WKT IS NOT NULL AND WKT <> '' THEN 1 ELSE 0 END) AS rows_with_wkt,
  MIN(CreatedDate) AS min_created_date,
  MAX(CreatedDate) AS max_created_date
FROM $quotedCatalog.dbo.vinspection
WHERE Deleted = false OR Deleted IS NULL
"@
    "08_asset_coverage_$catalog" = @"
SELECT
  '$catalog' AS catalog_name,
  COUNT(*) AS rows_total,
  SUM(CASE WHEN Contract IS NOT NULL AND Contract <> '' THEN 1 ELSE 0 END) AS rows_with_contract,
  SUM(CASE WHEN ParentAssetID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_parent_asset,
  SUM(CASE WHEN AssetCondition IS NOT NULL AND AssetCondition <> '' THEN 1 ELSE 0 END) AS rows_with_condition,
  SUM(CASE WHEN AssetCriticality IS NOT NULL AND AssetCriticality <> '' THEN 1 ELSE 0 END) AS rows_with_criticality,
  SUM(CASE WHEN AssetRisk IS NOT NULL AND AssetRisk <> '' THEN 1 ELSE 0 END) AS rows_with_risk,
  SUM(CASE WHEN ChainageFrom IS NOT NULL OR ChainageTo IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_chainage,
  SUM(CASE WHEN Stage IS NOT NULL AND Stage <> '' THEN 1 ELSE 0 END) AS rows_with_stage
FROM $quotedCatalog.dbo.asset
WHERE Deleted = false OR Deleted IS NULL
"@
    "09_capitalwork_coverage_$catalog" = @"
SELECT
  '$catalog' AS catalog_name,
  COUNT(*) AS rows_total,
  SUM(CASE WHEN Contract IS NOT NULL AND Contract <> '' THEN 1 ELSE 0 END) AS rows_with_contract,
  SUM(CASE WHEN AssetID IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_asset_id,
  SUM(CASE WHEN PlannedStart IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_planned_start,
  SUM(CASE WHEN ActualFinish IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_actual_finish,
  SUM(CASE WHEN ChainageFrom IS NOT NULL OR ChainageTo IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_chainage,
  SUM(CASE WHEN SpatialInfo IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_spatial_info
FROM $quotedCatalog.dbo.capitalwork
WHERE Deleted = false OR Deleted IS NULL
"@
    "10_photo_coverage_$catalog" = @"
SELECT '$catalog' AS catalog_name, SourceTable, Stage, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.photo
WHERE Deleted = false OR Deleted IS NULL
GROUP BY SourceTable, Stage
ORDER BY row_count DESC
LIMIT 100
"@
    "11_module_form_terms_$catalog" = @"
SELECT '$catalog' AS catalog_name, 'module' AS source_table, ModuleName AS matched_value, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.module
WHERE Deleted = false
  AND lower(coalesce(ModuleName, '') || ' ' || coalesce(Name, '') || ' ' || coalesce(Comments, '')) RLIKE '$validationTerms'
GROUP BY ModuleName
UNION ALL
SELECT '$catalog' AS catalog_name, 'formfield' AS source_table, Name AS matched_value, COUNT(*) AS row_count
FROM $quotedCatalog.dbo.formfield
WHERE Deleted = false
  AND lower(coalesce(Name, '') || ' ' || coalesce(Value, '')) RLIKE '$validationTerms'
GROUP BY Name
ORDER BY row_count DESC
LIMIT 200
"@
  }

  foreach ($queryName in $queries.Keys) {
    try {
      $result = Invoke-DatabricksSql -Statement $queries[$queryName] -Name $queryName
      $summary += [ordered]@{
        name = $queryName
        catalog = $catalog
        state = $result.status.state
        error = $null
      }
    } catch {
      $summary += [ordered]@{
        name = $queryName
        catalog = $catalog
        state = "FAILED_LOCALLY"
        error = $_.Exception.Message
      }
    }
  }
}

$summaryFile = Join-Path $OutputDir "00_run_summary.json"
$summary | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 -Path $summaryFile
Write-Host "Validation complete. Output written to $OutputDir"
