---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_customerrequest_all_attributes
full-name: transport_dev.transport_srapc.uvw_customerrequest_all_attributes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_customerrequest_all_attributes

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_customerrequest_all_attributes` |
| Full name | `transport_dev.transport_srapc.uvw_customerrequest_all_attributes` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 54 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-11-04T23:12:25.498Z; Last altered: 2025-11-04T23:12:25.498Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with CustomerReqPivoted as (
  with CustomerReqUnpivoted as (
    select
      m.ID as `Customer Request (VEN) ID`,
      m.Name as `Name`,
      m.Region as `District`,
      m.CreatedUser as `Created By User`,
      m.AssignedUser as `User Assigned To`,
      m.CreatedDate as `Created Date`,
      m.CompletedDate as `Completed Date `,
      m.Comments as `Comments`,
      a.AssetType as `Asset Type`,
      m.AssetID as `Asset ID`,
      m.AssetCode as `Asset Code`,
      m.AssetName as `Asset Name`,
      regexp_extract(f0.Value, 'POINT \\([^ ]+ ([^\\)]+)\\)', 1) as `latitude`,
      regexp_extract(f0.Value, 'POINT \\(([^ ]+)', 1) as `longitude`,
      f1.Name as `FieldName`,
      f1.Value as `FieldValue`
    from
      ext_mssql_asset_vision_ven_rms.dbo.vmodule m
        left join ext_mssql_asset_vision_ven_rms.dbo.asset a
          on a.id = m.AssetID
        left join ext_mssql_asset_vision_ven_rms.dbo.formfield f0
          on m.id = f0.sourcetableid
          and f0.Name = 'Event|Geographic_Coord'
          and f0.sourcetable IN ('Inspection', 'Module')
          and f0.Deleted = false
        left join ext_mssql_asset_vision_ven_rms.dbo.formfield f1
          on m.id = f1.sourcetableid
    where
      m.ModuleName = 'Customer Request (VEN)'
      and m.Deleted = false
      and f1.deleted = false
      and f1.datatype <> 'Label'
      and f1.Name <> 'Event|Geographic_Coord'
      and f1.sourcetable IN ('Inspection', 'Module')
    order by
      m.ID desc
  )
  select
    *
  from
    CustomerReqUnpivoted
      pivot (
        max(FieldValue) for FieldName in (
          'Event|UID' as `UID`,
          'Event|Case Status' as `Case Status`,
          'Event|Allocated_To' as `Allocated_To`,
          'Event|Issue Triage' as `Issue Triage`,
          'Event|Contact_Origin' as `Contact_Origin`,
          'Event|Record Type' as `Record Type`,
          'Event|Contact Type' as `Contact Type`,
          'Event|Outside Ventia Working Limits' as `Outside Ventia Working Limits`,
          'Event|Contact_Name' as `Contact_Name`,
          'Event|Contact_Phone' as `Contact_Phone`,
          'Event|Contact_Email' as `Contact_Email`,
          'Event|Contact_Address' as `Contact_Address`,
          'Event|Stakeholder_Type' as `Stakeholder_Type`,
          'Event|Business Name (if applicable)' as `Business Name (if applicable)`,
          'Event|Topic Category' as `Topic Category`,
          'Event|Topic' as `Topic`,
          'Event|Subtopic' as `Subtopic`,
          'Event|Date/Time_Received' as `Date/Time_Received_Text`,
          'Event|Date/Time_Acknowledged' as `Date/Time_Acknowledged_Text`,
          'Event|Event_Street_Address' as `Event_Street_Address`,
          'Event|Event_Suburb' as `Event_Suburb`,
          'Event|Local Government Area (LGA)' as `Local Government Area (LGA)`,
          'Event|State Electorate (SED)' as `State Electorate (SED)`,
          'Event|Federal Electorate (FED)' as `Federal Electorate (FED)`,
          'Event|Ongoing_Customer_Narrative' as `Ongoing_Customer_Narrative`,
          'Event|Ongoing_Sp_Actions' as `Ongoing_Sp_Actions`,
          'Event|Resolution_Type' as `Resolution_Type`,
          'Event|Resolution Commentary' as `Resolution Commentary`,
          'Event|Date/Time_Resolved' as `Date/Time_Resolved_Text`,
          'Event|Close_Out_Date/Time' as `Close_Out_Date/Time_Text`,
          'Event|Event_Response_Time' as `Event_Response_Time`,
          'Event|Event_Resolution_Time' as `Event_Resolution_Time`,
          'Event|Event_Closure_Time' as `Event_Closure_Time`,
          'Commitment|Customer_Requested_Response' as `Customer_Requested_Response`,
          'Commitment|Commitment Date' as `Commitment Date`,
          'Commitment|Commitment Owner' as `Commitment Owner`
        )
      )
)
select
  *,
  to_timestamp(`Date/Time_Received_Text`, 'dd/MM/yyyy HH:mm:ss') as `Date/Time_Received`,
  to_timestamp(`Date/Time_Acknowledged_Text`, 'dd/MM/yyyy HH:mm:ss') as `Date/Time_Acknowledged`,
  to_timestamp(`Date/Time_Resolved_Text`, 'dd/MM/yyyy HH:mm:ss') as `Date/Time_Resolved`,
  to_timestamp(`Close_Out_Date/Time_Text`, 'dd/MM/yyyy HH:mm:ss') as `Close_Out_Date/Time`
from
  CustomerReqPivoted
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Customer Request (VEN) ID` | `int` | Yes |  |
| `Name` | `string` | Yes |  |
| `District` | `string` | Yes |  |
| `Created By User` | `string` | Yes |  |
| `User Assigned To` | `string` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Completed Date ` | `timestamp` | Yes |  |
| `Comments` | `string` | Yes |  |
| `Asset Type` | `string` | Yes |  |
| `Asset ID` | `int` | Yes |  |
| `Asset Code` | `string` | Yes |  |
| `Asset Name` | `string` | Yes |  |
| `latitude` | `string` | Yes |  |
| `longitude` | `string` | Yes |  |
| `UID` | `string` | Yes |  |
| `Case Status` | `string` | Yes |  |
| `Allocated_To` | `string` | Yes |  |
| `Issue Triage` | `string` | Yes |  |
| `Contact_Origin` | `string` | Yes |  |
| `Record Type` | `string` | Yes |  |
| `Contact Type` | `string` | Yes |  |
| `Outside Ventia Working Limits` | `string` | Yes |  |
| `Contact_Name` | `string` | Yes |  |
| `Contact_Phone` | `string` | Yes |  |
| `Contact_Email` | `string` | Yes |  |
| `Contact_Address` | `string` | Yes |  |
| `Stakeholder_Type` | `string` | Yes |  |
| `Business Name (if applicable)` | `string` | Yes |  |
| `Topic Category` | `string` | Yes |  |
| `Topic` | `string` | Yes |  |
| `Subtopic` | `string` | Yes |  |
| `Date/Time_Received_Text` | `string` | Yes |  |
| `Date/Time_Acknowledged_Text` | `string` | Yes |  |
| `Event_Street_Address` | `string` | Yes |  |
| `Event_Suburb` | `string` | Yes |  |
| `Local Government Area (LGA)` | `string` | Yes |  |
| `State Electorate (SED)` | `string` | Yes |  |
| `Federal Electorate (FED)` | `string` | Yes |  |
| `Ongoing_Customer_Narrative` | `string` | Yes |  |
| `Ongoing_Sp_Actions` | `string` | Yes |  |
| `Resolution_Type` | `string` | Yes |  |
| `Resolution Commentary` | `string` | Yes |  |
| `Date/Time_Resolved_Text` | `string` | Yes |  |
| `Close_Out_Date/Time_Text` | `string` | Yes |  |
| `Event_Response_Time` | `string` | Yes |  |
| `Event_Resolution_Time` | `string` | Yes |  |
| `Event_Closure_Time` | `string` | Yes |  |
| `Customer_Requested_Response` | `string` | Yes |  |
| `Commitment Date` | `string` | Yes |  |
| `Commitment Owner` | `string` | Yes |  |
| `Date/Time_Received` | `timestamp` | Yes |  |
| `Date/Time_Acknowledged` | `timestamp` | Yes |  |
| `Date/Time_Resolved` | `timestamp` | Yes |  |
| `Close_Out_Date/Time` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
