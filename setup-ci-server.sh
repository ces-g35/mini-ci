#!/bin/sh

set -e

cd mini-ci

pnpm i --frozen-lockfile

cp ci-server.service /etc/systemd/system
systemctl daemon-reload
systemctl --now enable ci-server.service
