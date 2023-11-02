#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

cat /etc/passwd | cut -d: -f1