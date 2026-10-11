{ config, pkgs, ... }:

{
   networking.firewall.enable = true;
   networking.firewall.allowedUDPPorts = [6969];
}

