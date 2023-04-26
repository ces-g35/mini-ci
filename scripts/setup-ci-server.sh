#!/bin/sh

set -e

cd mini-ci

sed \
-e "s#\\(REPOSITORY_URL=\\).*#\\1${REPOSITORY_URL}#1;" \
-e "s#\\(REPOSITORY_BASE=\\).*#\\1${REPOSITORY_BASE}#1;" \
.env.template > .env

pnpm i --frozen-lockfile

sed "s/\\[REPOSITORY_BASE\\]/${REPOSITORY_BASE}/g" ces-server.service.template > ces-server.service
cp ces-server.service /etc/systemd/system
cp ci-server.service /etc/systemd/system
systemctl daemon-reload
systemctl --now enable ces-server.service
systemctl --now enable ci-server.service

