{ hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/boot.nix
    ../../modules/hardware.nix
    ../../modules/desktop.nix
    ../../modules/services.nix
    ../../modules/packages.nix
    ../../modules/users.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = hostname;
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/55e5eb6a-dfa4-4145-98fd-e5b801553fc0";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}
