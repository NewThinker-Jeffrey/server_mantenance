#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}

mkdir -p $WIZNOTE_HOME

# See https://www.wiz.cn/zh-cn/docker

docker run --detach \
  --publish 80:80 --publish 9269:9269/udp \
  --name ${CONTAINER_NAME} \
  --restart always \
  --volume /etc/localtime:/etc/localtime \
  --volume $WIZNOTE_HOME:/wiz/storage \
  $WIZNOTE_DOCKER_IMAGE
