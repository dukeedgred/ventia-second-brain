-- Source table
-- staged.stg_api_venspark.ideas

-- Sanitized idea extract used by the demo.
SELECT
  CAST(idea_id AS STRING) AS idea_id,
  CAST(id AS STRING) AS source_id,
  COALESCE(title, '') AS title,
  LEFT(REGEXP_REPLACE(REGEXP_REPLACE(COALESCE(description, ''), '<[^>]*>', ' '), '\\s+', ' '), 900) AS description,
  COALESCE(campaign_title, 'Unspecified') AS campaign_title,
  COALESCE(status_title, 'Unspecified') AS status_title,
  COALESCE(stage_title, 'Unspecified') AS stage_title,
  CAST(submittedAt AS STRING) AS submitted_at,
  CAST(lastStageUpdateAt AS STRING) AS last_stage_update_at,
  CAST(lastStatusUpdateAt AS STRING) AS last_status_update_at,
  CAST(row_updated_timestamp AS STRING) AS row_updated_timestamp,
  COALESCE(CAST(likesCount AS INT), 0) AS likes,
  COALESCE(CAST(commentsCount AS INT), 0) AS comments,
  COALESCE(CAST(tokenVotesSum AS INT), 0) AS votes,
  ROUND(COALESCE(TRY_CAST(textSentiment AS DOUBLE), 0), 3) AS sentiment
FROM staged.stg_api_venspark.ideas
WHERE COALESCE(CAST(deleted_from_source AS INT), 0) = 0
  AND COALESCE(CAST(isDeletedInternally AS BOOLEAN), false) = false
  AND COALESCE(CAST(wasComment AS BOOLEAN), false) = false
ORDER BY submittedAt DESC
LIMIT 1000;

-- Source-table count and recency check.
SELECT
  COUNT(*) AS source_rows,
  COUNT(DISTINCT idea_id) AS distinct_ideas,
  SUM(CASE WHEN COALESCE(CAST(deleted_from_source AS INT), 0) <> 0 THEN 1 ELSE 0 END) AS deleted_rows,
  SUM(CASE WHEN COALESCE(CAST(wasComment AS BOOLEAN), false) THEN 1 ELSE 0 END) AS comment_rows,
  CAST(MIN(submittedAt) AS STRING) AS first_submitted_at,
  CAST(MAX(submittedAt) AS STRING) AS last_submitted_at,
  CAST(MAX(row_updated_timestamp) AS STRING) AS last_loaded_at
FROM staged.stg_api_venspark.ideas;
