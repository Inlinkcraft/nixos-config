{ pkgs, ... }:

let
  # Prefer AGS v1 package if your nixpkgs has it.
  # Many nixpkgs expose v1 as `aylurs-gtk-shell`.
  agsPkg =
    if pkgs ? aylurs-gtk-shell then pkgs.aylurs-gtk-shell
    else pkgs.ags;

  agsBin = "${agsPkg}/bin/ags";
in
{
  # Deploy config
  xdg.configFile."ags/app.js".source = ./config/app.js;
  xdg.configFile."ags/style.css".source = ./config/style.css;

  # Start AGS as a daemon (v1 behavior)
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (daemon)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = agsBin;
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
