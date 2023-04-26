#!/bin/sh

set -e

apt remove -y needrestart
apt update -y && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sh nodesource_setup.sh
apt install -y nodejs apache2
npm i -g pnpm

# name conflict
rm -f /etc/apache2/mods-enabled/alias.conf
sed -i '/DocumentRoot \/var\/www\/html/a\        FallbackResource \/index.html' /etc/apache2/sites-available/000-default.conf
systemctl restart apache2

./setup-ces-server.sh

./setup-ci-server.sh

