{ pkgs, ... }:

{
  systemd.user.services.pywal = {
    Unit = {
      Description = "Restore pywal colors";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.pywal}/bin/wal -R";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
