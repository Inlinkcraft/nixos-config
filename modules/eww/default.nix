{ config, pkgs, lib, ... }:

let
  # IMPORTANT: on force le vrai HOME, pas XDG_CONFIG_HOME (qui peut pointer vers /nix/store via HM)
  ewwDir = "%h/.config/eww";
  pathBins = lib.makeBinPath [
    pkgs.coreutils
    pkgs.gawk
    pkgs.gnugrep
    pkgs.util-linux
    pkgs.procps
    pkgs.lm_sensors
    pkgs.networkmanager
    pkgs.pulseaudio
    pkgs.brightnessctl
    pkgs.bash
  ];
in
{
  home.packages = with pkgs; [
    eww
    networkmanager
    lm_sensors
    procps
    pulseaudio
    brightnessctl
  ];

  # Force overwrite (évite "would be clobbered")
  home.file.".config/eww/eww.yuck" = {
    source = ./config/eww.yuck;
    force = true;
  };

  home.file.".config/eww/eww.scss" = {
    source = ./config/eww.scss;
    force = true;
  };

  home.file.".config/eww/scripts/metrics" = {
    source = ./config/scripts/metrics;
    executable = true;
    force = true;
  };

  home.file.".config/eww/scripts/wifi_state" = {
    source = ./config/scripts/wifi_state;
    executable = true;
    force = true;
  };

  home.file.".config/eww/scripts/gen-wal-scss" = {
    source = ./config/scripts/gen-wal-scss;
    executable = true;
    force = true;
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";

      # On force un PATH correct pour nmcli/sensors/etc
      Environment = [
        "PATH=${pathBins}"
      ];

      # Génère un fichier SCSS pywal *toujours présent* avant de démarrer eww
      ExecStartPre = [
        "${pkgs.bash}/bin/bash -lc '%h/.config/eww/scripts/gen-wal-scss'"
      ];

      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize --config ${ewwDir}";
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
