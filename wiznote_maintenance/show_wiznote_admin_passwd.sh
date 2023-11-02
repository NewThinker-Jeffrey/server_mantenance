#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

# Default administrator account: admin@wiz.cn password:123456
# See https://www.wiz.cn/zh-cn/docker

echo ""
echo "Initial password for the user 'admin@wiz.cn':"
echo ""
echo "123456"
echo ""
