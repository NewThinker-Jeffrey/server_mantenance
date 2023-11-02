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


# Stop the processes that are connected to the database. Leave the rest of GitLab running:
#docker exec ${CONTAINER_NAME} gitlab-ctl stop unicorn
docker exec ${CONTAINER_NAME} gitlab-ctl stop puma
docker exec ${CONTAINER_NAME} gitlab-ctl stop sidekiq
# docker exec ${CONTAINER_NAME} gitlab-ctl stop  # Can't stop all?

datestr=$(date "+%Y-%m-%d_%H-%M-%S_%N")

echo "Making backup file ..."
#docker exec -t ${CONTAINER_NAME} gitlab-backup create STRATEGY=copy SKIP=artifacts
docker exec -t ${CONTAINER_NAME} gitlab-backup create SKIP=artifacts
backup_res=$?

docker exec ${CONTAINER_NAME} gitlab-ctl start

if [ "$backup_res" -eq "0" ]; then
  echo "backup file generated."
else
  echo "Fail to make backup!!"
  exit 1
fi

backup_name=gitlab_backup_${datestr}
backup_dir=$LOCAL_BACKUP_DIR/$backup_name
mkdir -p $backup_dir

cd ${GITLAB_HOME}/data/backups  # need root

# find .tar files created in the latest 0.5 day (12 hours)
find . -name '*.tar' -ctime -0.5 -exec mv {}  $backup_dir/ \;

# The gitlab-backup command above may warn us:
#   Warning: Your gitlab.rb and gitlab-secrets.json files contain sensitive data 
#            and are not included in this backup. You will need these files to restore a backup.
#            Please back them up manually.
# So backup the two files manually.
cp ${GITLAB_HOME}/config/gitlab.rb ${backup_dir}/
cp ${GITLAB_HOME}/config/gitlab-secrets.json ${backup_dir}/  # secrets file

cd $LOCAL_BACKUP_DIR
zip -r $backup_name.zip $backup_name/
rm -r $backup_name

echo "Sending the backup file to remote ..."
${MOUNT_REMOTE_SCRIPT} && cp  $backup_name.zip ${REMOTE_BACKUP_DIR}/
copy_res=$?
if [ "$copy_res" -eq "0" ]; then
  echo "Backup file has been sent to remote."
  rm $backup_name.zip
else
  echo "Fail to store backup file!!"
  exit 1
fi

