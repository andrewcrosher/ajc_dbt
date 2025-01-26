# ajc_dbt

## Summary

This is a simple personal project to extract and model music album data using Azure Data Factory, dbt, and Databricks.

## Table of Contents
- [Data: 1001 Albums To Hear Before You Die](#data-1001-albums-to-hear-before-you-die)
- [Build: GitHub Actions](#build-github-actions)
- [Extract: Data Factory](#extract-data-factory)
- [Transform: dbt](#transform-dbt)
- [Visualisation: Databricks](#visualisation-databricks)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Data: 1001 Albums To Hear Before You Die

Data is sourced from an API provided by the webapp [1001albumsgenerator](https://1001albumsgenerator.com/), based on the book `1001 Albums You Must Hear Before You Die` by Robert Dimery.

Every day a new music album is listened to and rated. The API tracks the albums listened to and the rating assigned, along with some metadata such as release year, Wikipedia link, genres, and global rating.

## Build: GitHub Actions

A GitHub Actions Workflow pipeline is triggered on push to the `main` branch and on completion of a PR. This pipeline compiles and lints the dbt project code before building it on the target Databricks database. A Databricks personal access token is stored as an environment variable called `ADBTOKEN`.

Build status:

[![build_dbt](https://github.com/andrewcrosher/ajc_dbt/actions/workflows/build_dbt.yml/badge.svg)](https://github.com/andrewcrosher/ajc_dbt/actions/workflows/build_dbt.yml)

## Extract: Data Factory

Data is extracted daily as JSON and stored as raw data in an Azure storage account via the Azure Data Factory pipeline `get_albums`.

The pipeline then calls an Azure Databricks notebook called `load_albums_delta` that loads today's JSON file into a delta table in an ADB workspace.

In addition, each week a maintenance script optimizes and vacuums the delta table.

Storage account access is managed via an API call to an Azure Key Vault that holds the details of a storage account key to be used by Databricks to connect to.

The source code for the Data Factory is stored in the [adf](./adf/) folder. The Databricks notebook lives in the [adb](/adb/) folder.

## Transform: dbt

Once the data is loaded into the delta lake, it can be transformed into the desired shape. A dbt project takes the raw Albums data and builds a small set of dimensional models to allow for data analysis and visualization.

## Visualisation: Databricks

In the ADB workspace, a Dashboard visualization uses the Gold layer of the dbt warehouse and provides simple visualizations and analysis.

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/andrewcrosher/ajc_dbt.git
   cd ajc_dbt
