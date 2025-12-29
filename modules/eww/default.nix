{ config, lib, pkgs, ... }:

let
  ewwPkg = if pkgs ? "eww-wayland" then pkgs."eww-wayland" else pkgs.eww;
in
{
  home.packages = with pkgs; [
    ewwPkg
    bash
    coreutils
    gawk
    gnugrep
    procps
    bc

    # dashboard deps
    playerctl
    brightnessctl
    lm_sensors
    acpi
    networkmanager
    pamixer
  ];

  # Put your yuck/scss/scripts into ~/.config/eww/
  xdg.configFile."eww/eww.yuck".source = ./config/eww.yuck;
  xdg.configFile."eww/eww.scss".source = ./config/eww.scss;

  # Make sure we always have a pywal colors.scss to import (fallback if none yet)
  home.activation.ensureWalColorsScss = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.cache/wal/colors.scss" ]; then
      mkdir -p "$HOME/.cache/wal"
      cat > "$HOME/.cache/wal/colors.scss" <<'EOF'
$background: #0b0f14;
$foreground: #e6e6e6;
$color0: #0b0f14;
$color1: #ff5c57;
$color2: #5af78e;
$color3: #f3f99d;
$color4: #57c7ff;
$color5: #ff6ac1;
$color6: #9aedfe;
$color7: #f1f1f0;
$color8: #686868;
$color9: #ff5c57;
$color10: #5af78e;
$color11: #f3f99d;
$color12: #57c7ff;
$color13: #ff6ac1;
$color14: #9aedfe;
$color15: #f1f1f0;
EOF
    fi
  '';

  # Symlink ~/.config/eww/colors.scss -> ~/.cache/wal/colors.scss
  xdg.configFile."eww/colors.scss".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/colors.scss";

  # Install scripts (executable)
  xdg.configFile."eww/scripts/cpu.sh" = { source = ./config/scripts/cpu.sh; executable = true; };
  xdg.configFile."eww/scripts/mem.sh" = { source = ./config/scripts/mem.sh; executable = true; };
  xdg.configFile."eww/scripts/disk.sh" = { source = ./config/scripts/disk.sh; executable = true; };
  xdg.configFile."eww/scripts/temp.sh" = { source = ./config/scripts/temp.sh; executable = true; };

  xdg.configFile."eww/scripts/uptime.sh" = { source = ./config/scripts/uptime.sh; executable = true; };
  xdg.configFile."eww/scripts/battery.sh" = { source = ./config/scripts/battery.sh; executable = true; };
  xdg.configFile."eww/scripts/wifi.sh" = { source = ./config/scripts/wifi.sh; executable = true; };

  xdg.configFile."eww/scripts/volume.sh" = { source = ./config/scripts/volume.sh; executable = true; };
  xdg.configFile."eww/scripts/mute.sh" = { source = ./config/scripts/mute.sh; executable = true; };
  xdg.configFile."eww/scripts/set-volume.sh" = { source = ./config/scripts/set-volume.sh; executable = true; };

  xdg.configFile."eww/scripts/brightness.sh" = { source = ./config/scripts/brightness.sh; executable = true; };
  xdg.configFile."eww/scripts/set-brightness.sh" = { source = ./config/scripts/set-brightness.sh; executable = true; };

  xdg.configFile."eww/scripts/music_title.sh" = { source = ./config/scripts/music_title.sh; executable = true; };
  xdg.configFile."eww/scripts/music_artist.sh" = { source = ./config/scripts/music_artist.sh; executable = true; };
  xdg.configFile."eww/scripts/music_status.sh" = { source = ./config/scripts/music_status.sh; executable = true; };
  xdg.configFile."eww/scripts/music_progress.sh" = { source = ./config/scripts/music_progress.sh; executable = true; };
  xdg.configFile."eww/scripts/music_position.sh" = { source = ./config/scripts/music_position.sh; executable = true; };
  xdg.configFile."eww/scripts/music_length.sh" = { source = ./config/scripts/music_length.sh; executable = true; };
  xdg.configFile."eww/scripts/music_prev.sh" = { source = ./config/scripts/music_prev.sh; executable = true; };
  xdg.configFile."eww/scripts/music_toggle.sh" = { source = ./config/scripts/music_toggle.sh; executable = true; };
  xdg.configFile."eww/scripts/music_next.sh" = { source = ./config/scripts/music_next.sh; executable = true; };

  # Start Eww daemon on login (so the toggle key always works)
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${ewwPkg}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
