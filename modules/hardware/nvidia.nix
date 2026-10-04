{ config, lib, pkgs, ... }:

{
  options.hardware.nvidia.enable =
    lib.mkEnableOption "NVIDIA drivers";

  config = lib.mkMerge [
    {
      hardware.graphics = {
        enable = true;
      };
    }

    (lib.mkIf config.hardware.nvidia.enable {
      services.xserver.videoDrivers = [
        "nvidia"
      ];

      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable; 
      };
    })
  ];
}

