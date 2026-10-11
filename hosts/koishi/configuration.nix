{ config, pkgs, agenix, ... }:

{
  imports =
    [
      ../../modules/default.nix
      ./hardware-configuration.nix
    ];

  # NordVPN configuration
  custom.services.nordvpn.enable = true;
  users.groups.nordvpn.members = ["koishi"];

  networking.hostName = "nixstrogen"; 


  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
  enable = true;
  wayland.enable = true;
};


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."koishi" = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  programs.hyprland.enable = true;
  

  boot.loader.systemd-boot.enable = true;  
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; 
  

  fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.jetbrains-mono
  font-awesome
];

  

  
  age.identityPaths = [ "/home/koishi/.ssh/id_ed25519" ];
  system.stateVersion = "26.05";

  #setup for my friend's nvim plugin
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  glib              # libglib-2.0, libgobject-2.0, libgio-2.0
  gtk4              # libgtk-4
  pango             # libpango-1.0, libpangocairo-1.0
  harfbuzz          # libharfbuzz
  gdk-pixbuf        # libgdk_pixbuf-2.0
  cairo             # libcairo, libcairo-gobject
  vulkan-loader     # libvulkan
  graphene          # libgraphene-1.0
  gtk4-layer-shell  # libgtk4-layer-shell
  gobject-introspection  # libgirepository-1.0

  ];

  nixpkgs.config.allowUnfree = true;
}
