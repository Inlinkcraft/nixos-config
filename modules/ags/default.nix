{ pkgs, ... }:

{
  # Install AGS config
  xdg.configFile."ags/app.js".source = ./config/app.js;
  xdg.configFile."ags/style.css".source = ./config/style.css;

  # AGS v1 runs with GTK3 — no Astal, no GTK4
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (GTK3)";
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
