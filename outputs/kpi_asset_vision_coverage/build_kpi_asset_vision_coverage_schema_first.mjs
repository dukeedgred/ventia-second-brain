import fs from "node:fs/promises";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = ".";
const workbook = Workbook.create();

const rows = [
  ["transport_ramc", "RAMC / RAMCSC", "Current and last month job snapshots", "utbl_current_month_job_snapshot; utbl_last_month_job_snapshot; bkp_* variants", "Yes", "Partial", "Current state can be rebuilt from Asset Vision job dates/status. Historical current/last month snapshot logic needs persisted snapshot tables."],
  ["transport_ramc", "RAMC / RAMCSC", "Backlog change and monthly backlog reduction", "utbl_backlog_change_report; utbl_monthly_backlog_reduction", "Yes", "Partial", "Current open/overdue backlog is Asset Vision-buildable. Month-over-month change needs snapshot/history tables."],
  ["transport_ramc", "RAMC / RAMCSC", "Inspection reporting and road last inspected", "uvw_inspection; uvw_roadlastinspected", "Yes", "Yes / Partial", "Inspection scheduled/completed and last inspection metrics are Asset Vision-buildable where dates and asset links are populated."],
  ["transport_wru", "Western Roads Upgrade", "KPI 1 inspection dashboard and series", "uvw_inspection_kpi_1_dashboard; uvw_inspection_kpi_1_series", "Yes", "Yes / Partial", "Core inspection counts and completion dates are Asset Vision-buildable. Official KPI filters may be WRU-specific."],
  ["transport_wru", "Western Roads Upgrade", "KPI 1 non-compliance", "uvw_kpi_1_noncompliant; utbl_non_compliant_inspections", "Yes", "Partial", "Needs the non-compliance flag/status/form logic. The uploaded non-compliant inspections table is not raw Asset Vision."],
  ["transport_wru", "Western Roads Upgrade", "KPI 2 job KPI", "uvw_job_kpi_2", "Yes", "Yes / Partial", "Core job due/completed/on-time/overdue metrics are Asset Vision-buildable. Official KPI 2 filters still need validation."],
  ["transport_wru", "Western Roads Upgrade", "Lane access reporting", "uvw_laneaccess_raw; uvw_laneaccess_report; utbl_lane_access_*", "Yes", "Partial / No", "Some lane-access records may be Asset Vision-sourced, but the full reporting logic uses WRU support/reference tables."],
  ["transport_srapc", "SRAPC", "Monthly report", "utbl_monthly_report", "Yes", "Partial / No", "Some operational sections may be Asset Vision-buildable, but the full monthly report is not raw Asset Vision-only."],
  ["transport_srapc", "SRAPC", "TfNSW defect/intervention monthly report", "uvw_srapc_tfnsw_monthly_report_defect_intervention", "Yes", "Partial", "Defect/intervention counts may be built from Asset Vision job fields if source coding aligns."],
  ["transport_srapc", "SRAPC", "Subcontractor monthly reporting", "uvw_monthly_subcontractor_data*; formitize_srapc.*", "Yes", "No", "Subcontractor energy, safety, material, social, fuel, and waste reporting is Formitize/non-Asset-Vision."],
  ["transport_srapc", "SRAPC", "TACP reporting/load data", "utbl_tacp_constants; utbl_tacp_toc; uvw_tacp_data_initial_load; uvw_tacp_data_delta_load", "Yes", "No", "TACP appears to be separate reference/load data."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 2 and KPI 3 road safety plus abatement", "utbl_kpi2_road_safety; uvw_kpi3_road_safety; uvw_kpi2_abatement_costs; uvw_kpi3_abatement_costs", "Yes", "Partial / No", "Some job/inspection inputs may be Asset Vision-buildable. Official road-safety and abatement logic uses TSRC-specific tables."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 4/5/6 incidents", "uvw_kpi456_incidents; incident tables", "Yes", "No", "Incident reporting is separate from base Asset Vision job/asset source tables."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 7-14 ITS asset uptime and jobs", "uvw_kpi_7_to_14_its_asset_uptime; uvw_kpi_7_to_14_its_jobs", "Yes", "Partial / No", "ITS job counts may be possible if ITS assets are identifiable in Asset Vision. Uptime is not Asset Vision-only."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 10 CCTV requests and abatement", "uvw_kpi_10_cctv_requests; uvw_kpi_10_abatement_costs", "Yes", "Partial / No", "CCTV request counts may be approximated from jobs/activities if captured there. Abatement costs need non-AV logic."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 18 noise and KPI 19 stakeholder events", "uvw_kpi18_noise_events; uvw_kpi19_stakeholder_events; abatement views", "Yes", "No", "Noise and stakeholder event KPI views are dedicated TSRC reporting data, not Asset Vision source tables."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 20/21 and KPI 22/23 PCAS", "uvw_kpi_20_21_pcas_test; uvw_kpi_22_23_pcas_test; PCAS views", "Yes", "No", "PCAS/pavement data is a separate reporting source."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "KPI 25 asset performance maintenance", "utbl_asset_perf_maint_kpi25_1/2/3; uvw_asset_perf_maint_kpi25_1; uvw_kpi25_*_abatement_costs", "Yes", "Partial", "Asset/job components may be Asset Vision-buildable. KPI 25 reference and abatement logic is external."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "Routine/corrective maintenance compliance", "utbl_ref_routine_maintenance_compliance; utbl_ref_corrective_maintenance_compliance; routine inspection compliance refs", "Yes", "Partial", "This is the explicit corrective maintenance reference logic found in a contract schema. It is TSRC, not BAC. It uses AV-style job fields plus external reference rules."],
  ["transport_tsrc", "TQ Network IR&M / TSRC", "Lane closure, tollroad unavailability, road safety audit", "lane closure reference tables; uvw_tollroad_unavailability_events; road safety audit register", "Yes", "No", "These are contract-specific non-Asset-Vision reporting sources."],
  ["transport_sht", "SHT / WHT", "Generic inspection, job, and critical asset reporting", "uvw_inspection; uvw_job; uvw_all_critical_assets", "Reporting views found; no KPI-numbered view found", "Partial / Unclear", "Generic job/inspection fields may be buildable from source tables, but tunnel context and Maximo boundary need validation."],
  ["transport_sht", "SHT / WHT", "Weather context", "uvw_weather_north_sydney_hourly_rolling_30days", "Yes", "No", "Weather is outside Asset Vision."],
  ["transport_nel", "North East Link", "KPI assets, KPI work orders, system/AV devices", "utbl_kpi_assets; utbl_kpi_work_orders; uvw_kpi_sys_av_devices", "Yes", "No", "Current NEL KPI data is synthetic/manual or future Maximo-oriented, not Asset Vision source table logic."],
  ["transport_fndc", "FNDC", "No KPI-labelled schema table found; forward works/cost/dispatch/weather/road network/pavement reporting", "uvw_fw_forward_work_view; uvw_mc_cost; uvw_mt_dispatch; weather; pavement/road network views", "No explicit KPI object found", "No", "Current schema evidence is non-Asset-Vision operational/reporting context."],
  ["transport_aklw", "Auckland West", "No explicit KPI table found; operational Asset Vision-style views", "uvw_asset; uvw_job; uvw_inspection; uvw_capitalwork; uvw_timesheet", "No explicit KPI object found", "Yes for operational data; no schema KPI logic", "Operational data is Asset Vision-style, but no dedicated KPI logic is documented."],
  ["transport_vsm", "VentureSmart", "No explicit KPI table found; asset with photo reporting", "uvw_all_asset_with_photo", "No explicit KPI object found", "Yes for asset/photo; no schema KPI logic", "Asset/photo coverage is Asset Vision-buildable, but this is not a KPI view."],
  ["formitize_srapc", "SRAPC / Formitize", "Form capture and subcontractor monthly reporting source", "formitize_srapc.*", "Reporting/source tables found", "No", "Formitize is not Asset Vision."],
];

