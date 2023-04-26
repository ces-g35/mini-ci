#!/bin/sh

set -e

systemctl disable -q --now ces-server.service

./mini-ci/pull.sh

./mini-ci/build.sh

systemctl enable -q --now ces-server.service
