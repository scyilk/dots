{ pkgs, lib, ... }:
{
  wayland.systemd.target = "sway-session.target";

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    systemd.enable = true;
    xwayland = true;

    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "fuzzel";
      bars = [ ];

      keybindings = lib.mkOptionDefault {
        "Mod4+Shift+e" = "exec ${pkgs.wlogout}/bin/wlogout";
      };

      input = {
        "*" = {
          xkb_layout = "us";
        };
        "9610:54:Glorious_Model_O" = {
          accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0";
        };
      };

      output = {
        "*" = {
          bg = "#1e1e2e solid_color";
        };
      };

      fonts = {
        names = [ "DejaVu Sans Mono" ];
        size = 14.0;
      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 26;
        spacing = 0;

        modules-left = [ "sway/workspaces" ];
        modules-right = [ "network" "battery" "memory" "clock" "tray" ];

        "sway/workspaces" = {
          format = "{name}";
          disable-auto-back-and-forth = true;
          tooltip = false;
        };

        network = {
          interval = 5;
          format = "<span foreground=\"#ff0000\">W: down</span> | ";
          "format-wifi" = "<span foreground=\"#00ff00\">W: {essid} {ipaddr}</span> | ";
          "format-ethernet" = "<span foreground=\"#ff0000\">W: down</span> | ";
          "format-linked" = "<span foreground=\"#ff0000\">W: down</span> | ";
          "format-disconnected" = "<span foreground=\"#ff0000\">W: down</span> | ";
          tooltip = false;
        };

        battery = {
          interval = 5;
          format = "UNK {capacity}% | ";
          "format-full" = "FULL {capacity}% | ";
          "format-charging" = "CHR {capacity}% {time} | ";
          "format-discharging" = "BAT {capacity}% {time} | ";
          "format-plugged" = "FULL {capacity}% | ";
          "format-not-charging" = "FULL {capacity}% | ";
          "format-time" = "{H}:{m}";
          tooltip = false;
        };

        memory = {
          interval = 5;
          format = "{used:0.1f} GiB | {avail:0.1f} GiB | ";
          "format-warning" = "<span foreground=\"#ffff00\">MEMORY &lt; {avail:0.1f} GiB</span> | ";
          "format-critical" = "<span foreground=\"#ff0000\">MEMORY &lt; {avail:0.1f} GiB</span> | ";
          states = {
            warning = 97;
            critical = 100;
          };
          tooltip = false;
        };

        clock = {
          interval = 5;
          format = "{:%d/%m/%Y %H:%M}";
          tooltip = false;
        };

        tray = {
          icon-size = 20;
          spacing = 0;
        };
      }
    ];

    style = ''
      * {
        font-family: "DejaVu Sans Mono";
        font-size: 14pt;
        border: none;
        border-radius: 0;
        box-shadow: none;
        padding: 0;
        min-height: 0;
        transition: none;
      }

      *:hover {
        background: transparent;
        box-shadow: none;
        text-shadow: none;
      }

      window#waybar {
        background: #000000;
        color: #ffffff;
      }

      #workspaces button {
        padding: 0 5px;
        background: #222222;
        color: #888888;
        border: 1px solid #333333;
      }

      #workspaces button.visible {
        background: #5f676a;
        color: #ffffff;
      }

      #workspaces button.focused {
        background: #285577;
        color: #ffffff;
        border-color: #4c7899;
      }

      #workspaces button.urgent {
        background: #900000;
        color: #ffffff;
        border-color: #2f343a;
      }

      #workspaces button:hover {
        background: #222222;
        color: #888888;
        border-color: #333333;
      }

      #workspaces button.visible:hover {
        background: #5f676a;
        color: #ffffff;
      }

      #workspaces button.focused:hover {
        background: #285577;
        color: #ffffff;
        border-color: #4c7899;
      }

      #workspaces button.urgent:hover {
        background: #900000;
        color: #ffffff;
        border-color: #2f343a;
      }

      #tray button:hover {
        background: transparent;
        box-shadow: none;
      }

      #tray {
        padding: 0 2px;
      }
    '';
  };

  services.mako.enable = true;

  services.udiskie = {
    enable = true;
    tray = "always";
    automount = true;
    notify = true;
    settings.program_options.menu = "flat";
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "mako notification daemon";
      PartOf = [ "sway-session.target" ];
      After = [ "sway-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };

  programs.fuzzel.enable = true;

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
      { event = "lock"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.hyprlock}/bin/hyprlock"; }
      { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