const noSchemaRows = [
  ["R30-BAC Pavement Maintenance Service / Brisbane Airport", "No documented transport_bac schema found", "Appears as Contract values in ext_mssql_asset_vision_ven_gen7.dbo source tables", "No BAC contract-schema SQL logic found for corrective/planned maintenance", "Completion can be profiled from Asset Vision job fields, but planned vs corrective needs activity/intervention mapping."],
  ["Port of Brisbane Road Corridor Maintenance Services", "No documented transport_pob schema found", "Appears as Contract values in ext_mssql_asset_vision_ven_gen7.dbo source tables", "No PoB contract-schema SQL logic found for corrective/planned maintenance", "Same issue as BAC: source records exist, but schema-level KPI logic is not documented."],
];

const commonRows = [
  [
    "Job / work-order completion, status, overdue, and backlog",
    9,
    "RAMC / RAMCSC; WRU; SRAPC; TSRC; SHT / WHT; Auckland West; NEL; R30-BAC / Brisbane Airport; Port of Brisbane",
    "transport_ramc snapshot/backlog tables; transport_wru.uvw_job_kpi_2; transport_srapc defect/intervention views; transport_tsrc maintenance/ITS/KPI25 views; transport_sht.uvw_job; transport_aklw.uvw_job; transport_nel.utbl_kpi_work_orders",
    "Most contracts count jobs, but they do not count them the same way. RAMC uses saved month-end snapshots. WRU has a KPI 2 job view. TSRC adds contract rule and abatement tables. NEL is uploaded/manual. BAC and PoB have no dedicated schema logic in the docs.",
    "Partly. Asset Vision can do basic job status: completed = `completeddate IS NOT NULL`; open overdue = `completeddate IS NULL AND duedate < current_timestamp()`.",
    "Use Asset Vision for simple job counts. For real KPI counts, add each schema's rules, for example `activitytype IN (...)`, `interventioncode IN (...)`, or RAMC snapshot tables.",
  ],
  [
    "Inspection scheduled/completed/on-time/compliance",
    6,
    "RAMC / RAMCSC; WRU; SRAPC; TSRC; SHT / WHT; Auckland West",
    "transport_ramc.uvw_inspection / uvw_roadlastinspected; transport_wru KPI 1 inspection views; SRAPC asset inspection last/next style views; TSRC routine inspection compliance refs; transport_sht.uvw_inspection; transport_aklw.uvw_inspection",
    "Everyone has scheduled and completed inspections, but each contract can define 'on time' differently. WRU has KPI 1 logic. TSRC has compliance reference tables. RAMC/SRAPC have last or next inspection style views.",
    "Mostly yes. Basic inspection logic is in Asset Vision: completed = `completeddate IS NOT NULL`; open overdue = `completeddate IS NULL AND coalesce(scheduleddateto, scheduleddate) < current_timestamp()`.",
    "Use Asset Vision for scheduled/completed counts. Add contract filters such as `inspectiontypename IN (...)` or TSRC compliance reference tables for official KPI rates.",
  ],
  [
    "Hazard, defect, intervention, activity, and response timing",
    6,
    "RAMC / RAMCSC; WRU; SRAPC; TSRC; R30-BAC / Brisbane Airport; Port of Brisbane",
    "Asset Vision job fields; transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention; transport_tsrc maintenance compliance refs; WRU job/inspection hazard-defect reporting",
    "The same kind of fields exist, but the labels mean different things by contract. BAC/PoB have source fields only. TSRC has reference tables. SRAPC and WRU have curated views.",
    "Partly. Asset Vision has useful fields: `hazarddefectcode IS NOT NULL`, `interventioncode IS NOT NULL`, plus `activitytype`, `activitycategoryname`, and `activityname`.",
    "First profile the actual values by contract. Then map exact values. Avoid guessing from broad keywords unless an SME confirms the mapping.",
  ],
  [
    "Corrective vs planned maintenance completion/compliance",
    5,
    "TSRC; WRU; RAMC / RAMCSC; R30-BAC / Brisbane Airport; Port of Brisbane",
    "transport_tsrc.utbl_ref_corrective_maintenance_compliance; transport_tsrc.utbl_ref_routine_maintenance_compliance; WRU job/RM reporting; RAMC job/backlog views; BAC/PoB Asset Vision job fields only",
    "TSRC is the only documented schema with an explicit corrective maintenance reference table. BAC and PoB do not have a documented corrective/planned SQL view. WRU/RAMC can count completions, but classification still depends on job coding.",
    "Partly. Asset Vision has candidate fields, not a final class. The split usually comes from conditions on `activitytype`, `activitycategoryname`, `activityname`, or `interventioncode`.",
    "Create a mapping table per contract. For BAC/PoB, first list distinct `activitytype`, `activitycategoryname`, `activityname`, `interventioncode`, then decide which values mean corrective or planned.",
  ],
  [
    "Asset register, criticality, asset performance, and asset KPI reporting",
    6,
    "TSRC; SHT / WHT; NEL; VentureSmart; Auckland West; WRU",
    "transport_tsrc KPI25 asset performance tables; transport_sht.uvw_all_critical_assets; transport_nel.utbl_kpi_assets; transport_vsm.uvw_all_asset_with_photo; transport_aklw.uvw_asset; WRU asset register style views",
    "These all sound asset-related, but they are not the same KPI. Critical assets, KPI25 asset performance, uploaded NEL KPI assets, and asset/photo coverage are different things.",
    "Base asset data is yes: active assets can use `deleted = false`; condition/criticality coverage can use `assetcondition IS NOT NULL` or `assetcriticality IS NOT NULL`. KPI-specific asset logic is only partly pullable.",
    "Use Asset Vision for inventory and attribute coverage. Do not treat NEL KPI assets, SHT critical assets, or TSRC KPI25 as the same metric without reading the schema logic.",
  ],
  [
    "Evidence/photo/geospatial/stripmap reporting",
    4,
    "RAMC / RAMCSC; WRU; VentureSmart; Auckland West",
    "RAMC stripmap jobs/photos/WKT; WRU lane/stripmap/geospatial style views; transport_vsm.uvw_all_asset_with_photo; Asset Vision WKT/photo source tables",
    "Photo and map geometry are common, but each contract may present chainage, stripmaps, or road sections differently.",
    "Mostly yes. Photo coverage can come from photo links such as `sourcetable IN ('asset', 'job', 'inspection')`. Map coverage can use `wkt IS NOT NULL`.",
    "Use Asset Vision for evidence and map coverage. Keep stripmap, chainage, and road-section display rules specific to each schema.",
  ],
  [
    "Lane access, lane closure, traffic, and tollroad availability",
    2,
    "WRU; TSRC",
    "transport_wru.uvw_laneaccess_raw / uvw_laneaccess_report; transport_tsrc lane closure reference tables; transport_tsrc.uvw_tollroad_unavailability_events; traffic views",
    "WRU lane access and TSRC lane closure/tollroad availability are related topics, but the rules are different. TSRC has abatement/reference tables. WRU has lane-access reporting tables.",
    "Mostly no. Asset Vision may help if there is an `asset_id` or `job_id`, but the main KPI rules are in contract-specific lane, traffic, or availability tables.",
    "Use the schema views/reference tables first. Only join back to Asset Vision when there is a real key such as `asset_id`, `job_id`, or road section.",
  ],
  [
    "Pavement, PCAS, capital works, forward works, and treatment planning",
    4,
    "TSRC; FNDC; WRU; R30-BAC / Brisbane Airport",
    "transport_tsrc PCAS views; transport_fndc pavement/treatment/forward works views; WRU capitalwork/capitalworktask views; BAC appears as pavement maintenance contract but no schema logic found",
    "Capital works can be in Asset Vision, but PCAS, pavement testing, treatment planning, and FNDC forward works usually come from other tables. BAC has a pavement contract name but no documented schema logic.",
    "Partly. Asset Vision can help with capital works using `plannedstart IS NOT NULL` or `actualfinish IS NOT NULL`. PCAS, pavement treatment, and road network logic are not Asset Vision-only.",
    "Use Asset Vision for capitalwork records. Use PCAS/pavement/treatment schema tables for formal pavement KPIs. Check live Databricks before assuming BAC has its own pavement KPI view.",
  ],
  [
    "External context reporting: subcontractor, Formitize, weather, noise, stakeholder, CCTV, incidents",
    4,
    "SRAPC; SHT / WHT; FNDC; TSRC",
    "formitize_srapc.*; SRAPC subcontractor views; SHT/FNDC weather views; TSRC incident/noise/stakeholder/CCTV KPI views",
    "These are real reporting areas, but they are not Asset Vision asset/job tables. SRAPC uses Formitize/subcontractor data. TSRC has incident, noise, stakeholder, and CCTV views. Weather is separate.",
    "No. These should come from their own tables, for example `formitize_*`, weather views, incident views, noise views, stakeholder views, or CCTV views.",
    "Keep them separate from Asset Vision. Join to Asset Vision only when a real link exists, such as `job_id`, `asset_id`, road section, or date.",
  ],
];

