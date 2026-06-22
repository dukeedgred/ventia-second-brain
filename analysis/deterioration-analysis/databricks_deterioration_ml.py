# Databricks notebook source
"""Road deterioration / failure risk PoC.

This script trains a simple ML model to estimate whether an asset / road section
is likely to have a future failure-type event in the next N days.

It intentionally uses structured Asset Vision job history only. No photos/images.
"""

import json


# ---------------------------------------------------------------------------
# Settings
# ---------------------------------------------------------------------------

SOURCE_TABLES = [
    {
        "source_context": "asset_vision_ven_gen7",
        "source_catalog": "ext_mssql_asset_vision_ven_gen7",
        "documented_contract_context": "RAMC / BAC / PoB / TSRC",
        "table": "ext_mssql_asset_vision_ven_gen7.dbo.vjob",
    },
    {
        "source_context": "asset_vision_ven_vicroads",
        "source_catalog": "ext_mssql_asset_vision_ven_vicroads",
        "documented_contract_context": "WRU",
        "table": "ext_mssql_asset_vision_ven_vicroads.dbo.vjob",
    },
    {
        "source_context": "asset_vision_vns_gen7",
        "source_catalog": "ext_mssql_asset_vision_vns_gen7",
        "documented_contract_context": "SHT / WHT",
        "table": "ext_mssql_asset_vision_vns_gen7.dbo.vjob",
    },
    {
        "source_context": "asset_vision_vnz_gen7",
        "source_catalog": "ext_mssql_asset_vision_vnz_gen7",
        "documented_contract_context": "Auckland West",
        "table": "ext_mssql_asset_vision_vnz_gen7.dbo.vjob",
    },
    {
        "source_context": "asset_vision_vsm_gen7",
        "source_catalog": "ext_mssql_asset_vision_vsm_gen7",
        "documented_contract_context": "VentureSmart",
        "table": "ext_mssql_asset_vision_vsm_gen7.dbo.vjob",
    },
]


def get_widget(name, default):
    try:
        dbutils.widgets.get(name)  # noqa: F821
    except Exception:
        try:
            dbutils.widgets.text(name, default)  # noqa: F821
        except Exception:
            return default

    try:
        return dbutils.widgets.get(name)  # noqa: F821
    except Exception:
        return default


def get_spark():
    existing = globals().get("spark")
    if existing is not None:
        return existing

    from pyspark.sql import SparkSession

    active = SparkSession.getActiveSession()
    if active is not None:
        return active

    return SparkSession.builder.getOrCreate()


def show_dataframe(df, rows=50):
    try:
        display(df)  # noqa: F821
    except Exception:
        df.show(rows, truncate=False)


CONFIG = {
    "prediction_horizon_days": int(get_widget("prediction_horizon_days", "90")),
    "failure_priority_max": int(get_widget("failure_priority_max", "2")),
    "failure_keywords": get_widget(
        "failure_keywords",
        "pothole,crack,defect,failure,failed,urgent,emergency,hazard,make safe,unplanned,repair",
    ),
    "contract_filter": get_widget("contract_filter", ""),
    "region_filter": get_widget("region_filter", ""),
    "exclude_source_contexts": get_widget("exclude_source_contexts", ""),
    "min_training_rows": int(get_widget("min_training_rows", "500")),
    "num_trees": int(get_widget("num_trees", "120")),
    "max_depth": int(get_widget("max_depth", "7")),
    "write_mode": get_widget("write_mode", "overwrite"),
    "output_test_predictions_table": get_widget(
        "output_test_predictions_table",
        "transport_dev.integ_transport_assets.deterioration_model_test_predictions",
    ),
    "output_latest_risk_table": get_widget(
        "output_latest_risk_table",
        "transport_dev.integ_transport_assets.deterioration_latest_risk",
    ),
    "output_metrics_table": get_widget(
        "output_metrics_table",
        "transport_dev.integ_transport_assets.deterioration_model_metrics",
    ),
    "output_feature_importance_table": get_widget(
        "output_feature_importance_table",
        "transport_dev.integ_transport_assets.deterioration_feature_importance",
    ),
}


def split_csv(value):
    return [item.strip() for item in str(value or "").split(",") if item.strip()]


