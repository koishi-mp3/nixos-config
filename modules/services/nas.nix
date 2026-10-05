{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];

  age.secrets.nas.file = ../../secrets/nas.age;

  fileSystems."/mnt/nas" = {
    device = "//192.168.10.10/home";  
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=${config.age.secrets.nas.path}"
      "uid=1000" "gid=100"
    ];
  };
}
