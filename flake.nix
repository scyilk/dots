{
  description = "NixOS config";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    llm-agents.url = "github:numtide/llm-agents.nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matcha = {
      url = "github:floatpane/matcha/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.8.0";
  };

  outputs = { nixpkgs, home-manager, bedrock-on-linux, matcha, llm-agents, nixvim, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      username = "scyilk";
      hostname = "dell-g3-3500";

      lib = nixpkgs.lib;
      shellPkgs = nixpkgs.legacyPackages.${system};

      # CLI-only home-manager profile: the shell setup from ./home without any
      # desktop packages, used by the `shell` devShell below.
      shellProfile = home-manager.lib.homeManagerConfiguration {
        pkgs = shellPkgs;
        extraSpecialArgs = { inherit username nixvim; };
        modules = [ ./shell ];
      };
      shellHome = shellProfile.config.home;

      # Only tool configs belong in a dev shell; systemd units and
      # environment.d entries are for an activated graphical session.
      shellConfigs = lib.filterAttrs
        (name: _: !(lib.hasPrefix "systemd/" name) && !(lib.hasPrefix "environment.d/" name))
        shellProfile.config.xdg.configFile;

      # Session variables home-manager would export at login. Drop the ones
      # that bake in this flake's build-time home directory or the desktop's
      # glibc locale: on a remote machine those paths don't exist.
      shellEnv = lib.filterAttrs
        (name: _:
          !(lib.hasPrefix "XDG_" name)
          && !(lib.hasPrefix "LOCALE_ARCHIVE" name)
          && name != "STARSHIP_CONFIG"
          && name != "TMUX_TMPDIR")
        shellHome.sessionVariables;
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system username hostname; };
        modules = [
          { nixpkgs.hostPlatform = system; }
          ./hosts/dell-g3-3500
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit system username hostname bedrock-on-linux matcha llm-agents nixvim; };
            home-manager.sharedModules = [ nix-flatpak.homeManagerModules.nix-flatpak ];
            home-manager.users.${username} = import ./home;
          }
        ];
      };

      # `nix develop github:scyilk/dots#shell` on any machine with Nix: the
      # user's shell setup and neovim, no X11/Wayland packages.
      devShells.${system}.shell = shellPkgs.mkShell (
        shellEnv
        // {
          name = "dots-shell";

          packages = [ shellHome.path ];

          shellHook = ''
            # `nix develop` never runs home-manager activation, so materialise
            # the generated tool configs (git, gh, tmux, direnv, nvim) once in
            # the interactive shell. Existing files are left untouched, so a
            # machine keeps its own setup.
            dotsLink() {
              local dest
              case "$1" in
                .config/*) dest="''${XDG_CONFIG_HOME:-$HOME/.config}/''${1#.config/}" ;;
                *) dest="$HOME/$1" ;;
              esac
              if [ -e "$dest" ] || [ -L "$dest" ]; then
                return 0
              fi
              mkdir -p "$(dirname "$dest")"
              cp -R "$2" "$dest"
            }
            ${lib.concatStrings (
              lib.mapAttrsToList
                (_: entry: "dotsLink ${lib.escapeShellArg entry.target} ${lib.escapeShellArg "${entry.source}"}\n")
                shellConfigs
            )}
            # Aliases, completion, starship prompt, fzf keybindings and the
            # direnv hook all live in the generated bashrc.
            if [ -n "''${BASH_VERSION:-}" ]; then
              . ${shellHome.file.".bashrc".source}
            fi
          '';
        }
      );
    };
}
