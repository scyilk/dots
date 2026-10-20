{ config, pkgs, ... }:
let
  mkAddon =
    {
      pname,
      version,
      guid,
      url,
      hash,
    }:
    pkgs.stdenvNoCC.mkDerivation {
      inherit pname version;
      src = pkgs.fetchurl { inherit url hash; };
      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -m644 "$src" "$dst/${guid}.xpi"
      '';
    };

  keepassxc-browser = mkAddon {
    pname = "keepassxc-browser";
    version = "1.10.4.1";
    guid = "keepassxc-browser@keepassxc.org";
    url = "https://addons.mozilla.org/firefox/downloads/file/5078406/keepassxc_browser-1.10.4.1.xpi";
    hash = "sha256-rkEVej8Bewdzq7ogl9WwBWJBYx0KOK021o0LJLGkCcE=";
  };

  sidebery = mkAddon {
    pname = "sidebery";
    version = "5.6.1";
    guid = "{3c078156-979c-498b-8990-85f7987dd929}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4903712/sidebery-5.6.1.xpi";
    hash = "sha256-6KCktVarfdU2iXwYFq+dCRgDAiMGjqZoOgQ3YQOmyvI=";
  };

  ublock-origin = mkAddon {
    pname = "ublock-origin";
    version = "1.75.0";
    guid = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/5034826/ublock_origin-1.75.0.xpi";
    hash = "sha256-W3RBWGBFY3BkS9gPFhJehlsObDVrtd/PuEBpln6qUoc=";
  };

  metamask = mkAddon {
    pname = "ether-metamask";
    version = "13.49.0.0";
    guid = "webextension@metamask.io";
    url = "https://addons.mozilla.org/firefox/downloads/file/5053331/ether_metamask-13.49.0.0.xpi";
    hash = "sha256-EP8Vluj1Z6ZkDb5fqS8xx+7aYRsJYUb5FDgT8sG1mUs=";
  };

  duckduckgo-id = "c596f957-9348-4c0b-9314-1453fd137cfc";
  nixos-search-id = "06dfa57f-f031-468a-923e-72f0affd88d8";
in
{
  programs.librewolf = {
    enable = true;
    configPath = "${config.xdg.configHome}/librewolf/librewolf";

    profiles.scyilk = {
      id = 0;
      name = "scyilk";
      isDefault = true;

      userChrome = ''
        /* Hides the tab bar */
        #TabsToolbar {
            visibility: collapse;
        }

        /* Hides the header area of the sidebar */
        #sidebar-panel-header {
          display: none !important;
        }

        * {
          border-radius: 0px !important;
        }
      '';

      userContent = ''
        * { border-radius: 0px !important };
      '';

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "ui.systemUsesDarkTheme" = 1;

        "extensions.autoDisableScopes" = 0;
      };

      search = {
        force = true;
        default = duckduckgo-id;
        privateDefault = duckduckgo-id;
        order = [
          "ddg"
          "mojeek"
          "startpage"
          "wikipedia"
          duckduckgo-id
          nixos-search-id
        ];

        engines = {
          ddg.metaData.hidden = true;
          mojeek.metaData.hidden = true;
          startpage.metaData.hidden = true;
          wikipedia.metaData.hidden = true;

          ${duckduckgo-id} = {
            name = "DuckDuckGo";
            urls = [
              {
                template = "https://duckduckgo.com/?kp=-2&kbj=1&k1=-1&kaj=m&kat=-1&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kae=d&kt=d&ka=d&ks=n&kpsb=-1&k5=2&kbe=1&kbl=0&q={searchTerms}";
              }
            ];
            definedAliases = [ ];
          };

          ${nixos-search-id} = {
            name = "NixOS: Search - Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                type = "searchform";
              }
              {
                template = "https://search.nixos.org/packages?query={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nix" ];
          };
        };
      };

      extensions.packages = [
        keepassxc-browser
        sidebery
        ublock-origin
        metamask
      ];

      containersForce = true;
      containers = {
        tor = {
          id = 1;
          name = "Tor";
          color = "purple";
          icon = "fingerprint";
        };
      };

      bookmarks.force = true;
      bookmarks.settings = [
        {
          name = "Syncthing";
          url = "http://localhost:8384/";
        }
      ];
    };
  };
}
