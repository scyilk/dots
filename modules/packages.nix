{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
    cpu-x
    wdisplays

    easyeffects

    podman-compose

    btop

    _7zz

    rclone
    localsend
  ];
}
