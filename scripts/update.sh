#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR"/utilities.sh

# Force script to exit if an error occurs
set -xe

install_hooks
clean_install
