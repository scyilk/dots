{ pkgs, ... }:
let
  everblush = pkgs.vimUtils.buildVimPlugin {
    pname = "everblush";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "Everblush";
      repo = "nvim";
      rev = "678f808d81801b983b6fb8296fb17ba1b2785d7c";
      hash = "sha256-1bX/wykK3/BKc1uRhRZD6QR/OezZY6XgyXg3a9UT3ec=";
    };
  };
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.source = pkgs.path;

    extraPlugins = [ everblush ];
    colorscheme = "everblush";

    globals = {
      mapleader = " ";
      snacks_animate = false;
    };

    opts = {
      relativenumber = true;
      wrap = false;
      tabstop = 4;
      shiftwidth = 4;
      smartcase = true;
      ignorecase = true;
      hlsearch = false;
      signcolumn = "yes";
      termguicolors = true;
    };

    highlightOverride = {
      MiniStatuslineModeNormal = { bg = "#8ccf7e"; fg = "#141b1e"; };
      MiniStatuslineModeInsert = { bg = "#96d988"; fg = "#141b1e"; };
      MiniStatuslineModeCommand = { bg = "#e57474"; fg = "#141b1e"; };
      MiniStatuslineModeVisual = { bg = "#6cbfbf"; fg = "#141b1e"; };
      MiniStatuslineModeReplace = { bg = "#e57474"; fg = "#141b1e"; };
      MiniStatuslineInactive = { bg = "#141b1e"; fg = "#dadada"; };
    };

    keymaps = [
      {
        mode = [ "n" "t" ];
        key = "<C-g>";
        action.__raw = "function() require('snacks').terminal.toggle() end";
        options.desc = "Toggle terminal window";
      }
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "function() require('snacks').explorer() end";
        options.desc = "Toggle file explorer";
      }
    ];

    plugins = {
      guess-indent.enable = true;

      mini = {
        enable = true;
        modules = {
          icons = { };
          tabline = { };
          notify = { };
          statusline = { };
          diff = {
            view = {
              style = "sign";
              signs = {
                add = "▎";
                change = "▎";
                delete = "➤";
              };
            };
          };
          clue = {
            triggers = [
              {
                mode = "n";
                keys = "g";
              }
              {
                mode = "n";
                keys = "<leader>";
              }
            ];
            clues.__raw = "require('mini.clue').gen_clues.g()";
          };
        };
      };

      snacks = {
        enable = true;
        settings = {
          input = {
            enabled = true;
            icon = "❯";
          };
          indent = {
            enabled = true;
            char = "▏";
          };
          explorer = {
            enabled = true;
            replace_netrw = true;
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          appearance.nerd_font_variant = "mono";
          completion.documentation = {
            auto_show = true;
            auto_show_delay_ms = 250;
          };
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          signature.enabled = true;
        };
      };
    };

    lsp.servers = {
      "*".config.capabilities.__raw = "require('blink.cmp').get_lsp_capabilities()";

      rust_analyzer = {
        enable = true;
        package = null;
        config = {
          cmd = [ "rust-analyzer" ];
          filetypes = [ "rust" ];
          root_markers = [
            "Cargo.toml"
            "rust-project.json"
          ];
          settings = {
            rust-analyzer = {
              cargo.allFeatures = true;
              check.command = "clippy";
              inlayHints = {
                bindingModeHints.enable = true;
                closureReturnTypeHints.enable = "with_block";
                lifetimeElisionHints.enable = "skip_trivial";
              };
            };
          };
        };
      };

      gopls = {
        enable = true;
        package = null;
        config = {
          cmd = [ "gopls" ];
          filetypes = [
            "go"
            "gomod"
            "gowork"
            "gotmpl"
          ];
          root_markers = [
            "go.work"
            "go.mod"
            ".git"
          ];
          settings = {
            gopls = {
              gofumpt = true;
              usePlaceholders = true;
              staticcheck = true;
              analyses = {
                unusedparams = true;
                useany = true;
              };
              codelenses = {
                gc_details = false;
                generate = true;
                regenerate_cgo = true;
                tidy = true;
                upgrade_dependency = true;
                vendor = true;
              };
              hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };
          };
        };
      };
    };
  };
}
