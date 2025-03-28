#!/bin/sh

DIR="$(dirname "$0")"
. "$DIR/submodules/megaman/megaman.sh"

default_action() { 
  dev 
}

setup() {
  echo "Navigating to root directory..."
  cd $DIR

  echo "Loading environment variables..."
  . ./.env

  export UID=${UID:-$(id -u)}
  export GID=${GID:-$(id -g)}
}

dev() {
  docker_compose down
  kill_port $PORT $PORT

  docker_compose build

  rails db:migrate
  rails db:reset
  docker_compose up
}

test() {
  rails test
}

rails() {
  docker_compose run app rails $@
}

docker_shell() {
  docker_compose run app bash
}
 

setup
run_args "$@"

