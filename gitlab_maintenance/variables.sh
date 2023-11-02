#!/usr/bin/env bash

# It's recommended to add a sudo user 'gitlab' on your server and put
# everything related to gitlab into its HOME dir (we assumed it
# is '/home/gitlab') of the user 'gitlab'.
#
# The user 'gitlab' should also be added to 'docker' group, so that it
# can run docker commands without sudo and passwd. 

USER_HOME="/home/gitlab"
#USER_HOME=$HOME

THIS_DIR="$USER_HOME/gitlab_maintenance" # ln -s </path/to/gitlab_maintenance> $USER_HOME/gitlab_maintenance
GITLAB_HOME="$USER_HOME/gitlab_example"  # Where to save gitlab data.
CONTAINER_NAME="gitlab_example"
GITLAB_HOSTNAME="gitlab.example.com"  # url: ip or domain.
default_user_passwd="yaoyaolingxian"  # NOTE: It's NOT the inital passwd for root!

# your personal access token (login your self-hosted gitlab as root and generate it)
personal_access_token="glpat-Cas349sNCWAn2QfrvsZY"

# mount point of remote backup dir.
REMOTE_BACKUP_DIR="$USER_HOME/remote_gitlab_backups"

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

LOCAL_BACKUP_DIR="$USER_HOME/local_gitlab_backups"

GITLAB_DOCKER_IMAGE="gitlab/gitlab-ee:latest"
