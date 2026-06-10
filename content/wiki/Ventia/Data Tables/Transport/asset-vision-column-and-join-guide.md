---
title: Asset Vision Column and Join Guide
date-created: 2026-06-05
source-contexts:
  - asset_vision_vsm_gen7
  - asset_vision_vnz_gen7
source-catalogs:
  - ext_mssql_asset_vision_vsm_gen7
  - ext_mssql_asset_vision_vnz_gen7
source-schema: dbo
status: working-notes
---

# Asset Vision Column and Join Guide

This guide summarizes the Asset Vision source tables already documented in the
workspace for `asset_vision_vsm_gen7` and `asset_vision_vnz_gen7`.

The two contexts currently expose the same practical table set. The `dbo`
component is the SQL Server source schema, not a client or contract name. The
catalog suffixes `vsm_gen7` and `vnz_gen7` should be treated as source contexts
until a Databricks/platform owner confirms the contract or environment meaning.

Use this as a field guide, not as a confirmed data model. The join paths below
are inferred from column names and repeated ID patterns. Validate joins with
row counts, duplicate checks, and business SMEs before production use.

## Executive Summary

For geospatial mapping, prefer the view tables with `WKT`:

- `vjob`
- `vinspection`
- `vassetlocation`
- `vcapitalwork`
- `vcapitalworktask`
- `vmodule`
- `vworkflowstatus`
- `vassetaudit`
- `vinspectionstatus`

The base tables often contain `SpatialInfo` as `binary`, but the notebook and
report use `WKT` because it can be parsed directly into `x` and `y`.

For formal asset criticality and condition, start with:

- `asset.AssetCriticality`
- `asset.AssetCondition`
- `asset.AssetRisk`
- `asset.AssetConditionModel`
- `asset.ConditionDate`

For operational danger or work risk, start with:

- `vjob.Priority`
- `vjob.HazardDefectCode`
- `vjob.HazardCode`
- `vjob.ActivityCategoryName`
- `vjob.ActivityName`
- `vjob.CompletedStatus`
- `vjob.MadeSafe`
- `vjob.Compliant`
- `vjob.CurrentWorkflowItemCode`
- `vjob.CurrentWorkflowItemName`
- `vjob.DueDate`
- `vjob.CompletedDate`
- `vjob.EstimatedLength`, `EstimatedWidth`, `EstimatedDepth`, `EstimatedQuantity`
- `vjob.RemainingQuantity`, `ActualQuantity`, `Unit`

For inspection state, start with:

- `vinspection.CurrentStatus`
- `vinspection.InspectionTypeName`
- `vinspection.Category`
- `vinspection.CompletedDate`
- `vinspection.JobID`
- `vinspection.CapitalWorkID`
- `vinspection.WKT`
- `vinspectionstatus.Status`
- `vinspectionstatus.StatusDateUTC`

## Column Families

### Identity and Join Columns

Common identifiers:

- `ID`
- `AssetID`, `AssetCode`, `AssetName`, `AssetTypeName`
- `JobID`
- `InspectionID`
- `CapitalWorkID`
- `ModuleID`
- `ResourceID`
- `RecordID`
- `SourceTable`, `SourceTableID`
- `ParentAssetID`, `ParentResourceID`, `ParentSourceTableName`, `ParentSourceTableID`
- `MergedJobID`, `LinkedJobID`
- `ChildInspectionID`

Treat `ID` as the likely row identifier for each table, but do not assume it is
declared as a primary key in Databricks foreign-table metadata.

### Geospatial and Linear Reference Columns

Geometry columns:

- `WKT`: string geometry, easiest for mapping.
- `SpatialInfo`: binary geometry, likely source-system geometry that needs
  source-specific decoding before mapping.

Linear-reference and location columns:

- `Direction`
- `ChainageFrom`, `ChainageTo`
- `DistancePast`, `EndDistancePast`, `StartDistancePast`
- `ReferencePointName`, `EndReferencePointName`
- `StartReferencePointName`, `StartPointName`, `EndPointName`
- `ReferencePointTypeName`, `EndReferencePointTypeName`
- `Section`
- `Region`
- `Contract`
- `BothDirections`
- `EntireLength`
- `OffsetSide`, `OffsetMetres`
- `Area`

For map visuals, use `WKT` when available. If `WKT` is missing, the notebook can
fall back to chainage by using average chainage as `x` and section/direction as
an artificial `y`.

### Criticality, Risk, Status, and Safety Columns

Formal asset risk/condition:

- `AssetCriticality`
- `AssetCondition`
- `AssetRisk`
- `AssetConditionModel`
- `ConditionDate`
- `Classification`
- `AlertNotes`

Operational job/work risk:

- `Priority`
- `HazardDefectCode`
- `HazardCode`
- `ActivityCategoryCode`, `ActivityCategoryName`
- `ActivityCode`, `ActivityName`
- `ActivityType`
- `InterventionCode`, `InterventionName`, `FullInterventionCode`
- `CompletedStatus`
- `Compliant`
- `MadeSafe`, `MadeSafeDateUTC`
- `CurrentWorkflowItemCode`, `CurrentWorkflowItemName`
- `CRMID`, `CRMDescription`, `CRMField1` to `CRMField6`
- `Comments`

Inspection/workflow status:

- `CurrentStatus`
- `Status`
- `StatusDateUTC`
- `WorkflowItemCode`, `WorkflowItemName`
- `StatusDate`
- `Comment`
- `Reason`

### Size, Quantity, Cost, and Lifecycle Columns

Problem size or work quantity:

- `EstimatedLength`
- `EstimatedWidth`
- `EstimatedDepth`
- `EstimatedQuantity`
- `ActualQuantity`
- `RemainingQuantity`
- `Quantity`
- `Unit`
- `Area`

Cost and duration:

- `EstimatedCost`
- `ActualCost`
- `ConstructionCost`
- `DisposalCost`
- `Cost`
- `EstimatedDuration`
- `UsefulLife`

Lifecycle dates:

- `ConstructionDate`
- `DisposalDate`
- `CreatedDate`
- `DueDate`
- `ScheduledDate`
- `ScheduledDateFrom`, `ScheduledDateTo`
- `ScheduledStart`, `ScheduledEnd`
- `PlannedStart`, `PlannedFinish`
- `ActualStart`, `ActualFinish`
- `CompletedDate`
- `ApprovalDate`
- `AssignedDate`
- `ComplianceCalculationDate`

### Audit, Export, and Deletion Columns

Common audit and sync columns:

- `DeltaUTC`
- `ModifiedUTC`
- `Modified`
- `ModifiedUser`
- `CreatedUser`
- `AssignedUser`
- `CompletedUser`
- `ApprovedUser`
- `ExportDateUTC`
- `LastExported`
- `Deleted`

Use `Deleted = false` or `coalesce(Deleted, false) = false` where the column
exists. Foreign tables may still expose soft-deleted source rows.

## Potential Join Model

### Core Asset Spine

Use `asset` as the asset spine:

```sql
asset.ID = <table>.AssetID
```

High-value child tables:

- `assetlocation` / `vassetlocation`: geometry and chainage per asset.
- `assetarea`: area membership or area segmentation per asset.
- `assetclassification`: classification segments per asset.
- `assetattribute`: name/value attributes per asset.
- `assetaudit` / `vassetaudit`: asset change history.
- `job` / `vjob`: jobs linked to assets.
- `inspection` / `vinspection`: inspections linked to assets.
- `capitalwork` / `vcapitalwork`: capital works linked to assets.
- `module` / `vmodule`: module records linked to assets.

### Jobs

Likely joins:

```sql
job.AssetID = asset.ID
vjob.AssetID = asset.ID
jobasset.JobID = job.ID
jobasset.AssetID = asset.ID
jobcomment.JobID = job.ID
inspection.JobID = job.ID
capitalworktask.JobID = job.ID
vjob.InspectionID = inspection.ID
```

`jobasset` appears to be a bridge between jobs and assets. Use it when one job
can relate to multiple assets or when `job.AssetID` is not enough.

### Inspections

Likely joins:

```sql
inspection.AssetID = asset.ID
vinspection.AssetID = asset.ID
inspection.JobID = job.ID
inspection.CapitalWorkID = capitalwork.ID
inspectionstatus.InspectionID = inspection.ID
vinspectionstatus.InspectionID = inspection.ID
inspectionrelationship.InspectionID = inspection.ID
inspectionrelationship.ChildInspectionID = inspection.ID
```

The table has both `ID` and `InspectionID` in some contexts/views. Validate
which field is the source-system inspection identifier before building stable
models.

### Capital Works

Likely joins:

```sql
capitalwork.AssetID = asset.ID
capitalworktask.CapitalWorkID = capitalwork.ID
capitalworktask.AssetID = asset.ID
capitalworktask.JobID = job.ID
```

Use `vcapitalwork` and `vcapitalworktask` when you need `WKT`.

### Workflow, Forms, Photos, Modules, and Other Attachments

Several tables use polymorphic linking:

```sql
<attachment>.SourceTable = '<source table name>'
<attachment>.SourceTableID = <source table>.ID
```

Tables using this pattern:

- `workflowstatus`, `vworkflowstatus`
- `formfield`
- `photo`
- `custommoduleitem`
- `plannedresourceitem`
- `timesheetitem`

Module parent references use a similar pattern:

```sql
module.ParentSourceTableName = '<source table name>'
module.ParentSourceTableID = <source table>.ID
```

### Resources and Timesheets

Likely joins:

```sql
resourceattribute.ResourceID = resource.ID
resourceaudit.ResourceID = resource.ID
plannedresourceitem.SourceTableID = <source table>.ID
timesheetitem.SourceTableID = <source table>.ID
```

`plannedresourceitem` and `timesheetitem` also carry resource-like fields such
as `ResourceCode`, `ResourceName`, `ResourceType`, `Hours`, `Minutes`,
`Quantity`, `Multiplier`, and `Cost`.

## Recommended Analysis Starting Points

### Danger Map

Use `vjob`.

Reasons:

- Has `WKT`.
- Has hazard fields.
- Has priority/status/safety fields.
- Has size and quantity fields.
- Has due/completion dates.
- Has `AssetID` for joining to formal asset criticality in `asset`.

Useful columns:

- Geometry: `WKT`, `SpatialInfo`, `ChainageFrom`, `ChainageTo`, `Direction`
- Risk: `Priority`, `HazardDefectCode`, `HazardCode`, `MadeSafe`,
  `CompletedStatus`, `Compliant`
- Size: `EstimatedLength`, `EstimatedWidth`, `EstimatedDepth`,
  `EstimatedQuantity`, `RemainingQuantity`, `ActualQuantity`, `Unit`
- Dates: `CreatedDate`, `DueDate`, `CompletedDate`, `MadeSafeDateUTC`
- Joins: `ID`, `AssetID`, `InspectionID`, `MergedJobID`, `LinkedJobID`

### Asset Criticality Overlay

Join `vjob` or `vassetlocation` to `asset`.

```sql
SELECT
  j.ID AS JobID,
  j.AssetID,
  j.AssetCode,
  j.HazardDefectCode,
  j.Priority,
  j.MadeSafe,
  j.DueDate,
  j.CompletedDate,
  j.EstimatedLength,
  j.EstimatedWidth,
  j.EstimatedDepth,
  j.WKT,
  a.AssetCriticality,
  a.AssetCondition,
  a.AssetRisk,
  a.AssetConditionModel,
  a.ConditionDate,
  a.Classification AS AssetClassification
FROM ext_mssql_asset_vision_vsm_gen7.dbo.vjob j
LEFT JOIN ext_mssql_asset_vision_vsm_gen7.dbo.asset a
  ON j.AssetID = a.ID
WHERE coalesce(j.Deleted, false) = false;
```

### Asset Geometry and Condition

Use `vassetlocation` for geometry and `asset` for condition/risk.

```sql
SELECT
  a.ID AS AssetID,
  a.Code,
  a.Name,
  a.AssetType,
  a.AssetCriticality,
  a.AssetCondition,
  a.AssetRisk,
  a.ConditionDate,
  l.Direction,
  l.ChainageFrom,
  l.ChainageTo,
  l.WKT
FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset a
LEFT JOIN ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation l
  ON l.AssetID = a.ID
WHERE coalesce(a.Deleted, false) = false;
```

### Inspection Status Map

Use `vinspection` plus `vinspectionstatus`.

```sql
SELECT
  i.ID AS InspectionRowID,
  i.AssetID,
  i.AssetCode,
  i.InspectionTypeName,
  i.CurrentStatus,
  i.ScheduledDate,
  i.CompletedDate,
  s.Status,
  s.StatusDateUTC,
  i.WKT
FROM ext_mssql_asset_vision_vsm_gen7.dbo.vinspection i
LEFT JOIN ext_mssql_asset_vision_vsm_gen7.dbo.vinspectionstatus s
  ON s.InspectionID = i.ID
WHERE coalesce(i.Deleted, false) = false;
```

Validate whether `s.InspectionID = i.ID` or `s.InspectionID = i.InspectionID`
is correct for the source. Both fields appear in the inspection view.

## Per-Table Guide

This table is based on the `asset_vision_vsm_gen7` table pages. Use the same
reading for `asset_vision_vnz_gen7` unless a table page says otherwise.

