{ config, pkgs, ... }:
let
  theme = import ../theme.nix { inherit pkgs; };
  colors = theme.colors;
  wallpaper = theme.wallpaper;

  plymouthTheme = pkgs.runCommand "plymouth-everblush" { } ''
    mkdir -p $out/share/plymouth/themes/everblush
    cp ${config.boot.plymouth.package}/share/plymouth/themes/spinner/*.png \
      $out/share/plymouth/themes/everblush/
    cp ${wallpaper} $out/share/plymouth/themes/everblush/background.png
    cp ${config.boot.plymouth.logo} $out/share/plymouth/themes/everblush/watermark.png

    cat > $out/share/plymouth/themes/everblush/everblush.plymouth <<EOF
    [Plymouth Theme]
    Name=Everblush
    Description=Everblush theme
    ModuleName=two-step

    [two-step]
    Font=JetBrains Mono 12
    TitleFont=JetBrains Mono 30
    ImageDir=$out/share/plymouth/themes/everblush
    DialogHorizontalAlignment=.5
    DialogVerticalAlignment=.5
    TitleHorizontalAlignment=.5
    TitleVerticalAlignment=.42
    HorizontalAlignment=.5
    VerticalAlignment=.7
    WatermarkHorizontalAlignment=.5
    WatermarkVerticalAlignment=.96
    Transition=none
    TransitionDuration=0.0
    ScaleBackgroundImage=true
    BackgroundStartColor=0x141b1e
    BackgroundEndColor=0x141b1e
    ProgressBarBackgroundColor=0x232a2d
    ProgressBarForegroundColor=0x8ccf7e
    MessageBelowAnimation=true

    [boot-up]
    UseEndAnimation=false

    [shutdown]
    UseEndAnimation=false

    [reboot]
    UseEndAnimation=false
    EOF
  '';
in
{
  boot.loader.limine = {
    enable = true;
    maxGenerations = 10;

    style = {
      wallpapers = [ "${wallpaper}" ];
      wallpaperStyle = "stretched";
      backdrop = colors.background;
      interface = {
        branding = "NixOS";
        brandingColor = colors.blue;
        helpColor = colors.green;
        helpColorBright = colors.cyan;
      };
      graphicalTerminal = {
        palette = "${colors.black};${colors.red};${colors.green};${colors.yellow};${colors.blue};${colors.magenta};${colors.cyan};${colors.white}";
        brightPalette = "${colors.blackBright};${colors.redBright};${colors.greenBright};${colors.yellowBright};${colors.blueBright};${colors.magentaBright};${colors.cyanBright};${colors.whiteBright}";
        foreground = colors.text;
        background = "cc${colors.background}";
        brightForeground = colors.text;
        brightBackground = colors.blackBright;
      };
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  boot.plymouth = {
    enable = true;
    theme = "everblush";
    themePackages = [ plymouthTheme ];
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
  };
  boot.consoleLogLevel = 3;

  boot.supportedFilesystems = [ "btrfs" "exfat" "ntfs" "vfat" ];
  boot.tmp.cleanOnBoot = true;
}