const commonMeasureNotes = {
  "Job / work-order completion, status, overdue, and backlog":
    "Count jobs/work orders, completed jobs, open jobs, overdue jobs, backlog jobs, estimated quantity/cost, and snapshot-to-snapshot backlog movement.",
  "Inspection scheduled/completed/on-time/compliance":
    "Count required inspections, completed inspections, late inspections, non-compliant inspections, days since previous inspection, and last/next inspection dates.",
  "Hazard, defect, intervention, activity, and response timing":
    "Classify jobs by hazard/defect/intervention/activity codes, then measure response stages such as travel, arrival, start work, finish work, due date, and completed date.",
  "Corrective vs planned maintenance completion/compliance":
    "Classify maintenance jobs into corrective/routine/planned using activity and intervention rules, then measure completion and response compliance.",
  "Asset register, criticality, asset performance, and asset KPI reporting":
    "Count assets, critical assets, assets with required inspections, asset condition/criticality coverage, and asset performance compliance against due dates.",
  "Evidence/photo/geospatial/stripmap reporting":
    "Count records with photos/evidence and geometry, then report asset/job/inspection map coverage using WKT, road section, chainage, and photo links.",
  "Lane access, lane closure, traffic, and tollroad availability":
    "Measure lane-access events, lane closure periods, traffic counts/volumes, unavailable time, and related abatement rules.",
  "Pavement, PCAS, capital works, forward works, and treatment planning":
    "Measure IRI/roughness, pavement section targets, treatment/capital works records, forward works plans, chainage, lane, and geometry.",
  "External context reporting: subcontractor, Formitize, weather, noise, stakeholder, CCTV, incidents":
    "Measure non-Asset-Vision events or submissions such as incidents, noise events, stakeholder events, CCTV requests, weather, and subcontractor monthly figures.",
};