# ---------------------------------------------------------------------------
# Source data
# ---------------------------------------------------------------------------

def read_asset_vision_jobs():
    from functools import reduce
    from pyspark.sql import functions as F

    spark_session = get_spark()
    normalised_tables = []
    excluded = set(split_csv(CONFIG["exclude_source_contexts"]))

    for source in SOURCE_TABLES:
        if source["source_context"] in excluded:
            continue

        raw = spark_session.table(source["table"]).where(F.col("Deleted") == F.lit(False))

        normalised = raw.select(
            F.lit(source["source_context"]).alias("source_context"),
            F.lit(source["source_catalog"]).alias("source_catalog"),
            F.lit(source["documented_contract_context"]).alias("documented_contract_context"),
            F.col("ID").cast("long").alias("job_id"),
            F.col("Contract").cast("string").alias("contract"),
            F.col("Region").cast("string").alias("region"),
            F.col("AssetID").cast("long").alias("asset_id"),
            F.col("AssetCode").cast("string").alias("asset_code"),
            F.col("AssetName").cast("string").alias("asset_name"),
            F.col("Section").cast("string").alias("section"),
            F.col("ActivityType").cast("string").alias("activity_type"),
            F.col("ActivityName").cast("string").alias("activity_name"),
            F.col("InterventionName").cast("string").alias("intervention_name"),
            F.col("Priority").cast("string").alias("priority_raw"),
            F.col("InspectionID").cast("long").alias("inspection_id"),
            F.col("InspectionTypeName").cast("string").alias("inspection_type_name"),
            F.col("DueDate").cast("timestamp").alias("due_ts"),
            F.col("ScheduledStart").cast("timestamp").alias("scheduled_start_ts"),
            F.col("ScheduledEnd").cast("timestamp").alias("scheduled_end_ts"),
            F.col("CompletedDate").cast("timestamp").alias("completed_ts"),
            F.col("CompletedStatus").cast("string").alias("completed_status"),
            F.col("AssignedUser").cast("string").alias("assigned_user"),
            F.col("CurrentWorkflowItemName").cast("string").alias("workflow_status"),
            F.col("EstimatedDuration").cast("double").alias("estimated_duration_minutes"),
            F.col("WKT").cast("string").alias("wkt"),
        )
        normalised_tables.append(normalised)

    if not normalised_tables:
        raise ValueError("No source tables selected. Check exclude_source_contexts.")

    return reduce(lambda left, right: left.unionByName(right), normalised_tables)


def prepare_events(source_df):
    from pyspark.sql import functions as F

    priority_num = F.coalesce(
        F.regexp_extract(F.col("priority_raw"), "(\\d+)", 1).cast("int"),
        F.lit(3),
    )

    event_ts = F.coalesce(
        F.col("completed_ts"),
        F.col("scheduled_start_ts"),
        F.col("due_ts"),
    )

    text_blob = F.lower(
        F.concat_ws(
            " ",
            F.coalesce(F.col("activity_type"), F.lit("")),
            F.coalesce(F.col("activity_name"), F.lit("")),
            F.coalesce(F.col("intervention_name"), F.lit("")),
            F.coalesce(F.col("inspection_type_name"), F.lit("")),
            F.coalesce(F.col("workflow_status"), F.lit("")),
            F.coalesce(F.col("completed_status"), F.lit("")),
        )
    )

    keyword_condition = F.lit(False)
    for keyword in split_csv(CONFIG["failure_keywords"]):
        keyword_condition = keyword_condition | text_blob.contains(keyword.lower())

    events = (
        source_df
        .withColumn("event_ts", event_ts)
        .withColumn("event_date", F.to_date(event_ts))
        .withColumn("event_unix", F.unix_timestamp(event_ts))
        .withColumn("priority", priority_num)
        .withColumn(
            "latitude",
            F.regexp_extract(F.col("wkt"), "(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)", 2).cast("double"),
        )
        .withColumn(
            "longitude",
            F.regexp_extract(F.col("wkt"), "(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)", 1).cast("double"),
        )
        .withColumn(
            "asset_key",
            F.when(
                F.col("asset_id").isNotNull(),
                F.concat_ws(":", F.col("source_context"), F.col("asset_id").cast("string")),
            ).otherwise(
                F.concat_ws(
                    ":",
                    F.coalesce(F.col("contract"), F.lit("unknown_contract")),
                    F.coalesce(F.col("region"), F.lit("unknown_region")),
                    F.coalesce(F.col("asset_code"), F.col("section"), F.col("asset_name"), F.lit("unknown_asset")),
                )
            ),
        )
        .withColumn(
            "is_failure_event",
            ((F.col("priority") <= F.lit(CONFIG["failure_priority_max"])) | keyword_condition).cast("int"),
        )
        .where(F.col("event_ts").isNotNull())
        .where(F.col("event_ts") <= F.current_timestamp())
        .where(F.col("asset_key").isNotNull())
    )

    if CONFIG["contract_filter"].strip():
        events = events.where(
            F.lower(F.col("contract").cast("string")).contains(CONFIG["contract_filter"].strip().lower())
        )

    if CONFIG["region_filter"].strip():
        events = events.where(
            F.lower(F.col("region").cast("string")).contains(CONFIG["region_filter"].strip().lower())
        )

    return events


