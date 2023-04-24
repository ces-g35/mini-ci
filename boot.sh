#!/bin/sh

set -e

git_executable=$(which git)

"$git_executable" clone https://www.github.com/ces-g35/mini-ci

cd mini-ci && ./setup.sh