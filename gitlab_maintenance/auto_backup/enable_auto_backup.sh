#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
gitlab_maintenance_dir=$(dirname $my_dir)
source $gitlab_maintenance_dir/variables.sh

echo "0 1 * * * $gitlab_maintenance_dir/run_gitlab_backup.sh" > $my_dir/backup.cron
sudo crontab $my_dir/backup.cron >> $my_dir/backup_log
