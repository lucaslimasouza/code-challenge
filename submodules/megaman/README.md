# Megaman Shell Library

## Overview

Megaman is a lightweight POSIX-compliant shell library optimized for DASH,
offering performance benefits and macOS compatibility.

It helps you build structured scripts where you can define and call your functions with ease.
It allows you to organize your code in a modular and maintainable way, where any function can be defined and called from any other function.
This flexibility is particularly useful for creating run.sh files to manage and run various projects efficiently.

## Why Megaman?
I chose the name "Megaman" because it reflects the project's focus on the Dash shell, which is known for its speed and efficiency.
This mirrors the iconic dash mechanic introduced in Mega Man X1, allowing quick movement through levels. 

## To add it as a Git Submodule
```
git submodule add --depth 1 https://github.com/CoinBR/megaman submodules/megaman && git submodule update --init --recursive
```

## Example Script w/ Instructions

```sh
!/bin/sh

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

# ! REQUIRED !
# run the functions passed as arguments
run_args "$@"
```

## Usage Examples

### 1: Run without arguments
```
./example.sh
```
Output:
```
ERROR: bla bla bla
```
---
### 2: A function that calls a function defined after it
```
./example.sh process_fruits
```
Output:
```
Processing item: apple
Processing item: banana
Processing item: kiwi
```
---
### 3: Call a function with a single arg
```
./example.sh process_item ae86
```
Output:
```
Processing item: ae86
```
---
### 4: Call a multiargifyed function with multiple args
```
./example.sh process_item ae86 gt86
```
Output:
```
Processing item: ae86
Processing item: gt86
```

