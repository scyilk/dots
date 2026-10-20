{ config, pkgs, ... }:
let
  torrc = pkgs.writeText "torrc" ''
    SOCKSPort 127.0.0.1:9050
    DataDirectory ${config.xdg.stateHome}/tor
    GeoIPFile ${pkgs.tor.geoip}/share/tor/geoip
    GeoIPv6File ${pkgs.tor.geoip}/share/tor/geoip6
    Log notice stdout
  '';
in
{
  systemd.user.services.tor = {
    Unit = {
      Description = "Tor SOCKS proxy";
      Documentation = [ "man:tor(8)" ];
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.tor}/bin/tor -f ${torrc}";
      Restart = "on-failure";
      RestartSec = 5;
      StateDirectory = "tor";
      StateDirectoryMode = "0700";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
