---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_customer_requests
full-name: transport_dev.transport_tsrc.uvw_customer_requests
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_customer_requests

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_customer_requests` |
| Full name | `transport_dev.transport_tsrc.uvw_customer_requests` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 88 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T01:35:34.422Z; Last altered: 2024-07-18T22:24:41.541Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  with custreqpivot as (
    select
      m.id,
      m.deltautc,
      m.modifiedutc,
      m.contract,
      m.region,
      m.completeddate,
      m.modulename,
      m.name as custrequestname,
      m.createddate,
      m.createduser,
      m.assigneduser,
      m.comments,
      m.assetid,
      m.assetcode,
      m.assetname,
      m.entirelength,
      m.direction,
      m.startpointname,
      m.chainagefrom,
      m.startdistancepast,
      m.endpointname,
      m.chainageto,
      m.enddistancepast,
      m.deleted,
      m.spatialinfo,
      m.parentsourcetablename,
      m.parentsourcetableid,
      f.name,  --- Name of field you see in the custom module forms
      f.value  --- Value of the form field
    from
      ext_mssql_asset_vision_ven_gen7.dbo.formfield f
      inner join ext_mssql_asset_vision_ven_gen7.dbo.module m on f.sourcetableid = m.id
    where
      f.deleted = false
      and m.deleted = false
      and m.contract = 'Toowoomba Second Range Crossing'
      and m.modulename = 'Customer Requests'
      and f.datatype <> 'Label'
  )

  ---- Pivot the form fields into Columns
  SELECT
    *,
    to_timestamp(`EventType-DateReceived_Text`, 'd/M/yyyy H:m:s') AS `EventType-DateReceived`,
    to_timestamp(`CustInfoEnqDetails-DateEventOccured_text`, 'd/M/yyyy H:m:s') AS `CustInfoEnqDetails-DateEventOccured`,
    to_timestamp(`CustInfoEnqDetails-ResponseDate_text`, 'd/M/yyyy H:m:s') AS `CustInfoEnqDetails-ResponseDate`,
    to_timestamp(`CloseOutDetails-NoiseLevelAssessmentDate_text`, 'd/M/yyyy H:m:s') AS `CloseOutDetails-NoiseLevelAssessmentDate`,
    to_timestamp(`CloseOutDetails-AgreedRectDueDate_text`, 'd/M/yyyy H:m:s') AS `CloseOutDetails-AgreedRectDueDate`,
    to_timestamp(`CloseOutDetails-MediaReqRespDueDate_text`, 'd/M/yyyy H:m:s') AS `CloseOutDetails-MediaReqRespDueDate`,
    to_timestamp(`CloseOutDetails-CloseOut/ResolutionDate_text`, 'd/M/yyyy H:m:s') AS `CloseOutDetails-CloseOut/ResolutionDate`

  FROM
    custreqpivot pivot (
      max(value) for name in (
        'ClientDetails|Details' as `ClientDetails-Details`,
        'ClientDetails|EnvironmentalSuitability' as `ClientDetails-EnvironSuitability`,
        'ClientDetails|SPARKSID' as `ClientDetails-SPARKSID`,

        ---- Event Type Fields ----
        'Event Type|Date Received' as `EventType-DateReceived_Text`,
        'Event Type|Event Classification' as `EventType-EventClassification`,
        'Event Type|Event Type' as `EventType-EventType`,

        ---- Customer Information and Enquiry Details Fields ----
        'Customer Information and Enquiry Details|Contact Name' as `CustInfoEnqDetails-ContactName`,
        'Customer Information and Enquiry Details|Contact Number' as `CustInfoEnqDetails-ContactNumber`,
        'Customer Information and Enquiry Details|Contact Email' as `CustInfoEnqDetails-ContactEmail`,
        'Customer Information and Enquiry Details|Contact Address' as `CustInfoEnqDetails-ContactAddress`,
        'Customer Information and Enquiry Details|Stakeholder Type' as `CustInfoEnqDetails-StakeholderType`,
        'Customer Information and Enquiry Details|Business Name (if applicable)' as `CustInfoEnqDetails-BusinessName`,
        'Customer Information and Enquiry Details|Date Event Occured' as `CustInfoEnqDetails-DateEventOccured_text`,
        'Customer Information and Enquiry Details|Topic' as `CustInfoEnqDetails-Topic`,
        'Customer Information and Enquiry Details|Response Date' as `CustInfoEnqDetails-ResponseDate_text`,
        'Customer Information and Enquiry Details|Event Street Address' as `CustInfoEnqDetails-EventStreetAddress`,
        'Customer Information and Enquiry Details|Geographic Coord' as `CustInfoEnqDetails-GeographicCoord`,

        --- Close Out Details Fields
        'Close Out Details|Status' as `CloseOutDetails-Status`,
        'Close Out Details|Project Co and State Notified?' as `CloseOutDetails-ProjectCoandStateNotified`,
        'Close Out Details|Noise Level Assessment Conducted and attached to "Documents"?' as `CloseOutDetails-NoiseLevelAssessmentAttached`,
        'Close Out Details|Noise Level Assessment Date' as `CloseOutDetails-NoiseLevelAssessmentDate_text`,
        'Close Out Details|Rectifications Required from Assessment?' as `CloseOutDetails-RectReqfromAssessment`,
        'Close Out Details|Description of Noise Rectification Works' as `CloseOutDetails-DescNoiseRectWorks`,
        'Close Out Details|Agreed Rectification Due Date' as `CloseOutDetails-AgreedRectDueDate_text`,
        'Close Out Details|Media Request Response Due Date' as `CloseOutDetails-MediaReqRespDueDate_text`,
        'Close Out Details|Request Urgency' as `CloseOutDetails-RequestUrgency`,
        'Close Out Details|Resolution Commentary' as `CloseOutDetails-ResolutionCommentary`,
        'Close Out Details|Close Out / Resolution Date' as `CloseOutDetails-CloseOut/ResolutionDate_text`,

        ----- OLD FORM FIELDS
        'Event|BusinessName(ifapplicable)' as `Event-BusinessName`,
        'Event|Close_Out_Date/Time' as `Event-Close_Out_Date/Time`,
        'Event|ContactAddress' as `Event-ContactAddress`,
        'Event|ContactEmail' as `Event-ContactEmail`,
        'Event|ContactName' as `Event-ContactName`,
        'Event|ContactNumber' as `Event-ContactNumber`,
        'Event|Contact_Address' as `Event-Contact_Address`,
        'Event|Contact_Email' as `Event-Contact_Email`,
        'Event|Contact_Name' as `Event-Contact_Name`,
        'Event|Contact_Number' as `Event-Contact_Number`,
        'Event|Date/Time_Acknowledged' as `Event-Date/Time_Acknowledged`,
        'Event|Date/Time_Received' as `Event-Date/Time_Received`,
        'Event|Date/Time_Resolved' as `Event-Date/Time_Resolved`,
        'Event|Date_Event_Occured' as `Event-Date_Event_Occured`,
        'Event|EventClassification' as `Event-EventClassification`,
        'Event|EventType' as `Event-EventType`,
        'Event|Event_Street_Address' as `Event-Event_Street_Address`,
        'Event|Geographic_Coord' as `Event-Geographic_Coord`,
        'Event|NotApplicable' as `Event-NotApplicable`,
        'Event|ResolutionCommentary' as `Event-ResolutionCommentary`,
        'Event|Resolution_Type' as `Event-Resolution_Type`,
        'Event|StakeholderType' as `Event-StakeholderType`,
        'Event|Topic' as `Event-Topic`,
        'SchedulingDetails|DueDate' as `SchedulingDetails-DueDate`,
        'SchedulingDetails|EarliestStartDate' as `SchedulingDetails-EarliestStartDate`,
        'SchedulingDetails|ScheduledDate' as `SchedulingDetails-ScheduledDate`
      )
    )
)
```

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
| `custrequestname` | `string` | Yes |  |
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
| `ClientDetails-Details` | `string` | Yes |  |
| `ClientDetails-EnvironSuitability` | `string` | Yes |  |
| `ClientDetails-SPARKSID` | `string` | Yes |  |
| `EventType-DateReceived_Text` | `string` | Yes |  |
| `EventType-EventClassification` | `string` | Yes |  |
| `EventType-EventType` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactName` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactNumber` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactEmail` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactAddress` | `string` | Yes |  |
| `CustInfoEnqDetails-StakeholderType` | `string` | Yes |  |
| `CustInfoEnqDetails-BusinessName` | `string` | Yes |  |
| `CustInfoEnqDetails-DateEventOccured_text` | `string` | Yes |  |
| `CustInfoEnqDetails-Topic` | `string` | Yes |  |
| `CustInfoEnqDetails-ResponseDate_text` | `string` | Yes |  |
| `CustInfoEnqDetails-EventStreetAddress` | `string` | Yes |  |
| `CustInfoEnqDetails-GeographicCoord` | `string` | Yes |  |
| `CloseOutDetails-Status` | `string` | Yes |  |
| `CloseOutDetails-ProjectCoandStateNotified` | `string` | Yes |  |
| `CloseOutDetails-NoiseLevelAssessmentAttached` | `string` | Yes |  |
| `CloseOutDetails-NoiseLevelAssessmentDate_text` | `string` | Yes |  |
| `CloseOutDetails-RectReqfromAssessment` | `string` | Yes |  |
| `CloseOutDetails-DescNoiseRectWorks` | `string` | Yes |  |
| `CloseOutDetails-AgreedRectDueDate_text` | `string` | Yes |  |
| `CloseOutDetails-MediaReqRespDueDate_text` | `string` | Yes |  |
| `CloseOutDetails-RequestUrgency` | `string` | Yes |  |
| `CloseOutDetails-ResolutionCommentary` | `string` | Yes |  |
| `CloseOutDetails-CloseOut/ResolutionDate_text` | `string` | Yes |  |
| `Event-BusinessName` | `string` | Yes |  |
| `Event-Close_Out_Date/Time` | `string` | Yes |  |
| `Event-ContactAddress` | `string` | Yes |  |
| `Event-ContactEmail` | `string` | Yes |  |
| `Event-ContactName` | `string` | Yes |  |
| `Event-ContactNumber` | `string` | Yes |  |
| `Event-Contact_Address` | `string` | Yes |  |
| `Event-Contact_Email` | `string` | Yes |  |
| `Event-Contact_Name` | `string` | Yes |  |
| `Event-Contact_Number` | `string` | Yes |  |
| `Event-Date/Time_Acknowledged` | `string` | Yes |  |
| `Event-Date/Time_Received` | `string` | Yes |  |
| `Event-Date/Time_Resolved` | `string` | Yes |  |
| `Event-Date_Event_Occured` | `string` | Yes |  |
| `Event-EventClassification` | `string` | Yes |  |
| `Event-EventType` | `string` | Yes |  |
| `Event-Event_Street_Address` | `string` | Yes |  |
| `Event-Geographic_Coord` | `string` | Yes |  |
| `Event-NotApplicable` | `string` | Yes |  |
| `Event-ResolutionCommentary` | `string` | Yes |  |
| `Event-Resolution_Type` | `string` | Yes |  |
| `Event-StakeholderType` | `string` | Yes |  |
| `Event-Topic` | `string` | Yes |  |
| `SchedulingDetails-DueDate` | `string` | Yes |  |
| `SchedulingDetails-EarliestStartDate` | `string` | Yes |  |
| `SchedulingDetails-ScheduledDate` | `string` | Yes |  |
| `EventType-DateReceived` | `timestamp` | Yes |  |
| `CustInfoEnqDetails-DateEventOccured` | `timestamp` | Yes |  |
| `CustInfoEnqDetails-ResponseDate` | `timestamp` | Yes |  |
| `CloseOutDetails-NoiseLevelAssessmentDate` | `timestamp` | Yes |  |
| `CloseOutDetails-AgreedRectDueDate` | `timestamp` | Yes |  |
| `CloseOutDetails-MediaReqRespDueDate` | `timestamp` | Yes |  |
| `CloseOutDetails-CloseOut/ResolutionDate` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