# ---------------------------------------------------------------------------
# Features and label
# ---------------------------------------------------------------------------

def build_features(events):
    from pyspark.sql import Window
    from pyspark.sql import functions as F

    seconds = 24 * 60 * 60
    asset_window = Window.partitionBy("asset_key").orderBy("event_unix")

    last_30d = asset_window.rangeBetween(-30 * seconds, -1)
    last_90d = asset_window.rangeBetween(-90 * seconds, -1)
    last_365d = asset_window.rangeBetween(-365 * seconds, -1)

    features = (
        events
        .withColumn("previous_event_ts", F.lag("event_ts").over(asset_window))
        .withColumn("days_since_previous_event", F.datediff(F.col("event_ts"), F.col("previous_event_ts")))
        .withColumn("jobs_last_30d", F.count("*").over(last_30d))
        .withColumn("jobs_last_90d", F.count("*").over(last_90d))
        .withColumn("jobs_last_365d", F.count("*").over(last_365d))
        .withColumn("failures_last_90d", F.sum("is_failure_event").over(last_90d))
        .withColumn("failures_last_365d", F.sum("is_failure_event").over(last_365d))
        .withColumn("avg_priority_last_365d", F.avg("priority").over(last_365d))
        .withColumn("month", F.month("event_ts"))
        .withColumn("year", F.year("event_ts"))
        .withColumn("event_key", F.concat_ws(":", F.col("source_context"), F.col("job_id").cast("string")))
    )

    return features


def add_future_failure_label(features):
    from pyspark.sql import functions as F

    horizon_seconds = CONFIG["prediction_horizon_days"] * 24 * 60 * 60

    base = features.alias("base")
    future_failures = (
        features
        .where(F.col("is_failure_event") == 1)
        .select(
            F.col("asset_key").alias("future_asset_key"),
            F.col("event_unix").alias("future_event_unix"),
            F.col("event_key").alias("future_event_key"),
        )
        .alias("future")
    )

    joined = base.join(
        future_failures,
        (F.col("base.asset_key") == F.col("future.future_asset_key"))
        & (F.col("future.future_event_unix") > F.col("base.event_unix"))
        & (F.col("future.future_event_unix") <= F.col("base.event_unix") + F.lit(horizon_seconds)),
        "left",
    )

    labels = (
        joined
        .groupBy(F.col("base.event_key").alias("event_key"))
        .agg(F.max(F.when(F.col("future.future_event_key").isNotNull(), 1).otherwise(0)).alias("label"))
    )

    return features.join(labels, "event_key", "inner")


# ---------------------------------------------------------------------------
# Model
# ---------------------------------------------------------------------------

def split_train_test(labeled_df):
    from pyspark.sql import functions as F

    cutoff = labeled_df.approxQuantile("event_unix", [0.8], 0.01)[0]
    train_df = labeled_df.where(F.col("event_unix") <= F.lit(cutoff))
    test_df = labeled_df.where(F.col("event_unix") > F.lit(cutoff))

    return train_df, test_df, cutoff


