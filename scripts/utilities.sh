#!/bin/bash

report_status() {
    echo -e "\n\n###### $1"
}

verify_ready() {
    if [ "$EUID" -eq 0 ]; then
        echo "This script must not run as root"
        exit 1
    fi
}

clean_install() {
    report_status "Clean up OS install"

    rm -rf ~/mainsail-config
    rm -f ~/printer_data/config/mainsail.cfg

    rm -rf ~/crowsnest
    rm -f ~/printer_data/config/crowsnest.conf

    rm -rf ~/sonar
    rm -f ~/printer_data/config/sonar.conf

    rm -f ~/printer_data/config/timelapse.cfg

    git config --global pull.ff only
}

install_hooks() {
    report_status "Installing git hooks"
    if [[ ! -e ~/mainsail_config/.git/hooks/post-merge ]]; then
        ln -sf ~/mainsail_config/scripts/update.sh ~/mainsail_config/.git/hooks/post-merge
        sudo chmod +x ~/mainsail_config/.git/hooks/post-merge
    fi
}

PRINTER=$(cat <<-END
[include printer_base.cfg]

#[gcode_macro VARS]

[mcu]
serial: /dev/serial/by-id/usb-Klipper_stm32f103xe_35FFDA054246303244701157-if00

[extruder]
control: pid
pid_kp: 28.413
pid_ki: 1.334
pid_kd: 151.300

[heater_bed]
control: pid
pid_Kp: 22.2
pid_Ki: 1.08
pid_Kd: 114

END

)
install_printer_config() {
    report_status "Installing printer configuration"

    rm -f ~/printer_data/config/printer.cfg
    ln -sf ~/mainsail_config/templates/initial-printer.template.cfg ~/printer_data/config/printer_base.cfg
    echo "$PRINTER" >~/printer_data/config/printer.cfg

    rm -f ~/printer_data/config/moonraker.conf
    ln -sf ~/mainsail_config/templates/moonraker.template.conf ~/printer_data/config/moonraker_base.conf
    echo "[include moonraker_base.conf]" >~/printer_data/config/moonraker.conf
}

install_udev_rules() {
    report_status "Installing udev rules"
    sudo ln -sf ~/mainsail_config/boards/*/*.rules /etc/udev/rules.d/
}

install_dependencies() {
    report_status "Installing dependencies"
    # shellcheck disable=SC2086
    sudo apt-get update && sudo apt-get install -y $PKGLIST
}

install_theme() {
    report_status "Installing theme"
    cd ~ && git clone https://github.com/gethe/mainsail_theme.git
    sudo -u pi bash ~/mainsail_theme/install.sh
}

install_linear_movement() {
    report_status "Installing Klipper Linear Movement"
    cd ~ && git clone https://github.com/worksasintended/klipper_linear_movement_analysis.git
    sudo -u pi bash ~/klipper_linear_movement_analysis/install.sh
}

install_kiauh() {
    report_status "Installing KIAUH"
    cd ~ && git clone https://github.com/th33xitus/kiauh.git
    sudo -u pi bash ~/kiauh/kiauh.sh
}

POLKIT_LEGACY_DIR="/etc/polkit-1/localauthority/50-local.d"
POLKIT_DIR="/etc/polkit-1/rules.d"
POLKIT_USR_DIR="/usr/share/polkit-1/rules.d"

ensure_moonraker_policiykit_rules() {
    if [[ -e ${POLKIT_USR_DIR}/moonraker.rules ]]; then
        echo -e "\n\n###### Moonraker policy exists, skipping policykit script."
        return
    fi
    if [[ -e ${POLKIT_DIR}/moonraker.rules ]]; then
        echo -e "\n\n###### Moonraker policy exists, skipping policykit script."
        return
    fi
    if [[ -e ${POLKIT_LEGACY_DIR}/10-moonraker.pkla ]]; then
        echo -e "\n\n###### Moonraker legacy policy exists, skipping policykit script."
        return
    fi
    if [[ -e /home/pi/moonraker/scripts/set-policykit-rules.sh ]]; then
        cp /home/pi/moonraker/scripts/set-policykit-rules.sh /tmp/set-policykit-rules.sh
        # if moonraker restarts the update process will be terminated, leaving a broken moonraker install.
        sed -i 's/sudo systemctl restart moonraker/#sudo systemctl restart moonraker/g' /tmp/set-policykit-rules.sh
        #sed -i ':a;N;$!ba;s/verify_ready\n/#verify_ready\n/g' /tmp/set-policykit-rules.sh
        echo -e "\n\n###### Moonraker policy not found, running moonraker policykit script..."
        if [ "$EUID" -eq 0 ]; then
            # This feels wrong, but...
            OLDUSER=$USER
            USER=pi
            /tmp/set-policykit-rules.sh --root
            USER=$OLDUSER
        else
            /tmp/set-policykit-rules.sh
        fi
        return 1
    fi
}
