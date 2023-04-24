#!/bin/sh

set -e

cd mini-ci

pnpm i --frozen-lockfile
pnpm start

cp ci-server.service /etc/systemd/system
systemctl daemon-reload
systemctl --now enable ci-server.service
