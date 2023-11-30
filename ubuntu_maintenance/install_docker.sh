#!/usr/bin/env bash
my_dir=$(cd $(dirname $0) && pwd)
source $my_dir/variables.sh

ARCH=$1  # amd64(default) or arm64
if [ "$ARCH" == "" ]; then
  ARCH=amd64
fi

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=$ARCH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

