#!/bin/sh

set -e

if [ $# -ne 1 ]; then
    fatal "No repository provided"
fi

if [ -d "$REPOSITORY_BASE" ]; then
    cd "$REPOSITORY_BASE"
    pnpm build
else
    fatal "repository has not been pull yet"
fi
