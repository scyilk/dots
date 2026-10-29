{ pkgs, ... }:
let
  theme = import ../theme.nix { inherit pkgs; };
  colors = theme.colors;
in
{
  home.packages = [
    pkgs.hyprlock
    pkgs.inter
  ];

  fonts.fontconfig.enable = true;

  home.file = {
    ".config/hypr/mountain.png".source = theme.wallpaper;

    ".config/hypr/hyprlock.conf".text = ''
      # BACKGROUND
      background {
          monitor =
          path = ~/.config/hypr/mountain.png
          blur_passes = 3
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
      }

      # GENERAL
      general {
          no_fade_in = false
          grace = 0
          disable_loading_bar = false
      }

      # TIME
      label {
          monitor =
          text = cmd[update:1000] echo "$(date +"%-I:%M%p")"
          color = rgba(${colors.rgb.yellow}, 0.75)
          font_size = 120
          font_family = Inter Bold
          position = 0, -140
          halign = center
          valign = top
      }

      # DAY-DATE-MONTH
      label {
          monitor =
          text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
          color = rgba(${colors.rgb.text}, 0.75)
          font_size = 30
          font_family = Inter Bold
          position = 0, 200
          halign = center
          valign = center
      }

      # LOGO
      label {
          monitor =
          text = 
          color = rgba(${colors.rgb.white}, 0.65)
          font_size = 120
          position = 0, 60
          halign = center
          valign = center
      }

      # USER
      label {
          monitor =
          text = Hello, $USER
          color = rgba(${colors.rgb.text}, 0.65)
          font_size = 25
          font_family = Inter Bold
          position = 0, -70
          halign = center
          valign = center
      }

      # INPUT FIELD
      input-field {
          monitor =
          size = 290, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(0, 0, 0, 0)
          inner_color = rgba(${colors.rgb.black}, 0.35)
          font_color = rgb(${colors.rgb.text})
          fade_on_empty = false
          font_family = Inter Bold
          placeholder_text = <i><span foreground="##${colors.text}99">Use Me</span></i>
          hide_input = false
          position = 0, -140
          halign = center
          valign = center
      }
    '';
  };
}
