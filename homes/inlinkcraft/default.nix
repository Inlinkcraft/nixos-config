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
  # Kitty (terminal)
  ########################################
  programs.kitty = {
    enable = true;

    extraConfig = ''
      # Load pywal colors
      include ~/.cache/wal/colors-kitty.conf

      # Allow live reload from theme scripts
      allow_remote_control yes
    '';
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
  # Wofi (OPAQUE, arrow-navigation, search-first)
  ########################################

  home.file.".config/wofi/style.css".text = ''
    @import "$HOME/.cache/wal/colors-waybar.css";

    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
    }

    /* FORCE opaque launcher surface */
    window {
      background-color: rgba(18, 18, 18, 0.97);
      color: @foreground;
      border: 2px solid @color4;
      border-radius: 12px;
      padding: 12px;
    }

    #input {
      margin: 6px;
      padding: 6px;
      border-radius: 6px;
      background-color: @color0;
      color: @foreground;
    }

    #entry {
      padding: 6px;
      border-radius: 6px;
    }

    #entry:selected {
      background-color: @color4;
      color: #000000;
    }
  '';

  home.file.".config/wofi/config".text = ''
    show=drun
    prompt=Select theme
    insensitive=true
    allow_images=false
    width=400
    lines=8

    key_up=Up
    key_down=Down
    key_left=Left
    key_right=Right
    key_accept=Return
    key_exit=Escape
  '';
}