def check_training_data(train_df, test_df):
    train_count = train_df.count()
    test_count = test_df.count()
    train_positive = train_df.where("label = 1").count()
    test_positive = test_df.where("label = 1").count()

    summary = {
        "train_rows": train_count,
        "test_rows": test_count,
        "train_positive_labels": train_positive,
        "test_positive_labels": test_positive,
    }
    print(json.dumps(summary, indent=2))

    if train_count < CONFIG["min_training_rows"]:
        raise ValueError("Not enough training rows. Reduce filters or lower min_training_rows for a tiny PoC.")
    if train_positive == 0:
        raise ValueError("Training set has no positive failure labels. Loosen failure keywords/priority or use more history.")
    if test_count == 0:
        raise ValueError("Test set is empty. Use more historical data.")


def train_random_forest(train_df):
    from pyspark.ml import Pipeline
    from pyspark.ml.classification import RandomForestClassifier
    from pyspark.ml.feature import Imputer, StringIndexer, VectorAssembler

    categorical_columns = [
        "source_context",
        "documented_contract_context",
        "contract",
        "region",
        "activity_type",
        "inspection_type_name",
    ]

    numeric_columns = [
        "priority",
        "estimated_duration_minutes",
        "latitude",
        "longitude",
        "days_since_previous_event",
        "jobs_last_30d",
        "jobs_last_90d",
        "jobs_last_365d",
        "failures_last_90d",
        "failures_last_365d",
        "avg_priority_last_365d",
        "month",
    ]

    indexers = [
        StringIndexer(
            inputCol=column,
            outputCol=f"{column}_index",
            handleInvalid="keep",
        )
        for column in categorical_columns
    ]

    filled_numeric_columns = [f"{column}_filled" for column in numeric_columns]
    imputer = Imputer(
        inputCols=numeric_columns,
        outputCols=filled_numeric_columns,
    ).setStrategy("median")

    assembler_inputs = filled_numeric_columns + [f"{column}_index" for column in categorical_columns]
    assembler = VectorAssembler(
        inputCols=assembler_inputs,
        outputCol="features",
        handleInvalid="keep",
    )

    classifier = RandomForestClassifier(
        labelCol="label",
        featuresCol="features",
        probabilityCol="probability",
        predictionCol="prediction",
        numTrees=CONFIG["num_trees"],
        maxDepth=CONFIG["max_depth"],
        seed=42,
    )

    pipeline = Pipeline(stages=indexers + [imputer, assembler, classifier])
    model = pipeline.fit(train_df)

    return model, assembler_inputs


def score_with_risk(model, df):
    from pyspark.ml.functions import vector_to_array
    from pyspark.sql import functions as F

    scored = model.transform(df)
    scored = scored.withColumn("risk_score", vector_to_array(F.col("probability"))[1])
    scored = scored.withColumn(
        "risk_band",
        F.when(F.col("risk_score") >= 0.70, F.lit("High"))
        .when(F.col("risk_score") >= 0.40, F.lit("Medium"))
        .otherwise(F.lit("Low")),
    )
    return scored


def evaluate_predictions(predictions, cutoff):
    from pyspark.ml.evaluation import BinaryClassificationEvaluator, MulticlassClassificationEvaluator
    from pyspark.sql import functions as F

    roc_auc = BinaryClassificationEvaluator(
        labelCol="label",
        rawPredictionCol="rawPrediction",
        metricName="areaUnderROC",
    ).evaluate(predictions)

    f1 = MulticlassClassificationEvaluator(
        labelCol="label",
        predictionCol="prediction",
        metricName="f1",
    ).evaluate(predictions)

    accuracy = MulticlassClassificationEvaluator(
        labelCol="label",
        predictionCol="prediction",
        metricName="accuracy",
    ).evaluate(predictions)

    counts = predictions.agg(
        F.count("*").alias("test_rows"),
        F.sum("label").alias("actual_failures"),
        F.sum("prediction").alias("predicted_failures"),
    ).collect()[0].asDict()

    metrics = {
        "model_run_ts": str(predictions.select(F.current_timestamp().alias("ts")).collect()[0]["ts"]),
        "prediction_horizon_days": CONFIG["prediction_horizon_days"],
        "train_test_split": "time_based_80_20",
        "split_cutoff_unix": float(cutoff),
        "roc_auc": float(roc_auc),
        "f1": float(f1),
        "accuracy": float(accuracy),
        "test_rows": int(counts["test_rows"]),
        "actual_failures": int(counts["actual_failures"] or 0),
        "predicted_failures": int(counts["predicted_failures"] or 0),
        "failure_priority_max": CONFIG["failure_priority_max"],
        "failure_keywords": CONFIG["failure_keywords"],
    }
    return metrics


