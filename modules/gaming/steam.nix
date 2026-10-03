{ config, lib, pkgs, ... }:

let
  cfg = config.cirno.gaming;
in
{
  config = lib.mkIf (cfg.enable && cfg.steam.enable) {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];
  };
}

