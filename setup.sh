#!/bin/sh

set -e

cd $(dirname $0)

cd ~

apt remove -y needrestart
apt update -y && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sh nodesource_setup.sh
apt install -y nodejs apache2
npm i -g pnpm

# name conflict
rm -f /etc/apache/mod-enabled/alias.conf
systemctl restart apache2

./mini-ci/pull.sh
cd "$REPOSITORY_BASE"

sed \
-e "s/\\(CLIENT_ID=\\).*/\\1${CLIENT_ID}/1;" \
-e "s/\\(CLIENT_SECRET=\\).*/\\1${CLIENT_SECRET}/1;" \
-e "s/\\(AWS_ACCESS_KEY_ID=\\).*/\\1${AWS_ACCESS_KEY_ID}/1;" \
-e "s#\\(AWS_SESSION_TOKEN=\\).*#\\1${AWS_SESSION_TOKEN}#1;" \
-e "s#\\(AWS_SECRET_ACCESS_KEY=\\).*#\\1${AWS_SECRET_ACCESS_KEY}#1;" \
-e "s#\\(URL=\\).*#\\1${URL}#1;" \
.env.template > .env

cd ..
chmod +x mini-ci/build.sh
./mini-ci/build.sh

cd mini-ci

sed \
-e "s#\\(REPOSITORY_URL=\\).*#\\1${REPOSITORY_URL}#1;" \
-e "s#\\(REPOSITORY_BASE=\\).*#\\1${REPOSITORY_BASE}#1;" \
.env.template > .env

sed "s/\\[REPOSITORY_BASE\\]/${REPOSITORY_BASE}/g" ces-server.service.template > ces-server.service
cp ces-server.service /etc/systemd/system
systemctl daemon-reload
systemctl --now enable ces-server.service