const commonRowsWithMeasures = commonRows.map((row) => [
  row[0],
  row[1],
  row[2],
  commonMeasureNotes[row[0]] ?? "",
  ...row.slice(3),
]);

const measureRows = [
  [
    "RAMC / RAMCSC",
    "Current and last month job snapshots",
    "Current jobs, completed jobs, backlog jobs, forward work plan jobs, estimated quantity, estimated cost",
    "transport_ramc.utbl_current_month_job_snapshot; transport_ramc.utbl_last_month_job_snapshot",
    "JobID, Status, CompletedDatetime, IsFWP, IsBacklog, BacklogMonth, EstimatedQuantity, EstimatedCost, ActivityType, ActivityCategoryName",
    "IsBacklog = 'Yes'; IsFWP = 'Yes'; CompletedDatetime IS NOT NULL",
    "RAMC has uploaded month-end job snapshots. Asset Vision can show current jobs, but the official month-to-month view needs the snapshot table.",
    "Partial",
  ],
  [
    "RAMC / RAMCSC",
    "Backlog change and monthly backlog reduction",
    "Backlog job count, backlog estimated cost, changed/not changed backlog, current vs last activity type",
    "transport_ramc.utbl_backlog_change_report; transport_ramc.utbl_monthly_backlog_reduction",
    "BacklogMonth, Type, Classification, CurrActivityType, LastActivityType, IsChanged, BacklogChange, JobCount, EstimatedCost",
    "GROUP BY BacklogMonth, Type, Classification, CurrActivityType, LastActivityType, IsChanged, BacklogChange",
    "This is not just a live job count. It compares one backlog snapshot to another.",
    "Partial",
  ],
  [
    "WRU",
    "KPI 1 inspection timing",
    "On-time vs late inspections, days since previous inspection, forward/reverse inspection IDs, completed inspection time",
    "transport_wru.uvw_inspection_kpi_1_series",
    "completedTime, Previous_InspDate, Previous_InspDay, Days_Since_LastInsp, classification, Inspection_Type, completedDay, F_Insp, R_Insp",
    "classification = 'RMC 3' AND inspection_Type = 'Hazard Inspection (Day)' AND Days_Since_LastInsp <= 7",
    "WRU checks inspection timing differently by road classification and inspection type.",
    "Partial",
  ],
  [
    "WRU",
    "KPI 1 non-compliance",
    "Non-compliant inspection flag/comment plus late inspections that were not separately flagged",
    "transport_wru.uvw_kpi_1_noncompliant; transport_wru.utbl_non_compliant_inspections; ext_mssql_asset_vision_ven_vicroads.dbo.formfield",
    "DateUID, non_compliant, Non_Compliant_Comments, formfield.name, formfield.value, Compliant_Timing",
    "name = 'Non-Compliant Information|Non-Compliant Inspection'; value IS TRUE; Compliant_Timing = 'Late'",
    "Non-compliance comes from three places: AV tick box, historical upload, and late inspection logic.",
    "Partial",
  ],
  [
    "WRU",
    "KPI 2 job response",
    "Defect/hazard/emergency response jobs, KPI category, travel/arrive/start/finish timestamps, ETS request flag",
    "transport_wru.uvw_job_kpi_2; transport_wru.uvw_job; ext_mssql_asset_vision_ven_vicroads.dbo.formfield",
    "intervention_level, activitycode, hazarddefectcode, activitycategorycode, createddate, duedate, completeddate, Travel_To_Site, Arrvied_On_Site, Start_On_Site, Finish_On_Site",
    "intervention_level IN ('Defect','Hazard','Emergency Response'); hazarddefectcode <> 'CP.CP'; activitycategorycode <> 'RM_TP'",
    "This is a response-time/job KPI. It is mostly Asset Vision, but some timing comes from AV form fields.",
    "Yes / Partial",
  ],
  [
    "WRU",
    "Lane access reporting",
    "Lane access events, lane/road/chainage, traffic-volume support tables",
    "transport_wru.uvw_laneaccess_raw; transport_wru.uvw_laneaccess_report; transport_wru.utbl_lane_access_*",
    "road, lane, direction, chainage, date/time, traffic volume/reference fields",
    "Use lane-access schema views first; only join to AV where job_id/asset_id exists",
    "The measure is not a normal Asset Vision job KPI. It relies on WRU lane-access support tables.",
    "Partial / No",
  ],
  [
    "SRAPC",
    "TfNSW defect/intervention monthly report",
    "Defect and intervention counts grouped for monthly reporting",
    "transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention",
    "defect/intervention fields, activity/intervention coding, month/reporting period",
    "GROUP BY month/reporting period, defect/intervention/activity fields",
    "Likely similar to Asset Vision job coding, but the official SRAPC view should be checked before rebuilding it.",
    "Partial",
  ],
  [
    "SRAPC / Formitize",
    "Subcontractor monthly reporting",
    "Energy, safety, material, social, fuel, waste, and subcontractor monthly form submissions",
    "formitize_srapc.*; transport_srapc.uvw_monthly_subcontractor_data*",
    "Form submission fields and monthly reporting attributes",
    "Source table family is formitize_srapc, not Asset Vision",
    "These are reporting forms, not AV jobs/assets.",
    "No",
  ],
  [
    "TSRC",
    "KPI 4/5/6 incidents",
    "Incident detection duration, initial response duration, actual response duration, failed KPI flags, abatement costs",
    "transport_tsrc.uvw_kpi456_incidents; transport_tsrc.utbl_kpi2_road_safety; transport_tsrc.utbl_ref_sections_kpi",
    "OccurrenceDateandTime, DetectedDateTime, InitiatedDateTime, ArrivalOnSiteDateTime, KPI4 Target, KPI5 Target, KPI6 Target, SectionID",
    "datediff(minute, OccurrenceDateandTime, DetectedDateTime); KPI6 Target < ActualResponseDuration",
    "This measures incident response times and abatement, not Asset Vision job completion.",
    "No",
  ],
  [
    "TSRC",
    "KPI 7-14 ITS jobs",
    "ITS asset jobs, compliance criticality, response interval, total down time hours",
    "transport_tsrc.uvw_kpi_7_to_14_its_jobs; transport_tsrc.uvw_jobs_all_attributes; transport_tsrc.utbl_ref_corrective_maintenance_compliance",
    "assetcode, activitycategorycode, activitycode, interventioncode, createddate, duedate, completeddate, KPI_Criticality, ResponseValue_ScheduleInterval, Total_Down_Time_Hrs",
    "assetcode IN (SELECT code FROM uvw_kpi_7_to_14_its_asset_uptime); join on ActivityCategoryCode + ActivityCode + InterventionCode",
    "Job details are AV-style, but uptime and compliance rules come from TSRC KPI/reference tables.",
    "Partial / No",
  ],
  [
    "TSRC",
    "Corrective maintenance compliance",
    "Maintenance response requirement by activity/intervention combination",
    "transport_tsrc.utbl_ref_corrective_maintenance_compliance",
    "ActivityCategoryCode, ActivityCode, InterventionCode, ActivityType, KPIComplianceRequirement, ResponseValue_ScheduleInterval, Response_IntervalUnit",
    "ON ref.ActivityCategoryCode = job.activitycategorycode AND ref.ActivityCode = job.activitycode AND ref.InterventionCode = job.interventioncode",
    "TSRC has an explicit corrective-maintenance rule table. BAC does not have an equivalent documented schema table.",
    "Partial",
  ],
  [
    "TSRC",
    "Routine inspection / KPI 25 asset performance",
    "Required inspections, scheduled status, compliant/late/overdue/pending status, additional rectification period",
    "transport_tsrc.uvw_asset_perf_maint_kpi25_1; transport_tsrc.utbl_ref_routine_inspection_compliance; transport_tsrc.uvw_inspection",
    "Frequency, EarliestStartDate, DueDate, scheduleddate, Completeddate, NonCompliantDate, ComplianceStatus, ScheduledStatus",
    "Completeddate <= DueDate THEN 'Compliant'; Completeddate IS NULL AND DueDate <= getdate() THEN 'Overdue'",
    "This is inspection compliance against a planned schedule, not a simple count of completed inspections.",
    "Partial",
  ],
  [
    "TSRC",
    "KPI 20/21 PCAS pavement performance",
    "Average IRI by pavement reporting section, rounded mean IRI, KPI incidents, penalty points incurred",
    "transport_tsrc.uvw_kpi_20_21_pcas_test; transport_tsrc.utbl_pcas_test; transport_tsrc.utbl_pavement_reporting_sections_test",
    "SurveyYear, PavementSectionID, ReportingSectionType, IRI_I, pavement_performance_target, penalty_points",
    "AVG(IRI_I); CEIL(AVG(IRI_I),1); carriageway target = 2.2; ramp target = 2.6",
    "IRI is already in the uploaded PCAS table. Databricks averages it and compares it to targets.",
    "No",
  ],
  [
    "TSRC",
    "KPI 22/23 PCAS pavement performance",
    "Segment-level IRI, rounded IRI, KPI incidents, penalty points incurred",
    "transport_tsrc.uvw_kpi_22_23_pcas_test; transport_tsrc.utbl_pcas_test; transport_tsrc.utbl_pavement_reporting_sections_test",
    "fid, SurveyYear, PavementSectionID, RoadName, lane, chainage_start, chainage_end, WKT, IRI_I",
    "CEIL(IRI_I,1); carriageway target = 2.9; ramp target = 3.6; CEIL((IRI_I - target),1) / 0.1",
    "This is pavement survey/PCAS data, not Asset Vision asset/job data.",
    "No",
  ],
  [
    "TSRC",
    "KPI 25 asset performance abatement",
    "Asset performance compliance and abatement costs for KPI25 sub-measures",
    "transport_tsrc.utbl_asset_perf_maint_kpi25_*; transport_tsrc.uvw_kpi25_*_abatement_costs",
    "asset, inspection, compliance status, abatement key, due/completed dates, reference KPI tables",
    "Use KPI25 schema tables/views first, then join to AV inspection/asset fields where the view already does it",
    "Some source fields are AV-style, but the KPI result needs TSRC-specific reference/abatement logic.",
    "Partial",
  ],
  [
    "SHT / WHT",
    "Generic inspection/job/critical asset reporting",
    "Job and inspection status, critical asset list, generic operational reporting",
    "transport_sht.uvw_job; transport_sht.uvw_inspection; transport_sht.uvw_all_critical_assets",
    "job dates/status/activity fields, inspection dates/status/type, critical asset fields",
    "completeddate IS NOT NULL; duedate < current_timestamp(); inspectiontypename IS NOT NULL",
    "There are generic reporting views, but no documented KPI-numbered logic in the schema evidence.",
    "Partial / Unclear",
  ],
  [
    "NEL",
    "KPI work orders",
    "Work order count, status, priority, target/actual start/finish, work type, attachment count",
    "transport_nel.utbl_kpi_work_orders",
    "Work Order, Status, Priority, Target Start, Target Finish, Actual Start, Actual Finish, Work Type, Attachment Count",
    "Status / target / actual date comparisons from uploaded KPI work-order table",
    "The table is uploaded/manual or future Maximo-oriented. It is not Asset Vision source logic.",
    "No",
  ],
  [
    "Auckland West",
    "Operational AV-style asset/job/inspection reporting",
    "Asset counts, job counts, inspection counts, timesheet/capital works operational measures",
    "transport_aklw.uvw_asset; transport_aklw.uvw_job; transport_aklw.uvw_inspection; transport_aklw.uvw_timesheet",
    "asset id/type/status, job dates/status/activity, inspection dates/type/status, timesheet fields",
    "Use normal AV-style conditions such as completeddate IS NOT NULL and asset deleted/stage filters",
    "Operational reporting is pullable, but no dedicated KPI logic was documented.",
    "Yes for operational data; no schema KPI logic",
  ],
  [
    "VentureSmart",
    "Asset with photo reporting",
    "Assets with photo/evidence coverage",
    "transport_vsm.uvw_all_asset_with_photo",
    "asset id/code/name/type plus photo/evidence link fields",
    "photo/link field IS NOT NULL",
    "This is asset evidence coverage, not a formal KPI view.",
    "Yes for asset/photo; no schema KPI logic",
  ],
  [
    "BAC / Brisbane Airport",
    "Candidate maintenance completion / corrective vs planned split",
    "Job counts, completed jobs, open jobs, overdue jobs, candidate corrective/planned split by activity/intervention coding",
    "ext_mssql_asset_vision_ven_gen7.dbo.job; ext_mssql_asset_vision_ven_gen7.dbo.vjob; ext_mssql_asset_vision_ven_gen7.dbo.jobasset",
    "Contract, ActivityType, ActivityCategoryName, ActivityName, InterventionCode, HazardDefectCode, CreatedDate, DueDate, CompletedDate",
    "Contract IN ('Brisbane Airport','R30-BAC Pavement Maintenance Service'); completeddate IS NOT NULL",
    "BAC appears in shared Asset Vision source records, but no BAC-specific Databricks KPI schema/view logic was found.",
    "Source data yes; KPI logic not documented",
  ],
  [
    "Port of Brisbane",
    "Candidate maintenance completion / corrective vs planned split",
    "Job counts, completed jobs, open jobs, overdue jobs, candidate corrective/planned split by activity/intervention coding",
    "ext_mssql_asset_vision_ven_gen7.dbo.job; ext_mssql_asset_vision_ven_gen7.dbo.vjob; ext_mssql_asset_vision_ven_gen7.dbo.jobasset",
    "Contract, ActivityType, ActivityCategoryName, ActivityName, InterventionCode, HazardDefectCode, CreatedDate, DueDate, CompletedDate",
    "Filter by PoB contract value; completeddate IS NOT NULL; due date overdue logic only after confirming date fields",
    "PoB has the same issue as BAC: source records can be profiled, but no dedicated contract-schema KPI logic was documented.",
    "Source data yes; KPI logic not documented",
  ],
];

