{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/hardware/openlinkhub.nix
      ../../modules/gaming
      ../../modules/default.nix
      ./hardware-configuration.nix
    ];


  hardware.nvidia.enable = true;
  services.hardware.openrgb.enable = true;
  # NordVPN configuration
  custom.services.nordvpn.enable = true;
  users.groups.nordvpn.members = ["cirno"];

  cirno.gaming = {
    enable = true;

    steam.enable = true;
    proton.enable = true;
    slippi.enable = true;

  };
 
  chimera.cooling.OpenLinkHub = {
    enable = true;
    package = pkgs.openlinkhub;
    config = ../../config/openlinkhub-config.json;
  };

  networking.hostName = "blahaj"; 

  
 
 # Enable networking
  networking.networkmanager.enable = true;

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
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
}; 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."cirno" = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      openrgb-with-all-plugins
      #cisco-packet-tracer_9 (setup once machine is setup)
    ];
  };


  

 boot.loader.systemd-boot.enable = true;  
 boot.loader.efi.canTouchEfiVariables = true;
 boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
  


  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
};

  fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.jetbrains-mono
  font-awesome
  jetbrains-mono
];

  system.stateVersion = "26.05"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
}
