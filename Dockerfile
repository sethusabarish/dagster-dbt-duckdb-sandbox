# Dagster libraries to run both dagster-webserver and the dagster-daemon. Does not
# need to have access to any pipeline code.

FROM python:3.10-slim
RUN apt update
RUN apt-get install -y python3-pip python3 python3-dev bash wget
RUN pip3 install --upgrade pip
RUN pip3 install 
RUN pip3 install dbt-core dbt-duckdb

RUN pip install \
    dagster \
    duckdb \
    dbt-duckdb \
    dbt-core \
    dagster-graphql \
    dagster-webserver \
    dagster-postgres \
    dagster-docker \
    dagster-dbt

# Uncomment this if duckdb isn't made available before
# RUN wget https://github.com/duckdb/duckdb/releases/download/v0.9.0/duckdb_cli-linux-amd64.zip
# Downalod and create xml file from this data set to consume the existing pipeline
# https://archive.org/download/stackexchange/stackoverflow.com-Comments.7z 


# Set $DAGSTER_HOME and copy dagster instance and workspace YAML there
ENV DAGSTER_HOME=/opt/dagster/dagster_home/

RUN mkdir -p $DAGSTER_HOME

#COPY dagster.yaml workspace.yaml $DAGSTER_HOME

WORKDIR $DAGSTER_HOME