---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_tacp_data_initial_load
full-name: transport_dev.transport_srapc.uvw_tacp_data_initial_load
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_tacp_data_initial_load

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_tacp_data_initial_load` |
| Full name | `transport_dev.transport_srapc.uvw_tacp_data_initial_load` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 65 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_srapc |
| Refresh/freshness | Created: 2024-09-11T00:02:08.271Z; Last altered: 2025-07-17T01:10:50.054Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select * from 
(
    -- finding asset with no ParentAssetTypeName
    select 
        'AU-SRA' as serviceProviderAssetId
        , 'Group' as assetDescription	, 'GROUP' as technicalObjectCodeAndTypeOf	
        , 'VALID' as recordStatus	, null as assetOwnerId	, null as assetCustodianId	, null as assetMaintainerPrimaryId	, null as assetMaintainerPrimaryContractId	
        , 'ISOP' as assetStatusCode	, null as tmpID	, null as tmcID	, null as heritageInventoryNumber	, null as hazardousMaterialCode	, null as contaminationRiskCode	, null as ddaCompliant	, null as assetCriticalityCode	, null as assetStatusDate	, null as assetConditionCode	, null as assetConditionDate		
        , 'AU' as serviceProviderParentAssetId
        , null as transportModeCode	, null as transportNetworkCode	, null as locationCode	, null as coordinateDatumCode	, null as startLatitude	, null as startLongitude	, null as endLatitude	, null as endLongitude	, null as corridorCode	, null as manufacturedDate	, null as constructedDate	, null as purchasedDate	, null as commissionedDate	, null as `in-ServiceDate`	, null as warrantyEndDate	, null as disposedDate	, null as serviceLifeEndDate	, null as plannedDisposalDate	, null as tfnswAssetId	, null as assetComments	, null as uniclassCode	, null as transportConcessionNumber	, null as assetOperatorId	, null as assetMaintainerThirdPartyId	, null as assetLesseeId	, null as startKm	, null as endKm	, null as baseCode	, null as roadCarriagewayGroup	, null as roadLinkNumber	, null as roadCarriagewayCode	, null as locationDescription	, null as crossSectionalPositionXSPCode	, null as assetGeometry	, null as designLife	, null as manufacturer	, null as vendor	, null as constructor	, null as model	, null as manufacturerPartNumber	, null as variant	, null as serialNumber	, null as batchNumber	, null as rotable	, null as typeApprovalNumber
)
union all
(
    -- finding asset with no ParentAssetTypeName
    select 
        upper(concat( 'AU-SRA-', b.SAPName)) as serviceProviderAssetId
        , 'Group' as assetDescription	, 'GROUP' as technicalObjectCodeAndTypeOf	
        , 'VALID' as recordStatus	, null as assetOwnerId	, null as assetCustodianId	, null as assetMaintainerPrimaryId	, null as assetMaintainerPrimaryContractId	
        , 'ISOP' as assetStatusCode	, null as tmpID	, null as tmcID	, null as heritageInventoryNumber	, null as hazardousMaterialCode	, null as contaminationRiskCode	, null as ddaCompliant	, null as assetCriticalityCode	, null as assetStatusDate	, null as assetConditionCode	, null as assetConditionDate		
        , 'AU-SRA' as serviceProviderParentAssetId
        , null as transportModeCode	, null as transportNetworkCode	, null as locationCode	, null as coordinateDatumCode	, null as startLatitude	, null as startLongitude	, null as endLatitude	, null as endLongitude	, null as corridorCode	, null as manufacturedDate	, null as constructedDate	, null as purchasedDate	, null as commissionedDate	, null as `in-ServiceDate`	, null as warrantyEndDate	, null as disposedDate	, null as serviceLifeEndDate	, null as plannedDisposalDate	, null as tfnswAssetId	, null as assetComments	, null as uniclassCode	, null as transportConcessionNumber	, null as assetOperatorId	, null as assetMaintainerThirdPartyId	, null as assetLesseeId	, null as startKm	, null as endKm	, null as baseCode	, null as roadCarriagewayGroup	, null as roadLinkNumber	, null as roadCarriagewayCode	, null as locationDescription	, null as crossSectionalPositionXSPCode	, null as assetGeometry	, null as designLife	, null as manufacturer	, null as vendor	, null as constructor	, null as model	, null as manufacturerPartNumber	, null as variant	, null as serialNumber	, null as batchNumber	, null as rotable	, null as typeApprovalNumber
    from transport_dev.transport_srapc.uvw_asset a
    join transport_dev.transport_srapc.utbl_tacp_toc b
    on a.AssetType = b.AssetType
    where isnotnull(a.ParentAssetTypeName) = false
    group by b.SAPName
    order by b.SAPName
)
union all
(
    -- finding all asset group
    select 
        upper(concat( 'AU-SRA-', b.SAPName)) as serviceProviderAssetId
        , 'Group' as assetDescription	, 'GROUP' as technicalObjectCodeAndTypeOf	
        , 'VALID' as recordStatus	, null as assetOwnerId	, null as assetCustodianId	, null as assetMaintainerPrimaryId	, null as assetMaintainerPrimaryContractId	
        , 'ISOP' as assetStatusCode	, null as tmpID	, null as tmcID	, null as heritageInventoryNumber	, null as hazardousMaterialCode	, null as contaminationRiskCode	, null as ddaCompliant	, null as assetCriticalityCode	, null as assetStatusDate	, null as assetConditionCode	, null as assetConditionDate		
        , 'AU-SRA' as serviceProviderParentAssetId
        , null as transportModeCode	, null as transportNetworkCode	, null as locationCode	, null as coordinateDatumCode	, null as startLatitude	, null as startLongitude	, null as endLatitude	, null as endLongitude	, null as corridorCode	, null as manufacturedDate	, null as constructedDate	, null as purchasedDate	, null as commissionedDate	, null as `in-ServiceDate`	, null as warrantyEndDate	, null as disposedDate	, null as serviceLifeEndDate	, null as plannedDisposalDate	, null as tfnswAssetId	, null as assetComments	, null as uniclassCode	, null as transportConcessionNumber	, null as assetOperatorId	, null as assetMaintainerThirdPartyId	, null as assetLesseeId	, null as startKm	, null as endKm	, null as baseCode	, null as roadCarriagewayGroup	, null as roadLinkNumber	, null as roadCarriagewayCode	, null as locationDescription	, null as crossSectionalPositionXSPCode	, null as assetGeometry	, null as designLife	, null as manufacturer	, null as vendor	, null as constructor	, null as model	, null as manufacturerPartNumber	, null as variant	, null as serialNumber	, null as batchNumber	, null as rotable	, null as typeApprovalNumber
    from transport_dev.transport_srapc.uvw_asset a
    join transport_dev.transport_srapc.utbl_tacp_toc b
    on a.AssetType = b.AssetType
    where isnotnull(a.ParentAssetTypeName) = true
    group by b.SAPName
    order by b.SAPName
)
union all
(
    select 
        -- (case isnotnull(a.ParentAssetTypeName) when true then concat('AU-SRA-', b.sapName, '-', a.ID) else concat('AU-SRA-', b.sapName, '-', a.ID) end) as serviceProviderAssetId
        upper(concat('AU-SRA-', b.sapName, '-', a.ID))  as serviceProviderAssetId
        , ( case isnull(a.name) when true then 'UNKNOWN' else (case (len(a.name) = 0) when true then 'UNKNOWN' else replace(a.name, CHAR(10), ' ') end) end)  as assetDescription
        , b.TacpToc as technicalObjectCodeAndTypeOf
        , ( case a.Deleted when true then 'INVALID' else 'VALID' end) as recordStatus
        , e.assetOwnerId
        , e.assetCustodianId
        , e.assetMaintainerPrimaryId
        , e.assetMaintainerPrimaryContractId
        , ( case a.stage when 'Active' then 'ISOP' when 'Planned' then 'PLAN' when 'Inactive' then 'OSBO' when 'Disposed' then 'DISP' else 'UNKN' end) as assetStatusCode
        , null as tmpID
        , null as tmcID
        , null as heritageInventoryNumber
        , null as hazardousMaterialCode
        , null as contaminationRiskCode
        , null as ddaCompliant
        , a.AssetCriticality as assetCriticalityCode
        , date_format( from_utc_timestamp(a.ModifiedUTC, 'Australia/Sydney'), 'yyyymmdd') as assetStatusDate --AESD
        , a.AssetCondition as assetConditionCode
        , date_format( from_utc_timestamp(a.ConditionDate, 'Australia/Sydney'), 'yyyymmdd') as assetConditionDate --AESD
        , upper(concat('AU-SRA-', b.sapName)) as serviceProviderParentAssetId
        , 'RD' as transportModeCode
        , ( case isnotnull( d.AssetID) when true then 'RDR' else 'RDS' end) as transportNetworkCode        
        , null as locationCode
        , 'WGS84' as coordinateDatumCode
        , null as startLatitude
        , null as startLongitude
        , null as endLatitude
        , null as endLongitude
        , ( case a.AssetType                
                when 'Road' then left(a.ParentAssetCode, 7)             
                when 'Link Carriageway' then left(a.ParentAssetCode, 7)  
                else ( case a.ParentAssetTypeName 
                            when 'Road' then left(a.ParentAssetCode, 7)
                            when 'Link Carriageway' then left(a.ParentAssetCode, 7)  
                        end
                    ) 
            end ) as corridorCode 
        , null as manufacturedDate
        , date_format( from_utc_timestamp(a.ConstructionDate, 'Australia/Sydney'), 'yyyymmdd') as constructedDate
        , null as purchasedDate
        , null as commissionedDate
        , null as `in-ServiceDate`
        , null as warrantyEndDate
        , null as disposedDate
        , null as serviceLifeEndDate
        , null as plannedDisposalDate
        , null as tfnswAssetId
        , replace(a.Notes, CHAR(10), ' | ') as assetComments
        , null as uniclassCode
        , null as transportConcessionNumber
        , null as assetOperatorId
        , null as assetMaintainerThirdPartyId
        , null as assetLesseeId
        , null as startKm
        , null as endKm
        , null as baseCode

        , ( case a.direction when 'Prescribed' then 'P' when 'Counter' then 'C' else null end) as roadCarriagewayGroup

        , ( case a.AssetType                
                when 'Road' then null  
                when 'Link Carriageway' then substring(a.code, 9, 4)  
                else ( case a.ParentAssetTypeName 
                            when 'Link Carriageway' then substring(a.ParentAssetCode, 9, 4) 
                        end
                    )
            end ) as roadLinkNumber

         , ( case a.AssetType                        
                when 'Link Carriageway' then left( right( code, 2), 1)
                else ( case a.ParentAssetTypeName 
                            when 'Link Carriageway' then left( right( ParentAssetCode, 2), 1)
                        end
                    ) 
            end )  as roadCarriagewayCode
            
        , null as locationDescription
        , null as crossSectionalPositionXSPCode
        , null as assetGeometry
        , null as designLife
        , null as manufacturer
        , null as vendor
        , null as constructor
        , null as model
        , null as manufacturerPartNumber
        , null as variant
        , null as serialNumber
        , null as batchNumber
        , null as rotable
        , null as typeApprovalNumber
    from transport_dev.transport_srapc.uvw_asset a
    join transport_dev.transport_srapc.utbl_tacp_toc b
        on a.assetType = b.assetType    
    left join transport_dev.transport_srapc.utbl_tacp_toc c    
        on a.ParentAssetTypeName = c.assetType        
    left join ( select AssetID from transport_dev.transport_srapc.uvw_assetattribute where name = 'Contract Region' and value = 'Regional ITS Zone' and Deleted = false ) d
        on a.ID = d.AssetID   
    join transport_dev.transport_srapc.utbl_tacp_constants e         
    where a.Deleted = false
    and a.id <> 252586 -- TEMPORARY SRAPC ROAD asste for loging CRM, not a valid asset for TACP
    and a.id <> 305695 -- funny road with incorrect link code format, R0154103000.000AU, skip load
    and a.stage = 'Active'
    order by a.AssetType, a.ID
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `serviceProviderAssetId` | `string` | Yes |  |
| `assetDescription` | `string` | Yes |  |
| `technicalObjectCodeAndTypeOf` | `string` | Yes |  |
| `recordStatus` | `string` | No |  |
| `assetOwnerId` | `bigint` | Yes |  |
| `assetCustodianId` | `bigint` | Yes |  |
| `assetMaintainerPrimaryId` | `bigint` | Yes |  |
| `assetMaintainerPrimaryContractId` | `string` | Yes |  |
| `assetStatusCode` | `string` | No |  |
| `tmpID` | `void` | Yes |  |
| `tmcID` | `void` | Yes |  |
| `heritageInventoryNumber` | `void` | Yes |  |
| `hazardousMaterialCode` | `void` | Yes |  |
| `contaminationRiskCode` | `void` | Yes |  |
| `ddaCompliant` | `void` | Yes |  |
| `assetCriticalityCode` | `string` | Yes |  |
| `assetStatusDate` | `string` | Yes |  |
| `assetConditionCode` | `string` | Yes |  |
| `assetConditionDate` | `string` | Yes |  |
| `serviceProviderParentAssetId` | `string` | Yes |  |
| `transportModeCode` | `string` | Yes |  |
| `transportNetworkCode` | `string` | Yes |  |
| `locationCode` | `void` | Yes |  |
| `coordinateDatumCode` | `string` | Yes |  |
| `startLatitude` | `void` | Yes |  |
| `startLongitude` | `void` | Yes |  |
| `endLatitude` | `void` | Yes |  |
| `endLongitude` | `void` | Yes |  |
| `corridorCode` | `string` | Yes |  |
| `manufacturedDate` | `void` | Yes |  |
| `constructedDate` | `string` | Yes |  |
| `purchasedDate` | `void` | Yes |  |
| `commissionedDate` | `void` | Yes |  |
| `in-ServiceDate` | `void` | Yes |  |
| `warrantyEndDate` | `void` | Yes |  |
| `disposedDate` | `void` | Yes |  |
| `serviceLifeEndDate` | `void` | Yes |  |
| `plannedDisposalDate` | `void` | Yes |  |
| `tfnswAssetId` | `void` | Yes |  |
| `assetComments` | `string` | Yes |  |
| `uniclassCode` | `void` | Yes |  |
| `transportConcessionNumber` | `void` | Yes |  |
| `assetOperatorId` | `void` | Yes |  |
| `assetMaintainerThirdPartyId` | `void` | Yes |  |
| `assetLesseeId` | `void` | Yes |  |
| `startKm` | `void` | Yes |  |
| `endKm` | `void` | Yes |  |
| `baseCode` | `void` | Yes |  |
| `roadCarriagewayGroup` | `string` | Yes |  |
| `roadLinkNumber` | `string` | Yes |  |
| `roadCarriagewayCode` | `string` | Yes |  |
| `locationDescription` | `void` | Yes |  |
| `crossSectionalPositionXSPCode` | `void` | Yes |  |
| `assetGeometry` | `void` | Yes |  |
| `designLife` | `void` | Yes |  |
| `manufacturer` | `void` | Yes |  |
| `vendor` | `void` | Yes |  |
| `constructor` | `void` | Yes |  |
| `model` | `void` | Yes |  |
| `manufacturerPartNumber` | `void` | Yes |  |
| `variant` | `void` | Yes |  |
| `serialNumber` | `void` | Yes |  |
| `batchNumber` | `void` | Yes |  |
| `rotable` | `void` | Yes |  |
| `typeApprovalNumber` | `void` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
