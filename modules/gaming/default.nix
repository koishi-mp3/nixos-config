{ lib, ... }:

{
  imports = [
    ./steam.nix
    ./proton.nix
    ./slippi.nix
    ./dolphinemu.nix 
  ];

  options.cirno.gaming = {
    enable = lib.mkEnableOption "gaming configuration";

    steam.enable = lib.mkEnableOption "Steam";
    proton.enable = lib.mkEnableOption "ProtonUp";
    slippi.enable = lib.mkEnableOption "Slippi";
    dolphinemu.enable = lib.mkEnableOption "Dolphinemu";
  };
}

