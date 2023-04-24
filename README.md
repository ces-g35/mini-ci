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

# Setup script
```sh
ssh -i <ssh-key> <user>@<ip> -o 'SendEnv REPOSITORY_URL CLIENT_ID CLIENT_SECRET AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN' -t 'curl -sSfL https://raw.githubusercontent.com/ces-g35/mini-ci/main/boot.sh | sh -'
```

# Exposed port
