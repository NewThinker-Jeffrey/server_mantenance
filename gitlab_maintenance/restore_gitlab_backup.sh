#!/usr/bin/env bash

# RUN THIS SCRIPT AS ROOT
if [ "$UID" != "0" ]; then
  echo "You should run $0 as root!"
  exit 1
fi


# https://docs.gitlab.com/ee/administration/backup_restore/restore_gitlab.html#restore-for-linux-package-installations

tar_file_suffix="_gitlab_backup.tar"
if [ "$3" == "" ]; then
    echo "Usage: $0 <backup_tar_file_prefix> <gitlab.rb> <gitlab-secrets.json>"
    echo "For example, if your tar file is /path/to/1698218202_2023_10_25_16.5.0-ee_gitlab_backup.tar,"
    echo "then the first argument should be /path/to/1698218202_2023_10_25_16.5.0-ee."
    exit 1
fi

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

backup_file_tar_prefix=$1
backup_file_tar="${backup_file_tar_prefix}${tar_file_suffix}"
gitlab_rb=$2
gitlab_secrets=$3

mkdir -p ${GITLAB_HOME}/data/backups
mkdir -p ${GITLAB_HOME}/config

#set -e

# Stop the processes that are connected to the database. Leave the rest of GitLab running:
# docker exec ${CONTAINER_NAME} gitlab-ctl stop unicorn
docker exec ${CONTAINER_NAME} gitlab-ctl stop puma
docker exec ${CONTAINER_NAME} gitlab-ctl stop sidekiq
# Verify
docker exec ${CONTAINER_NAME} gitlab-ctl status

cp $backup_file_tar ${GITLAB_HOME}/data/backups/
docker exec ${CONTAINER_NAME} chown git:git /var/opt/gitlab/backups/$(basename $backup_file_tar)

cp $gitlab_rb ${GITLAB_HOME}/config/
cp $gitlab_secrets ${GITLAB_HOME}/config/

ls ${GITLAB_HOME}/data/backups/
ls ${GITLAB_HOME}/config/


# ensure you have completed the restore prerequisites steps (https://docs.gitlab.com/ee/administration/backup_restore/restore_gitlab.html#restore-prerequisites)
# and have run `gitlab-ctl reconfigure` after copying over the GitLab secrets file from the original installation.

docker exec ${CONTAINER_NAME} gitlab-ctl reconfigure


# This command will overwrite the contents of your GitLab database!
# NOTE: "_gitlab_backup.tar" is omitted from the name (we only need the prefix)
# 
# NOTE: This command is interactive, so we need '-it'
docker exec -it ${CONTAINER_NAME} gitlab-rake gitlab:backup:restore BACKUP=/var/opt/gitlab/backups/$(basename $backup_file_tar_prefix)

# Trouble-shooting:
# The error below migth occur:
#   Restoring PostgreSQL database gitlabhq_production ... ERROR:  must be owner of extension pg_trgm
#   ERROR:  must be owner of extension btree_gist
#   ERROR:  must be owner of extension btree_gist
#   ERROR:  must be owner of extension pg_trgm
# To fix it, see restore_gitlab_backup.trouble-shooting.md  

docker exec ${CONTAINER_NAME} gitlab-ctl start

