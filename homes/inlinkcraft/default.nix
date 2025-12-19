{ pkgs, ... }:

{
  imports = [
    ./../../modules/home/wayland/default.nix
    ./../../modules/home/nvim/default.nix
  ];

  ########################################
  # Packages
  ########################################
  home.packages = with pkgs; [
    firefox
    wofi
    swww
    pywal
    tmux
    ledger
    spotify
    hyprshot
    zoom-us
    discord
    swaylock-effects
  ];

  ########################################
  # paywal config
  ########################################

  programs.pywal = {
    enable = true;
    colorSchemeFile = "~/.cache/wal/colors.json";  # Ensure colors are written to this file
    generateAlacrittyColors = true;  # Ensure Alacritty colors are generated
  };

  ########################################
  # Restore pywal at login
  ########################################
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

  ########################################
  # Pywal → Hyprland template
  ########################################
  home.file.".config/wal/templates/colors-hyprland.conf".text = ''
    $background = {background}
    $foreground = {foreground}
    $color0 = {color0}
    $color1 = {color1}
    $color2 = {color2}
    $color3 = {color3}
    $color4 = {color4}
    $color5 = {color5}
    $color6 = {color6}
    $color7 = {color7}
  '';

  ########################################
  # Swaylock
  ########################################
  programs.swaylock.settings = {
    color = "#00000000";
  };

  ########################################
  # Direnv
  ########################################
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  ########################################
  # Waybar (pywal-aware, portable)
  ########################################
  programs.waybar = {
    enable = true;

    settings.main = {
      layer = "top";
      position = "top";
      height = 20;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "pulseaudio" "battery" "tray" ];

      "hyprland/workspaces".format = "{name}";

      "clock" = {
        format = "{:%H:%M:%S}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      @import url("file://$HOME/.cache/wal/colors-waybar.css");

      #waybar {
        background: @background;
        color: @foreground;
      }
    '';
  };

  ########################################
  # Alacritty (pywal-native)
  ########################################
  programs.alacritty = {
    enable = true;

    settings = {
      general.import = [
        "~/.cache/wal/alacritty.yml"
      ];
    };
  };

  ########################################
  # Wofi (pywal-aware, portable)
  ########################################
  home.file.".config/wofi/style.css".text = ''
    @import "$HOME/.cache/wal/colors-waybar.css";

    window {
      background-color: @background;
      color: @foreground;
    }

    #entry:selected {
      background-color: @color2;
      color: @background;
    }
  '';
}
