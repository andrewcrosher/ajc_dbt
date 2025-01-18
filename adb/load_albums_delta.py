# Databricks notebook source
# MAGIC %md
# MAGIC ## Load Albums Data to Delta Lake
# MAGIC
# MAGIC This notebook loads today's reviewed album data from the raw data lake into a delta table `albums.ajc_albums`

# COMMAND ----------

# DBTITLE 1,create albums schema
# Create schema if not exists
spark.sql("CREATE SCHEMA IF NOT EXISTS albums")

# COMMAND ----------

# DBTITLE 1,create a df with today's json
# create a date variable for today
from datetime import datetime
date = datetime.now().strftime("%Y%m%d")

# Define the storage account details
storage_account_name = dbutils.widgets.get("storage_account_name")
storage_account_access_key = dbutils.widgets.get("storage_account_access_key")
container_name = "albums"
file_path = f"raw/{date}-raw_albums.json"

# Set the Spark configuration for accessing the Azure Blob Store
spark.conf.set(f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net", storage_account_access_key)

# Read the JSON file into a Spark DataFrame
df = spark.read.json(f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net/{file_path}")

# Display the DataFrame
display(df)

# COMMAND ----------

# DBTITLE 1,load the df into albums.ajc_albums delta table
from pyspark.sql.functions import current_timestamp

# Add a new column with the current timestamp
df_with_timestamp = df.withColumn("load_timestamp", current_timestamp())

# Write the DataFrame to a Delta table in the Hive metastore in append mode, targeting the 'albums' schema
df_with_timestamp.write.format("delta").mode("append").saveAsTable("albums.ajc_albums").option("mergeSchema", "true")
