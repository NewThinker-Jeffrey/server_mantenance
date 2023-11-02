#!/usr/bin/env bash

# RUN THIS SCRIPT AS ROOT
if [ "$UID" != "0" ]; then
  echo "You should run $0 as root!"
  exit 1
fi


my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/../variables.sh
source $my_dir/backupfile.sh

backup_name=$1
if [ "$backup_name" == "" ]; then
    echo "Please input the name to your backup."
    exit 1
fi

set -e

echo "Copying back the backup data from remote ..."
cp ${REMOTE_BACKUP_DIR}/${backup_name}.tar.gz ${LOCAL_BACKUP_DIR}/

echo "Restoring the backup ..."
mkdir -p $JENKINS_HOME
cd $JENKINS_HOME
tar --same-owner -zxvf ${LOCAL_BACKUP_DIR}/${backup_name}.tar.gz

rm ${LOCAL_BACKUP_DIR}/${backup_name}.tar.gz
