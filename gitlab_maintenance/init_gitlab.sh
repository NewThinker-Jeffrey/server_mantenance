#!/usr/bin/env bash


my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}

mkdir -p $GITLAB_HOME/config
mkdir -p $GITLAB_HOME/logs
mkdir -p $GITLAB_HOME/data

docker run --detach \
  --hostname $GITLAB_HOSTNAME  \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name ${CONTAINER_NAME} \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  $GITLAB_DOCKER_IMAGE 

