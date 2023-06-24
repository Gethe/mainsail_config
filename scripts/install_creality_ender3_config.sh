#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
ln -sf "$SCRIPT_DIR"/../templates/creality-ender3-printer.template.cfg "$SCRIPT_DIR"/../../printer_base.cfg
