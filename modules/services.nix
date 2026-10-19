{ pkgs, username, ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PasswordAuthentication = false;
  };

  services.syncthing = {
    enable = true;
    user = username;
  };

  services.fwupd.enable = true;
  services.thermald.enable = true;
  services.fstrim.enable = true;
  zramSwap.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  security.polkit.enable = true;

  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_full;

  programs.virt-manager.enable = true;
  programs.steam.enable = true;
  programs.ssh.startAgent = true;
}
