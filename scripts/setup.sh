#!/bin/sh

set -e

sudo apt remove -y needrestart
sudo apt update -y && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo sh nodesource_setup.sh
sudo apt install -y nodejs apache2
sudo npm i -g pnpm

# name conflict
sudo rm -f /etc/apache2/mods-enabled/alias.conf
sudo sed -i '/DocumentRoot \/var\/www\/html/a\        FallbackResource \/index.html' /etc/apache2/sites-available/000-default.conf
sudo systemctl restart apache2

./setup-ces-server.sh

./setup-ci-server.sh

