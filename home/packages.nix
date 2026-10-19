{ pkgs, ... }:
{
  home.packages = with pkgs; [
    librewolf
    tor-browser

    vesktop
    telegram-desktop
    nheko
    matcha

    mpv
    obs-studio
    kdePackages.kdenlive
    kdePackages.okular
    stirling-pdf
    losslesscut-bin
    ffmpeg-full
    yt-dlp
    moonlight-qt
    sunshine
    gpu-screen-recorder
    pinta

    vscode-fhs
    vscodium
    zed-editor
    opencode
    jetbrains.idea
    android-studio
    kdePackages.kate
    electron-fiddle

    zulu25
    zulu21
    zulu8
    android-tools
    arduino-ide

    alacritty
    ripgrep
    aria2
    fd
    exiftool
    imagemagick
    renameutils
    rmlint
    hyprpicker
    grim
    slurp
    swappy
    wl-clipboard
    # cliphist
    wget
    jq
    yq
    sway

    prismlauncher
    mangohud
    gamemode

    bisq2

    proton-vpn
    kdePackages.kdeconnect-kde
    snapshot
  ];
}
