{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware/nvidia.nix
   ./services/nordvpn.nix 
  ];
}
