# Custom Mainsail Configuration

This is my custom Mainsail/Klipper config. It is based on the [RatOS config],
and tweaked for my own purposes based on work by [mainsail-crew], [mjonuschat],
[th33xitus] and more, along with some of my own.

## Usage

This repo assumes an installation of [MainsailOS] via the Raspbarry Pi Imager, and
may require adjustments if another setup is used. You'll first clone the repo
and run the install script:

    cd ~
    git clone https://github.com/gethe/mainsail_config.git
    sudo -u pi bash ~/mainsail_config/scripts/install.sh

This will create read-only symlink files in `/home/pi/printer_data/config` that
provide a basic config. It will also create moonraker.conf and printer.cfg files
that can be edited to override settings.

The install script will additionally install [mainsail_theme] and
[linear_movement_analysis].

## Note

This config is tailored to my own printers and the specific idiosyncrasies and
mods they have. As such, it may not work well for other printers without
significant changes.

[RatOS config]: https://github.com/Rat-OS/RatOS-configuration
[mainsail-crew]: https://github.com/mainsail-crew/mainsail-config
[mjonuschat]: https://github.com/mjonuschat/voron-modular-config
[th33xitus]: https://github.com/th33xitus/kiauh/wiki/How-to-autocommit-config-changes-to-github%3F

[MainsailOS]: https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based
[mainsail_theme]: https://github.com/gethe/mainsail_theme
[linear_movement_analysis]: https://github.com/worksasintended/klipper_linear_movement_analysis
