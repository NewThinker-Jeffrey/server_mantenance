#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/../variables.sh
source $my_dir/backupfile.sh

set -e

docker save -o ${LOCAL_BACKUP_DIR}/${BACKUP_FILE} ${WIZNOTE_DOCKER_IMAGE}

echo "Sending the backup docker image to remote ..."
${MOUNT_REMOTE_SCRIPT} && cp ${LOCAL_BACKUP_DIR}/${BACKUP_FILE} ${REMOTE_BACKUP_DIR}/
