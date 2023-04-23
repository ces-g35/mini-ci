set -e

if ! git --version > /dev/null 2>&1; then
    echo 'git is not found in current system'

    exit 1
fi

git_executable=`which git`

fatal() {
    echo "fatal: $1"
    echo ''
    show_usage
    exit 1
}

show_usage() {
    echo 'usage: ./pull.sh <repo>'
    echo 'example: ./pull.sh https://github.com/ces-g35/cvinder'
}

if [ $# -ne 1 ]; then
    fatal "No repository provided"
fi

repository=$1
repository_base_name=`basename $1`


if [ -d "$repository_base_name" ]; then
    "$git_executable" remote set-url origin "$repository"
    "$git_executable" fetch -f
    "$git_executable" checkout -f origin/main
    "$git_executable" branch -f -d main
    "$git_executable" checkout -f -b main
else
    "$git_executable" clone "$repository"
fi

