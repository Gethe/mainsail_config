#!/bin/bash

PKGLIST="python3-numpy python3-matplotlib jq curl"

# shellcheck source=utilities.sh
source ~/mainsail_config/scripts/utilities.sh
# shellcheck source=klippy_extras.sh
source ~/mainsail_config/scripts/klippy_extras.sh

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
