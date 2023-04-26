#!/bin/sh

set -e

sudo systemctl disable -q --now ces-server.service

./pull.sh

./build.sh

sudo systemctl enable -q --now ces-server.service
