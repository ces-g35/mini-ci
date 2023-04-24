# Env
REPOSITORY_URL
repository url
example: https://github.com/ces-g35/cvinder

CLIENT_ID
self explanatory

CLIENT_SECRET
self explanatory

AWS_ACCESS_KEY_ID
self explanatory

AWS_SECRET_ACCESS_KEY
self explanatory

AWS_SESSION_TOKEN
self explanatory

URL
url of the remote server (don't include the port)
example: 18.204.219.62

# Setup script
```sh
ssh -i <ssh-key> <user>@$URL -t "curl -sSfL https://raw.githubusercontent.com/ces-g35/mini-ci/main/boot.sh | REPOSITORY_URL=${REPOSITORY_URL} CLIENT_ID=${CLIENT_ID} CLIENT_SECRET=${CLIENT_SECRET} AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} URL=${URL}:3000 sh -"
```

# Exposed port
## 3000
backend server port
## 5000
webhook port

# Note
Other than running this script user need to
- Allocate elastic ip
- enable exposed port
- Add webhook to github

# Project requirement
- have build script that with create root of the server at **dist** (Once you run dist, there should be dist/index.html, dist/public/background.png, etc.)
- use pnpm as package manager