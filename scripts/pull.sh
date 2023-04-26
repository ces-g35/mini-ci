#!/bin/sh

set -e

if ! git --version > /dev/null 2>&1; then
    echo 'git is not found in current system'

    exit 1
fi

git_executable=$(which git)

if [ -d "$REPOSITORY_BASE" ]; then
    cd "$REPOSITORY_BASE"
    "$git_executable" remote set-url origin "$REPOSITORY_URL"
    "$git_executable" fetch -f
    "$git_executable" checkout -f origin/main
    "$git_executable" branch -f -d main
    "$git_executable" checkout -f -b main
else
    "$git_executable" clone "$REPOSITORY_URL"
fi
