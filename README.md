# DAGSTER-DBT-DUCKDB-SANDBOX

A sandbox pipeline to explore the portable MDS. It can be used to build and test ETL pipelines or maintaining a mini-warehouse

## Components

- Dagster : Multi-faceted dataflow orchestrator
- DBT : Data build tool
- DuckDB - Lightweight superfast OLAP DB

## Structure

This is a single container system which can be spin up for building and managing datasets and data pipelines.
These folders are externally mounted to container so it can be persisted for re-use

- `src` - DBT and Dagster Assets reside here. Can house multiple projects under same folder
- `apps` - duckdb is downloaded and persisted here for the first time (Deatils are in `initialize.sh`)
- `data` - data folder to house raw datasets (Input), duckdb files and any output files that are generated

## Running the piipelines

1 - Download raw datasets manually or add scripts to this repo
2 - Run `initialize.sh` to setup the sandbox
3 - Develop projects within `src` folder via DBT and Dagster
4 - Materialize dagster assets via Dagster UI

Inspired by this [dbt-dagster tutorial](https://docs.dagster.io/integrations/dbt/using-dbt-with-dagster)