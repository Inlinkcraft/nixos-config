{ config, pkgs, lib, ... }:

let
  ewwConfigDir = "%h/.config/eww";
  ewwCacheDir = "${config.home.homeDirectory}/.cache/eww";

  runtimePkgs = with pkgs; [
    eww
    coreutils gawk gnugrep jq curl
    procps lm_sensors
    networkmanager
    pamixer brightnessctl acpi
    playerctl bluez
    util-linux systemd
    swaylock-effects
  ];

  runtimePath = lib.makeBinPath runtimePkgs;
in
{
  home.packages = with pkgs; [
    eww jq curl
    playerctl pamixer brightnessctl
    acpi lm_sensors networkmanager bluez
    swaylock-effects
  ];

  home.file.".config/eww/eww.yuck" = { source = ./config/eww.yuck; force = true; };
  home.file.".config/eww/eww.scss" = { source = ./config/eww.scss; force = true; };

  home.file.".config/eww/scripts/dashboard" = {
    source = ./config/scripts/dashboard;
    executable = true;
    force = true;
  };

  home.file.".config/eww/assets/avatar.svg" = { source = ./config/assets/avatar.svg; force = true; };
  home.file.".config/eww/assets/cover.svg"  = { source = ./config/assets/cover.svg;  force = true; };

  # generated at runtime into ~/.cache/eww/wal.scss
  home.file.".config/eww/wal.scss" = {
    source = config.lib.file.mkOutOfStoreSymlink "${ewwCacheDir}/wal.scss";
    force = true;
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      After = [ "graphical-session.target" "pywal.service" ];
      Wants = [ "pywal.service" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      Environment = [
        "PATH=${runtimePath}"
      ];

      ExecStartPre = [
        "${ewwConfigDir}/scripts/dashboard wal-gen"
      ];

      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize --config ${ewwConfigDir}";
      Restart = "on-failure";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

