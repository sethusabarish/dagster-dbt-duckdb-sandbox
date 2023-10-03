import pandas as pd,  lxml, json, os, duckdb
from dagster import AssetExecutionContext, asset
from dagster_dbt import DbtCliResource, dbt_assets
from .constants import dbt_manifest_path

duckdb_database_path='/data/duckdb/so_comments.duckdb'
raw_file_path='/data/raw/split-comments.xml'

@asset(compute_kind='python')
def raw_comments(context) -> None:
    df = pd.read_xml(raw_file_path)
    rename_dict={'PostId':'post_id','CreationDate':'create_ts','UserId':'user_id','Id':'id','Score':'score','Text':'comment_text'}
    df.rename(columns=rename_dict,inplace=True)
    df['create_ts']=pd.to_datetime(df['create_ts'],format='%Y-%m-%dT%H:%M:%S.%f')
    staging_df=df[['id','post_id','score','comment_text','user_id','create_ts']]
    connection = duckdb.connect(os.fspath(duckdb_database_path))
    connection.execute("create schema if not exists so")
    connection.execute(
        "create or replace table so.comment_events as select * from staging_df"
    )
    context.add_output_metadata({"Rows Loaded ": staging_df.shape[0]})


@dbt_assets(manifest=dbt_manifest_path)
def so_comments_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()