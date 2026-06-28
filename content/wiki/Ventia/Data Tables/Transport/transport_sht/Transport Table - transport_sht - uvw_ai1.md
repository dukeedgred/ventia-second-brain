---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_ai1
full-name: transport_dev.transport_sht.uvw_ai1
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, inspection, compliance]
---

# Transport Table - transport_sht - uvw_ai1

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_ai1` |
| Full name | `transport_dev.transport_sht.uvw_ai1` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 19 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection compliance |
| Related tables/reports | `ext_mssql_asset_vision_vns_gen7.dbo.inspection`, `transport_dev.transport_sht.utbl_ss_latitude` |

## View Query

```sql
select
  i.id as Inspection_ID,
  i.inspectionroutename as Inspection_Route_Name,
  i.inspectiontypename as Inspection_Type,
  i.assetname as Asset_Name,
  i.assetcode as Asset_Code,
  i.assigneduser as User_Assigned_To,
  i.createddate as Created_Date,
  i.currentstatus as Status,
  '' as Completed,
  convert_timezone('UTC', 'Australia/Sydney', i.completeddate) as Completed_Date,
  i.completeduser as Completed_User,
  case 
    when i.scheduleddate = '' or i.scheduleddate is null 
    then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
    else i.scheduleddate
  end as Scheduled_Date,
  i.reference1 as WBS,
  i.reference2 as WO,
  l.Days as Latitude_Days,
  dateadd(second, 86399, dateadd(day,
                                  l.Days,
                                  case
                                    when i.scheduleddate = '' or i.scheduleddate is null 
                                    then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                    else i.scheduleddate
                                  end
                                )
  ) as Due_Date,
  dateadd(day,
          - l.Days,
          case
              when i.scheduleddate = '' or i.scheduleddate is null 
              then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
              else i.scheduleddate
            end
  ) as Early_Start_Date,
  case 
      when dateadd(second, 
                      86399, 
                      dateadd(day,
                              l.Days,
                              case
                                when i.scheduleddate = '' or i.scheduleddate is null 
                                then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                else i.scheduleddate
                              end
                            ) 
          ) >= current_date()
      then 'N/A'
      else case 
              when i.completeddate is null or i.completeddate = ''
              then 'Fail'
              else case 
                      when  to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate))) < dateadd(day,
                                                                                                                          -l.Days,
                                                                                                                          case
                                                                                                                            when i.scheduleddate = '' or i.scheduleddate is null 
                                                                                                                            then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                                                                                                            else i.scheduleddate
                                                                                                                          end
                                                                                                                        ) 
                      then 'Fail'
                      else case 
                                when to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate))) > dateadd(second, 
                                                                                                                                    86399, 
                                                                                                                                    dateadd(day,
                                                                                                                                            l.Days,
                                                                                                                                            case
                                                                                                                                              when i.scheduleddate = '' or i.scheduleddate is null 
                                                                                                                                              then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                                                                                                                              else i.scheduleddate
                                                                                                                                            end
                                                                                                                                          ) 
                                                                                                                          )
                                then 'Fail'
                                else 'Pass'
                          end
                  end
          end
  end as ComplianceFlag,
  case 
      when dateadd(second, 
                      86399, 
                      dateadd(day,
                              l.Days,
                              case
                                when i.scheduleddate = '' or i.scheduleddate is null 
                                then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                else i.scheduleddate
                              end
                            ) 
          ) >= current_date()
      then ''
      else case 
              when i.completeddate is null or i.completeddate = ''
              then 'Incomplete after due date'
              else case 
                      when  to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate))) < dateadd(day,
                                                                                                                          -l.Days,
                                                                                                                          case
                                                                                                                            when i.scheduleddate = '' or i.scheduleddate is null 
                                                                                                                            then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                                                                                                            else i.scheduleddate
                                                                                                                          end
                                                                                                                        ) 
              then 'Completed before early start date'
                      else case 
                                when to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate))) > dateadd(second, 
                                                                                                                                    86399, 
                                                                                                                                    dateadd(day,
                                                                                                                                            l.Days,
                                                                                                                                            case
                                                                                                                                              when i.scheduleddate = '' or i.scheduleddate is null 
                                                                                                                                              then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
                                                                                                                                              else i.scheduleddate
                                                                                                                                            end
                                                                                                                                          ) 
                                                                                                                          )
                                then 'Completed after due date'
                                else ''
                          end
                  end
          end
  end as ComplianceFailureReason
from
  ext_mssql_asset_vision_vns_gen7.dbo.inspection i
  join transport_dev.transport_sht.utbl_ss_latitude l on i.inspectiontypename = l.`Service Schedule Title`
where
  i.contract = 'Sydney Harbour Tunnel (SHT)'
  and i.category = 'Inspection'
  and i.deleted = false
  and   (case 
          when i.scheduleddate = '' or i.scheduleddate is null 
          then to_timestamp(to_date(convert_timezone('UTC', 'Australia/Sydney', i.completeddate)))
          else i.scheduleddate
        end) between l.`Effective From` and l.`Effective to`
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Inspection_ID` | `int` | Yes |  |
| `Inspection_Route_Name` | `string` | Yes |  |
| `Inspection_Type` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `User_Assigned_To` | `string` | Yes |  |
| `Created_Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Completed` | `string` | No |  |
| `Completed_Date` | `timestamp_ntz` | Yes |  |
| `Completed_User` | `string` | Yes |  |
| `Scheduled_Date` | `timestamp` | Yes |  |
| `WBS` | `string` | Yes |  |
| `WO` | `string` | Yes |  |
| `Latitude_Days` | `bigint` | Yes |  |
| `Due_Date` | `timestamp` | Yes |  |
| `Early_Start_Date` | `timestamp` | Yes |  |
| `ComplianceFlag` | `string` | No |  |
| `ComplianceFailureReason` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
