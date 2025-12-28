{ config, pkgs, ... }:

{
  ########################################
  # Packages
  ########################################
  home.packages = with pkgs; [
    eww
  ];

  ########################################
  # Eww configuration
  ########################################
  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };

  ########################################
  # Eww daemon (systemd --user)
  ########################################
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww widget daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
