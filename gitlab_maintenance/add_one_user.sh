#!/usr/bin/env bash

if [ "$3" == "" ]; then
  echo "Usage: "
  echo "  $0  <email>  <username>  <name>"
  echo "Example:"
  echo "  $0 zhangsan@example.com  zhangsan  张三"
  exit 1
fi


my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh


password=${default_user_passwd}
email=$1
username=$2
name=$3

echo ""
echo "password: ${password}"
echo "email: $email"
echo "username: $username"
echo "name: $name"
echo ""
# send post request. change the token and url 
curl -X POST -H "PRIVATE-TOKEN: ${personal_access_token}"  "${GITLAB_HOSTNAME}/api/v4/users" -H 'cache-control: no-cache' -H 'content-type: application/json' \
-d '{ "email": "'"$email"'", "username": "'"$username"'", "password": "'"$password"'", "name": "'"$name"'", "skip_confirmation": "true" }'
echo ""
echo ""

