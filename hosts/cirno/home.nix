{ config, pkgs, ... }:

{
  
  home.username = "cirno";
  home.homeDirectory = "/home/cirno";
  home.stateVersion = "26.05";

  services.arrpc = {  
    enable = true;
    package = pkgs.arrpc;
    systemdTarget = "graphical-session.target";
  };

  home.packages = with pkgs; [
    # misc
    vesktop
    firefox
    btop
    pipewire
    p7zip
    thunar
    blueman
    filezilla
    qbittorrent
    vlc
    
 
    # games 
    osu-lazer-bin
    prismlauncher
    oversteer
    slimevr

    # terminal
    fastfetch
    ghostty
    neovim
    git
    putty	
    pywal16
    pywalfox-native
  ];
}  
