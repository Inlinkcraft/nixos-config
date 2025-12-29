{ pkgs, ... }:

{
  xdg.configFile."ags/app.js".source = ./config/app.js;
  xdg.configFile."ags/style.css".source = ./config/style.css;

  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (Astal-GJS)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ags}/bin/ags run --gtk4";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
