# Custom Mainsail Configuration

This is my custom Mainsail/Klipper config. It is based on the [RatOS config],
and tweaked for my own purposes based on work by [mainsail-crew], [mjonuschat],
[th33xitus] and more, along with some of my own.

## Usage

The repository should be cloned to `~/printer_data/config/main`, as everything
in this repository is expecting this as the root. From there, check the
[templates] folder and copy the files into moonraker.conf and printer.cfg in the
`~/printer_data/config` folder. Some options are configurable in [variables.cfg]
and some parameters need to be directly set in the respective hardware-specific
configuration snippets.


[RatOS config]: https://github.com/Rat-OS/RatOS-configuration
[mainsail-crew]: https://github.com/mainsail-crew/mainsail-config
[mjonuschat]: https://github.com/mjonuschat/voron-modular-config
[th33xitus]: https://github.com/th33xitus/kiauh/wiki/How-to-autocommit-config-changes-to-github%3F

[templates]: templates/
[variables.cfg]: variables.cfg
