# original config comes from https://github.com/FreshlyBakedCake/Patisserie/blob/940505258279fe07f19b2a0de08a98b3dbd2ffe7/modules/nixos/cooling/OpenLinkHub/default.nix#L10 but was edited with ai to work with my setup

{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.chimera.cooling.OpenLinkHub;
  stateDir = "/var/lib/OpenLinkHub";
  packageData = "${cfg.package}/opt/OpenLinkHub";
in
{
  options.chimera.cooling.OpenLinkHub = {
    enable = lib.mkEnableOption "OpenLinkHub service for Corsair iCUE Link";

    package = lib.mkOption {
      type = lib.types.package;
      description = "OpenLinkHub package to use";
      default = pkgs.openlinkhub;
    };

    config = lib.mkOption {
      type = lib.types.path;
      description = "OpenLinkHub configuration file";
      default = pkgs.writeText "openlinkhub-config.json" "{}";
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.OpenLinkHub = {};

    users.users.OpenLinkHub = {
      isSystemUser = true;
      group = "OpenLinkHub";
      extraGroups = [ config.users.groups.input.name ];
    };

    systemd.services.OpenLinkHub = {
      description =
        "Open source interface for iCUE LINK System Hub, Corsair AIOs and Hubs";

      wantedBy = [ "multi-user.target" ];

      path = [
        pkgs.coreutils
        pkgs.gawk
        pkgs.usbutils
      ];

      preStart = ''
        set -e

        mkdir -p ${stateDir}/database
        mkdir -p ${stateDir}/database/temperatures
        mkdir -p ${stateDir}/database/profiles
        mkdir -p ${stateDir}/database/keyboard
        mkdir -p /run/udev/rules.d

        # Copy the package database into the writable state directory.
        cp -r -n ${packageData}/database/. ${stateDir}/database/

        # Install the OpenLinkHub configuration.
        cp ${cfg.config} ${stateDir}/config.json

        # Link the web assets.
        if [ ! -e ${stateDir}/static ]; then
          ln -s ${packageData}/static ${stateDir}/static
        fi

        if [ ! -e ${stateDir}/web ]; then
          ln -s ${packageData}/web ${stateDir}/web
        fi

        # Create udev rules for connected Corsair devices.
        ${pkgs.usbutils}/bin/lsusb -d 1b1c: | while read -r line; do
          ids="$(${pkgs.gawk}/bin/awk '{print $6}' <<< "$line")"

          vendor_id="$(${pkgs.coreutils}/bin/cut -d ':' -f 1 <<< "$ids")"
          device_id="$(${pkgs.coreutils}/bin/cut -d ':' -f 2 <<< "$ids")"

          if [ -n "$vendor_id" ] && [ -n "$device_id" ]; then
            cat > "/run/udev/rules.d/99-corsair-openlinkhub-$device_id.rules" << EOF
        KERNEL=="hidraw*", SUBSYSTEMS=="usb", ATTRS{idVendor}=="$vendor_id", ATTRS{idProduct}=="$device_id", MODE="0666"
        EOF
          fi
        done

        chmod -R 744 ${stateDir}
        chown -R OpenLinkHub:OpenLinkHub ${stateDir}

        ${pkgs.systemd}/bin/udevadm control --reload
        ${pkgs.systemd}/bin/udevadm trigger
      '';

      postStop = ''
        ${pkgs.coreutils}/bin/rm -f ${stateDir}/web
        ${pkgs.coreutils}/bin/rm -f ${stateDir}/static
        ${pkgs.coreutils}/bin/rm -f \
          /run/udev/rules.d/99-corsair-openlinkhub-*.rules

        ${pkgs.systemd}/bin/udevadm control --reload
        ${pkgs.systemd}/bin/udevadm trigger
      '';

      serviceConfig = {
        User = "OpenLinkHub";
        Group = "OpenLinkHub";
        DynamicUser = false;

        ExecStart = "${cfg.package}/bin/OpenLinkHub";
        ExecReload = "${pkgs.coreutils}/bin/kill -s HUP $MAINPID";

        Restart = "on-failure";
        RestartSec = 5;

        StateDirectory = "OpenLinkHub";
        WorkingDirectory = stateDir;

        PermissionsStartOnly = true;

        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ stateDir ];
      };
    };
  };
}

