{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "scyilk";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "render"
      "libvirtd"
      "kvm"
      "dialout"
      "lp"
    ];
    shell = pkgs.bash;
  };

  security.sudo.wheelNeedsPassword = true;
}