| Table | Likely grain | Primary join candidates | Geospatial/location columns | Criticality/risk/status columns |
|---|---|---|---|---|
| `asset` | One asset/master asset record | `ID`, `ParentAssetID`, `Code` | `SpatialType`, `Direction`, `ChainageFrom`, `ChainageTo`, `OffsetSide`, `OffsetMetres`, `Contract` | `AssetCriticality`, `AssetCondition`, `AssetRisk`, `AssetConditionModel`, `ConditionDate`, `Classification`, `AlertNotes` |
| `assetarea` | Asset-area assignment or segment | `ID`, `AssetAreaID`, `AssetID` | `Area`, `Direction`, `ChainageFrom`, `ChainageTo` | None supplied |
| `assetattribute` | Asset name/value attribute | `ID`, `AssetID` | None supplied | `Name`, `Value`, `DataType` may hold custom criticality-like attributes |
| `assetaudit` | Asset audit/change record | `ID`, `AssetID`, `RecordID` | `SpatialInfo` | `DisplayName`, `OriginalValue`, `NewValue` can record changed risk/condition values |
| `assetclassification` | Asset classification segment | `ID`, `AssetClassificationID`, `AssetID` | `Direction`, `ChainageFrom`, `ChainageTo`, `Contract` | `Classification` |
| `assetlocation` | Asset location record | `ID`, `AssetID` | `SpatialInfo`, `Direction`, `ChainageFrom`, `ChainageTo` | None supplied |
| `capitalwork` | Capital work record | `ID`, `AssetID`, `AssetCode`, `AssetName` | `Section`, `Direction`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `Contract`, `Area`, `SpatialInfo` | None supplied |
| `capitalworktask` | Task under capital work | `ID`, `CapitalWorkID`, `AssetID`, `JobID` | `Section`, `Direction`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `SpatialInfo` | `Comments` |
| `contractreference` | Contract reference/config record | `ID`, `InterventionID`, `InspectionTypeID`, `AssetID` | `Contract` | `InspectionTypeID`, `Reference1`, `Reference2` |
| `custommoduleitem` | Module item pointing to another source record | `ID`, `ModuleID`, `SourceTable`, `SourceTableID` | None supplied | None supplied |
| `exportdate` | Export tracking header | `ID` | None supplied | None supplied |
| `exportdatelog` | Export tracking event | `ID`, `ExportDateID` | None supplied | None supplied |
| `formfield` | Dynamic form field/value | `ID`, `RecordID`, `SourceTable`, `SourceTableID`, `UniqueID` | None supplied | `Name`, `Value`, `DataType` may hold custom status/risk answers |
| `inspection` | Inspection record | `ID`, `AssetID`, `JobID`, `CapitalWorkID`, `InspectionID`, `ModuleID` | `Section`, `Contract`, `Region`, `StartReferencePointName`, `ChainageFrom`, `StartDistancePast`, `EndReferencePointName`, `ChainageTo`, `EndDistancePast`, `Direction`, `BothDirections`, `EntireLength`, `SpatialInfo` | `Classification`, `InspectionTypeName`, `Category`, `CurrentStatus`, `Comments` |
| `inspectionrelationship` | Parent/child inspection link | `Id`, `InspectionID`, `ChildInspectionID` | None supplied | `InspectionType`, `ChildInspectionType` |
| `inspectionstatus` | Inspection status event | `ID`, `InspectionID` | `SpatialInfo` | `Status`, `StatusDateUTC` |
| `job` | Work/job record | `ID`, `AssetID`, `InspectionID`, `MergedJobID`, `LinkedJobID`, `ExternalID`, `CRMID` | `Section`, `Contract`, `Region`, `Direction`, `ReferencePointName`, `EndReferencePointName`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `DistancePast`, `EndDistancePast`, `Area`, `SpatialInfo` | `HazardDefectCode`, `HazardCode`, `ActivityCategoryName`, `ActivityName`, `Priority`, `ActivityType`, `CompletedStatus`, `Compliant`, `Classification`, `MadeSafe`, `MadeSafeDateUTC`, `CRMDescription` |
| `jobasset` | Bridge between job and asset | `ID`, `JobID`, `AssetID` | `Direction`, `ChainageFrom`, `ChainageTo` | None supplied |
| `jobcomment` | Comment attached to job | `ID`, `JobID` | None supplied | `Comment` |
| `log` | Generic log row | `ID` | None supplied | None supplied |
| `module` | Module/workflow-like record | `ID`, `AssetID`, `ParentSourceTableName`, `ParentSourceTableID` | `Contract`, `Region`, `EntireLength`, `Direction`, `StartPointName`, `ChainageFrom`, `StartDistancePast`, `EndPointName`, `ChainageTo`, `EndDistancePast`, `SpatialInfo` | `Comments` |
| `photo` | Photo attachment | `ID`, `SourceTable`, `SourceTableID` | None supplied | `Stage` may indicate workflow context |
| `plannedresourceitem` | Planned labour/resource/cost item | `ID`, `PlannedResourceID`, `SourceTable`, `SourceTableID` | None supplied | None supplied |
| `resource` | Resource master record | `ID`, `ParentResourceID`, `ParentResourceCode` | `Contract` | `AlertNotes` |
| `resourceattribute` | Resource name/value attribute | `ID`, `ResourceID` | None supplied | `Name`, `Value`, `DataType` may hold custom resource risk attributes |
| `resourceaudit` | Resource audit/change record | `ID`, `ResourceID` | None supplied | `DisplayName`, `OriginalValue`, `NewValue` can record changed values |
| `summarycheck` | Count/reconciliation check | `ID` | `Contract` | None supplied |
| `timesheetitem` | Timesheet line/resource cost item | `ID`, `TimesheetID`, `SourceTable`, `SourceTableID` | None supplied | None supplied |
| `vassetaudit` | Asset audit view with geometry | `ID`, `AssetID`, `RecordID` | `SpatialInfo`, `WKT` | `DisplayName`, `OriginalValue`, `NewValue` can record changed risk/condition values |
| `vassetlocation` | Asset location view with geometry | `ID`, `AssetID` | `SpatialInfo`, `Direction`, `ChainageFrom`, `ChainageTo`, `WKT` | None supplied |
| `vcapitalwork` | Capital work view with geometry | `ID`, `AssetID`, `AssetCode`, `AssetName` | `Section`, `Direction`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `Contract`, `Area`, `SpatialInfo`, `WKT` | None supplied |
| `vcapitalworktask` | Capital work task view with geometry | `ID`, `CapitalWorkID`, `AssetID`, `JobID` | `Section`, `Direction`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `SpatialInfo`, `WKT` | `Comments` |
| `vinspection` | Inspection view with geometry | `ID`, `AssetID`, `JobID`, `CapitalWorkID`, `InspectionID`, `ModuleID` | `Section`, `Contract`, `Region`, `StartReferencePointName`, `ChainageFrom`, `StartDistancePast`, `EndReferencePointName`, `ChainageTo`, `EndDistancePast`, `Direction`, `BothDirections`, `EntireLength`, `SpatialInfo`, `WKT` | `Classification`, `InspectionTypeName`, `Category`, `CurrentStatus`, `Comments` |
| `vinspectionstatus` | Inspection status view with geometry | `ID`, `InspectionID` | `SpatialInfo`, `WKT` | `Status`, `StatusDateUTC` |
| `vjob` | Job/work view with geometry | `ID`, `AssetID`, `InspectionID`, `MergedJobID`, `LinkedJobID`, `ExternalID`, `CRMID` | `Section`, `Contract`, `Region`, `Direction`, `ReferencePointName`, `EndReferencePointName`, `ChainageFrom`, `ChainageTo`, `BothDirections`, `DistancePast`, `EndDistancePast`, `Area`, `SpatialInfo`, `WKT` | `HazardDefectCode`, `HazardCode`, `ActivityCategoryName`, `ActivityName`, `Priority`, `ActivityType`, `CompletedStatus`, `Compliant`, `Classification`, `MadeSafe`, `MadeSafeDateUTC`, `CRMDescription`, `CurrentWorkflowItemCode`, `CurrentWorkflowItemName` |
| `vmodule` | Module view with geometry | `ID`, `AssetID`, `ParentSourceTableName`, `ParentSourceTableID` | `Contract`, `Region`, `EntireLength`, `Direction`, `StartPointName`, `ChainageFrom`, `StartDistancePast`, `EndPointName`, `ChainageTo`, `EndDistancePast`, `SpatialInfo`, `WKT` | `Comments` |
| `vworkflowstatus` | Workflow status view with geometry | `ID`, `RecordID`, `SourceTable`, `SourceTableID` | `SpatialInfo`, `WKT` | `WorkflowItemCode`, `WorkflowItemName`, `StatusDate`, `Comment`, `Reason` |
| `workflowstatus` | Workflow status event | `ID`, `RecordID`, `SourceTable`, `SourceTableID` | `SpatialInfo` | `WorkflowItemCode`, `WorkflowItemName`, `StatusDate`, `Comment`, `Reason` |

## Live Column Examples From Databricks

Examples below were fetched live from Databricks SQL using OAuth. They are
non-null examples from up to `300` active sampled rows per table,
with a fallback query for columns that were null in the sample. Values are
truncated for readability, and binary geometry is shown as byte length.

Use these examples to understand what the columns actually contain; do not
treat the examples as complete enumerations of all possible values.

### `asset`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 63813; 63814; 63815 | 328712; 329049; 329050 |
| `DeltaUTC` | timestamp | 2025-03-31 04:23:34.813000; 2024-03-28 03:54:30.010000; 2024-03-28 03:54:30.013000 | 2024-03-28 03:43:33.350000; 2024-03-28 03:44:09.170000; 2024-03-28 03:44:30.090000 |
| `ModifiedUTC` | timestamp | 2025-03-31 03:52:42.140000; 2022-02-10 21:39:32.780000; 2025-03-31 03:52:42.143000 | 2022-12-02 02:39:08.127000; 2023-02-03 03:42:07.763000; 2022-12-02 02:39:09.090000 |
| `ExportDateUTC` | timestamp | 2025-03-31 04:23:26.827000; 2024-03-28 03:52:56.523000; 2025-03-31 03:53:27.900000 | 2024-03-28 03:42:56.747000 |
| `ModifiedUser` | string | VSM - Pranav Kumar; Main Roads Western Australia; VSM - David Michel | Auckland Transport; VNZ - VNZ Support |
| `Code` | string | WNS00001; WNS00002; WNS00003 | 30074; 10245; 10435 |
| `Name` | string | Broome Road Status Sign, Great Northern Hwy / Broome Rd, Roebuck; Derby Hwy, Great Northern Hwy 0.1km after Derby Hwy (North Bound); Great Northern Hwy, Fitzroy Crossing West, 0.1km before Forrest Rd (North Bound) (Opposite Ngiyali Rd House) | ASH ST; ARROWSMITH RD; RED HILLS RD 2 (TAUPAKI) |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `AssetType` | string | Warning Systems; Vehicle Detection Station | Roads |
| `SpatialType` | string | Point | Polyline |
| `ParentAssetID` | int | No non-null example found | 329049 |
| `ParentAssetCode` | string | No non-null example found | 10245 |
| `ParentAssetName` | string | No non-null example found | ARROWSMITH RD |
| `ParentAssetTypeName` | string | No non-null example found | Roads |
| `Direction` | string | No non-null example found | Forward |
| `ChainageFrom` | int | No non-null example found | 620 |
| `ChainageTo` | int | No non-null example found | 3084 |
| `ParentAssetPosition` | string | Snap to Parent | Free Location |
| `Stage` | string | Disposed; Active; Planned | Active |
| `ConstructionDate` | timestamp | No non-null example found | 2018-01-01 00:00:00 |
| `ConstructionCost` | decimal(12,2) | No non-null example found | No non-null example found |
| `DisposalDate` | timestamp | 2025-03-31 03:52:40.493000; 2025-03-31 03:52:40.723000; 2025-03-31 03:52:40.777000 | No non-null example found |
| `DisposalCost` | decimal(12,2) | 0.00 | No non-null example found |
| `UsefulLife` | decimal(6,2) | No non-null example found | No non-null example found |
| `AssetCriticality` | string | No non-null example found | No non-null example found |
| `AssetCondition` | string | No non-null example found | 1 - Very Good |
| `AssetRisk` | string | No non-null example found | No non-null example found |
| `AssetConditionModel` | string | No non-null example found | No non-null example found |
| `ConditionDate` | timestamp | No non-null example found | 2018-01-01 00:00:00 |
| `Classification` | string | ITS | RMC 1 - Urban; RMC 5 - Rural; RMC 1 - Rural |
| `Notes` | string | No non-null example found | No non-null example found |
| `AlertNotes` | string | No non-null example found | No non-null example found |
| `OffsetSide` | string | No non-null example found | No non-null example found |
| `OffsetMetres` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | False |

### `assetarea`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | No non-null example found |
| `AssetAreaID` | int | No non-null example found | No non-null example found |
| `DeltaUTC` | timestamp | No non-null example found | No non-null example found |
| `ModifiedUTC` | timestamp | No non-null example found | No non-null example found |
| `ModifiedUser` | string | No non-null example found | No non-null example found |
| `AssetID` | int | No non-null example found | No non-null example found |
| `Area` | string | No non-null example found | No non-null example found |
| `Direction` | string | No non-null example found | No non-null example found |
| `ChainageFrom` | int | No non-null example found | No non-null example found |
| `ChainageTo` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | No non-null example found |

### `assetattribute`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `AssetID` | int | 64142; 66161; 63923 | 328731; 328733; 425348 |
| `DeltaUTC` | timestamp | 2025-03-31 03:54:46.660000; 2022-06-17 04:04:54.117000; 2025-03-31 04:23:34.840000 | 2022-10-06 01:32:01.670000; 2022-10-06 01:32:02.150000; 2022-10-30 10:12:16.800000 |
| `ModifiedUTC` | timestamp | 2025-03-31 03:47:44.623000; 2022-02-10 21:39:32.780000; 2025-03-31 03:52:42.147000 | 2022-09-14 22:46:51.997000; 2022-09-14 22:46:52; 2022-10-30 09:28:16.210000 |
| `ModifiedUser` | string | VSM - Pranav Kumar; Main Roads Western Australia; VSM - Clayton Henderson | Auckland Transport; VNZ - VNZ Support |
| `Name` | string | Associated Site (Bluetooth Beacon); Suburb; Zone | Contract Asset Mapping; location; id |
| `Value` | string | EAST CANNINGTON - 6107; Metro (North); BELLEVUE - 6056 | 157; 7c9bbf34-72f2-454f-8f8a-c1203f8d64f4; Concrete |
| `DataType` | string | Text; Single-Select Dropdown | Single-Select Dropdown; Text; Number |
| `Deleted` | boolean | False | False |

