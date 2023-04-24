#!/bin/sh

if [ $# -lt 1 ]
then
    echo "usage: $0 <key>=<value> [<key>=<value>]..."
    exit 1
fi

command=""
while [ $# -ge 1 ]
do
    key=$(echo $1 | awk -F= '{print $1}')
    value=$(echo $1 | awk -F= '{print $2}')
    shift
    command="${command}; s#${key}=.*#${key}=${value}#"
done

sed -i "$command" .env