const sourceRows = [
  ["Transport Contractor KPI Inventory", "Contract schema KPI/reporting object list and confidence notes"],
  ["Transport Data Beyond Asset Vision", "Per-schema non-Asset-Vision source classification"],
  ["Databricks Source Systems", "Shared Asset Vision source catalog mapping to RAMC, BAC, PoB, TSRC"],
  ["asset_type_metrics tmp.md", "Scratch schema-first pullability notes, including BAC no-schema caveat"],
  ["asset_vision_ven_gen7 job/vjob docs", "Fields available for BAC/PoB contract values inside shared Asset Vision source"],
];

function countBucket(value) {
  if (value.startsWith("Yes")) return "Yes / operational AV";
  if (value.startsWith("Partial")) return "Partial";
  if (value.startsWith("No")) return "No";
  return "Unclear";
}

const counts = new Map();
for (const row of rows) {
  const bucket = countBucket(row[5]);
  counts.set(bucket, (counts.get(bucket) ?? 0) + 1);
}

const summary = workbook.worksheets.add("Summary");
const common = workbook.worksheets.add("Common KPI Summary");
const measures = workbook.worksheets.add("KPI Measure Detail");
const inventory = workbook.worksheets.add("Schema KPI Inventory");
const noSchema = workbook.worksheets.add("No BAC Schema Found");
const sources = workbook.worksheets.add("Sources");

