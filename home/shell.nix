{ pkgs, ... }:
let
  delta = "${pkgs.delta}/bin/delta";
in
{
  programs.neovim.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      cat = "bat";
      grep = "rg";
    };
  };

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.tmux.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.email = "61586104+scyilk@users.noreply.github.com";
      user.name = "Silk";
      core.pager = delta;
      interactive.diffFilter = "${delta} --color-only";
      delta.navigate = true;
      delta.dark = true;
      merge.conflictStyle = "zdiff3";
    };
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.keepassxc.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