def feature_importance_rows(model, assembler_inputs):
    classifier_model = model.stages[-1]
    importances = classifier_model.featureImportances.toArray()

    rows = []
    for feature, importance in zip(assembler_inputs, importances):
        rows.append({
            "feature": feature.replace("_filled", ""),
            "importance": float(importance),
        })
    return rows


def latest_asset_rows(features):
    from pyspark.sql import Window
    from pyspark.sql import functions as F

    latest_window = Window.partitionBy("asset_key").orderBy(F.col("event_ts").desc(), F.col("job_id").desc())
    return (
        features
        .withColumn("asset_latest_rank", F.row_number().over(latest_window))
        .where(F.col("asset_latest_rank") == 1)
        .drop("asset_latest_rank")
    )


def output_columns(df):
    wanted = [
        "asset_key",
        "source_context",
        "documented_contract_context",
        "contract",
        "region",
        "asset_id",
        "asset_code",
        "asset_name",
        "section",
        "job_id",
        "inspection_id",
        "event_ts",
        "activity_type",
        "activity_name",
        "intervention_name",
        "inspection_type_name",
        "priority",
        "is_failure_event",
        "label",
        "risk_score",
        "risk_band",
        "prediction",
        "jobs_last_90d",
        "jobs_last_365d",
        "failures_last_90d",
        "failures_last_365d",
        "days_since_previous_event",
        "latitude",
        "longitude",
    ]
    return [column for column in wanted if column in df.columns]


def write_outputs(test_predictions, latest_risk, metrics, importance_rows):
    spark_session = get_spark()

    spark_session.createDataFrame([metrics]).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_metrics_table"])

    spark_session.createDataFrame(importance_rows).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_feature_importance_table"])

    test_predictions.select(*output_columns(test_predictions)).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_test_predictions_table"])

    latest_risk.select(*output_columns(latest_risk)).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_latest_risk_table"])


# ---------------------------------------------------------------------------
# Run
# ---------------------------------------------------------------------------

def run_deterioration_model():
    spark_session = get_spark()

    print("Reading Asset Vision history...")
    source_df = read_asset_vision_jobs()

    print("Preparing events...")
    events = prepare_events(source_df).cache()
    print(f"Event rows: {events.count()}")

    print("Building history features...")
    features = build_features(events).cache()

    print("Creating future failure label...")
    labeled = add_future_failure_label(features).cache()

    train_df, test_df, cutoff = split_train_test(labeled)
    check_training_data(train_df, test_df)

    print("Training Random Forest...")
    model, assembler_inputs = train_random_forest(train_df)

    print("Scoring test set...")
    test_predictions = score_with_risk(model, test_df).cache()
    metrics = evaluate_predictions(test_predictions, cutoff)
    importance_rows = feature_importance_rows(model, assembler_inputs)

    print("Scoring latest asset/section risk...")
    latest_rows = latest_asset_rows(features)
    latest_risk = score_with_risk(model, latest_rows).cache()

    print("Writing outputs...")
    write_outputs(test_predictions, latest_risk, metrics, importance_rows)

    print(json.dumps(metrics, indent=2))
    show_dataframe(spark_session.createDataFrame([metrics]))
    show_dataframe(spark_session.createDataFrame(importance_rows).orderBy("importance", ascending=False))
    show_dataframe(latest_risk.select(*output_columns(latest_risk)).orderBy("risk_score", ascending=False).limit(50))

    return model, test_predictions, latest_risk, metrics, importance_rows


# COMMAND ----------

# In a Databricks notebook, run this cell after reviewing CONFIG above:
#
# model, test_predictions, latest_risk, metrics, importance_rows = run_deterioration_model()
