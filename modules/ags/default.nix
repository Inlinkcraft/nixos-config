{ config, pkgs, ... }:

{
  # Install AGS config
  home.file.".config/ags".source = ./config;

  # Start AGS (Astal) correctly
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (Aylur's GTK Shell)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ags}/bin/ags run";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
