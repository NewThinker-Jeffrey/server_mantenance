#!/usr/bin/env bash


my_dir=$(cd $(dirname $0) && pwd)

userinfo="$my_dir/userinfo.txt"

echo "***************"
while read -r line
do
    # strip the line
    l=`echo $line | awk '{gsub(/^\s+|\s+$/, "");print}'`
    echo $l

    # split the line and read entries
    email=`echo $l | awk '{print $1}'`
    username=`echo $l | awk '{print $2}'`
    name=`echo $l | awk '{print $3}'`
    if [ "$email" != "" ]; then
        $my_dir/add_one_user.sh $email $username $name
        echo "***************"
    fi
done < $userinfo

