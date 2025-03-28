#!/bin/sh

# points to script dir
DIR="$(dirname "$0")"

# ! REQUIRED !
# Source/Load the Megaman library
. ${DIR}/megaman.sh


# REQUIRED!
# Default action when no arguments are provided
default_action() {
    error "Usage: bla bla bla"
}

process_fruits() {
    process_item 'apple' 'banana' 'kiwi'
}

process_item() {
  for port in "$@"; do
    echo "Processing item: $1"
  done
}

kp() {
 kill_port "$@" 
}

# ! REQUIRED !
# run the functions passed as arguments
run_args "$@"
