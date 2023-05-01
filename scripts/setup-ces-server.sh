#!/bin/sh

set -e

./pull.sh

cd "$REPOSITORY_BASE"

sed \
-e "s/\\(CLIENT_ID=\\).*/\\1${CLIENT_ID}/1;" \
-e "s/\\(CLIENT_SECRET=\\).*/\\1${CLIENT_SECRET}/1;" \
-e "s#\\(AWS_REGION=\\).*#\\1${URL}#1;" \
-e "s/\\(AWS_ACCESS_KEY_ID=\\).*/\\1${AWS_ACCESS_KEY_ID}/1;" \
-e "s#\\(AWS_SESSION_TOKEN=\\).*#\\1${AWS_SESSION_TOKEN}#1;" \
-e "s#\\(AWS_SECRET_ACCESS_KEY=\\).*#\\1${AWS_SECRET_ACCESS_KEY}#1;" \
-e "s#\\(URL=\\).*#\\1${URL}#1;" \
-e "s#\\(JWT_SECRET=\\).*#\\1${JWT_SECRET}#1;" \
.env.template > .env

cd ..

./build.sh
