#!/usr/bin/env bash

# RUN THIS SCRIPT AS ROOT
if [ "$UID" != "0" ]; then
  echo "You should run $0 as root!"
  exit 1
fi


my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/../variables.sh
source $my_dir/backupfile.sh

mkdir -p ${LOCAL_BACKUP_DIR}
set -e

echo "Copying back the backup docker image from remote ..."
cp ${REMOTE_BACKUP_DIR}/${BACKUP_FILE} ${LOCAL_BACKUP_DIR}/

echo "Loading the docker file ..."
docker load -i ${LOCAL_BACKUP_DIR}/${BACKUP_FILE}

rm ${LOCAL_BACKUP_DIR}/${BACKUP_FILE}
