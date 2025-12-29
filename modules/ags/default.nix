{ config, pkgs, ... }:

{
  # Install AGS config into ~/.config/ags
  home.file.".config/ags".source = ./config;

  # Optional: autostart AGS on login (Hyprland/Sway)
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS - Aylur's GTK Shell";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ags}/bin/ags";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

