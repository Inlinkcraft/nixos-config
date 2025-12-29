{ config, pkgs, lib, ... }:

let
  cfgDir = "${config.home.homeDirectory}/.config/eww";
in
{
  # Ensure eww exists
  home.packages = with pkgs; [
    eww
    bash
    coreutils
    gawk
    gnused
    procps
    lm_sensors
    networkmanager
    bluez
    wireplumber
  ];

  # Copy eww config into ~/.config/eww
  home.file.".config/eww/eww.yuck".source = ./config/eww.yuck;
  home.file.".config/eww/eww.scss".source = ./config/eww.scss;

  # Scripts (must be executable!)
  home.file.".config/eww/scripts/metrics" = {
    source = ./config/scripts/metrics;
    executable = true;
  };

  # Run eww daemon as a persistent user service
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww widget daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize --config ${cfgDir}";
      Restart = "on-failure";
      RestartSec = 1;

      # Very important for daemon socket location:
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
