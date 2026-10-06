{ pkgs, lib, config, ... }: 
let
  cfg = config.cirno.gaming; 
in
{
  config = lib.mkIf (cfg.enable && cfg.dolphinemu.enable) {
  environment.systemPackages = [ pkgs.dolphin-emu ];
  services.udev.packages = [ pkgs.dolphin-emu ];

  boot.extraModulePackages = [ 
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [ 
    "gcadapter_oc"
  ];
 };
}
