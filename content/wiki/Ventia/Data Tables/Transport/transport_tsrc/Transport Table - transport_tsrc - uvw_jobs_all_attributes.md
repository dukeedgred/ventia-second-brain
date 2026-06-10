---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_jobs_all_attributes
full-name: transport_dev.transport_tsrc.uvw_jobs_all_attributes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_jobs_all_attributes

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_jobs_all_attributes` |
| Full name | `transport_dev.transport_tsrc.uvw_jobs_all_attributes` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 127 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-08-27T23:03:45.356Z; Last altered: 2024-10-22T03:46:29.841Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH jobspivot as (
              select
                j.*,
                vj.WKT,
                f.name,
                f.value
              from
                  ext_mssql_asset_vision_ven_gen7.dbo.job J
                    left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f on j.id = f.sourcetableid
                    inner join ext_mssql_asset_vision_ven_gen7.dbo.vjob vj on j.id = vj.id
              where
  j.contract = 'Toowoomba Second Range Crossing'
  and j.deleted = false
  and f.deleted = false
  and f.datatype <> 'Label'
  and f.sourcetable = 'Job'
            )
            Select
              *
            from
              jobspivot pivot (
                max(value) FOR name in (
                  'Job Compliance|KPI 25 Compliant' as `JobCompliance-KPI25Compliant`,
'Job Compliance|KPI Compliance Comment' as `JobCompliance-KPIComplianceComment`,
'Job Details|Additional Defect Details' as `JobDetails-AdditionalDefectDetails`,
'Job Details|Additional Location Details' as `JobDetails-AdditionalLocationDetails`,
'Job Details|Additional Repair Details' as `JobDetails-AdditionalRepairDetails`,
'Job Details|Intervention Criteria' as `JobDetails-InterventionCriteria`,
'Job Details|Location Confirmation' as `JobDetails-LocationConfirmation`,
'Job Details|Measurement Criteria' as `JobDetails-MeasurementCriteria`,
'Job Details|Missing Asset' as `JobDetails-MissingAsset`,
'Job Details|Work Order Type' as `JobDetails-WorkOrderType`,
'Job Start Checklist|Hot Works Permit' as `JobStartChecklist-HotWorksPermit`,
'Job Start Checklist|Plant Prestart' as `JobStartChecklist-PlantPrestart`,
'Job Start Checklist|Start Card' as `JobStartChecklist-StartCard`,
'Job Start Checklist|Vehicle Movement Plan' as `JobStartChecklist-VehicleMovementPlan`,
'Job Start Checklist|Working at Heights Permit' as `JobStartChecklist-WorkingatHeightsPermit`,
'Maintenance Jobs Information|Additional Defect Details' as `JobsInfo-AdditionalDefectDetails`,
'Maintenance Jobs Information|Additional Location Details' as `JobsInfo-AdditionalLocationDetails`,
'Maintenance Jobs Information|Additional Repair Details' as `JobsInfo-AdditionalRepairDetails`,
'Maintenance Jobs Information|Assets|Asset Comment' as `JobsInfo-AssetComment`,
'Maintenance Jobs Information|Assets|Asset in wrong location' as `JobsInfo-Assetinwronglocation`,
'Maintenance Jobs Information|Assets|Asset not in field' as `JobsInfo-Assetnotinfield`,
'Maintenance Jobs Information|Assets|Missing Asset' as `JobsInfo-Assets-MissingAsset`,
'Maintenance Jobs Information|Assets|Wrong asset type' as `JobsInfo-Wrongassettype`,
'Maintenance Jobs Information|Find and Fix - Corrective and Preventative Works' as `JobsInfo-FindandFix`,
'Maintenance Jobs Information|Location Confirmation' as `JobsInfo-LocationConfirmation`,
'Maintenance Jobs Information|Location Select' as `JobsInfo-LocationSelect`,
'Maintenance Jobs Information|Missing Asset' as `JobsInfo-MissingAsset`,
'Maintenance Jobs Information|Night Works' as `JobsInfo-NightWorks`,
'Maintenance Jobs Information|Required Plant' as `JobsInfo-RequiredPlant`,
'Maintenance Jobs Information|Traffic Control Required' as `JobsInfo-TrafficControlRequired`,
'Maintenance Jobs Information|Work Order Type' as `JobsInfo-WorkOrderType`,
'QA Review|Conducting QA review' as `QAReview-ConductingQAreview`,
'QA Review|Did Job Result in ITS asset to be down?' as `QAReview-DidJobResultinITSassettobedown`,
'QA Review|Job Start Form Checklist|Hot Works Permit Attached' as `QAReview-HotWorksPermitAttached`,
'QA Review|Job Start Form Checklist|Job Start Form Section has been completed' as `QAReview-JobStartFormSectionhasbeencompleted`,
'QA Review|Job Start Form Checklist|Plant Prestart Attached' as `QAReview-PlantPrestartAttached`,
'QA Review|Job Start Form Checklist|Start Card Attached' as `QAReview-StartCardAttached`,
'QA Review|Job Start Form Checklist|Vehicle Movement Plan Attached' as `QAReview-VehicleMovementPlanAttached`,
'QA Review|Job Start Form Checklist|Working at Heights Permit Attached' as `QAReview-WorkingatHeightsPermitAttached`,
'QA Review|KPI 25 Compliant' as `QAReview-KPI25Compliant`,
'QA Review|KPI Compliance Comment' as `QAReview-KPIComplianceComment`,
'QA Review|Photos|After Photo of the Defect (min of 1)' as `QAReview-AfterPhotooftheDefect`,
'QA Review|Photos|Before Photo of the Defect (min of 1)' as `QAReview-BeforePhotooftheDefect`,
'QA Review|Timesheet attached and populated (min of 1)' as `QAReview-Timesheetattachedandpopulated`,
'QA Review|Total Hours Down (Decimal hours e.g. 1.25 for 1hr 15 min downtime)' as `QAReview-TotalHoursDown`
))
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `HazardDefectCode` | `string` | Yes |  |
| `HazardCode` | `string` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategoryName` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `InterventionID` | `int` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `FullInterventionCode` | `string` | Yes |  |
| `InterventionName` | `string` | Yes |  |
| `InterventionReference1` | `string` | Yes |  |
| `InterventionReference2` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ReferencePointName` | `string` | Yes |  |
| `EndReferencePointName` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `DistancePast` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `Unit` | `string` | Yes |  |
| `EstimatedQuantity` | `decimal(10,3)` | Yes |  |
| `Priority` | `string` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `DueDate` | `timestamp` | Yes |  |
| `ScheduledStart` | `timestamp` | Yes |  |
| `ScheduledEnd` | `timestamp` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `ApprovalDate` | `timestamp` | Yes |  |
| `ApprovalNumber` | `string` | Yes |  |
| `FutureWorks` | `boolean` | Yes |  |
| `EstimatedCost` | `decimal(18,2)` | Yes |  |
| `Area` | `string` | Yes |  |
| `AssignedDate` | `timestamp` | Yes |  |
| `ActivityType` | `string` | Yes |  |
| `CompletedStatus` | `string` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `ReferencePointTypeName` | `string` | Yes |  |
| `EndReferencePointTypeName` | `string` | Yes |  |
| `Compliant` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `RemainingQuantity` | `decimal(38,2)` | Yes |  |
| `ActualQuantity` | `decimal(38,2)` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `ApprovedUser` | `string` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `ExternalID` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `CurrentWorkflowItemCode` | `string` | Yes |  |
| `CurrentWorkflowItemName` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `MergedJobID` | `int` | Yes |  |
| `LinkedJobID` | `int` | Yes |  |
| `CRMID` | `string` | Yes |  |
| `MadeSafe` | `boolean` | Yes |  |
| `MadeSafeDateUTC` | `timestamp` | Yes |  |
| `ComplianceCalculationDate` | `timestamp` | Yes |  |
| `CRMDescription` | `string` | Yes |  |
| `CRMField1` | `string` | Yes |  |
| `CRMField2` | `string` | Yes |  |
| `CRMField3` | `string` | Yes |  |
| `CRMField4` | `string` | Yes |  |
| `CRMField5` | `int` | Yes |  |
| `CRMField6` | `timestamp` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |
| `JobCompliance-KPI25Compliant` | `string` | Yes |  |
| `JobCompliance-KPIComplianceComment` | `string` | Yes |  |
| `JobDetails-AdditionalDefectDetails` | `string` | Yes |  |
| `JobDetails-AdditionalLocationDetails` | `string` | Yes |  |
| `JobDetails-AdditionalRepairDetails` | `string` | Yes |  |
| `JobDetails-InterventionCriteria` | `string` | Yes |  |
| `JobDetails-LocationConfirmation` | `string` | Yes |  |
| `JobDetails-MeasurementCriteria` | `string` | Yes |  |
| `JobDetails-MissingAsset` | `string` | Yes |  |
| `JobDetails-WorkOrderType` | `string` | Yes |  |
| `JobStartChecklist-HotWorksPermit` | `string` | Yes |  |
| `JobStartChecklist-PlantPrestart` | `string` | Yes |  |
| `JobStartChecklist-StartCard` | `string` | Yes |  |
| `JobStartChecklist-VehicleMovementPlan` | `string` | Yes |  |
| `JobStartChecklist-WorkingatHeightsPermit` | `string` | Yes |  |
| `JobsInfo-AdditionalDefectDetails` | `string` | Yes |  |
| `JobsInfo-AdditionalLocationDetails` | `string` | Yes |  |
| `JobsInfo-AdditionalRepairDetails` | `string` | Yes |  |
| `JobsInfo-AssetComment` | `string` | Yes |  |
| `JobsInfo-Assetinwronglocation` | `string` | Yes |  |
| `JobsInfo-Assetnotinfield` | `string` | Yes |  |
| `JobsInfo-Assets-MissingAsset` | `string` | Yes |  |
| `JobsInfo-Wrongassettype` | `string` | Yes |  |
| `JobsInfo-FindandFix` | `string` | Yes |  |
| `JobsInfo-LocationConfirmation` | `string` | Yes |  |
| `JobsInfo-LocationSelect` | `string` | Yes |  |
| `JobsInfo-MissingAsset` | `string` | Yes |  |
| `JobsInfo-NightWorks` | `string` | Yes |  |
| `JobsInfo-RequiredPlant` | `string` | Yes |  |
| `JobsInfo-TrafficControlRequired` | `string` | Yes |  |
| `JobsInfo-WorkOrderType` | `string` | Yes |  |
| `QAReview-ConductingQAreview` | `string` | Yes |  |
| `QAReview-DidJobResultinITSassettobedown` | `string` | Yes |  |
| `QAReview-HotWorksPermitAttached` | `string` | Yes |  |
| `QAReview-JobStartFormSectionhasbeencompleted` | `string` | Yes |  |
| `QAReview-PlantPrestartAttached` | `string` | Yes |  |
| `QAReview-StartCardAttached` | `string` | Yes |  |
| `QAReview-VehicleMovementPlanAttached` | `string` | Yes |  |
| `QAReview-WorkingatHeightsPermitAttached` | `string` | Yes |  |
| `QAReview-KPI25Compliant` | `string` | Yes |  |
| `QAReview-KPIComplianceComment` | `string` | Yes |  |
| `QAReview-AfterPhotooftheDefect` | `string` | Yes |  |
| `QAReview-BeforePhotooftheDefect` | `string` | Yes |  |
| `QAReview-Timesheetattachedandpopulated` | `string` | Yes |  |
| `QAReview-TotalHoursDown` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
