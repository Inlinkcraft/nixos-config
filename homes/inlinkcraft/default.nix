
{ pkgs, ... }: {
  
  imports = [
    ./../../modules/home/wayland/default.nix
    ./../../modules/home/nvim/default.nix
  ];

  home.packages = with pkgs; [
    firefox
    wofi
    swww
    tmux
    ledger
    spotify
    hyprshot
    netbeans
    zoom-us
  ];

  programs.waybar = {
    enable = true;
#    systemd.enable = true;
    
    settings.main = {
      layer = "top";
      position = "top";
      height = 30;
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
