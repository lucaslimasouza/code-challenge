#!/bin/sh
set -e  # Exit immediately if a command exits with non-zero status
set -u  # Treat unset variables as an error
set -C  # Prevent existing files from being overwritten with >


# you need to place a call to `run_args "$@"` 
#   at the end of your script
# you also need to create a default_action()
#   function on your script
run_args() { 
  is_fn_defined default_action \
    || error "Undefined function: default_action() Your script requires a default_action() function to handle execution when no arguments are provided.
  To fix this, define a default_action() function in your script.
  Example:
  default_action() {
      echo 'This is the default action'
  }"

  [ $# -eq 0 ] && {
      echo "No arguments provided - running default_action()"
      default_action
  } || {
      echo "Executing the following command(s): $@"
      "$@"
  }
}


create_missing_config_files_from_sample() {
    echo "Creating missing config files from the samples (files suffixed with .sample)..."
    echo "   Copies .sample config files to their non-sample versions"
    echo "   Only creates files that don't already exist"
    echo "   Only look for files on current folder"
    echo "   Preserves original sample files"

    # Use set -e to make the subshell exit immediately on error
    find . -maxdepth 1 -name "*.sample" -type f -exec sh -c '
        set -e
        for sample_file do
            new_name="${sample_file%.sample}"
            if [ ! -e "$new_name" ]; then
                if cp "$sample_file" "$new_name"; then
                    echo "Created $new_name from sample"
                else
                    echo "ERROR: Failed to create $new_name from $sample_file" >&2
                    exit 1
                fi
            else
              echo "$new_name already exists. Skipping..."
            fi
        done
    ' sh {} \;
    
    echo "Capturing the exit status of find..."
    find_status=$?
    [ $find_status -eq 0 ] \
        && echo "All sample files that need to be copied, were copied succesfully" \
        || error "Failed to create one or more config files"
    
    return 0
}

try_copy_to_child_project() {
    local child_folder="$1"; shift
    local source="$1"; shift

    echo "Copying '${source}' to child project '${child_folder}'..."

    [ ! -e "$source" ] \
      && error "Source '$source' does not exist."

    if [ ! -d "$child_folder" ]; then
        echo "child project ${child_folder} does not exist"
        echo_detail "maybe you are running this on the docker container of another child project"
        echo_detail "skipping ${child_folder}/${source} ..."
        return 0
    fi

    echo_detail "child project ${child_folder} exists. Copying ${source} ..."
    if [ -d "$source" ]; then
        echo_detail "Is a directory. Using recursive copy..."
        cp -rf "./${source}" "${child_folder}/"
    else
        echo_detail "It's not a directory. Using normal copy..."
        cp -f "./${source}" "${child_folder}/${source}"
    fi
}

docker_compose() {
    if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        docker compose "$@"
    elif command -v docker-compose >/dev/null 2>&1; then
        docker-compose "$@"
    else
        echo "Error: Neither 'docker compose' nor 'docker-compose' command found." >&2
        return 1
    fi
}

kill_port() {
    for port in "$@"; do
        echo "Killing process on PORT ${port}..."
        
        if ! is_fn_defined lsof; then
            error "lsof command not found. Please install lsof."
        fi
        
        pid=$(lsof -t -i ":$port" 2>/dev/null) || true
        
        if [ -n "$pid" ]; then
            echo_detail "Killing process with pid ${pid}..."
            kill -9 "$pid" 2>/dev/null || echo "Error killing process: $?" >&2
            return 0
        fi

        if ! is_fn_defined docker; then
            echo_detail "Docker is not installed. Not checking for containers on port ${port}"
        else
            container_id=$(docker ps -q --filter "publish=$port" 2>/dev/null) || true
            if [ -n "$container_id" ]; then
                echo_detail "Stopping Docker container ${container_id} using port ${port}..."
                docker stop "$container_id" >/dev/null 2>&1 || error "stopping container: $?"
                return 0
            fi
        fi

        echo_detail "No process or Docker container found using PORT ${port}. Skipping..."
    done
}

is_fn_defined() {
  local fn_name="$1"; shift
  type "$fn_name" >/dev/null 2>&1 
}

docker_compose() {
    if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        docker compose "$@"
    elif command -v docker-compose >/dev/null 2>&1; then
        docker-compose "$@"
    else
        error "Neither 'docker compose' nor 'docker-compose' command found."
    fi
}

echo_detail() {
    # Try using tput (more portable) for dim text
    if is_fn_defined tput; then
        tput dim
        echo "   $*"
        tput sgr0
    else
        # Fallback to ANSI if tput is unavailable
        printf '\033[2m%s\033[0m\n' "   $*"
    fi
}

error() {
  local msg="$1"; shift
  echo -e "\033[1;31m\033[1mERROR:\033[0m\033[31m $msg\033[0m" >&2
  exit 1
}