### `assetaudit`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `AssetID` | int | 63813; 63814; 63815 | 328712; 328721; 328722 |
| `Modified` | timestamp | 2022-02-11 08:39:32.780000; 2022-01-31 15:58:15; 2022-01-31 15:58:15.043000 | 2022-12-02 13:39:08.127000; 2022-12-02 13:39:07.883000; 2022-12-02 13:28:26.247000 |
| `DeltaUTC` | timestamp | 2024-03-28 03:54:30.373000; 2024-03-28 03:54:31.650000; 2024-03-28 03:54:31.653000 | 2024-03-28 03:43:33.433000; 2024-03-28 03:43:35.390000; 2024-03-28 03:43:35.393000 |
| `DisplayName` | string | Classification; Location Added; Record Created | Classification; RMC_Urban Rural; Contract Asset Mapping |
| `OriginalValue` | string | No non-null example found | RMC 1 - Urban; 330; 896 |
| `NewValue` | string | ITS; Created on 31/01/2022 15:58 | RMC 1 - Urban; Road; Created on 13/09/2022 13:39 |
| `ModifiedUser` | string | Main Roads Western Australia | Auckland Transport; VNZ - VNZ Support |
| `Source` | varchar(255) | Web | Web |
| `RecordID` | int | 79243; 79244; 79245 | 145532; 145533; 145534 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 288 bytes>; <binary 240 bytes>; <binary 38 bytes> |

### `assetclassification`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 1; 2; 3 |
| `AssetClassificationID` | int | No non-null example found | 8503; 2221; 11644 |
| `DeltaUTC` | timestamp | No non-null example found | 2022-10-06 04:09:05.373000; 2022-10-06 04:09:05.387000; 2022-10-06 04:09:05.390000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2022-09-28 03:24:37.030000; 2022-09-13 03:39:11.797000; 2022-09-28 03:30:09.870000 |
| `ModifiedUser` | string | No non-null example found | Auckland Transport |
| `AssetID` | int | No non-null example found | 353279; 328712; 356420 |
| `Classification` | string | No non-null example found | RMC 6 - Urban; RMC 1 - Urban; RMC 5 - Urban |
| `Direction` | string | No non-null example found | Forward |
| `ChainageFrom` | int | No non-null example found | 0; 235; 486 |
| `ChainageTo` | int | No non-null example found | 101; 1436; 96 |
| `Contract` | string | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | False |

### `assetlocation`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 63687; 63688; 63689 | 102313; 102314; 102315 |
| `DeltaUTC` | timestamp | 2025-03-31 04:23:35.300000; 2022-06-17 04:05:21.983000; 2022-06-17 04:05:21.987000 | 2022-12-02 02:43:02.157000; 2022-12-02 02:43:02.160000; 2022-12-02 02:43:02.163000 |
| `ModifiedUTC` | timestamp | 2025-03-31 03:52:42.203000; 2022-01-31 04:58:15.193000; 2022-01-31 04:58:15.243000 | 2022-12-02 02:39:07.943000; 2022-12-02 02:39:07.953000; 2022-12-02 02:39:07.963000 |
| `ModifiedUser` | string | VSM - Pranav Kumar; Main Roads Western Australia; VSM - David Michel | Auckland Transport; VNZ - VNZ Support |
| `AssetID` | int | 63813; 63814; 63815 | 328712; 328721; 328722 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 288 bytes>; <binary 240 bytes>; <binary 38 bytes> |
| `Direction` | string | No non-null example found | Forward |
| `ChainageFrom` | int | No non-null example found | 0; 1050; 1405 |
| `ChainageTo` | int | No non-null example found | 330; 1405; 1436 |
| `Deleted` | boolean | False | False |

### `capitalwork`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 805; 806 | 289; 350; 358 |
| `DeltaUTC` | timestamp | 2025-08-25 02:29:51.947000; 2025-08-19 03:38:40.050000 | 2023-04-04 03:33:35.900000; 2023-04-04 02:03:32.970000; 2023-06-13 21:21:53.283000 |
| `ModifiedUTC` | timestamp | 2025-08-25 02:01:10.163000; 2025-08-19 03:32:09.107000 | 2023-04-04 03:18:13.433000; 2023-04-04 01:37:43.710000; 2023-06-13 20:58:37.887000 |
| `ModifiedUser` | string | VSM - John Hough | VNZ - Nick Wulf; VNZ - Garth Birkett; VNZ - Mike Newman |
| `Name` | string | ECW23049 | Taupo Street Renewal; Bancroft Cres Renewal; Pooks road |
| `Description` | string | Cable Theft Project | Renewal; Footpath Kerb and Channel Renewal; Footpath, Kerb and Channel Renewal |
| `CapitalWorkType` | string | Electrical Capital Works | Concrete Works; Pavement Works |
| `AssetTypeName` | string | Road Lighting | Roads |
| `AssetID` | int | 66132; 66140 | 329599; 330285; 329761 |
| `AssetCode` | string | SWB01216; SWB01225 | 40339; 41091; 40519 |
| `AssetName` | string | Forrest Hwy and Kwinana Fwy and Pinjarra Rd; Lakes Rd Interchange and Forrest Hwy | TAUPO ST; BANCROFT CRES; POOKS RD |
| `Section` | string | No non-null example found | No non-null example found |
| `Direction` | string | No non-null example found | Forward; Reverse |
| `ChainageFrom` | int | No non-null example found | 0; 14 |
| `ChainageTo` | int | No non-null example found | 640; 90; 1864 |
| `BothDirections` | string | No non-null example found | No non-null example found |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `CreatedUser` | string | VSM - John Hough | VNZ - Irfan Kareekunnan; VNZ - Glen Bramhall; VNZ - Garth Birkett |
| `Area` | decimal(18,2) | No non-null example found | 550.00; 2100.00; 1800.00 |
| `PlannedStart` | timestamp | 2025-08-19 00:00:00 | 2022-11-23 00:00:00; 2023-03-24 00:00:00; 2023-04-05 00:00:00 |
| `PlannedFinish` | timestamp | 2025-09-05 00:00:00 | 2023-04-04 23:59:59; 2023-03-24 23:59:59; 2023-04-21 23:59:59 |
| `ActualStart` | timestamp | 2025-08-19 00:00:00 | 2022-11-24 07:22:49.867000; 2023-03-24 00:00:00; 2023-04-05 22:15:28.617000 |
| `ActualFinish` | timestamp | No non-null example found | 2023-04-04 15:17:58.417000; 2023-04-04 13:37:43.257000; 2023-06-14 08:58:37.537000 |
| `Reference1` | string | SWB01216; SWB01225 | 720-00502-03-04-11 |
| `Reference2` | string | WO#52; WO#51 | 220300062; 221330732; 220333470 |
| `Supervisor` | string | VSM - John Hough | VNZ - Garth Birkett; VNZ - Sione Alofaki; VNZ - Nick Wulf |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 713 bytes>; <binary 105 bytes>; <binary 208 bytes> |
| `Deleted` | boolean | False | False |

### `capitalworktask`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 670; 682; 689 |
| `DeltaUTC` | timestamp | No non-null example found | 2022-12-08 18:25:10.190000; 2022-12-08 18:25:10.200000; 2022-12-11 19:26:50.627000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2022-12-08 18:23:08.320000; 2022-12-08 18:23:08.337000; 2022-12-11 19:05:37.797000 |
| `ModifiedUser` | string | No non-null example found | VNZ - Garth Birkett; VNZ - Nick Wulf; VNZ - Sione Alofaki |
| `CapitalWorkID` | int | No non-null example found | 289; 350; 358 |
| `SortOrder` | int | No non-null example found | 1; 3; 4 |
| `Name` | string | No non-null example found | Digging Out Existing Footpath; Prep channel for A/C; Sione - 29/11 |
| `Description` | string | No non-null example found | Pour Concrete; Pour concrete; Pointing and cutting A/C to be done |
| `PlannedStart` | timestamp | No non-null example found | 2022-11-23 00:00:00; 2022-11-24 00:00:00; 2022-11-29 15:48:32.990000 |
| `PlannedFinish` | timestamp | No non-null example found | 2022-11-24 23:59:59; 2022-11-29 23:59:59.990000; 2022-11-30 23:59:59 |
| `ActualStart` | timestamp | No non-null example found | 2022-11-24 07:22:49.867000; 2022-11-28 15:33:39.930000; 2022-12-09 07:13:13.730000 |
| `ActualFinish` | timestamp | No non-null example found | 2022-11-24 23:59:59.140000; 2022-11-28 23:59:59.990000; 2022-12-12 23:59:59.597000 |
| `EstimatedQuantity` | decimal(10,3) | No non-null example found | 67.000; 200.000; 50.000 |
| `ActualQuantity` | decimal(10,3) | No non-null example found | No non-null example found |
| `Unit` | string | No non-null example found | m; m2; m3 |
| `EstimatedCost` | decimal(18,2) | No non-null example found | No non-null example found |
| `ActualCost` | decimal(18,2) | No non-null example found | No non-null example found |
| `Reference1` | string | No non-null example found | No non-null example found |
| `Reference2` | string | No non-null example found | 220300062; 221330732; 220333470 |
| `Comments` | string | No non-null example found | Completed works on 24/11/22; Storm event happened so no extra work has been started. Will push dates out to start next week on the 7th of Feb; Storm event has delayed works by a week. |
| `AssetTypeName` | string | No non-null example found | No non-null example found |
| `AssetID` | int | No non-null example found | No non-null example found |
| `AssetCode` | string | No non-null example found | No non-null example found |
| `AssetName` | string | No non-null example found | No non-null example found |
| `Section` | string | No non-null example found | No non-null example found |
| `Direction` | string | No non-null example found | No non-null example found |
| `ChainageFrom` | int | No non-null example found | No non-null example found |
| `ChainageTo` | int | No non-null example found | No non-null example found |
| `BothDirections` | string | No non-null example found | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | No non-null example found |
| `JobID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | False |

### `contractreference`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 17139; 17140; 17141 | 101425; 101426; 101427 |
| `DeltaUTC` | timestamp | 2022-06-17 04:05:32.223000; 2022-06-17 04:05:32.227000; 2022-06-17 04:05:32.230000 | 2022-11-25 04:01:11.853000; 2022-11-25 04:01:08.283000; 2022-11-25 04:01:08.750000 |
| `ModifiedUTC` | timestamp | 2022-04-14 06:55:44.460000; 2022-04-14 06:55:44.260000; 2022-04-14 06:55:43.910000 | 2022-11-25 03:39:57.103000; 2022-11-25 03:39:54.500000; 2022-11-25 03:39:54.530000 |
| `ModifiedUser` | string | VSM - VSM Support | VNZ - VNZ Support |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `InterventionID` | int | 7150; 7179; 7236 | 27063; 26188; 28811 |
| `InspectionTypeID` | int | 132 | 451 |
| `Reference1` | string | 700-03689-03-01-03-01-02; 700-03689-03-01-03-08-02; 700-03689-03-01-03-06-02 | 720-00502-03-06-02; 720-00502-03-04-03; 720-00502-03-05-01 |
| `Reference2` | string | No non-null example found | No non-null example found |
| `EstimatedDuration` | decimal(10,2) | No non-null example found | No non-null example found |
| `AssetID` | int | No non-null example found | No non-null example found |
| `EstimatedCost` | decimal(10,2) | No non-null example found | No non-null example found |
| `AssetAttributeName` | string | No non-null example found | No non-null example found |
| `AssetAttributeValue` | string | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | False |

### `custommoduleitem`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 101; 103; 261 |
| `DeltaUTC` | timestamp | No non-null example found | 2024-03-19 03:02:44.870000; 2024-03-19 03:02:46.120000; 2024-03-19 03:02:44.867000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2023-03-13 19:11:04.090000; 2023-04-03 20:26:25.423000; 2023-02-08 22:52:50.607000 |
| `ModifiedUser` | string | No non-null example found | VNZ - Alireza Sharif; VNZ - Garth Birkett; VNZ - Glen Bramhall |
| `ModuleID` | int | No non-null example found | 60848; 64627; 64632 |
| `SourceTable` | string | No non-null example found | Job; CapitalWork |
| `SourceTableID` | int | No non-null example found | 55895; 289; 55864 |
| `SortOrder` | int | No non-null example found | 1; 2; 3 |
| `Deleted` | boolean | No non-null example found | False |

### `exportdate`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `DeltaUTC` | timestamp | 2026-06-08 23:33:22.167000; 2026-06-08 23:33:25.600000; 2026-06-08 23:33:25.813000 | 2026-06-08 23:08:19.600000; 2026-06-08 23:08:20.377000; 2026-06-08 23:08:20.383000 |
| `Name` | string | Job; Inspection; Module | Job; Inspection; InspectionStatus |
| `LastExported` | timestamp | 2026-06-08 23:33:22.143000; 2026-06-08 23:33:22.207000; 2026-06-08 23:33:25.660000 | 2026-06-08 23:08:19.617000; 2026-06-08 23:08:19.647000; 2026-06-08 23:08:20.437000 |

### `exportdatelog`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `ExportDateID` | int | 1; 2; 3 | 1; 2; 3 |
| `DeltaUTC` | timestamp | 2022-06-20 06:28:58.903000; 2022-06-20 06:28:58.920000; 2022-06-20 06:28:58.937000 | 2022-10-06 01:28:14.880000; 2022-10-06 01:28:18.393000; 2022-10-06 01:28:18.703000 |
| `Name` | string | Job; Inspection; Module | Job; Inspection; InspectionStatus |
| `LastExported` | timestamp | 2022-06-20 06:28:58.913000; 2022-06-20 06:28:58.930000; 2022-06-20 06:28:58.943000 | 2022-10-06 01:28:03.797000; 2022-10-06 01:28:17.040000; 2022-10-06 01:28:19.413000 |

### `formfield`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `RecordID` | int | 382947; 304518; 383016 | 371756; 371747; 359108 |
| `DeltaUTC` | timestamp | 2022-07-20 08:04:02.977000; 2022-07-20 08:03:48.997000; 2022-07-20 08:03:45.843000 | 2022-12-02 01:06:05.103000; 2022-12-02 01:06:05.110000; 2023-10-24 23:09:27.557000 |
| `ModifiedUTC` | timestamp | 2022-05-26 02:56:22.183000; 2022-05-04 07:12:51.980000; 2022-05-26 02:56:51.383000 | 2022-12-02 00:40:05.383000; 2022-12-02 00:40:05.390000; 2023-10-24 22:52:21.870000 |
| `Name` | string | PART 1 – CHECK AND REPAIR\|1.3 Check that Asset Drawings and wiring charts are present, undamaged, legible and correct. Prepare ...; PART 2 – RECORD OF ASSET CONDITION AND REPAIRS\|PART 2 – RECORD OF ASSET CONDITION AND REPAIRS (8)\|SPARKS Reference; PART 1 – CHECK AND REPAIR\|9.5 Check and Record Battery Voltage when operating on battery power immediately after switching to b... | DISPATCH DETAILS\|Parent Dispatch; DISPATCH DETAILS\|Programme; GENERAL DETAILS\|Environmental Suitability |
| `Value` | string | Passed (P); N/A; L-2022-0008146 | November 2022; 2028; 470 |
| `DataType` | string | Single-Select Dropdown; Text; Label | Text; Single-Select Dropdown |
| `SortOrder` | int | 290; 1290; 980 | 240; 100; 20 |
| `ModifiedUser` | string | VSM - Thomas Speziali; VSM - Paul Cullen; VSM - Hans Cromhout | VNZ - Natalie Martin; VNZ - Shivnil Mani; VNZ - Ventia NZ CPI Integration |
| `SourceTable` | string | Inspection; Job | Job |
| `SourceTableID` | int | 37901; 35380; 35718 | 55465; 55014; 55464 |
| `UniqueID` | int | 5397; 5497; 5466 | 358; 400; 384 |
| `Deleted` | boolean | False | False |

### `inspection`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 35291; 35292; 35293 | 61960; 74736; 74737 |
| `DeltaUTC` | timestamp | 2024-07-05 06:53:53.233000; 2024-07-05 06:53:53.240000; 2024-07-05 06:53:53.243000 | 2024-07-05 06:47:05.443000; 2024-07-05 06:47:05.447000; 2024-07-05 06:47:05.453000 |
| `ModifiedUTC` | timestamp | 2022-05-02 04:42:47.220000; 2022-05-02 10:18:18.310000; 2022-05-02 10:19:49.243000 | 2022-11-30 00:23:06.953000; 2023-02-08 23:31:54.220000; 2023-02-08 23:31:56.010000 |
| `ModifiedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Sione Alofaki; VNZ - Conor Murphy; VNZ - John Hansen |
| `AssetTypeName` | string | No non-null example found | Footpath; Roads |
| `AssetID` | int | No non-null example found | 507039; 507084; 507567 |
| `AssetCode` | string | No non-null example found | 15563; 15610; 16198 |
| `AssetName` | string | No non-null example found | TOWNSHIP RD; MCENTEE RD (WAITAKERE); WAITAKERE RD (SWANSON) |
| `Section` | string | No non-null example found | No non-null example found |
| `Classification` | string | No non-null example found | RMC 1 - Rural; RMC 5 - Rural; RMC 1 - Urban |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `Region` | string | Western Australia | Auckland |
| `StartDate` | timestamp | 2022-05-02 04:42:25.003000; 2022-05-02 10:17:59.830000; 2022-05-02 10:19:28.787000 | 2022-11-29 18:59:01.993000; 2023-02-08 23:34:50.160000; 2023-02-09 21:48:29.667000 |
| `StartReferencePointName` | string | No non-null example found | Start Roads |
| `ChainageFrom` | int | No non-null example found | 0; 65; 11477 |
| `StartDistancePast` | int | No non-null example found | 0 |
| `EndReferencePointName` | string | No non-null example found | End Roads |
| `ChainageTo` | int | No non-null example found | 393; 97; 84 |
| `EndDistancePast` | int | No non-null example found | 0 |
| `Direction` | string | Forward | Forward |
| `BothDirections` | string | No | No |
| `OtherDirectionInspectionID` | int | No non-null example found | No non-null example found |
| `InspectionTypeID` | int | 129; 122; 120 | 450; 491; 451 |
| `InspectionTypeName` | string | Traffic Signals Maintenance Check Sheet; ESLS Maintenance Check Sheet; Bluetooth Travel Time Beacon Check Sheet | Job Start Card; Pathways Inspection; Hazard Inspection (Day) |
| `InspectionTypeReference1` | string | No non-null example found | No non-null example found |
| `InspectionTypeReference2` | string | No non-null example found | No non-null example found |
| `Category` | string | Forms | Forms; Inspection |
| `CreatedDate` | timestamp | 2022-05-02 11:53:56.290000; 2022-05-02 18:14:25.773000; 2022-05-02 18:18:14.207000 | 2022-11-30 06:23:44.663000; 2023-02-09 10:31:54.133000; 2023-02-09 10:31:55.997000 |
| `CreatedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Sione Alofaki; VNZ - Conor Murphy; VNZ - Mike VanEngelen |
| `AssignedUser` | string | VSM - Nick Perella | VNZ - John Hansen; VNZ - Conor Murphy |
| `Comments` | string | Site under construction; L-2022-0005267; L-2022-0005275 | This is a test inspection |
| `EntireLength` | string | Yes | Yes; No: |
| `ScheduledDate` | timestamp | No non-null example found | 2023-02-13 00:00:00; 2023-02-09 00:00:00; 2023-03-10 00:00:00 |
| `ScheduledDateFrom` | timestamp | No non-null example found | 2024-10-09 05:00:00 |
| `ScheduledDateTo` | timestamp | No non-null example found | 2024-10-16 13:30:00 |
| `CurrentStatus` | string | Running; Completed | Running; Scheduled; Completed |
| `CompletedDate` | timestamp | 2022-05-02 10:19:29.450000; 2022-05-03 04:45:36.713000; 2022-05-03 23:27:58.423000 | 2023-02-08 23:38:01.897000; 2023-03-21 21:27:51.570000; 2023-08-14 03:11:12.260000 |
| `CompletedUser` | string | VSM - Hans Cromhout; VSM - Phil Spragg; VSM - Brendan Lipple | VNZ - Conor Murphy; VNZ - John Hansen; VNZ - Tawhio Nehuaharawira |
| `JobID` | int | 38817; 38773; 38475 | 64694; 68395; 67611 |
| `CapitalWorkID` | int | No non-null example found | 289 |
| `InspectionRouteName` | string | No non-null example found | Johnny - Friday Weekly Route; Johnny - Tuesday Weekly Route |
| `InspectionGroupID` | int | 17022; 17023; 17024 | 34323; 45687; 45688 |
| `Reference1` | string | 700-03689-03-01-03-01-02 | 720-00502-03-02-01 |
| `Reference2` | string | No non-null example found | 000221241929; 000221238529; 000221312653 |
| `EstimatedDuration` | decimal(10,2) | 2.00 | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | <binary 249 bytes>; <binary 441 bytes>; <binary 217 bytes> |
| `InspectionID` | int | 123987 | 128513 |
| `ModuleID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | False |

