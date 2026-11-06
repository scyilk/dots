{ ... }:
{
  # User-installed flatpaks, reconciled on home-manager activation.
  # Adding/removing entries here installs/uninstalls them on the next switch.
  services.flatpak = {
    enable = true;
    packages = [
      # Roblox client
      "org.vinegarhq.Sober"
    ];
  };
}
