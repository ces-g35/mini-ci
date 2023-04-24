#!/bin/sh

set -e

sudo -sE

export REPOSITORY_URL CLIENT_ID CLIENT_SECRET AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

export REPOSITORY_BASE=$(basename $REPOSITORY_URL)

git_executable=$(which git)

"$git_executable" clone https://www.github.com/ces-g35/mini-ci

cd mini-ci
chmod +x setup.sh
./setup.sh
