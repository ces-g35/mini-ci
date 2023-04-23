set -e

fatal() {
    echo "fatal: $1"
    echo ''
    show_usage
    exit 1
}

show_usage() {
    echo "usage: $0 <repo>"
    echo "example: $0 https://github.com/ces-g35/cvinder"
}

if [ $# -ne 1 ]; then
    fatal "No repository provided"
fi

repository=$1
repository_base_name=`basename $1`

if [ -d "$repository_base_name" ]; then
    cd "$repository_base_name"
    wd=$(pwd)
else
    fatal "repository has not been pull yet"
fi