### `inspectionrelationship`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `Id` | int | No non-null example found | No non-null example found |
| `DeltaUTC` | timestamp | No non-null example found | No non-null example found |
| `ModifiedUTC` | timestamp | No non-null example found | No non-null example found |
| `InspectionID` | int | No non-null example found | No non-null example found |
| `InspectionType` | string | No non-null example found | No non-null example found |
| `ChildInspectionID` | int | No non-null example found | No non-null example found |
| `ChildInspectionType` | string | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | No non-null example found |

### `inspectionstatus`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 244247; 244248; 244249 | 402186; 402195; 402196 |
| `DeltaUTC` | timestamp | 2022-06-17 04:05:28.930000; 2022-06-17 04:05:28.923000; 2022-06-17 04:05:28.933000 | 2022-11-21 21:03:15.970000; 2022-11-21 21:03:15.980000; 2022-11-21 21:03:15.987000 |
| `ModifiedUTC` | timestamp | 2022-05-02 04:42:50.660000; 2022-05-02 10:18:19.007000; 2022-05-02 10:19:54.980000 | 2022-11-21 20:40:45.470000; 2022-11-21 20:40:45.483000; 2022-11-21 20:40:45.493000 |
| `ModifiedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Shaun Alborough; VNZ - Sione Alofaki; VNZ - Conor Murphy |
| `InspectionID` | int | 35291; 35292; 35293 | 59887; 59889; 59891 |
| `Status` | string | Started; Completed; Location Updated | Started; Paused; Recommenced |
| `StatusDateUTC` | timestamp | 2022-05-02 04:42:25.003000; 2022-05-02 10:17:59.830000; 2022-05-02 10:19:28.787000 | 2022-11-21 20:37:34.773000; 2022-11-21 20:39:13.053000; 2022-11-21 20:40:31.727000 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes> |
| `Deleted` | boolean | False | False |

### `job`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 38383; 38384; 38385 | 55014; 55015; 55016 |
| `DeltaUTC` | timestamp | 2024-07-05 06:52:49.357000; 2024-07-05 06:52:50.010000; 2024-07-05 06:52:49.353000 | 2024-07-05 06:45:01.043000; 2024-07-05 06:45:00.690000; 2024-07-05 06:45:24.357000 |
| `ModifiedUTC` | timestamp | 2022-05-17 04:57:36.930000; 2022-06-09 03:52:27.353000; 2022-06-02 03:40:43.290000 | 2022-12-02 02:27:29.700000; 2022-12-02 02:02:45.700000; 2024-01-27 08:47:32.917000 |
| `ModifiedUser` | string | VSM - Stuart Webb; VSM - Jarrod Holmes; VSM - Ross Dobbie | VNZ - Ventia NZ CPI Integration; VNZ - Adi Laisa Bolauga; VNZ - Gyanendra Sharma |
| `AssetID` | int | 68139; 68145; 68147 | 331435; 331862; 333425 |
| `AssetCode` | string | CCTV00070; CCTV00076; CCTV00078 | 13250; 13254; 13245 |
| `AssetName` | string | South St and Benningfield Rd (East Bound); Stock Rd and Leach Hwy (West Bound); Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound) | HETANA ST; STURGES RD; GREAT NORTH RD (WAITAKERE) |
| `Section` | string | No non-null example found | No non-null example found |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `Region` | string | Western Australia | Auckland |
| `HazardDefectCode` | string | PMCC.PM; PMES.PM; PMHP.PM | 007.N; 030.3; EM |
| `HazardCode` | string | No non-null example found | EM |
| `ActivityCategoryCode` | string | CTV; VSS; HLP | 2; 4; 5 |
| `ActivityCategoryName` | string | Close Circuit Television; ESLS(VSS); Help Phone | Signs; Surface water channels; Drainage(Culverts) |
| `ActivityCode` | string | PMCC; PMES; PMHP | 007; 030; IMN |
| `ActivityName` | string | Preventative Maintenance | CC__Damaged; Faded Sign; Missing Sign - Replace |
| `InterventionID` | int | 7552; 7554; 7555 | 29082; 29107; 29086 |
| `InterventionCode` | string | PM | N; 3; 5 |
| `FullInterventionCode` | string | PMCC.PM; PMES.PM; PMHP.PM | 007.N; 030.3; 007.5 |
| `InterventionName` | string | Preventative Maintenance Activities (Planned Works) | Normal / Routine; P3 - Programmed Works - Must Do; P5 - Emergency Works |
| `InterventionReference1` | string | No non-null example found | No non-null example found |
| `InterventionReference2` | string | No non-null example found | No non-null example found |
| `CreatedDate` | timestamp | 2022-04-30 00:00:00 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `Direction` | string | No non-null example found | Forward |
| `ReferencePointName` | string | No non-null example found | Start Sections; End Sections |
| `EndReferencePointName` | string | No non-null example found | End Sections; Start Sections |
| `EstimatedDuration` | decimal(10,2) | 2.00 | 4.00 |
| `ChainageFrom` | int | No non-null example found | 86; 187; 16 |
| `ChainageTo` | int | No non-null example found | 692; 423; 107 |
| `BothDirections` | string | No non-null example found | No |
| `DistancePast` | int | No non-null example found | 86; 187; 16 |
| `EndDistancePast` | int | No non-null example found | 113; 423; 107 |
| `Unit` | string | Number | Each |
| `EstimatedQuantity` | decimal(10,3) | 1.000 | 0.000; 1.000; 161.000 |
| `Priority` | string | Medium | Low |
| `InspectionID` | int | No non-null example found | 88549 |
| `DueDate` | timestamp | 2022-05-09 00:00:00; 2022-05-27 00:00:00; 2022-05-16 00:00:00 | 2022-09-26 14:12:39; 2022-11-07 12:26:00; 2022-09-22 06:36:00 |
| `ScheduledStart` | timestamp | 2022-11-15 00:00:00 | 2022-11-28 00:00:00 |
| `ScheduledEnd` | timestamp | 2022-11-15 00:00:00 | 2023-03-01 00:00:00 |
| `CompletedDate` | timestamp | 2022-05-17 12:57:36.563000; 2022-06-09 11:52:21.177000; 2022-06-02 11:40:38.123000 | 2022-10-27 17:52:07; 2022-09-12 14:22:38; 2022-11-07 14:56:12 |
| `AssignedUser` | string | VSM - Stephen Walden; VSM - Ross Dobbie; VSM - Damon Vandenbergh | VNZ - Job Reviewer (VNZ); VNZ - Garth Birkett; VNZ - Shivnil Mani |
| `ApprovalDate` | timestamp | No non-null example found | No non-null example found |
| `ApprovalNumber` | string | No non-null example found | No non-null example found |
| `FutureWorks` | boolean | False | False |
| `EstimatedCost` | decimal(18,2) | No non-null example found | 7475.12 |
| `Area` | string | No non-null example found | No non-null example found |
| `AssignedDate` | timestamp | 2022-04-30 00:00:00; 2022-06-28 10:09:46.060000; 2022-06-02 22:30:32.413000 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `ActivityType` | string | Planned | Planned; Emergency; Reactive |
| `CompletedStatus` | string | Complete | Complete; No Action Required |
| `Reference1` | string | 700-03689-03-01-03-06-01; 700-03689-03-01-03-04-01; 700-03689-03-01-03-05-01 | 720-00502-03-04-06; 720-00502-03-03-06; 720-00502-03-04-05 |
| `Reference2` | string | 000129304628; 000129304498; 000129304645 | 000117610344; 000117609902; 000117610093 |
| `ReferencePointTypeName` | string | No non-null example found | Sections Start/End |
| `EndReferencePointTypeName` | string | No non-null example found | End Sections; Start Sections |
| `Compliant` | string | No; Yes | Yes; No |
| `Classification` | string | ITS | RMC 1 - Urban; RMC 1 - Rural; RMC 5 - Urban |
| `Comments` | string | No non-null example found | No non-null example found |
| `RemainingQuantity` | decimal(38,2) | 0.00; -0.50; -1.50 | 0.00; -1.00; -2.00 |
| `ActualQuantity` | decimal(38,2) | 1.00; 1.50; 2.50 | 1.00; 3.00; 2.00 |
| `CreatedUser` | string | VSM - Jarrod Holmes | VNZ - VNZ Support |
| `ApprovedUser` | string | No non-null example found | No non-null example found |
| `CompletedUser` | string | VSM - Stuart Webb; VSM - Jarrod Holmes; VSM - Ross Dobbie | VNZ - VNZ Support; VNZ - Adi Laisa Bolauga; VNZ - Gyanendra Sharma |
| `ExternalID` | string | No non-null example found | 1875; 478; 2262 |
| `AssetTypeName` | string | Close Circuit Television; ESLS(VSS); Help Phone | Sections |
| `InspectionTypeName` | string | No non-null example found | Hazard Inspection (Day) |
| `CurrentWorkflowItemCode` | string | COMP | REVD; COMP; INPL |
| `CurrentWorkflowItemName` | string | Complete | Reviewed; Complete; In Planning |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes>; <binary 128 bytes>; <binary 272 bytes> |
| `MergedJobID` | int | No non-null example found | 57503 |
| `LinkedJobID` | int | No non-null example found | 55449; 55093; 55135 |
| `CRMID` | string | No non-null example found | No non-null example found |
| `MadeSafe` | boolean | No non-null example found | False |
| `MadeSafeDateUTC` | timestamp | No non-null example found | No non-null example found |
| `ComplianceCalculationDate` | timestamp | 2022-04-30 00:00:00; 2022-06-28 10:09:46.060000; 2022-06-02 22:30:32.413000 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `CRMDescription` | string | No non-null example found | No non-null example found |
| `CRMField1` | string | No non-null example found | No non-null example found |
| `CRMField2` | string | No non-null example found | No non-null example found |
| `CRMField3` | string | No non-null example found | No non-null example found |
| `CRMField4` | string | No non-null example found | No non-null example found |
| `CRMField5` | int | No non-null example found | No non-null example found |
| `CRMField6` | timestamp | No non-null example found | No non-null example found |
| `EstimatedLength` | decimal(10,3) | 0.000 | 0.000 |
| `EstimatedWidth` | decimal(10,3) | 0.000 | 0.000 |
| `EstimatedDepth` | decimal(10,3) | 0.000 | 0.000 |
| `Deleted` | boolean | False | False |

### `jobasset`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `DeltaUTC` | timestamp | 2022-06-17 04:05:26.500000; 2022-06-17 04:05:26.507000; 2022-06-17 04:05:26.513000 | 2023-01-23 21:02:11.340000; 2022-11-17 23:30:48.773000; 2023-04-16 19:54:56.030000 |
| `ModifiedUTC` | timestamp | 2022-05-24 06:31:18.117000; 2022-05-01 15:11:36.860000; 2022-04-03 02:02:06.640000 | 2023-01-23 20:41:38.130000; 2023-01-23 20:41:38.117000; 2022-11-17 23:13:55.740000 |
| `ModifiedUser` | string | VSM - Stuart Webb; VSM - VSM Support; VSM - Jarrod Holmes | VNZ - Glen Bramhall; VNZ - VNZ Support; VNZ - Shivnil Mani |
| `JobID` | int | 40287; 38196; 36601 | 55357; 55129; 55358 |
| `AssetID` | int | 69009; 66614; 68071 | 332393; 329625; 333401 |
| `Direction` | string | Forward | Forward |
| `ChainageFrom` | int | 0 | 208; 653; 109 |
| `ChainageTo` | int | No non-null example found | 110; 692; 1060 |
| `SystemGenerated` | boolean | True | True |
| `Deleted` | boolean | False | False |

### `jobcomment`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 47940; 47941; 47942 | 67757; 67759; 67760 |
| `DeltaUTC` | timestamp | 2022-09-21 07:02:21.160000; 2022-09-21 07:02:21.163000; 2022-09-21 07:02:21.170000 | 2022-11-21 01:31:07.607000; 2022-11-21 02:03:10.200000; 2022-11-21 03:08:52.760000 |
| `ModifiedUTC` | timestamp | 2022-04-03 01:49:37.740000; 2022-04-03 02:10:25.847000; 2022-04-03 02:24:27.597000 | 2022-11-21 01:03:28.607000; 2022-11-21 01:16:36.560000; 2022-11-21 01:21:31.920000 |
| `ModifiedUser` | string | VSM - VSM Support; VSM - Ross Dobbie; VSM - Paul Cullen | VNZ - Natalie Martin; VNZ - Shaun Alborough; VNZ - Pritpal Singh |
| `JobID` | int | 36601; 36602; 36603 | 55287; 55832; 56336 |
| `Comment` | string | Test job for PVT; Test for PVT; Sign 08 has been listed as a shading issue in log copies and tagged in streams, I have trimmed Bach the offending tree consider... | Paper DJR Completed 15/11/22 4pm - 7pm By Maintenance 1 - Pritpal Sweep Road with Intergroup truck, make road safe Photos passe...; 16 Sunnyside road - Inspect footpath, put cone bar out to protect. Permanent fix to be requested from AT.; Cleaned 2 carparks including cesspit & channel |
| `Deleted` | boolean | False | False |

### `log`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `Name` | string | Data Services Error; Job Transfer Error; Job Total | Data Services Error; Form Field Transfer Error; Job Transfer Error |
| `Description` | string | Company and code: Gen7, VSM \| The required column 'UniqueID' was not present in the results of a 'FromSql' operation. at Data_S...; Environment: Gen 7; Company code: VSM \| The time zone ID 'Australia/Melbourne' was not found on the local computer. at Data_Ser...; Environment: Gen 7; Company code: VSM \| Connection Timeout Expired. The timeout period elapsed during the post-login phase. The... | Environment: Gen 7; Company code: VNZ \| Transaction (Process ID 335) was deadlocked on lock resources with another process and ...; Environment: Gen 7; Company code: VNZ \| Transaction (Process ID 152) was deadlocked on lock resources with another process and ...; Environment: Gen 7; Company code: VNZ \| Transaction (Process ID 94) was deadlocked on lock resources with another process and h... |
| `Modified` | timestamp | 2022-07-20 06:52:10.210000; 2023-02-10 00:51:51.887000; 2023-02-10 01:21:15.857000 | 2023-01-19 22:11:12.777000; 2023-01-20 20:41:33.920000; 2023-01-21 20:11:50.763000 |

### `module`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 60848; 62180; 62181 |
| `DeltaUTC` | timestamp | No non-null example found | 2025-11-05 00:14:03.343000; 2025-11-05 00:14:03.350000; 2025-11-05 00:14:03.353000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2023-03-13 19:11:04; 2022-12-02 02:40:10.420000; 2022-12-02 02:41:17.817000 |
| `ModifiedUser` | string | No non-null example found | VNZ - Alireza Sharif; VNZ - Anna Covell; VNZ - Karan Sivakumaran |
| `Contract` | string | No non-null example found | Auckland West Transport |
| `Region` | string | No non-null example found | Auckland West Transport |
| `CompletedDate` | timestamp | No non-null example found | 2022-11-28 02:29:54.067000; 2022-12-10 08:54:00; 2022-10-13 08:59:00 |
| `ModuleName` | string | No non-null example found | Auck Renewal Pack; Customer Request; Auck RM Pack |
| `Name` | string | No non-null example found | Tapou Street Renewals; test 1; test 2 |
| `CreatedDate` | timestamp | No non-null example found | 2022-11-22 13:00:05.660000; 2022-12-02 12:39:02.227000; 2022-12-02 12:40:16.763000 |
| `CreatedUser` | string | No non-null example found | VNZ - Shaun Alborough; VNZ - Anna Covell; VNZ - Karan Sivakumaran |
| `AssignedUser` | string | No non-null example found | VNZ - Garth Birkett; VNZ - Karan Sivakumaran; VNZ - Laura Stokes |
| `Comments` | string | No non-null example found | test 2; jobs sent through from AT site observations following the storm. |
| `AssetID` | int | No non-null example found | No non-null example found |
| `AssetCode` | string | No non-null example found | No non-null example found |
| `AssetName` | string | No non-null example found | No non-null example found |
| `EntireLength` | string | No non-null example found | No: |
| `Direction` | varchar(50) | No non-null example found | Forward |
| `StartPointName` | string | No non-null example found | No non-null example found |
| `ChainageFrom` | int | No non-null example found | No non-null example found |
| `StartDistancePast` | int | No non-null example found | No non-null example found |
| `EndPointName` | string | No non-null example found | No non-null example found |
| `ChainageTo` | int | No non-null example found | No non-null example found |
| `EndDistancePast` | int | No non-null example found | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | No non-null example found |
| `ParentSourceTableName` | string | No non-null example found | No non-null example found |
| `ParentSourceTableID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | False |

