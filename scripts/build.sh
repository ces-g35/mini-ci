#!/bin/sh

set -e

fatal() {
    echo "fatal: $1"
    exit 1
}

if [ -d "$REPOSITORY_BASE" ]; then
    cd "$REPOSITORY_BASE"
    pnpm i --frozen-lockfile
    pnpm build

    sudo cp -r dist/* /var/www/html
else
    fatal "repository has not been pull yet"
fi
