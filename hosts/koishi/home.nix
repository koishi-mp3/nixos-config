{ config, pkgs, ... }:

{
  
  home.username = "koishi";
  home.homeDirectory = "/home/koishi";
  home.stateVersion = "26.05";
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #misc
    vesktop
    firefox
    btop
    nwg-look
    pipewire
    p7zip
    thunar
    grim
    slurp
    wl-clipboard
    libnotify
    dunst
    brightnessctl  
    proton-vpn
    blueman
    ollama
    virt-manager
    filezilla
  
    osu-lazer

    #terminal
    yazi
    kitty
    fastfetch
    alacritty
    ghostty


    #dev
    neovim
    vim
    git
    wget
    python3
    python312Packages.pip
    docker
    putty
    nodejs_26
    unzip
    

    #ricing
    waybar
    hyprland
    wofi
    hyprpaper
    pywal16
    pywalfox-native
    hyprlock	

  ];

   # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.

}
