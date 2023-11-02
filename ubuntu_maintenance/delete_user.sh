#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

if [ "$1" == "" ]; then
  echo "Usage: $0 <user_to_delete>"
  exit 1
fi

user_to_delete=$1
sudo deluser --remove-home ${user_to_delete}
