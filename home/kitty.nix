{ ... }:
{
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 16;

      # Keep ligatures enabled (e.g. "->" renders as an arrow).
      disable_ligatures = "never";

      foreground = "#dadada";
      background = "#141b1e";

      # Alacritty: colors.cursor.text / colors.cursor.cursor
      cursor = "#dadada";
      cursor_text_color = "#dadada";

      color0 = "#232a2d";
      color1 = "#e57474";
      color2 = "#8ccf7e";
      color3 = "#e5c76b";
      color4 = "#67b0e8";
      color5 = "#c47fd5";
      color6 = "#6cbfbf";
      color7 = "#b3b9b8";

      color8 = "#2d3437";
      color9 = "#ef7e7e";
      color10 = "#96d988";
      color11 = "#f4d67a";
      color12 = "#71baf2";
      color13 = "#ce89df";
      color14 = "#67cbe7";
      color15 = "#bdc3c2";
    };
  };
}
