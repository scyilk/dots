{ pkgs, ... }:
let
  theme = import ../theme.nix { inherit pkgs; };
  colors = theme.colors;
in
{
  home.packages = [ pkgs.wlogout ];

  home.file = {
    ".config/wlogout/layout".text = ''
      {
          "label" : "lock",
          "action" : "loginctl lock-session",
          "text" : "Lock",
          "keybind" : "l"
      }
      {
          "label" : "logout",
          "action" : "loginctl terminate-user $USER",
          "text" : "Logout",
          "keybind" : "e"
      }
      {
          "label" : "shutdown",
          "action" : "systemctl poweroff",
          "text" : "Shutdown",
          "keybind" : "s"
      }
      {
          "label" : "suspend",
          "action" : "systemctl suspend",
          "text" : "Suspend",
          "keybind" : "u"
      }
      {
          "label" : "reboot",
          "action" : "systemctl reboot",
          "text" : "Reboot",
          "keybind" : "r"
      }
    '';

    ".config/wlogout/style.css".text = ''
      * {
          background-image: none;
          box-shadow: none;
      }

      window {
          background-color: rgba(${colors.rgb.background}, 0.9);
      }

      button {
          border-radius: 0;
          border-color: #${colors.black};
          text-decoration-color: #${colors.text};
          color: #${colors.text};
          background-color: #${colors.black};
          border-style: solid;
          border-width: 1px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
      }

      button:focus, button:active, button:hover {
          background-color: #${colors.green};
          color: #${colors.background};
          outline-style: none;
      }

      #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
