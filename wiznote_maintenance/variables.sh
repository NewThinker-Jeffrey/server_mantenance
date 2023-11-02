#!/usr/bin/env bash

# It's recommended to add a sudo user 'wiznote' on your server and put
# everything related to wiznote into its HOME dir (we assumed it
# is '/home/wiznote') of the user 'wiznote'.
#
# The user 'wiznote' should also be added to 'docker' group, so that it
# can run docker commands without sudo and passwd. 

USER_HOME="/home/wiznote"
#USER_HOME=$HOME

THIS_DIR="$USER_HOME/wiznote_maintenance" # ln -s </path/to/wiznote_maintenance> $USER_HOME/wiznote_maintenance
WIZNOTE_HOME="$USER_HOME/wiznote_example"  # Where to save wiznote data.
CONTAINER_NAME="wiznote_example"

# mount point of remote backup dir.
REMOTE_BACKUP_DIR="$USER_HOME/remote_wiznote_backups"

# First edit your own 'mount_remote.sh'.
#
# If your don't need remote backuping, you can simply use 'mount_remote.sh.dummy':
#     - $ cp mount_remote.sh.dummy mount_remote.sh
#     - $ chmod +x mount_remote.sh
#
# Otherwise, you can modify you own 'mount_remote.sh' from 'mount_remote.sh.example':
#     $ cp mount_remote.sh.example mount_remote.sh
#     $ chomd +x mount_remote.sh
#     $ vim mount_remote.sh     # modify the script to mount your own remote folder
MOUNT_REMOTE_SCRIPT="$THIS_DIR/mount_remote.sh"

LOCAL_BACKUP_DIR="$USER_HOME/local_wiznote_backups"


WIZNOTE_DOCKER_IMAGE="wiznote/wizserver:latest"
