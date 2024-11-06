# Databricks notebook source
# MAGIC %md
# MAGIC ## Maintain Delta Lake
# MAGIC
# MAGIC This notebook performs `OPTIMIZE` and `VACUUM` operations on the delta table `albums.ajc_albums`

# COMMAND ----------

# DBTITLE 1,Optimize
# MAGIC %sql
# MAGIC OPTIMIZE hive_metastore.albums.ajc_albums

# COMMAND ----------

# DBTITLE 1,Vacuum
# MAGIC %sql
# MAGIC VACUUM hive_metastore.albums.ajc_albums
