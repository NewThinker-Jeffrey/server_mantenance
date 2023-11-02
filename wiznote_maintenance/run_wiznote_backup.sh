#!/usr/bin/env bash

# RUN THIS SCRIPT AS ROOT
if [ "$UID" != "0" ]; then
  echo "You should run $0 as root!"
  exit 1
fi

if ! [ -f ${MOUNT_REMOTE_SCRIPT} ]; then
  echo "${MOUNT_REMOTE_SCRIPT} doesn't exist!!"
  exit 1
fi

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

set -e

datestr=$(date "+%Y-%m-%d_%H-%M-%S_%N")
backup_name=wiznote_backup_${datestr}

cd $WIZNOTE_HOME
tar --same-owner -zcvf ${LOCAL_BACKUP_DIR}/${backup_name}.tar.gz  .

echo "Sending the backup data to remote ..."
${MOUNT_REMOTE_SCRIPT} && cp ${LOCAL_BACKUP_DIR}/${backup_name}.tar.gz ${REMOTE_BACKUP_DIR}/

