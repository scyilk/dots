{ username, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./sway.nix
    ./librewolf.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.userDirs.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