for (const sheet of [summary, common, measures, inventory, noSchema, sources]) sheet.showGridLines = false;

function styleTitle(range) {
  range.format = { fill: "#1F4E79", font: { bold: true, color: "#FFFFFF", size: 15 }, wrapText: true };
}

function styleHeader(range) {
  range.format = { fill: "#D9EAF7", font: { bold: true, color: "#1F1F1F" }, wrapText: true, verticalAlignment: "top" };
}

function styleBody(range) {
  range.format = { wrapText: true, verticalAlignment: "top" };
}

summary.getRange("A1:F1").merge();
summary.getRange("A1").values = [["Schema-first Transport KPI to Asset Vision Pullability"]];
styleTitle(summary.getRange("A1:F1"));
summary.getRange("A3:F5").values = [
  ["Method", "Start with documented contract schemas and KPI/reporting objects, then assess whether the object can be rebuilt from Asset Vision source tables.", null, null, null, null],
  ["Correction", "The earlier workbook mixed schema evidence with stakeholder-described KPI areas. This version separates BAC and PoB because no dedicated contract schemas were documented for them.", null, null, null, null],
  ["Key finding", "The KPI Measure Detail tab lists the measures/fields used. BAC / Brisbane Airport has Asset Vision source records in the shared ven_gen7 catalog, but no documented BAC schema or corrective/planned maintenance SQL logic was found.", null, null, null, null],
];
summary.getRange("A3:A5").format = { font: { bold: true }, fill: "#F2F2F2" };
summary.getRange("B3:F5").merge(true);
styleBody(summary.getRange("A3:F5"));

