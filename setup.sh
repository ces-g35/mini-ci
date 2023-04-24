#!/bin/sh

cd $(dirname $0)

export REPOSITORY_BASE=$(basename $REPOSITORY_URL)

pushd ~

sudo apt update -y && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo sh nodesource_setup.sh
sudo apt install -y nodejs
sudo npm i -g pnpm
sudo apt install -y apache2

./pull.sh
pushd "$REPOSITORY_BASE"

sed "s/\(CLIENT_ID=\).*/\1${CLIENT_ID}; s/\(CLIENT_SECRET=\).*/\1${CLIENT_SECRET}; s/\(AWS_ACCESS_KEY_ID=\).*/\1${AWS_ACCESS_KEY_ID}; s/\(AWS_SECRET_ACCESS_KEY=\).*/\1${AWS_SECRET_ACCESS_KEY}; s/\(AWS_SESSION_TOKEN=\).*/\1${AWS_SESSION_TOKEN}"

./build.sh
popd

popd
sed "s/\[REPOSITORY_BASE\]/${REPOSITORY_BASE}/g" ces-server.service.template > ces-server.service
sudo cp ces-server.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl --now enable ces-server.service
