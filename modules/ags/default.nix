{ pkgs, ... }:

let
  # Where GI typelibs live
  giPath = pkgs.lib.makeSearchPath "lib/girepository-1.0" [
    pkgs.glib
    pkgs.gobject-introspection
    pkgs.gdk-pixbuf
    pkgs.pango
    pkgs.cairo
    pkgs.graphene
    pkgs.gtk4
    pkgs.gtk4-layer-shell
    pkgs.astal-gjs
  ];

  # Desktop data dirs used by GTK (schemas, icons, etc.)
  xdgData = pkgs.lib.makeSearchPath "share" [
    pkgs.gsettings-desktop-schemas
    pkgs.gtk4
    pkgs.adwaita-icon-theme
  ];

  agsRun = pkgs.writeShellScriptBin "ags-run" ''
    export GI_TYPELIB_PATH="${giPath}''${GI_TYPELIB_PATH:+:}$GI_TYPELIB_PATH"
    export XDG_DATA_DIRS="${xdgData}''${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"
    exec ${pkgs.ags}/bin/ags run --gtk4
  '';
in
{
  # Deploy AGS config (explicit, reliable)
  xdg.configFile."ags/app.js".source = ./config/app.js;
  xdg.configFile."ags/style.css".source = ./config/style.css;

  # Ensure wrapper is available
  home.packages = [ agsRun ];

  # Start AGS with the wrapper so typelibs are visible
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (GTK4) with GI paths";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${agsRun}/bin/ags-run";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
