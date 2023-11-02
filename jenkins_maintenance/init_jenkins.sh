#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}

mkdir -p $JENKINS_HOME

docker run --detach \
  --publish 8080:8080 --publish 50000:50000 \
  --name ${CONTAINER_NAME} \
  --user ${UID} \
  --restart always \
  --volume $JENKINS_HOME:/var/jenkins_home \
  $JENKINS_DOCKER_IMAGE