### `photo`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 111248; 111249; 111250 | 213348; 213349; 213350 |
| `DeltaUTC` | timestamp | 2025-07-24 06:12:43.943000; 2025-07-24 06:12:42.640000; 2025-07-24 06:12:40.313000 | 2024-08-07 06:04:49.353000; 2024-08-07 06:04:15.377000; 2024-08-07 06:04:15.380000 |
| `ModifiedUTC` | timestamp | 2023-04-26 05:46:36.790000; 2023-04-26 05:46:36.917000; 2023-04-26 05:46:37.053000 | 2023-04-24 05:21:00.253000; 2023-04-24 05:21:00.520000; 2023-04-24 05:21:00.753000 |
| `CreatedDate` | timestamp | 2022-05-02 12:31:52.913000; 2022-05-02 18:16:32.103000; 2022-05-02 18:17:20.280000 | 2022-11-21 08:14:20; 2022-11-21 08:14:28; 2022-11-21 07:55:28 |
| `CreatedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - John Hansen; VNZ - Pritpal Singh; VNZ - Jake E Lee Fox |
| `SourceTable` | string | FormField_Inspection; Job; Inspection | FormField_Job; Job; FormField_Module |
| `SourceTableID` | int | 298277; 298349; 298516 | 410872; 426646; 57438 |
| `URL` | string | https://hnsavprod.blob.core.windows.net/photos-au3-prod/111248.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=kfse...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/111249.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=bUiQ...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/111250.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=34tR... | https://hnsavprod.blob.core.windows.net/photos-au3-prod/213348.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=AXlQ...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/213349.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=CdgW...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/213350.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp=r&sig=bYyO... |
| `ThumbnailURL` | string | https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/111248.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/111249.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/111250.jpg?sv=2021-06-08&se=9999-12-31T23%3A59%3A59Z&sr=b&sp... | https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/213348.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/213349.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp...; https://hnsavprod.blob.core.windows.net/photos-au3-prod/thumbnails/213350.JPG?sv=2021-08-06&se=9999-12-31T23%3A59%3A59Z&sr=b&sp... |
| `Stage` | string | Job Before; Job After; Job During | Job Before; Job After; Job During |
| `Deleted` | boolean | False | False |

### `plannedresourceitem`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 220758; 220759 | No non-null example found |
| `PlannedResourceID` | int | 47635 | No non-null example found |
| `DeltaUTC` | timestamp | 2024-07-05 00:16:57.380000 | No non-null example found |
| `ModifiedUTC` | timestamp | 2023-02-14 01:50:52.077000 | No non-null example found |
| `ModifiedUser` | string | VSM - Muhammad Alna | No non-null example found |
| `PlannedResourceCreatedDate` | timestamp | 2023-02-14 09:42:08.767000 | No non-null example found |
| `PlannedResourceCreatedUser` | string | VSM - Muhammad Alna | No non-null example found |
| `SourceTable` | string | Job | No non-null example found |
| `SourceTableID` | int | 64809 | No non-null example found |
| `PlannedResourceTypeName` | string | Employees | No non-null example found |
| `CompanyRateName` | string | Standard Rate | No non-null example found |
| `CompanyRateReference1` | string | No non-null example found | No non-null example found |
| `CompanyRateReference2` | string | No non-null example found | No non-null example found |
| `Hours` | int | No non-null example found | No non-null example found |
| `Minutes` | int | No non-null example found | No non-null example found |
| `Quantity` | decimal(9,2) | 5.00 | No non-null example found |
| `Multiplier` | int | No non-null example found | No non-null example found |
| `Cost` | decimal(12,2) | No non-null example found | No non-null example found |
| `ResourceCode` | string | EMP0091119; EMP0091105 | No non-null example found |
| `ResourceName` | string | Rodney Dann; Plamen Kurtev | No non-null example found |
| `ResourceType` | string | Employees | No non-null example found |
| `StartDate` | timestamp | No non-null example found | No non-null example found |
| `EndDate` | timestamp | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | No non-null example found |

### `resource`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 73073; 82928; 82929 | 328249; 328250; 328251 |
| `DeltaUTC` | timestamp | 2024-03-28 02:34:53.260000; 2024-03-28 02:34:53.280000; 2024-03-28 02:34:53.283000 | 2024-03-31 04:55:04.647000; 2024-03-31 04:55:04.693000; 2024-03-31 04:55:04.697000 |
| `ModifiedUTC` | timestamp | 2022-03-01 01:47:53.190000; 2022-03-27 22:45:54.617000; 2022-03-27 22:45:54.640000 | 2022-09-08 01:27:59.220000; 2022-09-08 01:27:59.263000; 2022-09-08 01:27:59.297000 |
| `ExportDateUTC` | timestamp | 2024-03-28 02:31:19.667000; 2025-08-29 01:33:51.287000; 2024-03-28 04:32:12.193000 | 2024-03-31 04:54:27.657000; 2024-07-23 01:39:26.277000; 2024-07-23 00:09:24.003000 |
| `ModifiedUser` | string | VSM - VSM Support; VSM - Tom Funge; VSM - VentureSmart CPI Integration | VNZ - VNZ Support; VNZ - Ventia NZ CPI Integration; VNZ - Adi Laisa Bolauga |
| `Code` | string | 12183486; L020; L021 | NZLAB (4); NZLAB (1); NZLAB (2) |
| `Name` | string | J13 PLANT; TEST TIME CONFIRMATION; 1GYU835; 1GYU958 | Operator 2 (S4/S5); General Labour (L2); Skilled Labour (O5) |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `ResourceType` | string | Plant and Equipment; Storage Locations; Inventory | Labour; Subcontractor; Storage Locations |
| `ResourceGroup` | string | No non-null example found | No non-null example found |
| `ParentResourceID` | int | 86151; 86152; 82931 | 465550 |
| `ParentResourceCode` | string | L067; L068; L023 | L150 |
| `ParentResourceName` | string | 1HMJ150; 1HMQ163; 1EZX206 | Ventia NZ Depot |
| `ParentResourceTypeName` | string | Storage Locations | Storage Locations |
| `Stage` | string | Active; Inactive | Active; Inactive |
| `Cost` | decimal(12,2) | No non-null example found | 35.20; 28.16; 31.68 |
| `Notes` | string | No non-null example found | measured in KG; Activity Type 120002; Construction Plant |
| `Quantity` | decimal(9,2) | 1.00; 0.00; 2.00 | 1.00; 3.00; 4.00 |
| `Unit` | string | Hour; Each; EA | hour; each; m3 |
| `AlertNotes` | string | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | False |

### `resourceattribute`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `ResourceID` | int | 82928; 82929; 82930 | 328249; 328250; 328251 |
| `DeltaUTC` | timestamp | 2022-06-02 01:39:46.367000; 2022-06-02 01:39:46.407000; 2022-06-02 01:39:46.430000 | 2022-10-06 01:29:02.267000; 2022-10-06 01:29:02.370000; 2022-10-06 01:29:03.293000 |
| `ModifiedUTC` | timestamp | 2022-03-27 22:45:54.617000; 2022-03-27 22:45:54.640000; 2022-03-27 22:45:54.660000 | 2022-09-08 01:27:59.220000; 2022-09-08 01:27:59.263000; 2022-09-08 01:27:59.297000 |
| `ModifiedUser` | string | VSM - VSM Support; VSM - Tom Funge | VNZ - VNZ Support; VNZ - Shaun Alborough |
| `Name` | string | SAP Code; Material Group; Manufacturer Part Number | Type; Subtype; Resource |
| `Value` | string | 9000189299; 46161500; TC412-06 | L; LS; LX |
| `DataType` | string | Text; Single-Select Dropdown | Text |
| `Deleted` | boolean | False | False |

### `resourceaudit`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `ResourceID` | int | 73073; 82928; 82929 | 328188; 328189; 328190 |
| `Modified` | timestamp | 2022-03-01 12:47:53.190000; 2022-03-01 12:47:20.417000; 2022-03-22 16:52:58.823000 | 2022-09-08 11:01:22.127000; 2022-09-08 11:01:22.193000; 2022-09-08 11:01:22.233000 |
| `DeltaUTC` | timestamp | 2024-03-28 02:34:53.840000; 2024-03-28 02:34:53.907000; 2024-03-28 02:34:53.920000 | 2024-03-31 04:55:04.883000; 2024-03-31 04:55:04.913000; 2024-03-31 04:55:04.920000 |
| `DisplayName` | string | Unit; Record Created; Stage | Record Created; Code; Stage |
| `OriginalValue` | string | Active; Inactive | NZCON_TRUCK12; NZCON_TRAFFIC02; NZCON_UTE02 |
| `NewValue` | string | Hour; Created on 01/03/2022 12:47; Created on 22/03/2022 16:52 | Created on 08/09/2022 11:01; Created on 08/09/2022 11:27; Created on 08/09/2022 11:28 |
| `ModifiedUser` | string | VSM - VSM Support | VNZ - VNZ Support |
| `Source` | varchar(255) | Web | Web |

### `summarycheck`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | No non-null example found |
| `DeltaUTC` | timestamp | No non-null example found | No non-null example found |
| `CheckDateUTC` | timestamp | No non-null example found | No non-null example found |
| `TableName` | string | No non-null example found | No non-null example found |
| `CountType` | string | No non-null example found | No non-null example found |
| `CountValueLocal` | int | No non-null example found | No non-null example found |
| `CountValueServer` | int | No non-null example found | No non-null example found |
| `Contract` | string | No non-null example found | No non-null example found |

### `timesheetitem`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 128724; 128725; 128726 | 200173; 200174; 200175 |
| `TimesheetID` | int | 27511; 27512; 27513 | 42263; 42264; 42271 |
| `DeltaUTC` | timestamp | 2022-06-02 01:37:43.803000; 2022-06-02 01:37:43.807000; 2022-06-02 01:37:43.810000 | 2022-11-21 01:31:01.773000; 2022-11-21 03:08:42.787000; 2022-11-21 03:08:42.783000 |
| `ModifiedUTC` | timestamp | 2022-04-03 02:00:58.470000; 2022-04-03 02:00:58.507000; 2022-04-03 02:13:29.873000 | 2022-11-21 01:12:28.167000; 2022-11-21 01:12:28.210000; 2022-11-21 01:18:25.123000 |
| `ModifiedUser` | string | VSM - VSM Support; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Natalie Martin; VNZ - Karan Sivakumaran; VNZ - Shivnil Mani |
| `TimesheetCreatedDate` | timestamp | 2022-04-03 11:57:05.647000; 2022-04-03 12:12:57.307000; 2022-04-03 12:13:17.753000 | 2022-11-15 15:00:19.333000; 2022-11-21 14:17:44.817000; 2022-11-15 15:51:22.330000 |
| `TimesheetCreatedUser` | string | VSM - VSM Support; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Pritpal Singh; VNZ - Natalie Martin; VNZ - Shivnil Mani |
| `SourceTable` | string | Job | Job; CapitalWorkTask |
| `SourceTableID` | int | 36601; 36602; 36603 | 55287; 55832; 56336 |
| `TimesheetTypeName` | string | Inventory; Quantity; Plant and Equipment | Labour; Plant and Equipment; Employees |
| `CompanyRateName` | string | Standard Rate | 0; Standard Hours |
| `CompanyRateReference1` | string | No non-null example found | No non-null example found |
| `CompanyRateReference2` | string | No non-null example found | No non-null example found |
| `Hours` | int | No non-null example found | 3; 2; 0 |
| `Minutes` | int | No non-null example found | 0; 30; 3 |
| `Quantity` | decimal(9,2) | 1.00; 2.00; 3.00 | 3.00; 2.00; 1.00 |
| `Multiplier` | int | No non-null example found | No non-null example found |
| `Cost` | decimal(12,2) | No non-null example found | 31.68; 470.00; 28.16 |
| `ResourceCode` | string | L020-9000189377; L003-3000047914; 12183486 | NZLAB (2); 12664267; 12664146 |
| `ResourceName` | string | N_LAMP,BLACK,ATS,GRN,WALKMAN,200MM-TS; AUDIO DRIVER CARD-TS; J13 PLANT; TEST TIME CONFIRMATION | Skilled Labour (O5); HMW728 TRUCK; TIPPER ISUZU NPR450M S/C 4X2; MPT648 UTE; TOYOTA HILUX SR DC 2X4 2.8 TD AUTO |
| `ResourceType` | string | Inventory; Plant and Equipment | Labour; Plant and Equipment; Employees |
| `StartDate` | timestamp | No non-null example found | 2022-11-15 09:00:00; 2022-11-25 09:07:00; 2022-11-28 00:00:00 |
| `EndDate` | timestamp | No non-null example found | 2022-11-15 12:30:22.330000; 2022-11-25 09:33:21.843000; 2022-11-28 00:00:41.853000 |
| `Deleted` | boolean | False | False |

### `vassetaudit`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `AssetID` | int | 63813; 63814; 63815 | 328712; 328721; 328722 |
| `Modified` | timestamp | 2022-02-11 08:39:32.780000; 2022-01-31 15:58:15; 2022-01-31 15:58:15.043000 | 2022-12-02 13:39:08.127000; 2022-12-02 13:39:07.883000; 2022-12-02 13:28:26.247000 |
| `DeltaUTC` | timestamp | 2024-03-28 03:54:30.373000; 2024-03-28 03:54:31.650000; 2024-03-28 03:54:31.653000 | 2024-03-28 03:43:33.433000; 2024-03-28 03:43:35.390000; 2024-03-28 03:43:35.393000 |
| `DisplayName` | string | Classification; Location Added; Record Created | Classification; RMC_Urban Rural; Contract Asset Mapping |
| `OriginalValue` | string | No non-null example found | RMC 1 - Urban; 330; 896 |
| `NewValue` | string | ITS; Created on 31/01/2022 15:58 | RMC 1 - Urban; Road; Created on 13/09/2022 13:39 |
| `ModifiedUser` | string | Main Roads Western Australia | Auckland Transport; VNZ - VNZ Support |
| `Source` | varchar(255) | Web | Web |
| `RecordID` | int | 79243; 79244; 79245 | 145532; 145533; 145534 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 288 bytes>; <binary 240 bytes>; <binary 38 bytes> |
| `WKT` | string | POINT (122.50359 -17.848); POINT (123.73992 -17.63385); POINT (125.56604 -18.19672) | LINESTRING (174.695681656347 -36.8919959825193, 174.69567738948 -36.8921148510253, 174.69544926643 -36.8924780235329, 174.69538...; LINESTRING (174.685932595285 -36.8968792882112, 174.685483421252 -36.8971000296969, 174.684966740444 -36.897356884751, 174.6846...; LINESTRING (174.682839554115 -36.8988277289035, 174.68273184471 -36.8990925508408) |

### `vassetlocation`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 63687; 63688; 63689 | 102313; 102314; 102315 |
| `DeltaUTC` | timestamp | 2025-03-31 04:23:35.300000; 2022-06-17 04:05:21.983000; 2022-06-17 04:05:21.987000 | 2022-12-02 02:43:02.157000; 2022-12-02 02:43:02.160000; 2022-12-02 02:43:02.163000 |
| `ModifiedUTC` | timestamp | 2025-03-31 03:52:42.203000; 2022-01-31 04:58:15.193000; 2022-01-31 04:58:15.243000 | 2022-12-02 02:39:07.943000; 2022-12-02 02:39:07.953000; 2022-12-02 02:39:07.963000 |
| `ModifiedUser` | string | VSM - Pranav Kumar; Main Roads Western Australia; VSM - David Michel | Auckland Transport; VNZ - VNZ Support |
| `AssetID` | int | 63813; 63814; 63815 | 328712; 328721; 328722 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 288 bytes>; <binary 240 bytes>; <binary 38 bytes> |
| `Direction` | string | No non-null example found | Forward |
| `ChainageFrom` | int | No non-null example found | 0; 1050; 1405 |
| `ChainageTo` | int | No non-null example found | 330; 1405; 1436 |
| `Deleted` | boolean | False | False |
| `WKT` | string | POINT (122.50359 -17.848); POINT (123.73992 -17.63385); POINT (125.56604 -18.19672) | LINESTRING (174.695681656347 -36.8919959825193, 174.69567738948 -36.8921148510253, 174.69544926643 -36.8924780235329, 174.69538...; LINESTRING (174.685932595285 -36.8968792882112, 174.685483421252 -36.8971000296969, 174.684966740444 -36.897356884751, 174.6846...; LINESTRING (174.682839554115 -36.8988277289035, 174.68273184471 -36.8990925508408) |

### `vcapitalwork`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 805; 806 | 289; 350; 358 |
| `DeltaUTC` | timestamp | 2025-08-25 02:29:51.947000; 2025-08-19 03:38:40.050000 | 2023-04-04 03:33:35.900000; 2023-04-04 02:03:32.970000; 2023-06-13 21:21:53.283000 |
| `ModifiedUTC` | timestamp | 2025-08-25 02:01:10.163000; 2025-08-19 03:32:09.107000 | 2023-04-04 03:18:13.433000; 2023-04-04 01:37:43.710000; 2023-06-13 20:58:37.887000 |
| `ModifiedUser` | string | VSM - John Hough | VNZ - Nick Wulf; VNZ - Garth Birkett; VNZ - Mike Newman |
| `Name` | string | ECW23049 | Taupo Street Renewal; Bancroft Cres Renewal; Pooks road |
| `Description` | string | Cable Theft Project | Renewal; Footpath Kerb and Channel Renewal; Footpath, Kerb and Channel Renewal |
| `CapitalWorkType` | string | Electrical Capital Works | Concrete Works; Pavement Works |
| `AssetTypeName` | string | Road Lighting | Roads |
| `AssetID` | int | 66132; 66140 | 329599; 330285; 329761 |
| `AssetCode` | string | SWB01216; SWB01225 | 40339; 41091; 40519 |
| `AssetName` | string | Forrest Hwy and Kwinana Fwy and Pinjarra Rd; Lakes Rd Interchange and Forrest Hwy | TAUPO ST; BANCROFT CRES; POOKS RD |
| `Section` | string | No non-null example found | No non-null example found |
| `Direction` | string | No non-null example found | Forward; Reverse |
| `ChainageFrom` | int | No non-null example found | 0; 14 |
| `ChainageTo` | int | No non-null example found | 640; 90; 1864 |
| `BothDirections` | string | No non-null example found | No non-null example found |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `CreatedUser` | string | VSM - John Hough | VNZ - Irfan Kareekunnan; VNZ - Glen Bramhall; VNZ - Garth Birkett |
| `Area` | decimal(18,2) | No non-null example found | 550.00; 2100.00; 1800.00 |
| `PlannedStart` | timestamp | 2025-08-19 00:00:00 | 2022-11-23 00:00:00; 2023-03-24 00:00:00; 2023-04-05 00:00:00 |
| `PlannedFinish` | timestamp | 2025-09-05 00:00:00 | 2023-04-04 23:59:59; 2023-03-24 23:59:59; 2023-04-21 23:59:59 |
| `ActualStart` | timestamp | 2025-08-19 00:00:00 | 2022-11-24 07:22:49.867000; 2023-03-24 00:00:00; 2023-04-05 22:15:28.617000 |
| `ActualFinish` | timestamp | No non-null example found | 2023-04-04 15:17:58.417000; 2023-04-04 13:37:43.257000; 2023-06-14 08:58:37.537000 |
| `Reference1` | string | SWB01216; SWB01225 | 720-00502-03-04-11 |
| `Reference2` | string | WO#52; WO#51 | 220300062; 221330732; 220333470 |
| `Supervisor` | string | VSM - John Hough | VNZ - Garth Birkett; VNZ - Sione Alofaki; VNZ - Nick Wulf |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 713 bytes>; <binary 105 bytes>; <binary 208 bytes> |
| `Deleted` | boolean | False | False |
| `WKT` | string | POINT (115.81343 -32.57078); POINT (115.79648 -32.5107) | MULTILINESTRING ((174.68053 -36.925699, 174.681261 -36.926308, 174.68136 -36.9264, 174.681416 -36.926461, 174.681437 -36.926496...; MULTILINESTRING ((174.660583442415 -36.8875657013357, 174.660863965791 -36.8874452214648, 174.661224955158 -36.8872303498976, 1...; GEOMETRYCOLLECTION (MULTILINESTRING ((174.69059376119 -36.9228500652578, 174.690395114245 -36.9228219959266, 174.690295656234 -... |

### `vcapitalworktask`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 670; 682; 689 |
| `DeltaUTC` | timestamp | No non-null example found | 2022-12-08 18:25:10.190000; 2022-12-08 18:25:10.200000; 2022-12-11 19:26:50.627000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2022-12-08 18:23:08.320000; 2022-12-08 18:23:08.337000; 2022-12-11 19:05:37.797000 |
| `ModifiedUser` | string | No non-null example found | VNZ - Garth Birkett; VNZ - Nick Wulf; VNZ - Sione Alofaki |
| `CapitalWorkID` | int | No non-null example found | 289; 350; 358 |
| `SortOrder` | int | No non-null example found | 1; 3; 4 |
| `Name` | string | No non-null example found | Digging Out Existing Footpath; Prep channel for A/C; Sione - 29/11 |
| `Description` | string | No non-null example found | Pour Concrete; Pour concrete; Pointing and cutting A/C to be done |
| `PlannedStart` | timestamp | No non-null example found | 2022-11-23 00:00:00; 2022-11-24 00:00:00; 2022-11-29 15:48:32.990000 |
| `PlannedFinish` | timestamp | No non-null example found | 2022-11-24 23:59:59; 2022-11-29 23:59:59.990000; 2022-11-30 23:59:59 |
| `ActualStart` | timestamp | No non-null example found | 2022-11-24 07:22:49.867000; 2022-11-28 15:33:39.930000; 2022-12-09 07:13:13.730000 |
| `ActualFinish` | timestamp | No non-null example found | 2022-11-24 23:59:59.140000; 2022-11-28 23:59:59.990000; 2022-12-12 23:59:59.597000 |
| `EstimatedQuantity` | decimal(10,3) | No non-null example found | 67.000; 200.000; 50.000 |
| `ActualQuantity` | decimal(10,3) | No non-null example found | No non-null example found |
| `Unit` | string | No non-null example found | m; m2; m3 |
| `EstimatedCost` | decimal(18,2) | No non-null example found | No non-null example found |
| `ActualCost` | decimal(18,2) | No non-null example found | No non-null example found |
| `Reference1` | string | No non-null example found | No non-null example found |
| `Reference2` | string | No non-null example found | 220300062; 221330732; 220333470 |
| `Comments` | string | No non-null example found | Completed works on 24/11/22; Storm event happened so no extra work has been started. Will push dates out to start next week on the 7th of Feb; Storm event has delayed works by a week. |
| `AssetTypeName` | string | No non-null example found | No non-null example found |
| `AssetID` | int | No non-null example found | No non-null example found |
| `AssetCode` | string | No non-null example found | No non-null example found |
| `AssetName` | string | No non-null example found | No non-null example found |
| `Section` | string | No non-null example found | No non-null example found |
| `Direction` | string | No non-null example found | No non-null example found |
| `ChainageFrom` | int | No non-null example found | No non-null example found |
| `ChainageTo` | int | No non-null example found | No non-null example found |
| `BothDirections` | string | No non-null example found | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | No non-null example found |
| `JobID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | False |
| `WKT` | string | No non-null example found | No non-null example found |

