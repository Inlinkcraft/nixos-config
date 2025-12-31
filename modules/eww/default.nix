{ config, pkgs, lib, ... }:

let
  ewwConfigDir = "%h/.config/eww";
  ewwCacheDir = "${config.home.homeDirectory}/.cache/eww";

  runtimePkgs = with pkgs; [
    bash
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
  home.packages = runtimePkgs;

  home.file.".config/eww/eww.yuck" = { source = ./config/eww.yuck; force = true; };
  home.file.".config/eww/eww.scss" = { source = ./config/eww.scss; force = true; };

  home.file.".config/eww/scripts/dashboard" = {
    source = ./config/scripts/dashboard;
    executable = true;
    force = true;
  };

  home.file.".config/eww/assets/avatar.svg" = { source = ./config/assets/avatar.svg; force = true; };
  home.file.".config/eww/assets/cover.svg"  = { source = ./config/assets/cover.svg;  force = true; };

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww widget daemon";
      After = [ "graphical-session.target" "pywal.service" ];
      Wants = [ "pywal.service" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";

      # Make scripts callable as `dashboard ...`
      Environment = [
        "PATH=${runtimePath}:%h/.config/eww/scripts"
        "EWW_CONFIG_DIR=%h/.config/eww"
      ];

      ExecStartPre = [
        # Generates ~/.cache/eww/wal.scss (safe even if you don't import it yet)
        "dashboard wal-gen"
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
