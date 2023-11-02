#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
wiznote_maintenance_dir=$(dirname $my_dir)
source $wiznote_maintenance_dir/variables.sh

echo "0 1 * * * $wiznote_maintenance_dir/run_wiznote_backup.sh" > $my_dir/backup.cron
sudo crontab $my_dir/backup.cron >> $my_dir/backup_log
