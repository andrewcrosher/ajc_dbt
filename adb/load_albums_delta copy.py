# Databricks notebook source
# MAGIC %md
# MAGIC ## Load Albums Data to Delta Lake
# MAGIC
# MAGIC This notebook loads today's reviewed album data from the raw data lake into a delta table `albums.ajc_albums`

# COMMAND ----------

# DBTITLE 1,create albums schema
# Create schema if not exists
spark.sql("CREATE SCHEMA IF NOT EXISTS albums")
