{ config, lib, pkgs, inputs, ... }: {
  imports = [
   ./firewall.nix
   ./networkmanager.nix
  ];
}
