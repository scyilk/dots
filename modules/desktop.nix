{ pkgs, username, ... }:
{
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      # Auto-login on boot. greetd starts this with XDG_SESSION_CLASS=user,
      # so logind can lock the session (default_session sessions are class
      # "greeter", where LockSession returns NotSupported).
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = username;
      };

      # greetd always requires a default_session. It runs after the session
      # exits (logout) or a greetd restart, so use the bundled text greeter;
      # logins it starts are ordinary user-class sessions too.
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.sway}/bin/sway";
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
