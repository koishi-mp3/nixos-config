{ config, lib, pkgs, inputs, ... }: {
  imports = [
   ./nordvpn.nix
   ./nas.nix
   ./cups.nix
   ./flatpak.nix
   ./openssh.nix
   ./pipewire.nix
  ];
}
