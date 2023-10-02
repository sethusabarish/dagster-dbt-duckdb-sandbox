#!/bin/bash
#Set of Commands to run into Jenkins build
#docker build .
#non editable
PROJECT_NAME_PROD='__PROJECT__'
PROJECT_HOME='D:\\base\\repos'

PROJECT_NAME_PROD_IMAGE=$PROJECT_NAME_PROD'_image:latest'
INPUT_PATH=$PROJECT_HOME'\\'$PROJECT_NAME_PROD

#editable
#PORT_FWD='-p 8888:8888'

# FOLDER_1='notebooks'
# VOLUME_1_IN=$INPUT_PATH"/$FOLDER_1"
# VOLUME_1_OUT="/scripts/$FOLDER_1"

# FOLDER_2='offline_scala'
# VOLUME_2_IN=$INPUT_PATH"/$FOLDER_2"
# VOLUME_2_OUT="/scripts/$FOLDER_2"

# VOLUME_FWD="-v $VOLUME_1_IN:$VOLUME_1_OUT -v $VOLUME_2_IN:$VOLUME_2_OUT"

if (docker ps -a|grep $PROJECT_NAME_PROD)
then
echo 'Killing prod and bringing it back..'
docker stop $PROJECT_NAME_PROD
docker rm $PROJECT_NAME_PROD
docker image rm $PROJECT_NAME_PROD_IMAGE
fi

docker build -t  $PROJECT_NAME_PROD_IMAGE .
docker run $PORT_FWD $VOLUME_FWD -dit --name $PROJECT_NAME_PROD $PROJECT_NAME_PROD_IMAGE