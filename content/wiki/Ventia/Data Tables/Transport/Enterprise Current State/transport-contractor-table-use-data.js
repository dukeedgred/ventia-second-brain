window.transportContractorTableUses = [
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_asset",
    "fullName": "transport_dev.transport_aklw.uvw_asset",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "asset",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset",
      "Key columns: ID, Contract, AssetType, ParentAssetID, ParentAssetCode, ParentAssetName, ParentAssetTypeName, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.asset",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_asset.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_capitalwork",
    "fullName": "transport_dev.transport_aklw.uvw_capitalwork",
    "tableType": "VIEW",
    "columnCount": 28,
    "documentedDomain": "capital work",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital work",
      "Key columns: ID, CapitalWorkType, AssetTypeName, AssetID, AssetCode, AssetName, Section, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_capitalwork.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_capitalworktask",
    "fullName": "transport_dev.transport_aklw.uvw_capitalworktask",
    "tableType": "VIEW",
    "columnCount": 32,
    "documentedDomain": "capital work",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital work",
      "Key columns: ID, CapitalWorkID, EstimatedCost, ActualCost, AssetTypeName, AssetID, AssetCode, AssetName",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.capitalworktask, ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_capitalworktask.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_formfield",
    "fullName": "transport_dev.transport_aklw.uvw_formfield",
    "tableType": "VIEW",
    "columnCount": 13,
    "documentedDomain": "form metadata",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: form metadata",
      "Key columns: ID, RecordID, SourceTableID, UniqueID",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.formfield",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_formfield.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_inspection",
    "fullName": "transport_dev.transport_aklw.uvw_inspection",
    "tableType": "VIEW",
    "columnCount": 46,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: ID, AssetTypeName, AssetID, AssetCode, AssetName, Section, Contract, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.inspection",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_inspection.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_aklw.uvw_job",
    "tableType": "VIEW",
    "columnCount": 80,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: ID, AssetID, AssetCode, AssetName, Section, Contract, HazardDefectCode, HazardCode",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.job",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_job.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_plant_pending_timesheet",
    "fullName": "transport_dev.transport_aklw.uvw_plant_pending_timesheet",
    "tableType": "VIEW",
    "columnCount": 21,
    "documentedDomain": "timesheet",
    "inferredCategory": "Resources / timesheets",
    "inferredUse": "Track labour, plant, resource, timesheet, or job-costing support records.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: timesheet",
      "Key columns: ID, TimesheetID, CreatedDate, CreatedUser, RecordID, ResourceID, SAPWorkOrder, WorkflowStatus"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_plant_pending_timesheet.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_timesheetitem",
    "fullName": "transport_dev.transport_aklw.uvw_timesheetitem",
    "tableType": "VIEW",
    "columnCount": 27,
    "documentedDomain": "timesheet",
    "inferredCategory": "Resources / timesheets",
    "inferredUse": "Track labour, plant, resource, timesheet, or job-costing support records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: timesheet",
      "Key columns: id, timesheetid, timesheetcreateddate, timesheetcreateduser, sourcetableid, cost",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem, ext_mssql_asset_vision_vnz_gen7.dbo.resource",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_timesheetitem.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_timesheetreport",
    "fullName": "transport_dev.transport_aklw.uvw_timesheetreport",
    "tableType": "VIEW",
    "columnCount": 31,
    "documentedDomain": "timesheet",
    "inferredCategory": "Resources / timesheets",
    "inferredUse": "Track labour, plant, resource, timesheet, or job-costing support records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: timesheet",
      "Key columns: RecordID, ResourceCost, SAPWorkOrder, SWONumber, RAMMDispatchID, RoadID, RoadName, Contract",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem, ext_mssql_asset_vision_vnz_gen7.dbo.job, ext_mssql_asset_vision_vnz_gen7.dbo.resource, ext_mssql_asset_vision_vnz_gen7.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_timesheetreport.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_updated_dispatch_id",
    "fullName": "transport_dev.transport_aklw.uvw_updated_dispatch_id",
    "tableType": "VIEW",
    "columnCount": 12,
    "documentedDomain": "dispatch",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: dispatch",
      "Key columns: id, recordid, sourcetableid",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_updated_dispatch_id.md"
  },
  {
    "context": "transport_aklw",
    "contractor": "AKLW",
    "label": "Auckland West",
    "tableName": "uvw_workflowstatus",
    "fullName": "transport_dev.transport_aklw.uvw_workflowstatus",
    "tableType": "VIEW",
    "columnCount": 14,
    "documentedDomain": "workflow",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: workflow",
      "Key columns: ID, RecordID, WorkflowItemCode, WorkflowItemName, SourceTableID, StatusDate",
      "View SQL references ext_mssql_asset_vision_vnz_gen7.dbo.workflowstatus",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_aklw/Transport%20Table%20-%20transport_aklw%20-%20uvw_workflowstatus.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "byo_tbl_kerikeri_weather_hr_fc",
    "fullName": "transport_dev.transport_fndc.byo_tbl_kerikeri_weather_hr_fc",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "weather",
    "inferredCategory": "Weather",
    "inferredUse": "Provide weather observations or forecasts for operational context and reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: weather",
      "Key columns: relative_humidity_2m"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20byo_tbl_kerikeri_weather_hr_fc.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "byo_tbl_national_road_cl_nz",
    "fullName": "transport_dev.transport_fndc.byo_tbl_national_road_cl_nz",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "road network",
    "inferredCategory": "Road network / spatial",
    "inferredUse": "Represent road network, chainage, section, geospatial, WKT, latitude/longitude, or GIS enrichment context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: road network",
      "Documented description/comment: This table contains data related to the national road centreline network, focusing on road controlling authorities. It includes information about road segments such as their geographic start and end coordinates, road names, classification, and surface types. Traffic data like total volume, heavy vehicle volume, and vehicle kilometres travelled are recorded, along with details about the responsible territorial authority. The data is useful for analyzing road usage, monitoring traffic patterns, planning maintenance, and managing road assets under different controlling authorities.",
      "Key columns: OBJECTID, ID, assetCarriageWayID, assetCwayEndNZTMX, assetCwayEndNZTMY, assetCwayStartNZTMX, assetCwayStartNZTMY, assetRCAID"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20byo_tbl_national_road_cl_nz.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_c_surface",
    "fullName": "transport_dev.transport_fndc.uvw_c_surface",
    "tableType": "VIEW",
    "columnCount": 79,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: c_surface_id, road_name, gps_method_id, surf_width, full_width_flag, contract_number, work_origin_id, condition_wt",
      "View SQL references staged_dev.stg_api_amds_fndc_test.c_surface"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_c_surface.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_drainage",
    "fullName": "transport_dev.transport_fndc.uvw_drainage",
    "tableType": "VIEW",
    "columnCount": 80,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: road_name, drainage_id, offset_side, cul_width, bridge_id, hazard, asset_owner, gps_method_id",
      "View SQL references staged_dev.stg_api_amds_fndc_test.drainage"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_drainage.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_footpath",
    "fullName": "transport_dev.transport_fndc.uvw_footpath",
    "tableType": "VIEW",
    "columnCount": 74,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: footpath_id, road_name, side, gps_method_id, width, condition_wt, condition, condition_date",
      "View SQL references staged_dev.stg_api_amds_fndc_test.footpath"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_footpath.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_fw_forward_work_view",
    "fullName": "transport_dev.transport_fndc.uvw_fw_forward_work_view",
    "tableType": "VIEW",
    "columnCount": 18,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: road_name, tl_width, priority, treat_length_id",
      "View SQL references staged_dev.stg_api_amds_fndc_test.fw_forward_work_view"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_fw_forward_work_view.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_mc_cost",
    "fullName": "transport_dev.transport_fndc.uvw_mc_cost",
    "tableType": "VIEW",
    "columnCount": 30,
    "documentedDomain": "commercial / finance",
    "inferredCategory": "Commercial / finance",
    "inferredUse": "Support cost, claim, subcontractor, procurement, material, waste, fuel, or commercial reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: commercial / finance",
      "Key columns: transaction_id, cost_group, cost_amount, cost_amount_rci, asset_id, gps_method_id, road_name, work_position",
      "View SQL references staged_dev.stg_api_amds_fndc_test.mc_cost"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_mc_cost.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_mt_dispatch",
    "fullName": "transport_dev.transport_fndc.uvw_mt_dispatch",
    "tableType": "VIEW",
    "columnCount": 94,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: contract_name, dispatch_id, assigned_patrol_id, job_manager_client, job_manager_contractor, road_name, side, gps_method_id",
      "View SQL references staged_dev.stg_api_amds_fndc_test.mt_dispatch"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_mt_dispatch.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_mt_dispatch_claim",
    "fullName": "transport_dev.transport_fndc.uvw_mt_dispatch_claim",
    "tableType": "VIEW",
    "columnCount": 58,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: dispatch_claim_id, contract_name, dispatch_id, claim_no, cost_rate, on_cost_pct, est_status, est_cost_amount",
      "View SQL references staged_dev.stg_api_amds_fndc_test.mt_dispatch_claim"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_mt_dispatch_claim.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_pave_layer",
    "fullName": "transport_dev.transport_fndc.uvw_pave_layer",
    "tableType": "VIEW",
    "columnCount": 53,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: layer_id, road_name, width, full_width_flag, estimate_status, work_origin_id, condition_wt, condition",
      "View SQL references staged_dev.stg_api_amds_fndc_test.pave_layer"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_pave_layer.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_railings",
    "fullName": "transport_dev.transport_fndc.uvw_railings",
    "tableType": "VIEW",
    "columnCount": 79,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: road_name, railing_id, gps_method_id, side, railing_width, other_road_name, other_side, condition_wt",
      "View SQL references staged_dev.stg_api_amds_fndc_test.railings"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_railings.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_sign",
    "fullName": "transport_dev.transport_fndc.uvw_sign",
    "tableType": "VIEW",
    "columnCount": 80,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: road_name, sign_id, side, sign_width, in_contract_id, in_dispatch_id, rep_contract_id, rep_dispatch_id",
      "View SQL references staged_dev.stg_api_amds_fndc_test.sign"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_sign.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "uvw_treatment_length",
    "fullName": "transport_dev.transport_fndc.uvw_treatment_length",
    "tableType": "VIEW",
    "columnCount": 197,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: treat_length_id, road_name, tl_width, tl_cost_set, tl_valid_ok, asset_owner, c_surface_id, surf_width",
      "View SQL references staged_dev.stg_api_amds_fndc_test.treatment_length"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20uvw_treatment_length.md"
  },
  {
    "context": "transport_fndc",
    "contractor": "FNDC",
    "label": "FNDC",
    "tableName": "weather_hourly_forecast",
    "fullName": "transport_dev.transport_fndc.weather_hourly_forecast",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "weather",
    "inferredCategory": "Weather",
    "inferredUse": "Provide weather observations or forecasts for operational context and reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: weather",
      "Key columns: relative_humidity_2m"
    ],
    "tableUrl": "../transport_fndc/Transport%20Table%20-%20transport_fndc%20-%20weather_hourly_forecast.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "_attachments",
    "fullName": "transport_dev.formitize_srapc._attachments",
    "tableType": "MANAGED",
    "columnCount": 9,
    "documentedDomain": "documents / evidence",
    "inferredCategory": "Documents / evidence",
    "inferredUse": "Store or report photos, attachments, documents, sign-offs, or other evidence records.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: documents / evidence",
      "Key columns: submittedFormID, formID, attachment_id, row_updated_exec_id"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20_attachments.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "_json_structure",
    "fullName": "transport_dev.formitize_srapc._json_structure",
    "tableType": "MANAGED",
    "columnCount": 24,
    "documentedDomain": "",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: submittedFormID, formID, row_updated_exec_id"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20_json_structure.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "civil_maintenance_pre_start_form",
    "fullName": "transport_dev.formitize_srapc.civil_maintenance_pre_start_form",
    "tableType": "MANAGED",
    "columnCount": 53,
    "documentedDomain": "forms / modules",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: forms / modules",
      "Key columns: submittedFormID, formID, row_updated_exec_id"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20civil_maintenance_pre_start_form.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "pre_start_checklist_light_and_heavy_vehicles",
    "fullName": "transport_dev.formitize_srapc.pre_start_checklist_light_and_heavy_vehicles",
    "tableType": "MANAGED",
    "columnCount": 53,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: submittedFormID, formID, inspectionDate, inspectionTime, serviceDueDate_byTime, row_updated_exec_id"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20pre_start_checklist_light_and_heavy_vehicles.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "srap_parkland_sustainable_procurement_questionnaire",
    "fullName": "transport_dev.formitize_srapc.srap_parkland_sustainable_procurement_questionnaire",
    "tableType": "MANAGED",
    "columnCount": 128,
    "documentedDomain": "forms / modules",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: forms / modules",
      "Key columns: submittedFormID, formID, Environmental_Incident, Evidence_1, Evidence_2, Innovative_idea, Learning_workers, Reclaimedorrecycledmaterials"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20srap_parkland_sustainable_procurement_questionnaire.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "srapc_monthly_subcontractor_data_capture_portal",
    "fullName": "transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal",
    "tableType": "MANAGED",
    "columnCount": 291,
    "documentedDomain": "",
    "inferredCategory": "Commercial / finance",
    "inferredUse": "Support cost, claim, subcontractor, procurement, material, waste, fuel, or commercial reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: submittedFormID, formID, Acid_sulfate_soils, Acid_sulfate_soils_Provider, Acid_sulfate_soils_generated_tonnes, Subcontractor, row_updated_exec_id, Aboriginal_spendon_subcontractors"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20srapc_monthly_subcontractor_data_capture_portal.md"
  },
  {
    "context": "formitize_srapc",
    "contractor": "Formitize SRAPC",
    "label": "SRAPC form-capture adjunct",
    "tableName": "srapc_monthly_subcontractor_data_capture_portal_fuel_stationary",
    "fullName": "transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary",
    "tableType": "MANAGED",
    "columnCount": 14,
    "documentedDomain": "",
    "inferredCategory": "Commercial / finance",
    "inferredUse": "Support cost, claim, subcontractor, procurement, material, waste, fuel, or commercial reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: submittedFormID, formID, row_updated_exec_id"
    ],
    "tableUrl": "../formitize_srapc/Transport%20Table%20-%20formitize_srapc%20-%20srapc_monthly_subcontractor_data_capture_portal_fuel_stationary.md"
  },
  {
    "context": "transport_nel",
    "contractor": "NEL",
    "label": "NEL",
    "tableName": "utbl_kpi_assets",
    "fullName": "transport_dev.transport_nel.utbl_kpi_assets",
    "tableType": "MANAGED",
    "columnCount": 66,
    "documentedDomain": "KPI asset",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI asset",
      "Key columns: Asset, Asset Name, Asset Type, Asset ID, Asset Description, Asset Modelled, ID, OMParentAssetID"
    ],
    "tableUrl": "../transport_nel/Transport%20Table%20-%20transport_nel%20-%20utbl_kpi_assets.md"
  },
  {
    "context": "transport_nel",
    "contractor": "NEL",
    "label": "NEL",
    "tableName": "utbl_kpi_work_orders",
    "fullName": "transport_dev.transport_nel.utbl_kpi_work_orders",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "KPI work order",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI work order",
      "Key columns: Work Order, Asset, Status, Priority, Anywhere Created, Work Type, Work Group, Job Plan"
    ],
    "tableUrl": "../transport_nel/Transport%20Table%20-%20transport_nel%20-%20utbl_kpi_work_orders.md"
  },
  {
    "context": "transport_nel",
    "contractor": "NEL",
    "label": "NEL",
    "tableName": "utbl_ref_date_table",
    "fullName": "transport_dev.transport_nel.utbl_ref_date_table",
    "tableType": "MANAGED",
    "columnCount": 25,
    "documentedDomain": "reference date",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference date",
      "Key columns: PublicHoliday, PublicHolidayName"
    ],
    "tableUrl": "../transport_nel/Transport%20Table%20-%20transport_nel%20-%20utbl_ref_date_table.md"
  },
  {
    "context": "transport_nel",
    "contractor": "NEL",
    "label": "NEL",
    "tableName": "uvw_kpi_sys_av_devices",
    "fullName": "transport_dev.transport_nel.uvw_kpi_sys_av_devices",
    "tableType": "VIEW",
    "columnCount": 12,
    "documentedDomain": "KPI asset/device",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI asset/device",
      "Key columns: Asset, AssetType, KPI_No, Work Type",
      "View SQL references utbl_kpi_work_orders, utbl_kpi_assets",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_nel/Transport%20Table%20-%20transport_nel%20-%20uvw_kpi_sys_av_devices.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "bkp_backlog_change_report",
    "fullName": "transport_dev.transport_ramc.bkp_backlog_change_report",
    "tableType": "MANAGED",
    "columnCount": 9,
    "documentedDomain": "backlog",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: backlog",
      "Key columns: JobCount, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20bkp_backlog_change_report.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "bkp_current_month_job_snapshot",
    "fullName": "transport_dev.transport_ramc.bkp_current_month_job_snapshot",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "job snapshot",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: job snapshot",
      "Key columns: JobID, Contract, AssetTypeName, AssetCode, AssetName, ChainageFrom, JobLocation, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20bkp_current_month_job_snapshot.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "bkp_last_month_job_snapshot",
    "fullName": "transport_dev.transport_ramc.bkp_last_month_job_snapshot",
    "tableType": "MANAGED",
    "columnCount": 24,
    "documentedDomain": "job snapshot",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: job snapshot",
      "Key columns: JobID, Contract, AssetTypeName, AssetCode, AssetName, ChainageFrom, JobLocation, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20bkp_last_month_job_snapshot.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "bkp_monthly_backlog_reduction",
    "fullName": "transport_dev.transport_ramc.bkp_monthly_backlog_reduction",
    "tableType": "MANAGED",
    "columnCount": 4,
    "documentedDomain": "backlog",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: backlog",
      "Key columns: JobType, JobCount"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20bkp_monthly_backlog_reduction.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "utbl_backlog_change_report",
    "fullName": "transport_dev.transport_ramc.utbl_backlog_change_report",
    "tableType": "MANAGED",
    "columnCount": 9,
    "documentedDomain": "backlog",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: backlog",
      "Key columns: JobCount, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20utbl_backlog_change_report.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "utbl_current_month_job_snapshot",
    "fullName": "transport_dev.transport_ramc.utbl_current_month_job_snapshot",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "job snapshot",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: job snapshot",
      "Key columns: JobID, Contract, AssetTypeName, AssetCode, AssetName, ChainageFrom, JobLocation, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20utbl_current_month_job_snapshot.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "utbl_last_month_job_snapshot",
    "fullName": "transport_dev.transport_ramc.utbl_last_month_job_snapshot",
    "tableType": "MANAGED",
    "columnCount": 24,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: JobID, Contract, AssetTypeName, AssetCode, AssetName, ChainageFrom, JobLocation, EstimatedCost"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20utbl_last_month_job_snapshot.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "utbl_monthly_backlog_reduction",
    "fullName": "transport_dev.transport_ramc.utbl_monthly_backlog_reduction",
    "tableType": "MANAGED",
    "columnCount": 4,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: JobType, JobCount"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20utbl_monthly_backlog_reduction.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "utbl_reporting_period",
    "fullName": "transport_dev.transport_ramc.utbl_reporting_period",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20utbl_reporting_period.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_inspection",
    "fullName": "transport_dev.transport_ramc.uvw_inspection",
    "tableType": "VIEW",
    "columnCount": 36,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, contract, assettypename, assetid, assetcode, assetname, section, chainagefrom",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.inspection",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_inspection.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_ramc.uvw_job",
    "tableType": "VIEW",
    "columnCount": 45,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: contract, id, sapworkorder, assetid, assetcode, assetname, section, chainagefrom",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vjob, ext_mssql_asset_vision_ven_gen7.dbo.assetarea, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_job.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_job_temp",
    "fullName": "transport_dev.transport_ramc.uvw_job_temp",
    "tableType": "VIEW",
    "columnCount": 41,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: contract, id, sapworkorder, assetid, assetcode, assetname, section, chainagefrom",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vjob, ext_mssql_asset_vision_ven_gen7.dbo.assetarea",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_job_temp.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_roadlastinspected",
    "fullName": "transport_dev.transport_ramc.uvw_roadlastinspected",
    "tableType": "VIEW",
    "columnCount": 12,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Contract, AssetTypeName, AssetID, AssetCode, AssetName, InspectionID, InspectionTypeName, CompletedDate",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vinspection, latestinspection, ext_mssql_asset_vision_ven_gen7.dbo.asset",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_roadlastinspected.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_stripmap_full",
    "fullName": "transport_dev.transport_ramc.uvw_stripmap_full",
    "tableType": "VIEW",
    "columnCount": 25,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: AV_Asset_ID, AV_Asset_Code, JobID, assetname, ChainageFrom, ChainageTo, Chainage_Text, parentassetid",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, ext_mssql_asset_vision_ven_gen7.dbo.assetattribute, them, in",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_stripmap_full.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_stripmap_jobphotos",
    "fullName": "transport_dev.transport_ramc.uvw_stripmap_jobphotos",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "stripmap photo",
    "inferredCategory": "Documents / evidence",
    "inferredUse": "Store or report photos, attachments, documents, sign-offs, or other evidence records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: stripmap photo",
      "Key columns: JobID, Photo_ID",
      "View SQL references transport_dev.transport_ramc.uvw_stripmap_jobs, ext_mssql_asset_vision_ven_gen7.dbo.photo",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_stripmap_jobphotos.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_stripmap_jobs",
    "fullName": "transport_dev.transport_ramc.uvw_stripmap_jobs",
    "tableType": "VIEW",
    "columnCount": 56,
    "documentedDomain": "stripmap job",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: stripmap job",
      "Key columns: AV_Asset_ID, AV_Asset_Code, assetname, ChainageFrom, ChainageTo, Chainage_Text, parentassetid, parentassetcode",
      "View SQL references transport_dev.transport_ramc.uvw_job, to, on, ext_mssql_asset_vision_ven_gen7.dbo.asset",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_stripmap_jobs.md"
  },
  {
    "context": "transport_ramc",
    "contractor": "RAMC",
    "label": "RAMC / QSTC context",
    "tableName": "uvw_stripmap_wkt",
    "fullName": "transport_dev.transport_ramc.uvw_stripmap_wkt",
    "tableType": "VIEW",
    "columnCount": 11,
    "documentedDomain": "stripmap GIS",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: stripmap GIS",
      "Key columns: WKT_Object_ID, AV_Asset_ID, JobID, RideQualityClass, JobStatus, JobActivityType, JobCategory, WKT",
      "View SQL references transport_dev.transport_ramc.uvw_stripmap_jobs, for, ext_mssql_asset_vision_ven_gen7.dbo.vjob, transport_dev.transport_ramc.uvw_stripmap_full",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_ramc/Transport%20Table%20-%20transport_ramc%20-%20uvw_stripmap_wkt.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_nps03_sb",
    "fullName": "transport_dev.transport_sht.utbl_nps03_sb",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "sensor reading",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: sensor reading"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_nps03_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_nps04_nb",
    "fullName": "transport_dev.transport_sht.utbl_nps04_nb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "upload staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: upload staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_nps04_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_sps01_nb",
    "fullName": "transport_dev.transport_sht.utbl_sps01_nb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "upload staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: upload staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_sps01_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_sps02_sb",
    "fullName": "transport_dev.transport_sht.utbl_sps02_sb",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "sensor reading",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: sensor reading"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_sps02_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_ss_latitude",
    "fullName": "transport_dev.transport_sht.utbl_ss_latitude",
    "tableType": "MANAGED",
    "columnCount": 8,
    "documentedDomain": "service schedule",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: service schedule",
      "Key columns: Latitude"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_ss_latitude.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_nps03_sb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_nps03_sb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_nps03_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_nps04_nb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_nps04_nb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_nps04_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_sps01_nb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_sps01_nb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_sps01_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_sps02_sb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_sps02_sb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_sps02_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_tvs03_sb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_tvs03_sb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_tvs03_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tmp_tvs07_nb",
    "fullName": "transport_dev.transport_sht.utbl_tmp_tvs07_nb",
    "tableType": "MANAGED",
    "columnCount": 1,
    "documentedDomain": "temporary staging",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: temporary staging"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tmp_tvs07_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tvs03_sb",
    "fullName": "transport_dev.transport_sht.utbl_tvs03_sb",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "sensor reading",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: sensor reading"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tvs03_sb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "utbl_tvs07_nb",
    "fullName": "transport_dev.transport_sht.utbl_tvs07_nb",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "sensor reading",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: sensor reading"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20utbl_tvs07_nb.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_ai1",
    "fullName": "transport_dev.transport_sht.uvw_ai1",
    "tableType": "VIEW",
    "columnCount": 19,
    "documentedDomain": "inspection compliance",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection compliance",
      "Key columns: Inspection_ID, Inspection_Route_Name, Inspection_Type, Asset_Name, Asset_Code, Created_Date, Status, Completed",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.inspection, transport_dev.transport_sht.utbl_ss_latitude",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_ai1.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_ai2",
    "fullName": "transport_dev.transport_sht.uvw_ai2",
    "tableType": "VIEW",
    "columnCount": 17,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Job_ID, Created_Date, Asset_Name, Priority, Job_Type, Status, Completed_User, Completed_Date",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.job, ext_mssql_asset_vision_vns_gen7.dbo.formfield",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_ai2.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_all_assets",
    "fullName": "transport_dev.transport_sht.uvw_all_assets",
    "tableType": "VIEW",
    "columnCount": 35,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, Contract, AssetType, ParentAssetID, ParentAssetCode, ParentAssetName, ParentAssetTypeName, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.asset",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_all_assets.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_all_critical_assets",
    "fullName": "transport_dev.transport_sht.uvw_all_critical_assets",
    "tableType": "VIEW",
    "columnCount": 21,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, Contract, AssetCode, AssetName, AssetType, ParentAssetID, ParentAssetCode, ParentAssetName",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.asset, ext_mssql_asset_vision_vns_gen7.dbo.assetattribute, ext_mssql_asset_vision_vns_gen7.dbo.job",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_all_critical_assets.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_inspection",
    "fullName": "transport_dev.transport_sht.uvw_inspection",
    "tableType": "VIEW",
    "columnCount": 46,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: ID, AssetTypeName, AssetID, AssetCode, AssetName, Section, Contract, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.inspection",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_inspection.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_sht.uvw_job",
    "tableType": "VIEW",
    "columnCount": 80,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: ID, AssetID, AssetCode, AssetName, Section, Contract, HazardDefectCode, HazardCode",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.job",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_job.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_nps03_sb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_nps03_sb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_nps03_sb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_nps03_sb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_nps04_nb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_nps04_nb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_nps04_nb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_nps04_nb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_sps01_nb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_sps01_nb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_sps01_nb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_sps01_nb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_sps02_sb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_sps02_sb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_sps02_sb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_sps02_sb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_tvs03_sb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_tvs03_sb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_tvs03_sb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_tvs03_sb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_tvs07_nb_segmented",
    "fullName": "transport_dev.transport_sht.uvw_tvs07_nb_segmented",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "segmented sensor reading",
    "inferredCategory": "User / security",
    "inferredUse": "Represent user, group, or security context for reporting or access analysis.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: segmented sensor reading",
      "View SQL references transport_dev.transport_sht.utbl_tvs07_nb"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_tvs07_nb_segmented.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_user_groups",
    "fullName": "transport_dev.transport_sht.uvw_user_groups",
    "tableType": "VIEW",
    "columnCount": 2,
    "documentedDomain": "user mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: user mapping",
      "Key columns: Completed User, Amended Completed User",
      "View SQL references ext_mssql_asset_vision_vns_gen7.dbo.inspection",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_user_groups.md"
  },
  {
    "context": "transport_sht",
    "contractor": "SHT",
    "label": "Sydney Harbour Tunnel reporting context",
    "tableName": "uvw_weather_north_sydney_hourly_rolling_30days",
    "fullName": "transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days",
    "tableType": "VIEW",
    "columnCount": 62,
    "documentedDomain": "weather",
    "inferredCategory": "Weather",
    "inferredUse": "Provide weather observations or forecasts for operational context and reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: weather",
      "Key columns: relative_humidity_2m, weather_condition, cloud_cover_mid, row_created_exec_id, row_updated_exec_id, row_created_timestamp",
      "View SQL references staged_dev.stg_api_open_metro_au.north_sydney_hourly, staged_dev.stg_api_open_metro_au.weather_interpretation_codes",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_sht/Transport%20Table%20-%20transport_sht%20-%20uvw_weather_north_sydney_hourly_rolling_30days.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "utbl_monthly_report",
    "fullName": "transport_dev.transport_srapc.utbl_monthly_report",
    "tableType": "MANAGED",
    "columnCount": 12,
    "documentedDomain": "monthly reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: monthly reporting"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20utbl_monthly_report.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "utbl_srapc_formitize_mapping",
    "fullName": "transport_dev.transport_srapc.utbl_srapc_formitize_mapping",
    "tableType": "MANAGED",
    "columnCount": 7,
    "documentedDomain": "form mapping",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: form mapping"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20utbl_srapc_formitize_mapping.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "utbl_tacp_constants",
    "fullName": "transport_dev.transport_srapc.utbl_tacp_constants",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "TACP constants",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: TACP constants",
      "Key columns: assetMaintainerPrimaryContractId, assetMaintainerPrimaryId, assetcustodianId, assetownerId, senderServiceProviderId"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20utbl_tacp_constants.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "utbl_tacp_toc",
    "fullName": "transport_dev.transport_srapc.utbl_tacp_toc",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "TACP mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: TACP mapping",
      "Key columns: AssetType"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20utbl_tacp_toc.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "utbl_tmp_civil_master",
    "fullName": "transport_dev.transport_srapc.utbl_tmp_civil_master",
    "tableType": "MANAGED",
    "columnCount": 54,
    "documentedDomain": "civil maintenance master",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: civil maintenance master",
      "Key columns: Asset_Group, Asset_Group__level_1, Asset_Class__level_2, Asset_Type__level_3, Asset_Component__Level_4, Defect_identification__Evident_or_Hidden_, Latitude__Days_, No._Inspections_in_PF_Interval"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20utbl_tmp_civil_master.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_a_bridge_all_data",
    "fullName": "transport_dev.transport_srapc.uvw_a_bridge_all_data",
    "tableType": "VIEW",
    "columnCount": 58,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: ID, Asset Type, Parent Asset Code, Parent Asset Name, Parent Chainage, Condition, Parent Asset Type, Parent Asset Position",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.asset, ext_mssql_asset_vision_ven_rms.dbo.vassetlocation, ext_mssql_asset_vision_ven_rms.dbo.assetattribute, bridgesunpivioted",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_a_bridge_all_data.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_a_slope_all_data",
    "fullName": "transport_dev.transport_srapc.uvw_a_slope_all_data",
    "tableType": "VIEW",
    "columnCount": 86,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: ID, Asset Type, Parent Asset Code, Parent Asset Name, Parent Chainage From, Parent Chainage To, Condition, Parent Asset Type",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.asset, ext_mssql_asset_vision_ven_rms.dbo.assetattribute, slopesunpivioted, ext_mssql_asset_vision_ven_rms.dbo.job",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_a_slope_all_data.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_arcgis_jobs",
    "fullName": "transport_dev.transport_srapc.uvw_arcgis_jobs",
    "tableType": "VIEW",
    "columnCount": 20,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, priority, createddate, duedate, completedstatus, completeddate, createduser, completeduser",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.jobcomment, ext_mssql_asset_vision_ven_rms.dbo.vjob, ext_mssql_asset_vision_ven_rms.dbo.formfield, ext_mssql_asset_vision_ven_rms.dbo.workflowstatus",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_arcgis_jobs.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_asset",
    "fullName": "transport_dev.transport_srapc.uvw_asset",
    "tableType": "VIEW",
    "columnCount": 38,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, Contract, AssetType, ParentAssetID, ParentAssetCode, ParentAssetName, ParentAssetTypeName, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.asset, ext_mssql_asset_vision_ven_rms.dbo.vassetlocation",
      "View SQL includes spatial or linear-reference fields",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_asset.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_asset_all_data_withphoto",
    "fullName": "transport_dev.transport_srapc.uvw_asset_all_data_withphoto",
    "tableType": "VIEW",
    "columnCount": 56,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: Asset_ID, Asset_Type, Asset_Code, Asset_Name, Chainage_From, Chainage_To, Condition, Contract_Region",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.inspection, ext_mssql_asset_vision_ven_rms.dbo.photo, latestinsp, assetallphoto",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_asset_all_data_withphoto.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_asset_inspection_last",
    "fullName": "transport_dev.transport_srapc.uvw_asset_inspection_last",
    "tableType": "VIEW",
    "columnCount": 48,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, AssetTypeName, AssetID, AssetCode, AssetName, Section, Contract, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.inspection, ranked_inspections",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_asset_inspection_last.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_asset_inspection_next",
    "fullName": "transport_dev.transport_srapc.uvw_asset_inspection_next",
    "tableType": "VIEW",
    "columnCount": 48,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, AssetTypeName, AssetID, AssetCode, AssetName, Section, Contract, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.inspection, ranked_inspections",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_asset_inspection_next.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_assetattribute",
    "fullName": "transport_dev.transport_srapc.uvw_assetattribute",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, AssetID",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.assetattribute"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_assetattribute.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_av_tmp_combined",
    "fullName": "transport_dev.transport_srapc.uvw_av_tmp_combined",
    "tableType": "VIEW",
    "columnCount": 69,
    "documentedDomain": "staging / backup",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: staging / backup",
      "Key columns: Job ID, Asset Group, Priority, Latitude, Longitude, Created Date, Created Month, Status",
      "View SQL references transport_dev.transport_srapc.uvw_jobs_actgroup, transport_dev.transport_srapc.utbl_tmp_civil_master",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_av_tmp_combined.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_customerrequest",
    "fullName": "transport_dev.transport_srapc.uvw_customerrequest",
    "tableType": "VIEW",
    "columnCount": 28,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: ID, Contract, CompletedDate, CreatedDate, CreatedUser, AssetID, AssetCode, AssetName",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.module",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_customerrequest.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_customerrequest_all_attributes",
    "fullName": "transport_dev.transport_srapc.uvw_customerrequest_all_attributes",
    "tableType": "VIEW",
    "columnCount": 54,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Customer Request (VEN) ID, Created By User, Created Date, Completed Date , Asset Type, Asset ID, Asset Code, Asset Name",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.vmodule, ext_mssql_asset_vision_ven_rms.dbo.asset, ext_mssql_asset_vision_ven_rms.dbo.formfield, CustomerReqUnpivoted",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_customerrequest_all_attributes.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_customerrequestpivot",
    "fullName": "transport_dev.transport_srapc.uvw_customerrequestpivot",
    "tableType": "VIEW",
    "columnCount": 5,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: ModuleID",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.module, ext_mssql_asset_vision_ven_rms.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_customerrequestpivot.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_inspection_all_attributes",
    "fullName": "transport_dev.transport_srapc.uvw_inspection_all_attributes",
    "tableType": "VIEW",
    "columnCount": 41,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: Inspection ID, AssetTypeName, Created User, Completed User, Inspection Type Code, Inspection Type, Asset Type Name, Asset Code",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.job, ext_mssql_asset_vision_ven_rms.dbo.timesheetitem, ext_mssql_asset_vision_ven_rms.dbo.vinspection, ext_mssql_asset_vision_ven_rms.dbo.capitalwork",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_inspection_all_attributes.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_inspections_all",
    "fullName": "transport_dev.transport_srapc.uvw_inspections_all",
    "tableType": "VIEW",
    "columnCount": 42,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: Inspection ID, AssetTypeName, Created User, Completed User, Inspection Type Code, Inspection Type, Asset Type Category, Asset Type Name",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.job, ext_mssql_asset_vision_ven_rms.dbo.timesheetitem, ext_mssql_asset_vision_ven_rms.dbo.inspection, ext_mssql_asset_vision_ven_rms.dbo.capitalwork",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_inspections_all.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_srapc.uvw_job",
    "tableType": "VIEW",
    "columnCount": 82,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: ID, AssetID, AssetCode, AssetName, Section, Contract, HazardDefectCode, HazardCode",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.vjob, ext_mssql_asset_vision_ven_rms.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_job.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_job_all_attributes",
    "fullName": "transport_dev.transport_srapc.uvw_job_all_attributes",
    "tableType": "VIEW",
    "columnCount": 78,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: Job ID, Created Date, Created User, Contract, Contract Region, Asset Type Name, Asset ID, Asset Code",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.workflowstatus, ext_mssql_asset_vision_ven_rms.dbo.jobcomment, ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem, ext_mssql_asset_vision_ven_rms.dbo.module",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_job_all_attributes.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_jobs_actgroup",
    "fullName": "transport_dev.transport_srapc.uvw_jobs_actgroup",
    "tableType": "VIEW",
    "columnCount": 15,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: Job ID, Asset Group, Priority, Latitude, Longitude, Created Date, Created Month, Status",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.vjob",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_jobs_actgroup.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_jobs_am_weighted_score",
    "fullName": "transport_dev.transport_srapc.uvw_jobs_am_weighted_score",
    "tableType": "VIEW",
    "columnCount": 22,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, assetcode, priority, createddate, duedate, completeddate, completedstatus, inspectiontypename",
      "View SQL references transport_dev.transport_srapc.uvw_job",
      "View SQL calculates score or prioritisation fields",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_jobs_am_weighted_score.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_jobspowerbi",
    "fullName": "transport_dev.transport_srapc.uvw_jobspowerbi",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: Job ID, Priority, Created Date, Status, Incident > Is this an Incident?, Incident > Is there Asset Damage?, Job Data > Describe the Works Performed, Created By",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.jobcomment, ext_mssql_asset_vision_ven_rms.dbo.vjob, ext_mssql_asset_vision_ven_rms.dbo.formfield, ext_mssql_asset_vision_ven_rms.dbo.workflowstatus",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_jobspowerbi.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data",
    "tableType": "VIEW",
    "columnCount": 282,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Acid_sulfate_soils, Acid_sulfate_soils_generated_tonnes, Acid_sulfate_soils_Provider, Subcontractor email, Excavated Public Road Materials (EPRM) Waste, Liquid Waste, Hazardous Waste, Restricted Solid Waste",
      "View SQL references transport_dev.formitize_srapc.monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_energy",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy",
    "tableType": "VIEW",
    "columnCount": 37,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor, Subcontractor email, Main Type of Works, Contractor Representative Name",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_energy.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_health_safety",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_health_safety",
    "tableType": "VIEW",
    "columnCount": 15,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor email, Subcontractor, Main Type of Works, Contractor Representative Name, Number of safety inspections undertaken, Total number of Health and Safety Hazards reported",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_health_safety.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_material",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material",
    "tableType": "VIEW",
    "columnCount": 28,
    "documentedDomain": "inventory / materials",
    "inferredCategory": "Commercial / finance",
    "inferredUse": "Support cost, claim, subcontractor, procurement, material, waste, fuel, or commercial reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inventory / materials",
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor, Subcontractor email, Main Type of Works, Contractor Representative Name",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_material.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_social",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social",
    "tableType": "VIEW",
    "columnCount": 11,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor, Subcontractor email, Main Type of Works, Contractor Representative Name, Spend amount Aboriginal sub-subcontractors AUD ",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_social.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_stationary_fuel",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel",
    "tableType": "VIEW",
    "columnCount": 18,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor, Subcontractor email, Main Type of Works, Contractor Representative Name",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary, transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_stationary_fuel.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_monthly_subcontractor_data_waste",
    "fullName": "transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste",
    "tableType": "VIEW",
    "columnCount": 75,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Form ID, Name of Aboriginal vendor (sub subcontracted), Subcontractor, Subcontractor email, Main Type of Works, Contractor Representative Name, Acid_sulfate_soils_generated_tonnes, Acid_sulfate_soils_Provider",
      "View SQL references transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_monthly_subcontractor_data_waste.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_ndh_shift_report",
    "fullName": "transport_dev.transport_srapc.uvw_ndh_shift_report",
    "tableType": "VIEW",
    "columnCount": 20,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: id, ReportAssetID, ReportJobID, CompletedJobType, HighPriorityJobCivil, HighPriorityJobITS, completedstatus, createddate",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.job, ext_mssql_asset_vision_ven_rms.dbo.asset, ext_mssql_asset_vision_ven_rms.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_ndh_shift_report.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_pbi_master_jobs_export",
    "fullName": "transport_dev.transport_srapc.uvw_pbi_master_jobs_export",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: Job ID, Priority, Created Date, Status, Incident > Is this an Incident?, Incident > Is there Asset Damage?, Job Data > Describe the Works Performed, Created By",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.jobcomment, ext_mssql_asset_vision_ven_rms.dbo.vjob, ext_mssql_asset_vision_ven_rms.dbo.formfield, ext_mssql_asset_vision_ven_rms.dbo.workflowstatus",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_pbi_master_jobs_export.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_photos_unique",
    "fullName": "transport_dev.transport_srapc.uvw_photos_unique",
    "tableType": "VIEW",
    "columnCount": 12,
    "documentedDomain": "documents / evidence",
    "inferredCategory": "Documents / evidence",
    "inferredUse": "Store or report photos, attachments, documents, sign-offs, or other evidence records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: documents / evidence",
      "Key columns: ID, CreatedDate, CreatedUser, SourceTableID",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.photo",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_photos_unique.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_school_zone",
    "fullName": "transport_dev.transport_srapc.uvw_school_zone",
    "tableType": "VIEW",
    "columnCount": 3,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: id, sourcetableid",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.inspection, ext_mssql_asset_vision_ven_rms.dbo.photo",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_school_zone.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_srapc_assets",
    "fullName": "transport_dev.transport_srapc.uvw_srapc_assets",
    "tableType": "VIEW",
    "columnCount": 22,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: Asset_Table_ID, Asset_Location_Table_ID, Assetid, Asset_Spatial_Type, assettype, contract, parentassetid, parentassetcode",
      "View SQL references ext_mssql_asset_vision_ven_rms.dbo.vassetlocation, ext_mssql_asset_vision_ven_rms.dbo.asset, MinLatitudeCTE, ext_mssql_asset_vision_ven_rms.dbo.photo",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_srapc_assets.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_srapc_jobs_am_weighted_score",
    "fullName": "transport_dev.transport_srapc.uvw_srapc_jobs_am_weighted_score",
    "tableType": "VIEW",
    "columnCount": 21,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, assetcode, priority, createddate, duedate, completeddate, completedstatus, inspectiontypename",
      "View SQL references transport_dev.transport_srapc.uvw_job",
      "View SQL calculates score or prioritisation fields",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_srapc_jobs_am_weighted_score.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_srapc_special_projects",
    "fullName": "transport_dev.transport_srapc.uvw_srapc_special_projects",
    "tableType": "VIEW",
    "columnCount": 94,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: issue_id, status, priority, created, Finalisation Handover completed?, Planning - % Completed To Date",
      "View SQL references staged_dev.stg_api_jira_proj_tran_srapc.issues, staged_dev.stg_api_jira_proj_tran_srapc.custom_fields, combinedissues",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_srapc_special_projects.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_srapc_tfnsw_monthly_report_defect_intervention",
    "fullName": "transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention",
    "tableType": "VIEW",
    "columnCount": 11,
    "documentedDomain": "defects / hazards / failures",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: defects / hazards / failures",
      "Key columns: Asset_Class, Defect_Type, Priority, priority_type, Longitude, Latitude",
      "View SQL references transport_dev.transport_srapc.uvw_job",
      "View SQL includes spatial or linear-reference fields"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_srapc_tfnsw_monthly_report_defect_intervention.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_tacp_data_delta_load",
    "fullName": "transport_dev.transport_srapc.uvw_tacp_data_delta_load",
    "tableType": "VIEW",
    "columnCount": 65,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: serviceProviderAssetId, assetDescription, recordStatus, assetOwnerId, assetCustodianId, assetMaintainerPrimaryId, assetMaintainerPrimaryContractId, assetStatusCode",
      "View SQL references transport_dev.transport_srapc.uvw_asset, transport_dev.transport_srapc.utbl_tacp_toc, transport_dev.transport_srapc.uvw_assetattribute, transport_dev.transport_srapc.utbl_tacp_constants",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_tacp_data_delta_load.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_tacp_data_initial_load",
    "fullName": "transport_dev.transport_srapc.uvw_tacp_data_initial_load",
    "tableType": "VIEW",
    "columnCount": 65,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: serviceProviderAssetId, assetDescription, recordStatus, assetOwnerId, assetCustodianId, assetMaintainerPrimaryId, assetMaintainerPrimaryContractId, assetStatusCode",
      "View SQL references transport_dev.transport_srapc.uvw_asset, transport_dev.transport_srapc.utbl_tacp_toc, transport_dev.transport_srapc.uvw_assetattribute, transport_dev.transport_srapc.utbl_tacp_constants",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_tacp_data_initial_load.md"
  },
  {
    "context": "transport_srapc",
    "contractor": "SRAPC",
    "label": "SRAPC",
    "tableName": "uvw_weatherobervations",
    "fullName": "transport_dev.transport_srapc.uvw_weatherobervations",
    "tableType": "VIEW",
    "columnCount": 26,
    "documentedDomain": "weather",
    "inferredCategory": "Weather",
    "inferredUse": "Provide weather observations or forecasts for operational context and reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: weather",
      "Key columns: station_id",
      "View SQL references staged_dev.stg_api_bom_au.bom_au_station_weather_details",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_srapc/Transport%20Table%20-%20transport_srapc%20-%20uvw_weatherobervations.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "bkp_uvw_incident_closures",
    "fullName": "transport_dev.transport_tsrc.bkp_uvw_incident_closures",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "incident closure",
    "inferredCategory": "Staging / backup",
    "inferredUse": "Hold uploaded, temporary, backup, snapshot, or raw working data that needs source-of-truth validation before operational use.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: incident closure",
      "Key columns: parentsourcetableid, IncidentClosureDetails-TGS, IncidentClosureDetails-ClosurePurpose, IncidentClosureDetails-ClosureType, IncidentClosureDetails-Section, IncidentClosureDetails-Appliedby"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20bkp_uvw_incident_closures.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_asset_bridge",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_asset_bridge",
    "tableType": "MANAGED",
    "columnCount": 56,
    "documentedDomain": "bridge asset",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: bridge asset",
      "Key columns: Road ID, Asset Description, Asset ID, Section, Bridge Name, Start Chainage, End Chainage, Left Width"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_asset_bridge.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_assets",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_assets",
    "tableType": "MANAGED",
    "columnCount": 4,
    "documentedDomain": "AED asset",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: AED asset",
      "Key columns: AssetId, AssetTag"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_assets.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_incidents_closures",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_incidents_closures",
    "tableType": "MANAGED",
    "columnCount": 34,
    "documentedDomain": "incident closure",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: incident closure",
      "Key columns: Closure ID, Status, StatusDate, SectionId, Section, HasGuideline, ChainageStart, ChainageEnd"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_incidents_closures.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_incidents_events",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_incidents_events",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "incident event",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: incident event",
      "Key columns: Event ID, Incident No"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_incidents_events.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_incidents_list",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_incidents_list",
    "tableType": "MANAGED",
    "columnCount": 11,
    "documentedDomain": "incident",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: incident",
      "Key columns: Incident Id, Incident, IncidentType, Status, StatusDate, section, IncidentLocation"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_incidents_list.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_incidents_sr",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_incidents_sr",
    "tableType": "MANAGED",
    "columnCount": 14,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Id, Asset, Status, StatusDate, WONum, WODesc, WOCreate, WOStatus"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_incidents_sr.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_inspection_requirements",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_inspection_requirements",
    "tableType": "MANAGED",
    "columnCount": 8,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Id"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_inspection_requirements.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_wo_assets",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_wo_assets",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: WO_Asset_Id, WorkOrderId, AssetId, AssetTag"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_wo_assets.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_aed_wo_list",
    "fullName": "transport_dev.transport_tsrc.utbl_aed_wo_list",
    "tableType": "MANAGED",
    "columnCount": 25,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI",
      "Key columns: WO Num, WorkType, WOStatus, StatusDate, TargetCompleteDate, ActualCompleteDate, ScheduledCompleteDate, CreateDate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_aed_wo_list.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_asset_perf_maint_kpi25_1",
    "fullName": "transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1",
    "tableType": "MANAGED",
    "columnCount": 32,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettype, assetname, AssetSubType, Asset_Type, Asset_Raised_Against, AV_Asset_Name, AV_Inspection_Name"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_asset_perf_maint_kpi25_1.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_asset_perf_maint_kpi25_2",
    "fullName": "transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2",
    "tableType": "MANAGED",
    "columnCount": 33,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettype, AssetSubType, Asset_Raised_Against, Asset_Type, DueDate, scheduledinspid, CompletedJobId"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_asset_perf_maint_kpi25_2.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_asset_perf_maint_kpi25_3",
    "fullName": "transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3",
    "tableType": "MANAGED",
    "columnCount": 30,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettypename, assetcode, createddate_time, duedate_time, completeddate_time, createddate, duedate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_asset_perf_maint_kpi25_3.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_asset_register",
    "fullName": "transport_dev.transport_tsrc.utbl_asset_register",
    "tableType": "MANAGED",
    "columnCount": 66,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Asset, Asset Name, Asset Type, Asset ID, Asset Description, Asset Modelled, ID, OMParentAssetID"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_asset_register.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_incident_triggered_section_geom",
    "fullName": "transport_dev.transport_tsrc.utbl_incident_triggered_section_geom",
    "tableType": "MANAGED",
    "columnCount": 39,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Key columns: TriggerSectionId, assetcode, assetname, incidentcount, minChainage, minIncidentDate, maxChainage, maxIncidentDate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_incident_triggered_section_geom.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_kpi2_road_safety",
    "fullName": "transport_dev.transport_tsrc.utbl_kpi2_road_safety",
    "tableType": "MANAGED",
    "columnCount": 127,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, contract, completeddate, incidentdescription, createddate, createduser, assetid, assetcode"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_kpi2_road_safety.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_pavement_reporting_sections_test",
    "fullName": "transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test",
    "tableType": "MANAGED",
    "columnCount": 12,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: PavementReportingSection, RoadName, ReportingSectionType, StartChainage, EndChainage"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_pavement_reporting_sections_test.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_pcas_test",
    "fullName": "transport_dev.transport_tsrc.utbl_pcas_test",
    "tableType": "MANAGED",
    "columnCount": 17,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: WKT, PavementSectionID, fid, RoadName, chainage_start, chainage_end"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_pcas_test.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_activitytype_to_category_mapping",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_activitytype_to_category_mapping",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_activitytype_to_category_mapping.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_comp_code_to_inc_category",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: id"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_comp_code_to_inc_category.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_corrective_maintenance_compliance",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance",
    "tableType": "MANAGED",
    "columnCount": 12,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Spec_ID, KPIComplianceRequirement"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_corrective_maintenance_compliance.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_date_table",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_date_table",
    "tableType": "MANAGED",
    "columnCount": 25,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: PublicHoliday, PublicHolidayName"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_date_table.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_incident_group",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_incident_group",
    "tableType": "MANAGED",
    "columnCount": 2,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: IncidentGroupNumber, IncidentGroup"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_incident_group.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_inspection_due_dates_monthly",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly",
    "tableType": "MANAGED",
    "columnCount": 7,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: DueDate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_inspection_due_dates_monthly.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_inspection_due_dates_weekly",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: DueDate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_inspection_due_dates_weekly.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_inspection_due_dates_yearly",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly",
    "tableType": "MANAGED",
    "columnCount": 8,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: DueDate"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_inspection_due_dates_yearly.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_kpi_25_coms_asset_ref",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_kpi_25_coms_asset_ref",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Asset_Type_Name"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_kpi_25_coms_asset_ref.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_abate_pct",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_abate_pct.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_financial_factor",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_financial_factor.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_lane_factor",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_lane_factor",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Section"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_lane_factor.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_section_factor",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_section_factor",
    "tableType": "MANAGED",
    "columnCount": 2,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Section"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_section_factor.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_special_day",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_special_day.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_lane_closure_type",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_lane_closure_type",
    "tableType": "MANAGED",
    "columnCount": 2,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_lane_closure_type.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_road_chng_10_m",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_road_chng_10_m",
    "tableType": "MANAGED",
    "columnCount": 7,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Asset Type, Asset Code, Chainage, Latitude, Longitude"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_road_chng_10_m.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_routine_inspection_compliance",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance",
    "tableType": "MANAGED",
    "columnCount": 12,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: COMS Section, COMS Asset Name, AV Asset Name, AV Inspection Name, Asset Raised Against, Asset Type, Date Valid From, Date Valid To"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_routine_inspection_compliance.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_routine_maintenance_compliance",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_routine_maintenance_compliance",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Intervention ID, Asset Raised Against, Asset Type, Date Valid From, Date Valid To, Intervention ID2"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_routine_maintenance_compliance.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_section_to_km_mapping",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping",
    "tableType": "MANAGED",
    "columnCount": 10,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: id, sectionid, chainage_start, chainage_end"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_section_to_km_mapping.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_section_to_m_mapping_2_km_sections",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections",
    "tableType": "MANAGED",
    "columnCount": 10,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: ID, AssetName, IncidentKey, SectionID"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_section_to_m_mapping_2_km_sections.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_ref_sections_kpi",
    "fullName": "transport_dev.transport_tsrc.utbl_ref_sections_kpi",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Section No, Section, KPI 4, KPI 5, KPI-6"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_ref_sections_kpi.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_road_safety_audit_register",
    "fullName": "transport_dev.transport_tsrc.utbl_road_safety_audit_register",
    "tableType": "MANAGED",
    "columnCount": 35,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, contract, completeddate, createddate, createduser, assetid, assetcode, assetname"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_road_safety_audit_register.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_test_condition_data",
    "fullName": "transport_dev.transport_tsrc.utbl_test_condition_data",
    "tableType": "MANAGED",
    "columnCount": 11,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: assetnum, siteid, classificationid"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_test_condition_data.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "utbl_work_order",
    "fullName": "transport_dev.transport_tsrc.utbl_work_order",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Work Order, Asset, Status, Priority, Anywhere Created, Work Type, Work Group, Job Plan"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20utbl_work_order.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_asset_perf_maint_kpi25_1",
    "fullName": "transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1",
    "tableType": "VIEW",
    "columnCount": 30,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettype, assetname, ElectricalAssetType, MechanicalAssetType, Asset Type, Asset Raised Against, AV Asset Name",
      "View SQL references transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance, transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly, transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly, transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_asset_perf_maint_kpi25_1.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_assets",
    "fullName": "transport_dev.transport_tsrc.uvw_assets",
    "tableType": "VIEW",
    "columnCount": 37,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, assetname, contract, assettype, parentassetid, parentassetcode, parentassetname, parentassettypename",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, ext_mssql_asset_vision_ven_gen7.dbo.assetattribute, assetspivot, assetconsolidate",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_assets.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_capital_work",
    "fullName": "transport_dev.transport_tsrc.uvw_capital_work",
    "tableType": "VIEW",
    "columnCount": 18,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: capitalworkid, capitalworkname, taskid, assettypename, assetid, assetcode, assetname, section",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.capitalwork, ext_mssql_asset_vision_ven_gen7.dbo.capitalworktask",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_capital_work.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_customer_requests",
    "fullName": "transport_dev.transport_tsrc.uvw_customer_requests",
    "tableType": "VIEW",
    "columnCount": 88,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: id, contract, completeddate, createddate, createduser, assetid, assetcode, assetname",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.formfield, ext_mssql_asset_vision_ven_gen7.dbo.module, custreqpivot",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_customer_requests.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_customer_requests_report",
    "fullName": "transport_dev.transport_tsrc.uvw_customer_requests_report",
    "tableType": "VIEW",
    "columnCount": 8,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: ID, CreatedDate",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.module, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_customer_requests_report.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_incident_closures",
    "fullName": "transport_dev.transport_tsrc.uvw_incident_closures",
    "tableType": "VIEW",
    "columnCount": 6,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Key columns: parentsourcetableid, IncidentClosureDetails-TGS, IncidentClosureDetails-ClosurePurpose, IncidentClosureDetails-ClosureType, IncidentClosureDetails-Section, IncidentClosureDetails-Appliedby",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.formfield, ext_mssql_asset_vision_ven_gen7.dbo.module, tmp",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_incident_closures.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_incident_report",
    "fullName": "transport_dev.transport_tsrc.uvw_incident_report",
    "tableType": "VIEW",
    "columnCount": 25,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Key columns: id, CreatedDate, IncidentDescription, IncidentStatus, RoadName, ChainageFrom, ChainageTo, Chainage",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.module, ext_mssql_asset_vision_ven_gen7.dbo.formfield, transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_incident_report.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_incident_trigger_report_map_geom",
    "fullName": "transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom",
    "tableType": "VIEW",
    "columnCount": 7,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Key columns: UID, ObjectId, TriggerSectionId, incidentid, WKT",
      "View SQL references utbl_incident_triggered_section_geom, uvw_incident_triggered_report",
      "View SQL includes spatial or linear-reference fields",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_incident_trigger_report_map_geom.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_incident_triggered_report",
    "fullName": "transport_dev.transport_tsrc.uvw_incident_triggered_report",
    "tableType": "VIEW",
    "columnCount": 17,
    "documentedDomain": "incidents",
    "inferredCategory": "Incidents / closures",
    "inferredUse": "Track incidents, closures, unavailability events, event categories, or incident-triggered reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: incidents",
      "Key columns: TriggerSectionId, assetcode, assetname, incidentid, incidentchainage, minChainage, maxChainage, rolling5countpertriggersectionid",
      "View SQL references utbl_kpi2_road_safety, tmp, utbl_ref_section_to_m_mapping_2_km_sections, TriggerSection",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_incident_triggered_report.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_inspection",
    "fullName": "transport_dev.transport_tsrc.uvw_inspection",
    "tableType": "VIEW",
    "columnCount": 54,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: ID, AssetTypeName, AssetID, AssetCode, AssetName, Section, Contract, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vinspection, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_inspection.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_tsrc.uvw_job",
    "tableType": "VIEW",
    "columnCount": 64,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, assetid, assetcode, assetname, assettypename, section, interventionid, hazardcode",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.photo, ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem, ext_mssql_asset_vision_ven_gen7.dbo.job, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_job.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_jobs_all_attributes",
    "fullName": "transport_dev.transport_tsrc.uvw_jobs_all_attributes",
    "tableType": "VIEW",
    "columnCount": 127,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: ID, AssetID, AssetCode, AssetName, Section, Contract, HazardDefectCode, HazardCode",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.job, ext_mssql_asset_vision_ven_gen7.dbo.formfield, ext_mssql_asset_vision_ven_gen7.dbo.vjob, jobspivot",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_jobs_all_attributes.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_10_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 28,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetid, assetcode, assetname, createddate, createduser, TMRRequestIDRef, completeddate",
      "View SQL references transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests, date, transport_dev.transport_tsrc.utbl_ref_date_table, DateExpanded",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_10_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_10_cctv_requests",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests",
    "tableType": "VIEW",
    "columnCount": 16,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetid, assetcode, assetname, createddate, createduser, TMRRequestIDRef, completeddate",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.formfield, ext_mssql_asset_vision_ven_gen7.dbo.module, cctvreqpivot, transport_dev.transport_tsrc.utbl_ref_date_table",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_10_cctv_requests.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_20_21_pcas_test",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: PavementSectionID, ReportingSectionType, kpi_incidents",
      "View SQL references transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test, tmp, tmp2",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_20_21_pcas_test.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_22_23_pcas_test",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test",
    "tableType": "VIEW",
    "columnCount": 15,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: fid, PavementSectionID, ReportingSectionType, RoadName, chainage_start, chainage_end, WKT, kpi_incidents",
      "View SQL references transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test, tmp, tmp2",
      "View SQL includes spatial or linear-reference fields",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_22_23_pcas_test.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_7_to_14_its_asset_uptime",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime",
    "tableType": "VIEW",
    "columnCount": 45,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: ID, Contract, AssetType, ParentAssetID, ParentAssetCode, ParentAssetName, ParentAssetTypeName, ChainageFrom",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, assetstble, transport_dev.transport_tsrc.utbl_ref_date_table, ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_7_to_14_its_asset_uptime.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi_7_to_14_its_jobs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettypename, assetcode, assetname, createddate_time, duedate_time, completeddate_time, createddate",
      "View SQL references transport_dev.transport_tsrc.uvw_jobs_all_attributes, All, transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance, transport_dev.transport_tsrc.utbl_ref_date_table",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi_7_to_14_its_jobs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi18_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi18_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 52,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetcode, chainagefrom, chainageto, createddate, CloseOutDetails-Status, CloseOutDetails-DescNoiseRectWorks, CloseOutDetails-AgreedRectDueDate",
      "View SQL references transport_dev.transport_tsrc.uvw_kpi18_noise_events, date, transport_dev.transport_tsrc.utbl_ref_date_table, DateExpanded",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi18_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi18_noise_events",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi18_noise_events",
    "tableType": "VIEW",
    "columnCount": 43,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetcode, chainagefrom, chainageto, createddate, CloseOutDetails-Status, CloseOutDetails-DescNoiseRectWorks, CloseOutDetails-AgreedRectDueDate",
      "View SQL references transport_dev.transport_tsrc.utbl_ref_date_table, transport_dev.transport_tsrc.uvw_customer_requests, transport_dev.transport_tsrc.utbl_ref_road_chng_10_m, tmp1",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi18_noise_events.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi19_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi19_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 53,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetcode, chainagefrom, chainageto, createddate, CloseOutDetails-Status, CloseOutDetails-DescNoiseRectWorks, CloseOutDetails-AgreedRectDueDate",
      "View SQL references transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events, transport_dev.transport_tsrc.utbl_ref_date_table, DateExpanded",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi19_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi19_stakeholder_events",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events",
    "tableType": "VIEW",
    "columnCount": 46,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assetcode, chainagefrom, chainageto, createddate, CloseOutDetails-Status, CloseOutDetails-DescNoiseRectWorks, CloseOutDetails-AgreedRectDueDate",
      "View SQL references transport_dev.transport_tsrc.utbl_ref_date_table, transport_dev.transport_tsrc.uvw_customer_requests, transport_dev.transport_tsrc.utbl_ref_road_chng_10_m, tmp1",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi19_stakeholder_events.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi2_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi2_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 40,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: TriggerSectionId, assetcode, assetname, incidentcount, minChainage, minIncidentDate, maxChainage, maxIncidentDate",
      "View SQL references transport_dev.transport_tsrc.utbl_ref_date_table, transport_dev.transport_tsrc.utbl_incident_triggered_section_geom, transport_dev.transport_tsrc.utbl_road_safety_audit_register, kpi2_compliance",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi2_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi25_1_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi25_1_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 34,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: assettype, Asset_Raised_Against, AV_Inspection_Name, DueDate, Completeddate, ComplianceStatus, ReqInspId, KPI_Assessment_Date_time",
      "View SQL references transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1, transport_dev.transport_tsrc.utbl_ref_date_table, step1, step2",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi25_1_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi25_2_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 35,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: assettype, Asset_Type, Asset_Raised_Against, DueDate, Completeddate, ComplianceStatus, ReqMaintId, KPI_Assessment_Date_time",
      "View SQL references transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2, transport_dev.transport_tsrc.utbl_ref_date_table, step1, step2",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi25_2_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi25_3_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 49,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, assettypename, assetcode, createddate_time, duedate_time, completeddate_time, createddate, duedate",
      "View SQL references transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3, date, transport_dev.transport_tsrc.utbl_ref_date_table, DateExpanded",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi25_3_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi3_abatement_costs",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi3_abatement_costs",
    "tableType": "VIEW",
    "columnCount": 64,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: capital works id, capital works id link, capital works name, capital works description, capitalworktype, capital works asset type, capital works asset id, capital works asset code",
      "View SQL references transport_dev.transport_tsrc.utbl_ref_date_table, transport_dev.transport_tsrc.uvw_kpi3_road_safety, kpi3businessday, kpi3abatementcost",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi3_abatement_costs.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi3_road_safety",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi3_road_safety",
    "tableType": "VIEW",
    "columnCount": 54,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: capital works id, capital works id link, capital works name, capital works description, capitalworktype, capital works asset type, capital works asset id, capital works asset code",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork, ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask, ext_mssql_asset_vision_ven_gen7.dbo.formfield, tmp",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi3_road_safety.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_kpi456_incidents",
    "fullName": "transport_dev.transport_tsrc.uvw_kpi456_incidents",
    "tableType": "VIEW",
    "columnCount": 23,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: id, id_link, SectionID, Section, IncidentGroup, IncidentStatus, KPI4 Target, KPI5 Target",
      "View SQL references transport_dev.transport_tsrc.utbl_kpi2_road_safety, transport_dev.transport_tsrc.utbl_ref_sections_kpi, incidentstagedatetime, kpifailed",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_kpi456_incidents.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_all_attributes",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_all_attributes",
    "tableType": "VIEW",
    "columnCount": 103,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, DnC_Defect, Network Group, AV_Asset_ID, AV_Asset_Code",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_numeric_data, pcas_vals",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_all_attributes.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_capdone_pivotted",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted",
    "tableType": "VIEW",
    "columnCount": 19,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: cap_assetname",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane, captrt, captrt_grouped",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_capdone_pivotted.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_caplentrted_pivotted",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted",
    "tableType": "VIEW",
    "columnCount": 19,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: caplen_assetname",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane, caplentrt, caplentrt_grouped",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_caplentrted_pivotted.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_condrating_pivotted",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted",
    "tableType": "VIEW",
    "columnCount": 14,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: AV_Asset_ID_CondRating",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_numeric_data, pcas_condrating",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_condrating_pivotted.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_lppc_defects_pivotted",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted",
    "tableType": "VIEW",
    "columnCount": 110,
    "documentedDomain": "defects / hazards / failures",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: defects / hazards / failures",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, DnC_Defect, Network Group, AV_Asset_ID, AV_Asset_Code",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_numeric_data, pcas_pass_fail, it, transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_lppc_defects_pivotted.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_numeric_data",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_numeric_data",
    "tableType": "VIEW",
    "columnCount": 43,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, DnC_Defect, Network Group, AV_Asset_ID, AV_Asset_Code",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, ext_mssql_asset_vision_ven_gen7.dbo.assetattribute, in, assetjoined",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_numeric_data.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_numeric_data_pivotted",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted",
    "tableType": "VIEW",
    "columnCount": 41,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, DnC_Defect, Network Group, AV_Asset_ID, AV_Asset_Code",
      "View SQL references transport_dev.transport_tsrc.uvw_pcas_numeric_data, pcas_vals",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_numeric_data_pivotted.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_seg_geom_wkt",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt",
    "tableType": "VIEW",
    "columnCount": 8,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: AV_Asset_ID, assetname, Chainage_Text, WKT",
      "View SQL includes spatial or linear-reference fields",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_seg_geom_wkt.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_stripmap_all",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_stripmap_all",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, AV_Asset_ID, AV_Asset_Code, contract, parentassetid",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, ext_mssql_asset_vision_ven_gen7.dbo.assetattribute, in, assetjoined",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_stripmap_all.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_stripmap_ele_capworks_singlelane",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane",
    "tableType": "VIEW",
    "columnCount": 27,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, AV_Asset_ID, AV_Asset_Code, contract, parentassetid",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork, to, ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_stripmap_ele_capworks_singlelane.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_pcas_stripmap_ele_feature_singlelane",
    "fullName": "transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane",
    "tableType": "VIEW",
    "columnCount": 27,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Key columns: parentassetcode, parentassetname, assetname, Chainage_Text, AV_Asset_ID, AV_Asset_Code, contract, parentassetid",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.asset, ext_mssql_asset_vision_ven_gen7.dbo.assetattribute, in, assetjoined",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_pcas_stripmap_ele_feature_singlelane.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_road_safety_audit_register",
    "fullName": "transport_dev.transport_tsrc.uvw_road_safety_audit_register",
    "tableType": "VIEW",
    "columnCount": 35,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, contract, completeddate, createddate, createduser, assetid, assetcode, assetname",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.formfield, ext_mssql_asset_vision_ven_gen7.dbo.module, RoadSafetyAuditRegPivot, RSAKey",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_road_safety_audit_register.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_sys_av_devices",
    "fullName": "transport_dev.transport_tsrc.uvw_sys_av_devices",
    "tableType": "VIEW",
    "columnCount": 12,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset, AssetType, KPI_No, Work Type",
      "View SQL references utbl_work_order, utbl_asset_register",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_sys_av_devices.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_test_asset_condition_report",
    "fullName": "transport_dev.transport_tsrc.uvw_test_asset_condition_report",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: siteid",
      "View SQL references transport_dev.transport_tsrc.utbl_test_condition_data, S1, S2",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_test_asset_condition_report.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_tollroad_unavailability_events",
    "fullName": "transport_dev.transport_tsrc.uvw_tollroad_unavailability_events",
    "tableType": "VIEW",
    "columnCount": 32,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: Incident Id, Incident Name, Incident Type, Abatement Section, Subsection Location, IncidentStatus, Overview-DidanAbatementOccur, IncidentClosureDetails-ClosurePurpose",
      "View SQL references start, transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct, transport_dev.transport_tsrc.utbl_kpi2_road_safety, transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_tollroad_unavailability_events.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_traffic_closures",
    "fullName": "transport_dev.transport_tsrc.uvw_traffic_closures",
    "tableType": "VIEW",
    "columnCount": 17,
    "documentedDomain": "traffic closure",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: traffic closure",
      "Key columns: id, CreatedDate, IncidentDescription, Chainage, Section, AEDExternalID, AVIncidentID",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.module, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_traffic_closures.md"
  },
  {
    "context": "transport_tsrc",
    "contractor": "TSRC",
    "label": "TSRC",
    "tableName": "uvw_traffic_volume",
    "fullName": "transport_dev.transport_tsrc.uvw_traffic_volume",
    "tableType": "VIEW",
    "columnCount": 10,
    "documentedDomain": "traffic volume",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: traffic volume",
      "Key columns: id, createddate, roadname, sectionname",
      "View SQL references ext_mssql_asset_vision_ven_gen7.dbo.module, ext_mssql_asset_vision_ven_gen7.dbo.formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_tsrc/Transport%20Table%20-%20transport_tsrc%20-%20uvw_traffic_volume.md"
  },
  {
    "context": "transport_vsm",
    "contractor": "VSM",
    "label": "VSM",
    "tableName": "uvw_all_asset_with_photo",
    "fullName": "transport_dev.transport_vsm.uvw_all_asset_with_photo",
    "tableType": "VIEW",
    "columnCount": 25,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, contract, assettype, parentassetid, parentassetcode, parentassetname, latestjobid, Photo1",
      "View SQL references ext_mssql_asset_vision_vsm_gen7.dbo.job, ext_mssql_asset_vision_vsm_gen7.dbo.photo, latestjob, assetallphoto",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_vsm/Transport%20Table%20-%20transport_vsm%20-%20uvw_all_asset_with_photo.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_capitalwork_chainage",
    "fullName": "transport_dev.transport_wru.utbl_capitalwork_chainage",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "capital work",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: capital work",
      "Key columns: Capital_Work_ID, assettype, RoadNo, ChainageFrom"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_capitalwork_chainage.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_counter_locations",
    "fullName": "transport_dev.transport_wru.utbl_counter_locations",
    "tableType": "MANAGED",
    "columnCount": 24,
    "documentedDomain": "traffic counter",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic counter",
      "Key columns: Metrocount ID, Parent_Asset_Code, Parent_Asset_Name, Condition, Parent_Asset_Type, Latitude, Longitude, Contract"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_counter_locations.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_counts_by_carriageway",
    "fullName": "transport_dev.transport_wru.utbl_counts_by_carriageway",
    "tableType": "MANAGED",
    "columnCount": 22,
    "documentedDomain": "traffic count",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic count",
      "Key columns: SiteID, Working_sensors, percent_working_sensors"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_counts_by_carriageway.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_counts_by_lane",
    "fullName": "transport_dev.transport_wru.utbl_counts_by_lane",
    "tableType": "MANAGED",
    "columnCount": 25,
    "documentedDomain": "traffic count",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic count",
      "Key columns: SiteID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_counts_by_lane.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_counts_hourly",
    "fullName": "transport_dev.transport_wru.utbl_counts_hourly",
    "tableType": "MANAGED",
    "columnCount": 26,
    "documentedDomain": "traffic count",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic count",
      "Key columns: SiteID, day_night_status"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_counts_hourly.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_date_table",
    "fullName": "transport_dev.transport_wru.utbl_date_table",
    "tableType": "MANAGED",
    "columnCount": 13,
    "documentedDomain": "reference date",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: reference date"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_date_table.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_eot_reasons",
    "fullName": "transport_dev.transport_wru.utbl_eot_reasons",
    "tableType": "MANAGED",
    "columnCount": 2,
    "documentedDomain": "extension of time",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: extension of time",
      "Key columns: Job_ID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_eot_reasons.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_inspection_road_sections",
    "fullName": "transport_dev.transport_wru.utbl_inspection_road_sections",
    "tableType": "MANAGED",
    "columnCount": 10,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Asset_Type, Asset_Code, Asset_Name, Section_Name, Section_Desc, Forward_Start_Chainage, Forward_End_Chainage, Reverse_Start_Chainage"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_inspection_road_sections.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_lane_access_lane_config",
    "fullName": "transport_dev.transport_wru.utbl_lane_access_lane_config",
    "tableType": "MANAGED",
    "columnCount": 7,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: NB_ROAD, RoadName, Chainage Direction, Start Chainage (SRRS), End Chainage (SRRS)"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_lane_access_lane_config.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_lane_access_road_chainage",
    "fullName": "transport_dev.transport_wru.utbl_lane_access_road_chainage",
    "tableType": "MANAGED",
    "columnCount": 5,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Road_No, Divided Section"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_lane_access_road_chainage.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_lane_access_traffic_volumes",
    "fullName": "transport_dev.transport_wru.utbl_lane_access_traffic_volumes",
    "tableType": "MANAGED",
    "columnCount": 10,
    "documentedDomain": "traffic counts / closures",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: traffic counts / closures",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Road_ID, Road_Name, Chainage_S, Chainage_E"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_lane_access_traffic_volumes.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_metrocount_direction_converter",
    "fullName": "transport_dev.transport_wru.utbl_metrocount_direction_converter",
    "tableType": "MANAGED",
    "columnCount": 9,
    "documentedDomain": "",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Station ID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_metrocount_direction_converter.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_monthly_bins",
    "fullName": "transport_dev.transport_wru.utbl_monthly_bins",
    "tableType": "MANAGED",
    "columnCount": 9,
    "documentedDomain": "",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI",
      "Key columns: reporting_ID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_monthly_bins.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_non_compliant_inspections",
    "fullName": "transport_dev.transport_wru.utbl_non_compliant_inspections",
    "tableType": "MANAGED",
    "columnCount": 2,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Inspection_ID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_non_compliant_inspections.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_psdr_comparison",
    "fullName": "transport_dev.transport_wru.utbl_psdr_comparison",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI",
      "Key columns: percent_working_sensor"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_psdr_comparison.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_public_holidays",
    "fullName": "transport_dev.transport_wru.utbl_public_holidays",
    "tableType": "MANAGED",
    "columnCount": 3,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Documented description/comment: Created by the file upload UI",
      "Key columns: Holiday"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_public_holidays.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_raw_data_march",
    "fullName": "transport_dev.transport_wru.utbl_raw_data_march",
    "tableType": "MANAGED",
    "columnCount": 6,
    "documentedDomain": "",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI",
      "Key columns: SiteID"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_raw_data_march.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "utbl_work_peaktime_periods",
    "fullName": "transport_dev.transport_wru.utbl_work_peaktime_periods",
    "tableType": "MANAGED",
    "columnCount": 4,
    "documentedDomain": "",
    "inferredCategory": "Unclassified",
    "inferredUse": "Use is not strongly inferable from the documented domain, columns, table name, or view SQL. Treat as requiring SME validation.",
    "confidence": "Low",
    "evidenceBasis": [
      "Documented description/comment: Created by the file upload UI"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20utbl_work_peaktime_periods.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_drainage",
    "fullName": "transport_dev.transport_wru.uvw_a_drainage",
    "tableType": "VIEW",
    "columnCount": 21,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: id, assetcondition, assetcondition_int, globalid",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_drainage.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_embankments",
    "fullName": "transport_dev.transport_wru.uvw_a_embankments",
    "tableType": "VIEW",
    "columnCount": 11,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: id, assetcondition, assetcondition_int, Width_metres",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_embankments.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_fencing",
    "fullName": "transport_dev.transport_wru.uvw_a_fencing",
    "tableType": "VIEW",
    "columnCount": 26,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, Asset_support_type",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_fencing.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_kerb_and_channels",
    "fullName": "transport_dev.transport_wru.uvw_a_kerb_and_channels",
    "tableType": "VIEW",
    "columnCount": 13,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: id, asset_name, assetcondition, assetcondition_int, Width_metres",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_kerb_and_channels.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_minor_culverts",
    "fullName": "transport_dev.transport_wru.uvw_a_minor_culverts",
    "tableType": "VIEW",
    "columnCount": 53,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, asset_name, assetcondition, assetcondition_int, drainage_class_risk_classification_score, CUL_DI_WID, warranty_defect_liability_date",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister, pit",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_minor_culverts.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_pathways",
    "fullName": "transport_dev.transport_wru.uvw_a_pathways",
    "tableType": "VIEW",
    "columnCount": 30,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, width_m",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_pathways.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_paved_areas",
    "fullName": "transport_dev.transport_wru.uvw_a_paved_areas",
    "tableType": "VIEW",
    "columnCount": 20,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, warranty_defect_liability_date",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_paved_areas.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_pit",
    "fullName": "transport_dev.transport_wru.uvw_a_pit",
    "tableType": "VIEW",
    "columnCount": 20,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, Asset Sub-Type",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_pit.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_road",
    "fullName": "transport_dev.transport_wru.uvw_a_road",
    "tableType": "VIEW",
    "columnCount": 11,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: assetID, Forward_Start_Chainage, Forward_End_Chainage, Reverse_Start_Chainage, Reverse_End_Chainage",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_road.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_signs",
    "fullName": "transport_dev.transport_wru.uvw_a_signs",
    "tableType": "VIEW",
    "columnCount": 31,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, local_road_name",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_signs.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_table_drains",
    "fullName": "transport_dev.transport_wru.uvw_a_table_drains",
    "tableType": "VIEW",
    "columnCount": 19,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, assetcondition, assetcondition_int, width_m, warranty_defect_liability_date, consequence_urban_rural_score, drainage_class_risk_classification_score",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_table_drains.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_a_vehicle_barriers",
    "fullName": "transport_dev.transport_wru.uvw_a_vehicle_barriers",
    "tableType": "VIEW",
    "columnCount": 35,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: Asset_ID, Asset_Code, Asset_Name, Road_No, Road_Name, assetcondition, conditiondate, asset_hyperlink",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, assetregister",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_a_vehicle_barriers.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_asset",
    "fullName": "transport_dev.transport_wru.uvw_asset",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, contract, assettype, parentassetid, parentassetcode, parentassetname, parentassettypename, parentassetposition",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_asset.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_asset_audit",
    "fullName": "transport_dev.transport_wru.uvw_asset_audit",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, AssetID",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_asset_audit.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_asset_pwa",
    "fullName": "transport_dev.transport_wru.uvw_asset_pwa",
    "tableType": "VIEW",
    "columnCount": 16,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, assetname, assetclass, asset_hyperlink, assettype, status",
      "View SQL references uvw_asset, uvw_assetattribute, sq1, sq2",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_asset_pwa.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_asset_register",
    "fullName": "transport_dev.transport_wru.uvw_asset_register",
    "tableType": "VIEW",
    "columnCount": 13,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id, structure_ID, road_name, road_number, asset_class, asset_subclass, assettype, bridge_function",
      "View SQL references transport_wru.uvw_asset, transport_wru.uvw_assetattribute, sq1, sq2",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_asset_register.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_assetattribute",
    "fullName": "transport_dev.transport_wru.uvw_assetattribute",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: ID, AssetID",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_assetattribute.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_bridge",
    "fullName": "transport_dev.transport_wru.uvw_bis_bridge",
    "tableType": "VIEW",
    "columnCount": 23,
    "documentedDomain": "",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: BridgeID, StrucIdentNo, RoadNumber, RoadName, BridgeThumbnail, ConstructionDate_Widening, DesignLoading_Widening",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_bridge.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_new_ras_bridge",
    "fullName": "transport_dev.transport_wru.uvw_bis_new_ras_bridge",
    "tableType": "VIEW",
    "columnCount": 14,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: ID_STRUCTURE, TRAF_WIDTH, L2INSPECTION",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_new_ras_bridge.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_new_ras_component",
    "fullName": "transport_dev.transport_wru.uvw_bis_new_ras_component",
    "tableType": "VIEW",
    "columnCount": 22,
    "documentedDomain": "",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: ID_STRUCTURE",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_new_ras_component.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_new_ras_inventory",
    "fullName": "transport_dev.transport_wru.uvw_bis_new_ras_inventory",
    "tableType": "VIEW",
    "columnCount": 46,
    "documentedDomain": "inventory / materials",
    "inferredCategory": "Commercial / finance",
    "inferredUse": "Support cost, claim, subcontractor, procurement, material, waste, fuel, or commercial reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inventory / materials",
      "Key columns: ID_STRUCTURE, OWID_CU, OWID_BR",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_new_ras_inventory.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_new_ras_miscellaneous",
    "fullName": "transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous",
    "tableType": "VIEW",
    "columnCount": 16,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Key columns: ID_STRUCTURE, CONS_DATE_WIDE, DESIGN_LOAD_WIDE",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_new_ras_miscellaneous.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_bis_new_ras_status",
    "fullName": "transport_dev.transport_wru.uvw_bis_new_ras_status",
    "tableType": "VIEW",
    "columnCount": 5,
    "documentedDomain": "workflow / status",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: workflow / status",
      "Key columns: StrucIdentNo, ValidFlag, StatusOverAll",
      "View SQL references transport_dev.transport_wru.uvw_assetattribute, transport_dev.transport_wru.uvw_asset",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_bis_new_ras_status.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_capitalwork",
    "fullName": "transport_dev.transport_wru.uvw_capitalwork",
    "tableType": "VIEW",
    "columnCount": 27,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: id, capitalworktype, assettypename, assetid, assetcode, assetname, section, chainagefrom",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_capitalwork.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_capitalworktask",
    "fullName": "transport_dev.transport_wru.uvw_capitalworktask",
    "tableType": "VIEW",
    "columnCount": 33,
    "documentedDomain": "capital works / forward works",
    "inferredCategory": "Capital works / forward works",
    "inferredUse": "Support capital works, forward works, pavement/PCAS analysis, treatment planning, or programme reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: capital works / forward works",
      "Key columns: ID, CapitalWorkID, EstimatedCost, ActualCost, AssetTypeName, AssetID, AssetCode, AssetName",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask, ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_capitalworktask.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_created_assets",
    "fullName": "transport_dev.transport_wru.uvw_created_assets",
    "tableType": "VIEW",
    "columnCount": 6,
    "documentedDomain": "asset register / hierarchy",
    "inferredCategory": "Asset register / hierarchy",
    "inferredUse": "Represent asset inventory, hierarchy, classification, physical attributes, condition, criticality, photos, or asset-location context.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: asset register / hierarchy",
      "Key columns: id",
      "View SQL references transport_dev.transport_wru.uvw_asset, sq",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_created_assets.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_created_completed_jobs",
    "fullName": "transport_dev.transport_wru.uvw_created_completed_jobs",
    "tableType": "VIEW",
    "columnCount": 4,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: job_id, job_date",
      "View SQL references uvw_rm_jobs_reporting",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_created_completed_jobs.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_doc_signees",
    "fullName": "transport_dev.transport_wru.uvw_doc_signees",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: module_id, form_id",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.inspection, ext_mssql_asset_vision_ven_vicroads.dbo.formfield, ext_mssql_asset_vision_ven_vicroads.dbo.photo, cte",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_doc_signees.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_documents",
    "fullName": "transport_dev.transport_wru.uvw_documents",
    "tableType": "VIEW",
    "columnCount": 13,
    "documentedDomain": "documents / evidence",
    "inferredCategory": "Documents / evidence",
    "inferredUse": "Store or report photos, attachments, documents, sign-offs, or other evidence records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: documents / evidence",
      "Key columns: module_id, createduser, module_item_created_date",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.module, ext_mssql_asset_vision_ven_vicroads.dbo.formfield, cte",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_documents.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_eot_jobs",
    "fullName": "transport_dev.transport_wru.uvw_eot_jobs",
    "tableType": "VIEW",
    "columnCount": 23,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: Reporting_ID, JobID, OriginalDueDate, NewDueDate, createddate, assetid, assetcode, assetname",
      "View SQL references transport_dev.transport_wru.uvw_job, ext_mssql_asset_vision_ven_vicroads.dbo.formfield, EOT_Jobs, transport_dev.transport_wru.utbl_eot_reasons",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_eot_jobs.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_exportdate",
    "fullName": "transport_dev.transport_wru.uvw_exportdate",
    "tableType": "VIEW",
    "columnCount": 5,
    "documentedDomain": "reference / mapping",
    "inferredCategory": "Reference / mapping",
    "inferredUse": "Provide reference data, mapping logic, date scaffolding, lookup values, constants, or conversion tables.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: reference / mapping",
      "Key columns: ID",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.exportdate",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_exportdate.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection",
    "fullName": "transport_dev.transport_wru.uvw_inspection",
    "tableType": "VIEW",
    "columnCount": 47,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, assettypename, assetid, assetcode, assetname, section, contract, chainagefrom",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.inspection",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_cathodic_protection",
    "fullName": "transport_dev.transport_wru.uvw_inspection_cathodic_protection",
    "tableType": "VIEW",
    "columnCount": 20,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: completed_date, inspection_id, inspection_hyperlink, assetid, assettypename, completeduser, completed_date_datetime, previous_completed_date",
      "View SQL references transport_dev.transport_wru.uvw_inspection_completions, selection",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_cathodic_protection.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_completions",
    "fullName": "transport_dev.transport_wru.uvw_inspection_completions",
    "tableType": "VIEW",
    "columnCount": 16,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, inspection_hyperlink, assettypename, assetid, completed_date, completeduser, inspectiontype, inspection_punctuality",
      "View SQL references transport_dev.transport_wru.uvw_inspection, inspection_typesnormalised, selection, transport_dev.transport_wru.uvw_asset_register",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_completions.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_hazard_defect",
    "fullName": "transport_dev.transport_wru.uvw_inspection_hazard_defect",
    "tableType": "VIEW",
    "columnCount": 50,
    "documentedDomain": "defects / hazards / failures",
    "inferredCategory": "Defects / hazards",
    "inferredUse": "Identify, classify, or report defects, hazards, failures, interventions, or related operational risk signals.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: defects / hazards / failures",
      "Key columns: DateUID, InspUID, inspection_ID, assettypename, assetid, assetcode, assetname, Asset_Name",
      "View SQL references transport_wru.uvw_inspection, transport_wru.uvw_a_road, transport_wru.utbl_inspection_road_sections, transport_wru.utbl_date_table",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_hazard_defect.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_kpi_1_dashboard",
    "fullName": "transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard",
    "tableType": "VIEW",
    "columnCount": 30,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: Compliant_Status, completedTime, dateuid, section_name, Section_Desc, Forward_Start_Chainage, Forward_End_Chainage, Reverse_Start_Chainage",
      "View SQL references transport_dev.transport_wru.uvw_inspection_kpi_1_series, transport_dev.transport_wru.uvw_kpi_1_noncompliant",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_kpi_1_dashboard.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_kpi_1_series",
    "fullName": "transport_dev.transport_wru.uvw_inspection_kpi_1_series",
    "tableType": "VIEW",
    "columnCount": 28,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: completedTime, dateuid, section_name, Section_Desc, Forward_Start_Chainage, Forward_End_Chainage, Reverse_Start_Chainage, Reverse_End_Chainage",
      "View SQL references transport_dev.transport_wru.uvw_inspection_hazard_defect, preData, inspection_time, inspection_data",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_kpi_1_series.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_settlement_monitoring",
    "fullName": "transport_dev.transport_wru.uvw_inspection_settlement_monitoring",
    "tableType": "VIEW",
    "columnCount": 8,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: inspection_id, inspection_hyperlink, assettypename, assetid, completed_date, completeduser, structure_id",
      "View SQL references transport_dev.transport_wru.uvw_inspection_completions",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_settlement_monitoring.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_structures",
    "fullName": "transport_dev.transport_wru.uvw_inspection_structures",
    "tableType": "VIEW",
    "columnCount": 23,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: inspection_id, inspection_hyperlink, inspectiontype, assetid, assettype, completeduser, completed_date, previous_inspection_id",
      "View SQL references transport_dev.transport_wru.uvw_inspection, inspection_typesnormalised, selection, transport_dev.transport_wru.uvw_asset_register",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_structures.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspection_typesnormalised",
    "fullName": "transport_dev.transport_wru.uvw_inspection_typesnormalised",
    "tableType": "VIEW",
    "columnCount": 8,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: id, assettypename, assetid, completed_date, completeduser, inspectiontype",
      "View SQL references transport_dev.transport_wru.uvw_inspection",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspection_typesnormalised.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspections_level_1",
    "fullName": "transport_dev.transport_wru.uvw_inspections_level_1",
    "tableType": "VIEW",
    "columnCount": 17,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: inspection_id, assetid, assettypename, completeduser, completed_date, completed_date_datetime, previous_completed_date, inspection_status",
      "View SQL references transport_dev.transport_wru.uvw_inspection_completions, selection",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspections_level_1.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspections_level_2",
    "fullName": "transport_dev.transport_wru.uvw_inspections_level_2",
    "tableType": "VIEW",
    "columnCount": 18,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: inspection_id, inspection_hyperlink, assetid, assettypename, completeduser, completed_date_datetime, previous_completed_date, inspection_comments",
      "View SQL references transport_dev.transport_wru.uvw_inspection_completions, selection",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspections_level_2.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_inspections_level_3",
    "fullName": "transport_dev.transport_wru.uvw_inspections_level_3",
    "tableType": "VIEW",
    "columnCount": 9,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: inspection_id, inspection_hyperlink, assetid, assettypename, completed_date, inspectiontype, completeduser, inspection_comments",
      "View SQL references transport_dev.transport_wru.uvw_inspection_completions",
      "View SQL applies filters or business rules"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_inspections_level_3.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_jeopardy_board",
    "fullName": "transport_dev.transport_wru.uvw_jeopardy_board",
    "tableType": "VIEW",
    "columnCount": 23,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Key columns: job_id, asset_code, asset_name, AssetTypeName, created_date, parent_asset_name, parentassetcode, status",
      "View SQL references transport_dev.transport_wru.uvw_job, transport_dev.transport_wru.uvw_asset, transport_dev.transport_wru.uvw_job_geom",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_jeopardy_board.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_jeopardy_board_jobs",
    "fullName": "transport_dev.transport_wru.uvw_jeopardy_board_jobs",
    "tableType": "VIEW",
    "columnCount": 22,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: asset_code, asset_name, assettype, created_date, job_id, parent_asset_name, parentassetcode, status",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.vjob, ext_mssql_asset_vision_ven_vicroads.dbo.asset",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_jeopardy_board_jobs.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_job",
    "fullName": "transport_dev.transport_wru.uvw_job",
    "tableType": "VIEW",
    "columnCount": 87,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, assetid, assetcode, assetname, section, contract, hazarddefectcode, hazardcode",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.vjob, ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment, sq, sq1",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_job.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_job_geom",
    "fullName": "transport_dev.transport_wru.uvw_job_geom",
    "tableType": "VIEW",
    "columnCount": 5,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: id, wkt, wkt_Type, start_longitude, start_latitude",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.vjob",
      "View SQL includes spatial or linear-reference fields"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_job_geom.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_job_kpi_2",
    "fullName": "transport_dev.transport_wru.uvw_job_kpi_2",
    "tableType": "VIEW",
    "columnCount": 44,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: reporting_ID, job_id, assetid, assetcode, assetname, assettypename, hazarddefectcode, hazardcode",
      "View SQL references transport_dev.transport_wru.uvw_job, ext_mssql_asset_vision_ven_vicroads.dbo.formfield, KPI_2_Jobs, Travel_To_Site",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_job_kpi_2.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_kpi_1_noncompliant",
    "fullName": "transport_dev.transport_wru.uvw_kpi_1_noncompliant",
    "tableType": "VIEW",
    "columnCount": 3,
    "documentedDomain": "KPI / reporting",
    "inferredCategory": "KPI / reporting",
    "inferredUse": "Support performance reporting, scoring, dashboard extraction, abatement calculations, or analytical prioritisation.",
    "confidence": "Medium",
    "evidenceBasis": [
      "Documented domain: KPI / reporting",
      "Key columns: DateUID",
      "View SQL references AV, ext_mssql_asset_vision_ven_vicroads.dbo.formfield, transport_dev.transport_wru.uvw_inspection, transport_dev.transport_wru.uvw_inspection_hazard_defect",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_kpi_1_noncompliant.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_laneaccess_raw",
    "fullName": "transport_dev.transport_wru.uvw_laneaccess_raw",
    "tableType": "VIEW",
    "columnCount": 40,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Key columns: assettype, roadno, Parent_Asset_chainage, Reporting_ID, Public_Holiday, Holiday_Name, RecordID, AssetCode",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess, transport_dev.transport_wru.uvw_job, transport_dev.transport_wru.utbl_date_table, transport_dev.transport_wru.utbl_public_holidays",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_laneaccess_raw.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_laneaccess_report",
    "fullName": "transport_dev.transport_wru.uvw_laneaccess_report",
    "tableType": "VIEW",
    "columnCount": 41,
    "documentedDomain": "lane access",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: lane access",
      "Key columns: Reporting_ID, RecordID, Work_Order_Type, Work_Order_Number, assettype, AssetName, RoadNo, Parent_Asset_chainage",
      "View SQL references transport_dev.transport_wru.uvw_laneaccess_raw, transport_dev.transport_wru.utbl_work_peaktime_periods, laneAccess_prep, predata",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_laneaccess_report.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_lastmodified",
    "fullName": "transport_dev.transport_wru.uvw_lastmodified",
    "tableType": "VIEW",
    "columnCount": 2,
    "documentedDomain": "",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "Low",
    "evidenceBasis": [
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute, ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork, ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_lastmodified.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_rm_inspection_dashboard",
    "fullName": "transport_dev.transport_wru.uvw_rm_inspection_dashboard",
    "tableType": "VIEW",
    "columnCount": 62,
    "documentedDomain": "inspection / audit / condition",
    "inferredCategory": "Inspection / condition",
    "inferredUse": "Track inspection schedules, inspection outcomes, audit status, condition evidence, compliance, or last-inspected reporting.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: inspection / audit / condition",
      "Key columns: kpi_unique_id, id, assettypename, assetid, assetcode, assetname, section, contract",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.inspection, ext_mssql_asset_vision_ven_vicroads.dbo.vinspection, cte, cte1",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_rm_inspection_dashboard.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_rm_jobs_reporting",
    "fullName": "transport_dev.transport_wru.uvw_rm_jobs_reporting",
    "tableType": "VIEW",
    "columnCount": 64,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: createddate, createduser, job_id, assetid, asset_code, asset_name, wkt, completeduser",
      "View SQL references formfield, OLD, ext_mssql_asset_vision_ven_vicroads.dbo.vjob, ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_rm_jobs_reporting.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_rm_yesterdays_jobs",
    "fullName": "transport_dev.transport_wru.uvw_rm_yesterdays_jobs",
    "tableType": "VIEW",
    "columnCount": 5,
    "documentedDomain": "jobs / work orders",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: jobs / work orders",
      "Key columns: assetcode, createddate, job_id",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.job",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_rm_yesterdays_jobs.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_tgs_module",
    "fullName": "transport_dev.transport_wru.uvw_tgs_module",
    "tableType": "VIEW",
    "columnCount": 7,
    "documentedDomain": "forms / modules",
    "inferredCategory": "Forms / data capture",
    "inferredUse": "Capture or structure form submissions, checklists, questionnaires, portal data, or configurable form fields.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: forms / modules",
      "Key columns: module_id, description_works, road_type, current_status, work_location",
      "View SQL references module, formfield, photo",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_tgs_module.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_tgs_speed_limits",
    "fullName": "transport_dev.transport_wru.uvw_tgs_speed_limits",
    "tableType": "VIEW",
    "columnCount": 2,
    "documentedDomain": "",
    "inferredCategory": "Traffic / lane access",
    "inferredUse": "Support traffic counts, traffic volumes, closure factors, lane access planning, speed limits, or road-use reporting.",
    "confidence": "Low",
    "evidenceBasis": [
      "Key columns: module_id",
      "View SQL references module, formfield",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_tgs_speed_limits.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_timesheet",
    "fullName": "transport_dev.transport_wru.uvw_timesheet",
    "tableType": "VIEW",
    "columnCount": 21,
    "documentedDomain": "timesheet",
    "inferredCategory": "Resources / timesheets",
    "inferredUse": "Track labour, plant, resource, timesheet, or job-costing support records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: timesheet",
      "Key columns: id, timesheetid, timesheetcreateduser, Job_ID, job_Duration_hrs, job_Duration_minutes",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem, transport_dev.transport_wru.uvw_job, timesheet",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_timesheet.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "uvw_timesheetitem",
    "fullName": "transport_dev.transport_wru.uvw_timesheetitem",
    "tableType": "VIEW",
    "columnCount": 29,
    "documentedDomain": "timesheet",
    "inferredCategory": "Resources / timesheets",
    "inferredUse": "Track labour, plant, resource, timesheet, or job-costing support records.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: timesheet",
      "Key columns: id, timesheetid, timesheetcreateddate, timesheetcreateduser, sourcetableid, cost",
      "View SQL references ext_mssql_asset_vision_ven_vicroads.dbo.resource, ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit, ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem, resourceregister",
      "View SQL applies filters or business rules",
      "View SQL normalises timestamps to Australia/Sydney",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20uvw_timesheetitem.md"
  },
  {
    "context": "transport_wru",
    "contractor": "WRU",
    "label": "Western Roads Upgrade",
    "tableName": "vw_job_export_final",
    "fullName": "transport_dev.transport_wru.vw_job_export_final",
    "tableType": "VIEW",
    "columnCount": 32,
    "documentedDomain": "job export",
    "inferredCategory": "Jobs / work orders",
    "inferredUse": "Track, enrich, or report operational jobs, work orders, dispatches, status, dates, assets, priorities, interventions, completion, or compliance.",
    "confidence": "High",
    "evidenceBasis": [
      "Documented domain: job export",
      "Key columns: Job ID, Inspection ID, Merged Into Job ID, Linked Job ID, Job URL, Asset Name, Parent Asset Name, Parent Asset Name Original",
      "View SQL references WKT, ext_mssql_asset_vision_ven_vicroads.dbo.job, ext_mssql_asset_vision_ven_vicroads.dbo.asset, ext_mssql_asset_vision_ven_vicroads.dbo.vjob",
      "View SQL includes spatial or linear-reference fields",
      "View SQL applies filters or business rules",
      "View SQL joins multiple sources"
    ],
    "tableUrl": "../transport_wru/Transport%20Table%20-%20transport_wru%20-%20vw_job_export_final.md"
  }
];
