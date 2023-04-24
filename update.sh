#!/bin/sh

set -e

systemctl disable -q --now ces-server.service

./pull.sh

./build.sh

systemctl enable -q --now ces-server.service
