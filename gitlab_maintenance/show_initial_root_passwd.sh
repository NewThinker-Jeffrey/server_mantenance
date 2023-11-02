#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh


echo ""
docker exec -it ${CONTAINER_NAME} grep 'Password:' /etc/gitlab/initial_root_password

if [ "$?" -eq "0" ]; then
  echo ""
  echo "Visit the GitLab URL, and sign in with the username 'root' and the password above"
  echo ""
else
  echo ""
  echo "initial_root_passwd has been lost!!"
  echo "If you've forgotten the root passwd, you might need to run ./reset_root_passwd.sh."
  echo ""
fi

