{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    eww
    jq
    playerctl
    pamixer
    brightnessctl
    networkmanager
    bluez
    wlogout
    acpi
    lm_sensors
  ];

  xdg.configFile."eww".source = ./config;

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      After = [ "graphical-session.target" "pywal.service" ];
      Wants = [ "pywal.service" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.eww}/bin/eww daemon";
      ExecStop = "${pkgs.eww}/bin/eww kill";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
