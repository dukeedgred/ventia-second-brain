---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_kpi2_road_safety
full-name: transport_dev.transport_tsrc.utbl_kpi2_road_safety
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_kpi2_road_safety

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_kpi2_road_safety` |
| Full name | `transport_dev.transport_tsrc.utbl_kpi2_road_safety` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 127 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_admins |
| Refresh/freshness | Created: 2024-07-22T01:57:10.126Z; Last altered: 2026-06-09T05:40:05.426Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `modulename` | `string` | Yes |  |
| `incidentdescription` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `direction` | `varchar(50)` | Yes |  |
| `startpointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endpointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `spatialinfo` | `binary` | Yes |  |
| `parentsourcetablename` | `string` | Yes |  |
| `parentsourcetableid` | `int` | Yes |  |
| `Details-AbatementSection` | `string` | Yes |  |
| `Rectification-ActionTaken` | `string` | Yes |  |
| `Overview-KPI4ActualMinutes` | `string` | Yes |  |
| `Overview-KPI5ActualMinutes` | `string` | Yes |  |
| `Overview-KPI6ActualMinutes` | `string` | Yes |  |
| `Overview-AbatementExemption` | `string` | Yes |  |
| `Details-AdditionalLocationdetails` | `string` | Yes |  |
| `Rectification-AEDExternalID` | `string` | Yes |  |
| `Details-AnimalConditional` | `string` | Yes |  |
| `Travel-ArrivalOnSiteTime` | `string` | Yes |  |
| `Overview-Brief` | `string` | Yes |  |
| `Details-Chainage` | `string` | Yes |  |
| `Overview-Chainage` | `string` | Yes |  |
| `Rectification-Comment` | `string` | Yes |  |
| `Travel-Comment` | `string` | Yes |  |
| `Rectification-CompletionCode` | `string` | Yes |  |
| `Details-Damagebrief` | `string` | Yes |  |
| `Initiation-DetectedBy` | `string` | Yes |  |
| `Initiation-DetectedTime2` | `string` | Yes |  |
| `Initiation-DetectedTime` | `string` | Yes |  |
| `Initiation-Detection` | `string` | Yes |  |
| `Initiation-DetectionMethod` | `string` | Yes |  |
| `Overview-DetectionMethod` | `string` | Yes |  |
| `Initiation-DetectionReference` | `string` | Yes |  |
| `Overview-DidanAbatementOccur` | `string` | Yes |  |
| `Details-Direction` | `string` | Yes |  |
| `Details-Emergencyservicesonsite` | `string` | Yes |  |
| `Rectification-EndTime` | `string` | Yes |  |
| `Details-HazardType` | `string` | Yes |  |
| `Overview-Impact` | `string` | Yes |  |
| `Initiation-Incident` | `string` | Yes |  |
| `Initiation-IncidentDescription` | `string` | Yes |  |
| `Details-IncidentDetails` | `string` | Yes |  |
| `Details-IncidentType` | `string` | Yes |  |
| `Initiation-InitialAction` | `string` | Yes |  |
| `Overview-InitialAction` | `string` | Yes |  |
| `Initiation-Initiatedby` | `string` | Yes |  |
| `Initiation-InitiatedDate` | `string` | Yes |  |
| `Initiation-InitiatedDate2` | `string` | Yes |  |
| `Initiation-Initiation` | `string` | Yes |  |
| `Initiation-IRCNotified` | `string` | Yes |  |
| `Initiation-IRcrewnotifiedvia` | `string` | Yes |  |
| `Overview-IRP` | `string` | Yes |  |
| `Overview-KPIs` | `string` | Yes |  |
| `Details-LanesAffected` | `string` | Yes |  |
| `Rectification-LightCondition` | `string` | Yes |  |
| `Details-Location` | `string` | Yes |  |
| `Details-Motorwayassetdamage` | `string` | Yes |  |
| `Overview-Occurredat` | `string` | Yes |  |
| `Occurrence-OccurrenceDateandTime` | `string` | Yes |  |
| `Details-PoliceReference` | `string` | Yes |  |
| `Details-PoliceReferenceDate` | `string` | Yes |  |
| `Details-PoliceReferenceRecievedDate` | `string` | Yes |  |
| `Details-RampAffected` | `string` | Yes |  |
| `Rectification-ReportedBy` | `string` | Yes |  |
| `Rectification-ReportedtoTCCO` | `string` | Yes |  |
| `Rectification-RoadSurface` | `string` | Yes |  |
| `Overview-Section` | `string` | Yes |  |
| `Overview-KPI4SetpointMinutes` | `string` | Yes |  |
| `Overview-KPI5SetpointMinutes` | `string` | Yes |  |
| `Overview-KPI6SetpointMinutes` | `string` | Yes |  |
| `Overview-Severity` | `string` | Yes |  |
| `Travel-StartLocation` | `string` | Yes |  |
| `Travel-StartTime` | `string` | Yes |  |
| `Overview-Status` | `string` | Yes |  |
| `Overview-Subsection` | `string` | Yes |  |
| `Details-SubsectionLocation` | `string` | Yes |  |
| `Details-TowingArrangement` | `string` | Yes |  |
| `Details-TowingCompany` | `string` | Yes |  |
| `Details-TowingRequired` | `string` | Yes |  |
| `Details-TowType` | `string` | Yes |  |
| `Travel-TrafficCondition` | `string` | Yes |  |
| `Travel-TrafficConditionReportedDate` | `string` | Yes |  |
| `Travel-TravelDetails` | `string` | Yes |  |
| `Overview-Type` | `string` | Yes |  |
| `Travel-Vehicle` | `string` | Yes |  |
| `Travel-VehicleDetails` | `string` | Yes |  |
| `Rectification-WeatherCondition` | `string` | Yes |  |
| `Details-Whattypeofanimal` | `string` | Yes |  |
| `EmergencyservicesonsiteDerived` | `string` | Yes |  |
| `CompletionCodeDerived` | `string` | Yes |  |
| `ChainageDerived` | `string` | Yes |  |
| `DetectedDateTime` | `timestamp` | Yes |  |
| `InitiatedDateTime` | `timestamp` | Yes |  |
| `ModuleItemStatus` | `string` | Yes |  |
| `IncidentStatus` | `string` | Yes |  |
| `AVDirection` | `string` | Yes |  |
| `Chainage_KM` | `decimal(13,0)` | Yes |  |
| `SectionID` | `int` | Yes |  |
| `id_link` | `string` | Yes |  |
| `IncidentClosureDetails-TGS` | `string` | Yes |  |
| `IncidentClosureDetails-ClosurePurpose` | `string` | Yes |  |
| `IncidentClosureDetails-ClosureType` | `string` | Yes |  |
| `IncidentClosureDetails-Section` | `string` | Yes |  |
| `IncidentClosureDetails-Appliedby` | `string` | Yes |  |
| `Key` | `string` | Yes |  |
| `IncidentGroup` | `string` | Yes |  |
| `OccurrenceDateandTimeDerived` | `timestamp` | Yes |  |
| `OccurrenceDateandTime` | `timestamp` | Yes |  |
| `InKPI2` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