const countRows = Array.from(counts.entries()).sort((a, b) => a[0].localeCompare(b[0]));
summary.getRange("A8:B8").values = [["Asset Vision pullability bucket", "Schema KPI/reporting rows"]];
styleHeader(summary.getRange("A8:B8"));
summary.getRangeByIndexes(8, 0, countRows.length, 2).values = countRows;
summary.getRange("A8:B13").format = { wrapText: true };
const chart = summary.charts.add("bar", summary.getRangeByIndexes(7, 0, countRows.length + 1, 2));
chart.title = "Pullability of Schema KPI/Reporting Objects";
chart.hasLegend = false;
chart.xAxis = { axisType: "textAxis" };
chart.yAxis = { numberFormatCode: "0" };
chart.setPosition("D8", "J22");
summary.getRange("A16:F16").merge();
summary.getRange("A16").values = [["BAC interpretation"]];
styleHeader(summary.getRange("A16:F16"));
summary.getRange("A17:F19").merge();
summary.getRange("A17").values = [[
  "Do not claim BAC has contract-schema corrective maintenance logic unless Databricks information_schema shows a transport_bac-style schema or view definition. Current evidence supports only an Asset Vision source-table classification exercise using BAC contract values.",
]];
styleBody(summary.getRange("A17:F19"));
summary.getRange("A:A").format.columnWidthPx = 200;
summary.getRange("B:F").format.columnWidthPx = 145;
summary.getRange("3:5").format.rowHeightPx = 42;

common.getRange("A1:H1").values = [[
  "Common KPI / reporting family",
  "Distinct contract/context count",
  "Contracts / contexts with this KPI family",
  "Measures used",
  "Schema evidence examples",
  "Logical difference across contracts",
  "Asset Vision pullability",
  "Required handling",
]];
styleHeader(common.getRange("A1:H1"));
common.getRangeByIndexes(1, 0, commonRowsWithMeasures.length, 8).values = commonRowsWithMeasures;
styleBody(common.getRangeByIndexes(0, 0, commonRowsWithMeasures.length + 1, 8));
const commonTable = common.tables.add(`A1:H${commonRowsWithMeasures.length + 1}`, true, "CommonKpiSummary");
commonTable.style = "TableStyleMedium9";
common.freezePanes.freezeRows(1);
common.getRange("A:A").format.columnWidthPx = 250;
common.getRange("B:B").format.columnWidthPx = 125;
common.getRange("C:C").format.columnWidthPx = 360;
common.getRange("D:D").format.columnWidthPx = 340;
common.getRange("E:E").format.columnWidthPx = 360;
common.getRange("F:F").format.columnWidthPx = 430;
common.getRange("G:G").format.columnWidthPx = 160;
common.getRange("H:H").format.columnWidthPx = 360;
common.getRange(`A2:H${commonRowsWithMeasures.length + 1}`).format.rowHeightPx = 105;
common.getRange(`B2:B${commonRowsWithMeasures.length + 1}`).format = { numberFormat: "0", horizontalAlignment: "center", verticalAlignment: "top" };
common.getRange(`G2:G${commonRowsWithMeasures.length + 1}`).conditionalFormats.add("containsText", { text: "Yes", format: { fill: "#E2F0D9", font: { color: "#375623" } } });
common.getRange(`G2:G${commonRowsWithMeasures.length + 1}`).conditionalFormats.add("containsText", { text: "Partial", format: { fill: "#FFF2CC", font: { color: "#7F6000" } } });
common.getRange(`G2:G${commonRowsWithMeasures.length + 1}`).conditionalFormats.add("containsText", { text: "No", format: { fill: "#FCE4D6", font: { color: "#9E480E" } } });

measures.getRange("A1:H1").values = [[
  "Contract / context",
  "KPI / reporting object",
  "Measures used",
  "Source tables/views",
  "Fields / measure columns",
  "Key SQL / condition snippet",
  "Plain meaning",
  "Asset Vision pullability",
]];
styleHeader(measures.getRange("A1:H1"));
measures.getRangeByIndexes(1, 0, measureRows.length, 8).values = measureRows;
styleBody(measures.getRangeByIndexes(0, 0, measureRows.length + 1, 8));
const measureTable = measures.tables.add(`A1:H${measureRows.length + 1}`, true, "KpiMeasureDetail");
measureTable.style = "TableStyleMedium4";
measures.freezePanes.freezeRows(1);
measures.getRange("A:A").format.columnWidthPx = 155;
measures.getRange("B:B").format.columnWidthPx = 235;
measures.getRange("C:C").format.columnWidthPx = 320;
measures.getRange("D:D").format.columnWidthPx = 360;
measures.getRange("E:E").format.columnWidthPx = 350;
measures.getRange("F:F").format.columnWidthPx = 360;
measures.getRange("G:G").format.columnWidthPx = 330;
measures.getRange("H:H").format.columnWidthPx = 165;
measures.getRange(`A2:H${measureRows.length + 1}`).format.rowHeightPx = 92;
measures.getRange(`H2:H${measureRows.length + 1}`).conditionalFormats.add("containsText", { text: "Yes", format: { fill: "#E2F0D9", font: { color: "#375623" } } });
measures.getRange(`H2:H${measureRows.length + 1}`).conditionalFormats.add("containsText", { text: "Partial", format: { fill: "#FFF2CC", font: { color: "#7F6000" } } });
measures.getRange(`H2:H${measureRows.length + 1}`).conditionalFormats.add("containsText", { text: "No", format: { fill: "#FCE4D6", font: { color: "#9E480E" } } });

