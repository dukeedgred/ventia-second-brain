CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.dict_transport_kpi_buildability AS
SELECT
    kpi_area,
    kpi_name,
    asset_vision_buildability,
    asset_vision_inputs,
    non_asset_vision_dependency,
    notes,
    CURRENT_TIMESTAMP() AS created_ts,
    CURRENT_TIMESTAMP() AS updated_ts
FROM VALUES
    ('Asset data quality', 'Asset register completeness', 'Yes', 'asset', CAST(NULL AS STRING), 'Build from Asset Vision asset records and mapped asset categories.'),
    ('Asset data quality', 'Location and WKT completeness', 'Yes', 'assetlocation; vassetlocation', CAST(NULL AS STRING), 'Coordinate validity still needs agreed data quality rules.'),
    ('Asset data quality', 'Condition, criticality, and risk coverage', 'Yes / Partial', 'asset.AssetCondition; asset.AssetCriticality; asset.AssetRisk', 'Business definitions', 'Completeness is buildable; official meaning and thresholds need governance validation.'),
    ('Job', 'Job/work-order volume and completion', 'Yes', 'job; jobasset', CAST(NULL AS STRING), 'Good first dashboard KPI where due and completed dates are populated.'),
    ('Job', 'Open overdue jobs and backlog', 'Partial', 'job.DueDate; job.CompletedDate; workflow status fields', 'Historical snapshot logic', 'Current overdue is buildable; month-over-month backlog needs persisted snapshots.'),
    ('Job', 'Hazard, defect, activity, intervention, priority, and compliance', 'Partial', 'job.HazardDefectCode; ActivityCategoryName; ActivityName; ActivityType; InterventionCode; Priority; Compliant', 'Contract-specific coding rules', 'Fields exist but need mapping and agreed definitions before treating as contractual KPIs.'),
    ('Inspection', 'Inspection scheduled and completed', 'Yes', 'inspection.ScheduledDate; inspection.CompletedDate; inspection.InspectionTypeName', CAST(NULL AS STRING), 'Good first dashboard KPI where scheduled and completed dates are populated.'),
    ('Inspection', 'Inspection compliance or on-time rate', 'Partial', 'inspection.ScheduledDate; inspection.CompletedDate; inspectionstatus', 'Contract-specific compliance thresholds', 'Core dates are buildable; official compliance rules need business validation.'),
    ('Capital work', 'Capital works planned and completed', 'Yes / Partial', 'capitalwork.PlannedStart; capitalwork.ActualFinish; capitalworktask', 'Custom chainage/reference logic', 'Core volume and completion are buildable where capital works are asset-linked.'),
    ('Evidence', 'Photo/evidence coverage', 'Yes', 'photo; job; inspection; capitalwork; asset links', CAST(NULL AS STRING), 'Build from photo source table and source table ID after linking back to asset.'),
    ('Resource utilisation', 'Planned resource time, quantity, and cost', 'Yes / Partial', 'plannedresourceitem', 'Resource classification rules', 'Buildable when SourceTableID is correctly joined to asset, job, inspection, or capital work.'),
    ('Resource utilisation', 'Actual timesheet time, quantity, and cost', 'Yes / Partial', 'timesheetitem', 'Resource classification rules', 'Buildable when SourceTableID is correctly joined to asset, job, inspection, or capital work.'),
    ('Safety', 'Incident and enterprise safety KPIs', 'No / Partial', 'job and inspection may provide some operational inputs', 'Safety/incident source systems; official safety metric definitions', 'TRIFR, SIFR, SAIFR, and incident KPIs should not be treated as Asset Vision-only.'),
    ('Tunnel / Maximo', 'Tunnel work-order and asset KPIs', 'No', CAST(NULL AS STRING), 'Maximo and tunnel systems', 'Not covered by current Asset Vision source objects.'),
    ('External context', 'Traffic, weather, lane closure, PCAS, pavement, tollroad, stakeholder, noise, and abatement reporting', 'No / Partial', 'Some lane/job references may exist in Asset Vision', 'Contract-specific non-Asset-Vision tables', 'Keep these separate from the first Asset Vision dashboard unless source-specific tables are onboarded.')
AS KPI_BUILDABILITY(
    kpi_area,
    kpi_name,
    asset_vision_buildability,
    asset_vision_inputs,
    non_asset_vision_dependency,
    notes
)
;

