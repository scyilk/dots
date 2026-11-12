# CLI-only home-manager profile backing the `shell` devShell output.
#
# Reuses the desktop shell configuration (../home/shell.nix) and editor
# (../home/nvim.nix) so aliases, prompt, git/gh/tmux/direnv settings and the
# neovim config live in exactly one place, while everything graphical stays out.
{ username, pkgs, nixvim, lib, ... }:
{
  imports = [
    ../home/shell.nix
    ../home/nvim.nix
    nixvim.homeModules.nixvim
  ];

  # Graphical password manager; a remote editing shell never needs it.
  programs.keepassxc.enable = lib.mkForce false;

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  xdg.enable = true;

  # Desktop plumbing: a dev shell has no graphical session.
  xdg.mime.enable = lib.mkForce false;

  # CLI companions of the aliases in ../home/shell.nix (`grep` -> rg) plus the
  # usual editing helpers.
  home.packages = with pkgs; [
    ripgrep
    fd
    delta
    jq
    yq
    wget
  ];
}
