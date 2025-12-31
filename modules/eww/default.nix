{ config, pkgs, lib, ... }:

let
  ewwDir = "%h/.config/eww";

  # Make sure scripts called by defpoll have what they need in PATH
  pathBins = lib.makeBinPath [
    pkgs.bash
    pkgs.coreutils
    pkgs.gnugrep
    pkgs.gawk
    pkgs.util-linux
    pkgs.procps
    pkgs.lm_sensors
    pkgs.networkmanager
    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.pulseaudio
    pkgs.pamixer
    pkgs.acpi
    pkgs.curl
    pkgs.jq
    pkgs.khal
    pkgs.swaylock-effects
  ];
in
{
  home.packages = with pkgs; [
    eww
    brightnessctl
    playerctl
    networkmanager
    pamixer
    acpi
    curl
    jq
    khal
    swaylock-effects
    lm_sensors
    procps
  ];

  home.file.".config/eww/eww.yuck" = {
    source = ./config/eww.yuck;
    force = true;
  };

  home.file.".config/eww/eww.scss" = {
    source = ./config/eww.scss;
    force = true;
  };

  home.file.".config/eww/scripts/dashboard" = {
    source = ./config/scripts/dashboard;
    executable = true;
    force = true;
  };

  home.file.".config/eww/assets/avatar.svg" = {
    source = ./config/assets/avatar.svg;
    force = true;
  };

  home.file.".config/eww/assets/cover.svg" = {
    source = ./config/assets/cover.svg;
    force = true;
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww widget daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      Environment = [
        "PATH=${pathBins}"
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
