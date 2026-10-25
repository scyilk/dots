{ pkgs, system, bedrock-on-linux, matcha, ... }:
{
  home.packages = with pkgs; [
    tor-browser

    vesktop
    telegram-desktop
    nheko
    (matcha.packages.${system}.default.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.git ];
      checkPhase = ''
        runHook preCheck
        export HOME=$(mktemp -d)
        go test $(go list ./... | grep -v '/tests/integration')
        runHook postCheck
      '';
    }))

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
    udiskie
    adwaita-icon-theme

    prismlauncher
    mangohud
    gamemode

    bisq2

    proton-vpn
    kdePackages.kdeconnect-kde
    snapshot

    bedrock-on-linux.packages.${system}.default
  ];

  home.file = {
    ".local/share/jdks/zulu8".source = pkgs.zulu8;
    ".local/share/jdks/zulu21".source = pkgs.zulu21;
    ".local/share/jdks/zulu25".source = pkgs.zulu25;
  };
}
