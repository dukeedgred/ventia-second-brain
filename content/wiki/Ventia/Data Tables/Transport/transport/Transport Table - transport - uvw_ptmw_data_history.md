---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_ptmw_data_history
full-name: transport_dev.transport.uvw_ptmw_data_history
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_ptmw_data_history

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_ptmw_data_history` |
| Full name | `transport_dev.transport.uvw_ptmw_data_history` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-07-07T09:29:00.237Z; Last altered: 2025-07-07T09:29:00.237Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select * from corporate_dev.enterprise_reporting.uvw_sap_employee_attendance_absence_history
where Sector= 'Transport'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Person` | `string` | Yes | Personnel Number |
| `Cost_center` | `string` | Yes |  |
| `Profit_center` | `string` | Yes |  |
| `Sector` | `varchar(255)` | Yes |  |
| `Sector_Key` | `varchar(255)` | Yes |  |
| `BusinessUnit` | `varchar(255)` | Yes |  |
| `BusinessUnit_Key` | `varchar(255)` | Yes |  |
| `Subtype` | `string` | Yes | Subtype |
| `Att_abs_type` | `string` | Yes | Attendance or Absence Type |
| `Att_abs_text` | `string` | Yes | Text for Attendance/Absence Type |
| `Start_Date` | `date` | Yes |  |
| `Start_time` | `string` | Yes | Start Time |
| `End_Date` | `date` | Yes |  |
| `End_time` | `string` | Yes | End Time |
| `Previous_day` | `string` | Yes | Previous Day Indicator |
| `Full_day` | `string` | Yes | Record is for Full Day |
| `Document_number` | `string` | Yes | Document number for time data |
| `Activity_type` | `string` | Yes | Activity Type |
| `Service_order` | `string` | Yes | Order Number |
| `Internal_order` | `string` | Yes | Internal Order |
| `Receiver_Cost_Center` | `string` | Yes | Receiver Cost Center |
| `WBS_Element` | `string` | Yes | Work Breakdown Structure Element (WBS element) |
| `Network_Number` | `string` | Yes | Network Number for Account Assignment |
| `Activity` | `string` | Yes | Activity Number |
| `Short_text` | `string` | Yes | Short Text |
| `Customer_reference` | `string` | Yes | Customer Reference |
| `Record_ID` | `string` | Yes | Number of Infotype Record With Same Key |
| `Changed_On` | `string` | Yes | Last Changed On |
| `Changed_By` | `string` | Yes | Name of Person Who Changed Object |
| `Payrdays` | `decimal(6,2)` | Yes | Payroll days |
| `Payroll_hours` | `decimal(7,2)` | Yes | Payroll hours |
| `Attendance_hours` | `decimal(8,2)` | Yes |  |
| `Category` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
