#!/usr/bin/env bash

my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh



echo ""
echo "Initial password for the user 'admin':"
echo ""
cat $JENKINS_HOME/secrets/initialAdminPassword
echo ""
