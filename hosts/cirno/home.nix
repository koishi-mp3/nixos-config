{ config, pkgs, ... }:

{
  
  home.username = "cirno";
  home.homeDirectory = "/home/kirno";
  home.stateVersion = "26.05";
  
  home.packages = with pkgs; [
    #misc
    vesktop
    firefox
    btop
    pipewire
    p7zip
    thunar
    blueman
    filezilla
 
    #games 
    osu-lazer
    prismlauncher


    #terminal
    fastfetch
    ghostty
    neovim
    git
    putty	

  ];
}
