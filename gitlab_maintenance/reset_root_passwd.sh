#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

docker exec -it ${CONTAINER_NAME} gitlab-rake "gitlab:password:reset[root]"

