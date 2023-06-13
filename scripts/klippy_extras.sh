#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
KLIPPY_PATH=$(realpath "$SCRIPT_DIR"/../klippy)

install_klippy_extension() {
    EXT_NAME=$1
    EXT_PATH=$2
    EXT_FILE=$3
    ERROR_IF_EXISTS=$4
    [[ "$ERROR_IF_EXISTS" == "false" ]] && ERROR_IF_EXISTS="false" || ERROR_IF_EXISTS="true"

    report_status "Installing klippy extension '$EXT_NAME' ..."
    if [ ! -e "$EXT_PATH/$EXT_FILE" ]; then
        echo "ERROR: The file you're trying to install does not exist"
        exit 1
    fi

    if ln -sf "$EXT_PATH/$EXT_FILE" "/home/pi/klipper/klippy/extras/$EXT_FILE"; then
        echo "Installed $EXT_NAME successfully."
    else
        echo "ERROR: Failed to install $EXT_NAME."
        exit 1
    fi
}

install_gcode_shell_command() {
    EXT_NAME="gcode_shell_extension"
    EXT_FILE="gcode_shell_command.py"
    install_klippy_extension $EXT_NAME "$KLIPPY_PATH" $EXT_FILE
}

install_ratos_homing() {
    EXT_NAME="ratos_homing_extension"
    EXT_FILE="ratos_homing.py"
    # Don't error if extension is already installed
    install_klippy_extension $EXT_NAME "$KLIPPY_PATH" $EXT_FILE "false"
}
