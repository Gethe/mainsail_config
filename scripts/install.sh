#!/bin/bash

SYSTEMDDIR="/etc/systemd/system"
PKGLIST="python3-numpy python3-matplotlib jq curl"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/utilities.sh
source $SCRIPT_DIR/klippy_extras.sh

install_printer_config() {
    report_status "Copying printer configuration"

    ln -sf /home/pi/mainsail_config/templates/initial-printer.template.cfg /home/pi/printer_data/config/main.cfg
    echo "[include main.cfg]" >/home/pi/printer_data/config/printer.cfg

    ln -sf /home/pi/mainsail_config/templates/moonraker.template.conf /home/pi/printer_data/config/moonraker.conf
}

install_udev_rules() {
    report_status "Installing udev rules"
    sudo ln -s /home/pi/mainsail_config/boards/*/*.rules /etc/udev/rules.d/
}

install_dependencies() {
    report_status "Installing dependencies"
    sudo apt-get update && sudo apt-get install -y $PKGLIST
}

# Force script to exit if an error occurs
set -xe

verify_ready
install_printer_config
install_udev_rules
install_dependencies

install_gcode_shell_command
install_ratos_homing

ensure_moonraker_policiykit_rules

