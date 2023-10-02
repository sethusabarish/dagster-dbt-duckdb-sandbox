#!/bin/bash
#Set of Commands to run into Jenkins build
#docker build .
# Create data folders for persisting db and output files if any
mkdir -p data/raw
mkdir -p data/duckdb
mkdir -p data/output/viz

PROJECT_NAME_PROD='dagster-dbt-duckdb-sandbox'

##################################################
### Edit to the directory where repo is cloned####
PROJECT_HOME='D:\\base\\repos\\'$PROJECT_NAME_PROD
##################################################


PROJECT_NAME_PROD_IMAGE=$PROJECT_NAME_PROD'_image:latest'


#To-do
#Enable consumption from config files

VOLUME_1_IN=$PROJECT_HOME'\\data'
VOLUME_1_OUT='/data'
VOLUME_2_IN=$PROJECT_HOME'\\src'
VOLUME_2_OUT='/src'
VOLUME_3_IN=$PROJECT_HOME'\\ref'
VOLUME_3_OUT='/ref'
VOLUME_4_IN=$PROJECT_HOME'\\apps'
VOLUME_4_OUT='/apps'

if (docker ps -a|grep $PROJECT_NAME_PROD)
then
echo 'Killing prod and bringing it back..'
docker stop $PROJECT_NAME_PROD
docker rm $PROJECT_NAME_PROD
docker image rm $PROJECT_NAME_PROD_IMAGE
fi

docker build -t  $PROJECT_NAME_PROD_IMAGE .

VOLUME_FWD="-v $VOLUME_1_IN:$VOLUME_1_OUT -v $VOLUME_2_IN:$VOLUME_2_OUT -v $VOLUME_3_IN:$VOLUME_3_OUT -v $VOLUME_4_IN:$VOLUME_4_OUT"

docker run $PORT_FWD $VOLUME_FWD -dit --name $PROJECT_NAME_PROD $PROJECT_NAME_PROD_IMAGE