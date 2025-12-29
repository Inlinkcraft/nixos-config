{ pkgs, ... }:

{
  # Deploy files explicitly (bulletproof, no recursion surprises)
  xdg.configFile."ags/app.js".source = ./config/app.js;
  xdg.configFile."ags/style.css".source = ./config/style.css;

  # Start AGS as a user service (GTK4 layer shell)
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (Astal-GJS)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ags}/bin/ags run --gtk4";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
