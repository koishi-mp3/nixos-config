{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.cirno.gaming;
in
{
  config = lib.mkIf (
    cfg.enable
    && cfg.slippi.enable
  ) {
    environment.systemPackages = [
      inputs.slippi.packages.${pkgs.system}.default
    ];
  };
}

