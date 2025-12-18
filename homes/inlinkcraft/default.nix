
{ pkgs, ... }: {
  
  imports = [
    ./../../modules/home/wayland/default.nix
    ./../../modules/home/nvim/default.nix
  ];

  home.packages = with pkgs; [
    firefox
    wofi
    swww
    pywall
    tmux
    ledger
    spotify
    hyprshot
    zoom-us
    discord
    jetbrains.idea-ultimate
    swaylock-effects
  ];

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

      #waybar {
        background: rgba(0, 0, 0, 0.5);
        color: #ffffff;
      }
    '';

  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font"; # Replace with the actual font name
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMonoNerdFont";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMonoNerdFont";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMonoNerdFont";
          style = "Bold Italic";
        };
        size = 12; # Adjust font size as needed
      };
    };
  };
}
