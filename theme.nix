{ pkgs }:
let
  colors = {
    background = "141b1e";
    black = "232a2d";
    blackBright = "2d3437";
    text = "dadada";
    white = "b3b9b8";
    red = "e57474";
    green = "8ccf7e";
    yellow = "e5c76b";
    blue = "67b0e8";
    magenta = "c47fd5";
    cyan = "6cbfbf";
    redBright = "ef7e7e";
    greenBright = "96d988";
    yellowBright = "f4d67a";
    blueBright = "71baf2";
    magentaBright = "ce89df";
    cyanBright = "67cbe7";
    whiteBright = "bdc3c2";
    rgb = {
      background = "20, 27, 30";
      black = "35, 42, 45";
      text = "218, 218, 218";
      white = "179, 185, 184";
      yellow = "229, 199, 107";
      green = "140, 207, 126";
      blue = "103, 176, 232";
    };
  };
in
{
  inherit colors;

  wallpaper = pkgs.fetchurl {
    name = "everblush-mountain.png";
    url = "https://github.com/Everblush/wallpapers/blob/main/Mountain.png?raw=true";
    hash = "sha256-QK98soVDMJA6U+wYf9RkivNAlpqbziw+9O+jhxyXrq0=";
  };
}
