-- Returns distinct job activity category names in:
-- ('activity_name 1'),
-- ('activity_name 2')
-- format.

WITH activity_categories AS (
  SELECT DISTINCT
    COALESCE(activity_category_name, '[null]') AS raw_activity_category_name
  FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base
)
SELECT
  ARRAY_JOIN(
    TRANSFORM(
      SORT_ARRAY(COLLECT_LIST(raw_activity_category_name)),
      x -> CONCAT('(', CHR(39), REPLACE(x, CHR(39), CONCAT(CHR(39), CHR(39))), CHR(39), ')')
    ),
    ',\n'
  ) AS activity_category_name_list
FROM activity_categories;

-- If the single-cell output is truncated in Databricks, run this row-by-row
-- version instead and copy the result column.
WITH activity_categories AS (
  SELECT DISTINCT
    COALESCE(activity_category_name, '[null]') AS raw_activity_category_name
  FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base
)
SELECT
  CONCAT(
    '(',
    CHR(39),
    REPLACE(raw_activity_category_name, CHR(39), CONCAT(CHR(39), CHR(39))),
    CHR(39),
    '),'
  ) AS activity_category_name_line
FROM activity_categories
ORDER BY raw_activity_category_name;