inventory.getRange("A1:G1").values = [[
  "Contract schema",
  "Contract / context",
  "KPI or reporting object",
  "Evidence tables/views in schema",
  "Schema has KPI/reporting logic?",
  "Can be pulled from Asset Vision source tables?",
  "Reason / caveat",
]];
styleHeader(inventory.getRange("A1:G1"));
inventory.getRangeByIndexes(1, 0, rows.length, 7).values = rows;
styleBody(inventory.getRangeByIndexes(0, 0, rows.length + 1, 7));
const table = inventory.tables.add(`A1:G${rows.length + 1}`, true, "SchemaKpiInventory");
table.style = "TableStyleMedium2";
inventory.freezePanes.freezeRows(1);
inventory.getRange("A:A").format.columnWidthPx = 140;
inventory.getRange("B:B").format.columnWidthPx = 185;
inventory.getRange("C:C").format.columnWidthPx = 245;
inventory.getRange("D:D").format.columnWidthPx = 330;
inventory.getRange("E:E").format.columnWidthPx = 170;
inventory.getRange("F:F").format.columnWidthPx = 200;
inventory.getRange("G:G").format.columnWidthPx = 390;
inventory.getRange(`A2:G${rows.length + 1}`).format.rowHeightPx = 70;
inventory.getRange(`F2:F${rows.length + 1}`).conditionalFormats.add("containsText", { text: "Yes", format: { fill: "#E2F0D9", font: { color: "#375623" } } });
inventory.getRange(`F2:F${rows.length + 1}`).conditionalFormats.add("containsText", { text: "Partial", format: { fill: "#FFF2CC", font: { color: "#7F6000" } } });
inventory.getRange(`F2:F${rows.length + 1}`).conditionalFormats.add("containsText", { text: "No", format: { fill: "#FCE4D6", font: { color: "#9E480E" } } });
inventory.getRange(`F2:F${rows.length + 1}`).conditionalFormats.add("containsText", { text: "Unclear", format: { fill: "#E7E6E6", font: { color: "#404040" } } });

noSchema.getRange("A1:E1").values = [[
  "Contract / context",
  "Contract schema evidence",
  "Where records appear instead",
  "Schema-level logic found?",
  "Asset Vision implication",
]];
styleHeader(noSchema.getRange("A1:E1"));
noSchema.getRangeByIndexes(1, 0, noSchemaRows.length, 5).values = noSchemaRows;
styleBody(noSchema.getRangeByIndexes(0, 0, noSchemaRows.length + 1, 5));
const noSchemaTable = noSchema.tables.add(`A1:E${noSchemaRows.length + 1}`, true, "NoDedicatedSchema");
noSchemaTable.style = "TableStyleMedium7";
noSchema.freezePanes.freezeRows(1);
noSchema.getRange("A:A").format.columnWidthPx = 250;
noSchema.getRange("B:B").format.columnWidthPx = 220;
noSchema.getRange("C:C").format.columnWidthPx = 300;
noSchema.getRange("D:D").format.columnWidthPx = 260;
noSchema.getRange("E:E").format.columnWidthPx = 360;
noSchema.getRange("A2:E3").format.rowHeightPx = 78;

sources.getRange("A1:B1").values = [["Source", "Use in this workbook"]];
styleHeader(sources.getRange("A1:B1"));
sources.getRangeByIndexes(1, 0, sourceRows.length, 2).values = sourceRows;
sources.getRangeByIndexes(sourceRows.length + 3, 0, 3, 2).values = [
  ["Evidence boundary", "This is based on documented local wiki/table docs and analysis notes, not a live information_schema query."],
  ["Databricks validation query", "Search information_schema.tables/views for transport_bac, Brisbane Airport, R30-BAC, corrective, and planned before claiming a BAC schema logic exists."],
  ["Supersedes", "This schema-first workbook supersedes the earlier mixed-synthesis KPI coverage workbook for your stated question."],
];
styleBody(sources.getRangeByIndexes(0, 0, sourceRows.length + 6, 2));
sources.getRange("A:A").format.columnWidthPx = 250;
sources.getRange("B:B").format.columnWidthPx = 650;
sources.getRange(`A2:B${sourceRows.length + 6}`).format.rowHeightPx = 46;

const check = await workbook.inspect({
  kind: "table",
  range: "Common KPI Summary!A1:H10",
  include: "values,formulas",
  tableMaxRows: 10,
  tableMaxCols: 8,
});
console.log(check.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 300 },
  summary: "final formula error scan",
});
console.log(errors.ndjson);

for (const sheetName of ["Summary", "Common KPI Summary", "KPI Measure Detail", "Schema KPI Inventory", "No BAC Schema Found", "Sources"]) {
  const preview = await workbook.render({ sheetName, autoCrop: "all", scale: 1, format: "png" });
  await fs.writeFile(`${outputDir}/${sheetName.replace(/[^A-Za-z0-9]+/g, "_").toLowerCase()}_schema_first.png`, new Uint8Array(await preview.arrayBuffer()));
}

const xlsx = await SpreadsheetFile.exportXlsx(workbook);
await xlsx.save(`${outputDir}/transport_kpi_asset_vision_coverage_schema_first_plain_summary.xlsx`);
