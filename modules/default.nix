{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware/nvidia.nix 
   ./services/default.nix
   ./networking/default.nix
  ];
}
