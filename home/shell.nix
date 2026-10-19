{ ... }:
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
  programs.git.enable = true;
  programs.keepassxc.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
