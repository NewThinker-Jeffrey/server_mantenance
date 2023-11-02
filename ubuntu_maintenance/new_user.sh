#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

if [ "$1" == "" ]; then
  echo "Usage: $0 <new_user_name>"
  exit 1
fi

default_passwd="$user_initial_passwd"

NEW_USER=$1
sudo useradd -d "$user_home_root/${NEW_USER}" -m -s "/bin/bash" ${NEW_USER}
echo "${NEW_USER}:${default_passwd}" | sudo chpasswd


# Allow ${NEW_USER} to use docker
sudo usermod -aG docker ${NEW_USER}

# # Allow sudo
# sudo echo "${NEW_USER}	ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/${NEW_USER}
# # Or
# sudo usermod -aG sudo ${NEW_USER}


