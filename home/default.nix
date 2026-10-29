{ username, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./sway.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./librewolf.nix
    ./tor.nix
    ./nvim.nix
    ./alacritty.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
