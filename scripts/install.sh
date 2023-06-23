#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PKGLIST="python3-numpy python3-matplotlib jq curl"

source "$SCRIPT_DIR"/utilities.sh
source "$SCRIPT_DIR"/klippy_extras.sh

# Force script to exit if an error occurs
set -xe

verify_ready
clean_install

install_hooks
install_printer_config
install_udev_rules
install_dependencies

install_theme
install_linear_movement

install_kiauh
install_ratos_homing

ensure_moonraker_policiykit_rules
