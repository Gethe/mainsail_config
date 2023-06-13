#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR"/utilities.sh
source "$SCRIPT_DIR"/install.sh

# Force script to exit if an error occurs
set -xe

rm /home/pi/printer_data/config/main.cfg
install_printer_config
install_theme
install_linear_movement
