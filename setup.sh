#!/bin/sh

cd $(dirname $0)

cd ~

sudo apt update -y && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo sh nodesource_setup.sh
sudo apt install -y nodejs apache2
sudo npm i -g pnpm

./mini-ci/pull.sh
cd "$REPOSITORY_BASE"

sed \
-e "s/\\(CLIENT_ID=\\).*/\\1${CLIENT_ID}/1;" \
-e "s/\\(CLIENT_SECRET=\\).*/\\1${CLIENT_SECRET}/1;" \
-e "s/\\(AWS_ACCESS_KEY_ID=\\).*/\\1${AWS_ACCESS_KEY_ID}/1;" \
-e "s#\\(AWS_SESSION_TOKEN=\\).*#\\1${AWS_SESSION_TOKEN}#1;" \
-e "s#\\(AWS_SECRET_ACCESS_KEY=\\).*#\\1${AWS_SECRET_ACCESS_KEY}#1;" \
.env.template

cd ..
./mini-ci/build.sh

cd mini-ci

sed "s/\\[REPOSITORY_BASE\\]/${REPOSITORY_BASE}/g" ces-server.service.template > ces-server.service
sudo cp ces-server.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl --now enable ces-server.service
