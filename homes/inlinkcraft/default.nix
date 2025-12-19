
{ pkgs, ... }: {
  
  imports = [
    ./../../modules/home/wayland/default.nix
    ./../../modules/home/nvim/default.nix
  ];

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

  home.file.".config/wal/templates/colors-hyprland.conf".text = ''
    $background = {background}
    $foreground = {foreground}
    $color0 = {color0}
    $color1 = {color1}
  '';

  programs.swaylock.settings = {
    color = "#00000000";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.waybar = {
    enable = true;
#    systemd.enable = true;
    
    settings.main = {
      layer = "top";
      position = "top";
      height = 20;
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "pulseaudio" "battery" "tray" ];
      
      "hyprland/workspaces" = {
        format = "{name}";
      };

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
      
      @import url("file:///home/antoine/.cache/wal/colors-waybar.css");

      #waybar {
        background: @background;
        color: @foreground;
      }
    '';

  };

  programs.alacritty = {
    enable = true;
    
    settings = {
      general.import = [
        "~/.cache/wal/alacritty.yml"
      ];
    };

  };
}
