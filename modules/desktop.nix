{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway";
      };
    };
  };

  programs.dconf.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    dejavu_fonts
  ];
  fonts.fontconfig.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    SWAY_UNSUPPORTED_GPU = "1";
  };
}
