# Summary

This is a simple project to extract and model data using Azure Data Factory, dbt and Databricks.

## Data Source

Data is sourced from an API provided by the webapp [1001albumsgenerator](https://1001albumsgenerator.com/). 

## ETL via Data Factory

Data is extracted daily as JSON and stored as raw data in an Azure storage account via an Azure Data Factory
pipeline.

The ADF pipeline then calls an Azure Databricks notebook that loads today's json file into a delta table in an
ADB workspace.

The source code for the Data Factory is stored in the `/adf` folder.

## dbt

This dbt project takes the raw Albums data and builds a small set of dimensional models to allow for data analysis and
visualisation. 

## Visualisation

Back in the ADB workspace used to load the daily delta table, a Dashboard visualisation is setup to point to the 
Gold layer of the dbt warehouse and provide simple visualisations and analysis.

Users with permission can access the visualisation dashboard vis the ADB workspace [here](https://adb-2359489148887710.10.azuredatabricks.net/dashboardsv3/01ef83092f1b1403b7967bea7000d543/published?o=2359489148887710)
