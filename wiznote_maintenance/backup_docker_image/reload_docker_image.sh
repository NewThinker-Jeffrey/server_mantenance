#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/../variables.sh
source $my_dir/backupfile.sh

set -e

echo "Copying back the backup docker image from remote ..."
cp ${REMOTE_BACKUP_DIR}/${BACKUP_FILE} ${LOCAL_BACKUP_DIR}/

echo "Loading the docker file ..."
docker load -i ${LOCAL_BACKUP_DIR}/${BACKUP_FILE}

rm ${LOCAL_BACKUP_DIR}/${BACKUP_FILE}
