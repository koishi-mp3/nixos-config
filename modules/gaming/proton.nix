{ config, lib, pkgs, ... }:

let
  cfg = config.cirno.gaming;
in
{
  config = lib.mkIf (cfg.enable && cfg.proton.enable) {
    environment.systemPackages = with pkgs; [
      protonup-qt
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}