### `vinspection`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 35291; 35292; 35293 | 61960; 74736; 74737 |
| `DeltaUTC` | timestamp | 2024-07-05 06:53:53.233000; 2024-07-05 06:53:53.240000; 2024-07-05 06:53:53.243000 | 2024-07-05 06:47:05.443000; 2024-07-05 06:47:05.447000; 2024-07-05 06:47:05.453000 |
| `ModifiedUTC` | timestamp | 2022-05-02 04:42:47.220000; 2022-05-02 10:18:18.310000; 2022-05-02 10:19:49.243000 | 2022-11-30 00:23:06.953000; 2023-02-08 23:31:54.220000; 2023-02-08 23:31:56.010000 |
| `ModifiedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Sione Alofaki; VNZ - Conor Murphy; VNZ - John Hansen |
| `AssetTypeName` | string | No non-null example found | Footpath; Roads |
| `AssetID` | int | No non-null example found | 507039; 507084; 507567 |
| `AssetCode` | string | No non-null example found | 15563; 15610; 16198 |
| `AssetName` | string | No non-null example found | TOWNSHIP RD; MCENTEE RD (WAITAKERE); WAITAKERE RD (SWANSON) |
| `Section` | string | No non-null example found | No non-null example found |
| `Classification` | string | No non-null example found | RMC 1 - Rural; RMC 5 - Rural; RMC 1 - Urban |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `Region` | string | Western Australia | Auckland |
| `StartDate` | timestamp | 2022-05-02 04:42:25.003000; 2022-05-02 10:17:59.830000; 2022-05-02 10:19:28.787000 | 2022-11-29 18:59:01.993000; 2023-02-08 23:34:50.160000; 2023-02-09 21:48:29.667000 |
| `StartReferencePointName` | string | No non-null example found | Start Roads |
| `ChainageFrom` | int | No non-null example found | 0; 65; 11477 |
| `StartDistancePast` | int | No non-null example found | 0 |
| `EndReferencePointName` | string | No non-null example found | End Roads |
| `ChainageTo` | int | No non-null example found | 393; 97; 84 |
| `EndDistancePast` | int | No non-null example found | 0 |
| `Direction` | string | Forward | Forward |
| `BothDirections` | string | No | No |
| `OtherDirectionInspectionID` | int | No non-null example found | No non-null example found |
| `InspectionTypeID` | int | 129; 122; 120 | 450; 491; 451 |
| `InspectionTypeName` | string | Traffic Signals Maintenance Check Sheet; ESLS Maintenance Check Sheet; Bluetooth Travel Time Beacon Check Sheet | Job Start Card; Pathways Inspection; Hazard Inspection (Day) |
| `InspectionTypeReference1` | string | No non-null example found | No non-null example found |
| `InspectionTypeReference2` | string | No non-null example found | No non-null example found |
| `Category` | string | Forms | Forms; Inspection |
| `CreatedDate` | timestamp | 2022-05-02 11:53:56.290000; 2022-05-02 18:14:25.773000; 2022-05-02 18:18:14.207000 | 2022-11-30 06:23:44.663000; 2023-02-09 10:31:54.133000; 2023-02-09 10:31:55.997000 |
| `CreatedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Sione Alofaki; VNZ - Conor Murphy; VNZ - Mike VanEngelen |
| `AssignedUser` | string | VSM - Nick Perella | VNZ - John Hansen; VNZ - Conor Murphy |
| `Comments` | string | Site under construction; L-2022-0005267; L-2022-0005275 | This is a test inspection |
| `EntireLength` | string | Yes | Yes; No: |
| `ScheduledDate` | timestamp | No non-null example found | 2023-02-13 00:00:00; 2023-02-09 00:00:00; 2023-03-10 00:00:00 |
| `ScheduledDateFrom` | timestamp | No non-null example found | 2024-10-09 05:00:00 |
| `ScheduledDateTo` | timestamp | No non-null example found | 2024-10-16 13:30:00 |
| `CurrentStatus` | string | Running; Completed | Running; Scheduled; Completed |
| `CompletedDate` | timestamp | 2022-05-02 10:19:29.450000; 2022-05-03 04:45:36.713000; 2022-05-03 23:27:58.423000 | 2023-02-08 23:38:01.897000; 2023-03-21 21:27:51.570000; 2023-08-14 03:11:12.260000 |
| `CompletedUser` | string | VSM - Hans Cromhout; VSM - Phil Spragg; VSM - Brendan Lipple | VNZ - Conor Murphy; VNZ - John Hansen; VNZ - Tawhio Nehuaharawira |
| `JobID` | int | 38817; 38773; 38475 | 64694; 68395; 67611 |
| `CapitalWorkID` | int | No non-null example found | 289 |
| `InspectionRouteName` | string | No non-null example found | Johnny - Friday Weekly Route; Johnny - Tuesday Weekly Route |
| `InspectionGroupID` | int | 17022; 17023; 17024 | 34323; 45687; 45688 |
| `Reference1` | string | 700-03689-03-01-03-01-02 | 720-00502-03-02-01 |
| `Reference2` | string | No non-null example found | 000221241929; 000221238529; 000221312653 |
| `EstimatedDuration` | decimal(10,2) | 2.00 | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | <binary 249 bytes>; <binary 441 bytes>; <binary 217 bytes> |
| `InspectionID` | int | 123987 | 128513 |
| `ModuleID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | False | False |
| `WKT` | string | No non-null example found | MULTIPOLYGON (((174.543628122038 -36.8514294325812, 174.543638314408 -36.8514378098486, 174.543740964959 -36.8513571486182, 174...; MULTIPOLYGON (((174.543969838343 -36.8511371793853, 174.543965910106 -36.8511484623773, 174.544033265142 -36.8511636076173, 174...; MULTIPOLYGON (((174.542677615218 -36.8506935972838, 174.542691442127 -36.8506876202007, 174.542664580618 -36.8506474868925, 174... |

### `vinspectionstatus`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 244247; 244248; 244249 | 402186; 402195; 402196 |
| `DeltaUTC` | timestamp | 2022-06-17 04:05:28.930000; 2022-06-17 04:05:28.923000; 2022-06-17 04:05:28.933000 | 2022-11-21 21:03:15.970000; 2022-11-21 21:03:15.980000; 2022-11-21 21:03:15.987000 |
| `ModifiedUTC` | timestamp | 2022-05-02 04:42:50.660000; 2022-05-02 10:18:19.007000; 2022-05-02 10:19:54.980000 | 2022-11-21 20:40:45.470000; 2022-11-21 20:40:45.483000; 2022-11-21 20:40:45.493000 |
| `ModifiedUser` | string | VSM - Paul Cullen; VSM - Hans Cromhout; VSM - Ross Dobbie | VNZ - Shaun Alborough; VNZ - Sione Alofaki; VNZ - Conor Murphy |
| `InspectionID` | int | 35291; 35292; 35293 | 59887; 59889; 59891 |
| `Status` | string | Started; Completed; Location Updated | Started; Paused; Recommenced |
| `StatusDateUTC` | timestamp | 2022-05-02 04:42:25.003000; 2022-05-02 10:17:59.830000; 2022-05-02 10:19:28.787000 | 2022-11-21 20:37:34.773000; 2022-11-21 20:39:13.053000; 2022-11-21 20:40:31.727000 |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes> |
| `Deleted` | boolean | False | False |
| `WKT` | string | POINT (115.826666 -31.861213); POINT (115.8785753 -32.0874979); POINT (115.8785654 -32.0875066) | POINT (174.6266152 -36.8908301); POINT (174.7644751 -36.8575598); POINT (174.7643979 -36.8573734) |

### `vjob`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 38383; 38384; 38385 | 55014; 55015; 55016 |
| `DeltaUTC` | timestamp | 2024-07-05 06:52:49.357000; 2024-07-05 06:52:50.010000; 2024-07-05 06:52:49.353000 | 2024-07-05 06:45:01.043000; 2024-07-05 06:45:00.690000; 2024-07-05 06:45:24.357000 |
| `ModifiedUTC` | timestamp | 2022-05-17 04:57:36.930000; 2022-06-09 03:52:27.353000; 2022-06-02 03:40:43.290000 | 2022-12-02 02:27:29.700000; 2022-12-02 02:02:45.700000; 2024-01-27 08:47:32.917000 |
| `ModifiedUser` | string | VSM - Stuart Webb; VSM - Jarrod Holmes; VSM - Ross Dobbie | VNZ - Ventia NZ CPI Integration; VNZ - Adi Laisa Bolauga; VNZ - Gyanendra Sharma |
| `AssetID` | int | 68139; 68145; 68147 | 331435; 331862; 333425 |
| `AssetCode` | string | CCTV00070; CCTV00076; CCTV00078 | 13250; 13254; 13245 |
| `AssetName` | string | South St and Benningfield Rd (East Bound); Stock Rd and Leach Hwy (West Bound); Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound) | HETANA ST; STURGES RD; GREAT NORTH RD (WAITAKERE) |
| `Section` | string | No non-null example found | No non-null example found |
| `Contract` | string | VentureSmart | Auckland West Transport |
| `Region` | string | Western Australia | Auckland |
| `HazardDefectCode` | string | PMCC.PM; PMES.PM; PMHP.PM | 007.N; 030.3; EM |
| `HazardCode` | string | No non-null example found | EM |
| `ActivityCategoryCode` | string | CTV; VSS; HLP | 2; 4; 5 |
| `ActivityCategoryName` | string | Close Circuit Television; ESLS(VSS); Help Phone | Signs; Surface water channels; Drainage(Culverts) |
| `ActivityCode` | string | PMCC; PMES; PMHP | 007; 030; IMN |
| `ActivityName` | string | Preventative Maintenance | CC__Damaged; Faded Sign; Missing Sign - Replace |
| `InterventionID` | int | 7552; 7554; 7555 | 29082; 29107; 29086 |
| `InterventionCode` | string | PM | N; 3; 5 |
| `FullInterventionCode` | string | PMCC.PM; PMES.PM; PMHP.PM | 007.N; 030.3; 007.5 |
| `InterventionName` | string | Preventative Maintenance Activities (Planned Works) | Normal / Routine; P3 - Programmed Works - Must Do; P5 - Emergency Works |
| `InterventionReference1` | string | No non-null example found | No non-null example found |
| `InterventionReference2` | string | No non-null example found | No non-null example found |
| `CreatedDate` | timestamp | 2022-04-30 00:00:00 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `Direction` | string | No non-null example found | Forward |
| `ReferencePointName` | string | No non-null example found | Start Sections; End Sections |
| `EndReferencePointName` | string | No non-null example found | End Sections; Start Sections |
| `EstimatedDuration` | decimal(10,2) | 2.00 | 2.00 |
| `ChainageFrom` | int | No non-null example found | 86; 187; 16 |
| `ChainageTo` | int | No non-null example found | 692; 423; 107 |
| `BothDirections` | string | No non-null example found | No |
| `DistancePast` | int | No non-null example found | 86; 187; 16 |
| `EndDistancePast` | int | No non-null example found | 113; 423; 107 |
| `Unit` | string | Number | Each |
| `EstimatedQuantity` | decimal(10,3) | 1.000 | 0.000; 1.000; 161.000 |
| `Priority` | string | Medium | Low |
| `InspectionID` | int | No non-null example found | 88549 |
| `DueDate` | timestamp | 2022-05-09 00:00:00; 2022-05-27 00:00:00; 2022-05-16 00:00:00 | 2022-09-26 14:12:39; 2022-11-07 12:26:00; 2022-09-22 06:36:00 |
| `ScheduledStart` | timestamp | 2022-11-15 00:00:00 | 2024-08-28 00:00:00 |
| `ScheduledEnd` | timestamp | 2022-11-15 00:00:00 | 2023-03-01 00:00:00 |
| `CompletedDate` | timestamp | 2022-05-17 12:57:36.563000; 2022-06-09 11:52:21.177000; 2022-06-02 11:40:38.123000 | 2022-10-27 17:52:07; 2022-09-12 14:22:38; 2022-11-07 14:56:12 |
| `AssignedUser` | string | VSM - Stephen Walden; VSM - Ross Dobbie; VSM - Damon Vandenbergh | VNZ - Job Reviewer (VNZ); VNZ - Garth Birkett; VNZ - Shivnil Mani |
| `ApprovalDate` | timestamp | No non-null example found | No non-null example found |
| `ApprovalNumber` | string | No non-null example found | No non-null example found |
| `FutureWorks` | boolean | False | False |
| `EstimatedCost` | decimal(18,2) | No non-null example found | 45439.00 |
| `Area` | string | No non-null example found | No non-null example found |
| `AssignedDate` | timestamp | 2022-04-30 00:00:00; 2022-06-28 10:09:46.060000; 2022-06-02 22:30:32.413000 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `ActivityType` | string | Planned | Planned; Emergency; Reactive |
| `CompletedStatus` | string | Complete | Complete; No Action Required |
| `Reference1` | string | 700-03689-03-01-03-06-01; 700-03689-03-01-03-04-01; 700-03689-03-01-03-05-01 | 720-00502-03-04-06; 720-00502-03-03-06; 720-00502-03-04-05 |
| `Reference2` | string | 000129304628; 000129304498; 000129304645 | 000117610344; 000117609902; 000117610093 |
| `ReferencePointTypeName` | string | No non-null example found | Sections Start/End |
| `EndReferencePointTypeName` | string | No non-null example found | End Sections; Start Sections |
| `Compliant` | string | No; Yes | Yes; No |
| `Classification` | string | ITS | RMC 1 - Urban; RMC 1 - Rural; RMC 5 - Urban |
| `Comments` | string | No non-null example found | No non-null example found |
| `RemainingQuantity` | decimal(38,2) | 0.00; -0.50; -1.50 | 0.00; -1.00; -2.00 |
| `ActualQuantity` | decimal(38,2) | 1.00; 1.50; 2.50 | 1.00; 3.00; 2.00 |
| `CreatedUser` | string | VSM - Jarrod Holmes | VNZ - VNZ Support |
| `ApprovedUser` | string | No non-null example found | No non-null example found |
| `CompletedUser` | string | VSM - Stuart Webb; VSM - Jarrod Holmes; VSM - Ross Dobbie | VNZ - VNZ Support; VNZ - Adi Laisa Bolauga; VNZ - Gyanendra Sharma |
| `ExternalID` | string | No non-null example found | 1875; 478; 2262 |
| `AssetTypeName` | string | Close Circuit Television; ESLS(VSS); Help Phone | Sections |
| `InspectionTypeName` | string | No non-null example found | Auck RM Pack |
| `CurrentWorkflowItemCode` | string | COMP | REVD; COMP; INPL |
| `CurrentWorkflowItemName` | string | Complete | Reviewed; Complete; In Planning |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes>; <binary 128 bytes>; <binary 272 bytes> |
| `MergedJobID` | int | No non-null example found | 57503 |
| `LinkedJobID` | int | No non-null example found | 55449; 55093; 55135 |
| `CRMID` | string | No non-null example found | No non-null example found |
| `MadeSafe` | boolean | No non-null example found | False |
| `MadeSafeDateUTC` | timestamp | No non-null example found | No non-null example found |
| `ComplianceCalculationDate` | timestamp | 2022-04-30 00:00:00; 2022-06-28 10:09:46.060000; 2022-06-02 22:30:32.413000 | 2022-10-21 21:06:00; 2022-09-12 14:12:39; 2022-11-07 10:26:00 |
| `CRMDescription` | string | No non-null example found | No non-null example found |
| `CRMField1` | string | No non-null example found | No non-null example found |
| `CRMField2` | string | No non-null example found | No non-null example found |
| `CRMField3` | string | No non-null example found | No non-null example found |
| `CRMField4` | string | No non-null example found | No non-null example found |
| `CRMField5` | int | No non-null example found | No non-null example found |
| `CRMField6` | timestamp | No non-null example found | No non-null example found |
| `EstimatedLength` | decimal(10,3) | 0.000 | 0.000 |
| `EstimatedWidth` | decimal(10,3) | 0.000 | 0.000 |
| `EstimatedDepth` | decimal(10,3) | 0.000 | 0.000 |
| `Deleted` | boolean | False | False |
| `WKT` | string | POINT (115.85883 -32.06594); POINT (115.79338 -32.04932); POINT (115.97422 -32.00317) | POINT (174.686362707061 -36.9095448879393); POINT (174.609020104407 -36.8869797205536); POINT (174.689719144146 -36.9029196355385) |

### `vmodule`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | No non-null example found | 60848; 62180; 62181 |
| `DeltaUTC` | timestamp | No non-null example found | 2025-11-05 00:14:03.343000; 2025-11-05 00:14:03.350000; 2025-11-05 00:14:03.353000 |
| `ModifiedUTC` | timestamp | No non-null example found | 2023-03-13 19:11:04; 2022-12-02 02:40:10.420000; 2022-12-02 02:41:17.817000 |
| `ModifiedUser` | string | No non-null example found | VNZ - Alireza Sharif; VNZ - Anna Covell; VNZ - Karan Sivakumaran |
| `Contract` | string | No non-null example found | Auckland West Transport |
| `Region` | string | No non-null example found | Auckland West Transport |
| `CompletedDate` | timestamp | No non-null example found | 2022-11-28 02:29:54.067000; 2022-12-10 08:54:00; 2022-10-13 08:59:00 |
| `ModuleName` | string | No non-null example found | Auck Renewal Pack; Customer Request; Auck RM Pack |
| `Name` | string | No non-null example found | Tapou Street Renewals; test 1; test 2 |
| `CreatedDate` | timestamp | No non-null example found | 2022-11-22 13:00:05.660000; 2022-12-02 12:39:02.227000; 2022-12-02 12:40:16.763000 |
| `CreatedUser` | string | No non-null example found | VNZ - Shaun Alborough; VNZ - Anna Covell; VNZ - Karan Sivakumaran |
| `AssignedUser` | string | No non-null example found | VNZ - Garth Birkett; VNZ - Karan Sivakumaran; VNZ - Laura Stokes |
| `Comments` | string | No non-null example found | test 2; jobs sent through from AT site observations following the storm. |
| `AssetID` | int | No non-null example found | No non-null example found |
| `AssetCode` | string | No non-null example found | No non-null example found |
| `AssetName` | string | No non-null example found | No non-null example found |
| `EntireLength` | string | No non-null example found | No: |
| `Direction` | varchar(50) | No non-null example found | Forward |
| `StartPointName` | string | No non-null example found | No non-null example found |
| `ChainageFrom` | int | No non-null example found | No non-null example found |
| `StartDistancePast` | int | No non-null example found | No non-null example found |
| `EndPointName` | string | No non-null example found | No non-null example found |
| `ChainageTo` | int | No non-null example found | No non-null example found |
| `EndDistancePast` | int | No non-null example found | No non-null example found |
| `SpatialInfo` | binary | No non-null example found | No non-null example found |
| `ParentSourceTableName` | string | No non-null example found | No non-null example found |
| `ParentSourceTableID` | int | No non-null example found | No non-null example found |
| `Deleted` | boolean | No non-null example found | False |
| `WKT` | string | No non-null example found | No non-null example found |

### `vworkflowstatus`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `RecordID` | int | 20251; 20261; 9 | 52137; 52164; 52165 |
| `DeltaUTC` | timestamp | 2024-02-29 23:17:30.963000; 2024-02-29 23:17:28.717000; 2024-02-29 23:17:32.973000 | 2024-02-29 23:07:30.477000; 2024-02-29 23:07:30.480000; 2024-02-29 23:07:30.490000 |
| `ModifiedUTC` | timestamp | 2022-05-25 02:09:07.017000; 2022-05-25 02:22:55.327000; 2022-04-03 01:49:37.767000 | 2022-11-18 01:37:26.470000; 2022-11-18 03:56:06.587000; 2022-11-18 03:56:46.210000 |
| `ModifiedUser` | string | VSM - Ross Dobbie; VSM - Brendan Lipple; VSM - VSM Support | VNZ - Shaun Alborough; VNZ - Pranav Kumar; VNZ - John Hansen |
| `WorkflowItemCode` | string | COMP; INPL; REVD | INPL; PLND; DISP |
| `WorkflowItemName` | string | Complete; In Planning; Reviewed | In Planning; Planned; Dispatched |
| `SourceTable` | string | Job | Job |
| `SourceTableID` | int | 38618; 38981; 36601 | 57181; 57188; 57189 |
| `StatusDate` | timestamp | 2022-05-25 10:08:57.257000; 2022-05-24 14:40:53.517000; 2022-04-03 11:48:04.793000 | 2022-11-18 12:33:56.697000; 2022-11-18 14:54:12.787000; 2022-11-18 14:56:42.397000 |
| `Comment` | string | No non-null example found | Updating dispatch |
| `Reason` | string | No non-null example found | Manager Request |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes> |
| `Deleted` | boolean | False | False |
| `WKT` | string | POINT (115.9509132 -32.0430883); POINT (115.8505432 -31.944495); POINT (115.6688964 -33.3466903) | POINT (174.6464803 -36.8416402) |

### `workflowstatus`

| Column | Type | VSM examples | VNZ examples |
|---|---|---|---|
| `ID` | int | 1; 2; 3 | 1; 2; 3 |
| `RecordID` | int | 20251; 20261; 9 | 52137; 52164; 52165 |
| `DeltaUTC` | timestamp | 2024-02-29 23:17:30.963000; 2024-02-29 23:17:28.717000; 2024-02-29 23:17:32.973000 | 2024-02-29 23:07:30.477000; 2024-02-29 23:07:30.480000; 2024-02-29 23:07:30.490000 |
| `ModifiedUTC` | timestamp | 2022-05-25 02:09:07.017000; 2022-05-25 02:22:55.327000; 2022-04-03 01:49:37.767000 | 2022-11-18 01:37:26.470000; 2022-11-18 03:56:06.587000; 2022-11-18 03:56:46.210000 |
| `ModifiedUser` | string | VSM - Ross Dobbie; VSM - Brendan Lipple; VSM - VSM Support | VNZ - Shaun Alborough; VNZ - Pranav Kumar; VNZ - John Hansen |
| `WorkflowItemCode` | string | COMP; INPL; REVD | INPL; PLND; DISP |
| `WorkflowItemName` | string | Complete; In Planning; Reviewed | In Planning; Planned; Dispatched |
| `SourceTable` | string | Job | Job |
| `SourceTableID` | int | 38618; 38981; 36601 | 57181; 57188; 57189 |
| `StatusDate` | timestamp | 2022-05-25 10:08:57.257000; 2022-05-24 14:40:53.517000; 2022-04-03 11:48:04.793000 | 2022-11-18 12:33:56.697000; 2022-11-18 14:54:12.787000; 2022-11-18 14:56:42.397000 |
| `Comment` | string | No non-null example found | Updating dispatch |
| `Reason` | string | No non-null example found | Manager Request |
| `SpatialInfo` | binary | <binary 22 bytes> | <binary 22 bytes> |
| `Deleted` | boolean | False | False |

## Data Caveats and Open Questions

- `WKT` is available on view tables, not most base tables.
- `SpatialInfo` is binary and not decoded in the current notebook.
- `AssetCriticality` exists on `asset`; operational risk is mainly in `job` and
  `vjob`.
- Some tables contain both row IDs and source-system IDs, such as `ID` and
  `InspectionID`. Validate the correct join key before using them.
- `SourceTable` and `SourceTableID` joins need source-table values from real
  rows before they can be made robust.
- `Deleted` is nullable. Use `coalesce(Deleted, false) = false` for active-row
  filtering where supported.
- Current `asset_vision_vnz_gen7` documentation shows `summarycheck` with zero
  supplied columns, while `asset_vision_vsm_gen7` shows eight columns. Refresh
  VNZ metadata if `summarycheck` matters.

