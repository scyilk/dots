{ pkgs, ... }:
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

      input = {
        "*" = {
          xkb_layout = "us";
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

    extraConfig = ''
      bar {
        status_command ${pkgs.i3status}/bin/i3status
        position top
        bindsym button4 nop
        bindsym button5 nop
      }
    '';
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      interval = 5;
    };

    modules = {
      "wireless _first_" = {
        position = 1;
        settings = {
          format_up = "W: %essid %ip";
          format_down = "W: down";
        };
      };

      "battery all" = {
        position = 2;
        settings = {
          format = "%status %percentage %remaining";
          last_full_capacity = true;
        };
      };

      memory = {
        position = 3;
        settings = {
          format = "%used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 4;
        settings = {
          format = "%d/%m/%Y %H:%M";
        };
      };
    };
  };

  services.mako.enable = true;

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
  programs.swaylock.enable = true;

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
