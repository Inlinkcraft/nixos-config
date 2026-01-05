{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {

      ####################################
      # Pywal → Hyprland
      ####################################
      source = [
        "~/.cache/wal/colors-hyprland.conf"
      ];

      ####################################
      # Monitors
      ####################################
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-3,1920x1080@60,0x0,1"
        "DP-3,1920x1080@60,1920x0,1"
      ];

      ####################################
      # Input
      ####################################
      input = {
        kb_layout = "ca";
        kb_options = "caps:escape";
      };

      ####################################
      # Keybindings
      ####################################
      bind = [
        # Apps
        "SUPER,Return,exec,kitty"
        "SUPER,B,exec,firefox"
        "SUPER,SPACE,exec,wofi --show drun"
        "SUPER,N,exec,alacritty -e nvim"

        # Dashboard (Eww overlay toggle)
        "SUPER,D,exec,eww open-many --toggle calendar profile clock power restart logout lock --arg width=1920 --arg height=1080 --arg spacing=2"

        # Window management
        "SUPER,Q,killactive"
        "SUPER,F,togglefloating"
        "SUPER,f,fullscreen"

        # Focus
        "SUPER,H,movefocus,l"
        "SUPER,L,movefocus,r"
        "SUPER,K,movefocus,u"
        "SUPER,J,movefocus,d"

        # Move windows
        "SUPER_SHIFT,H,movewindow,l"
        "SUPER_SHIFT,L,movewindow,r"
        "SUPER_SHIFT,K,movewindow,u"
        "SUPER_SHIFT,J,movewindow,d"

        # Resize
        "SUPER_CTRL,H,resizeactive,-10 0"
        "SUPER_CTRL,L,resizeactive,10 0"
        "SUPER_CTRL,J,resizeactive,0 -10"
        "SUPER_CTRL,K,resizeactive,0 10"

        # Waybar reload
        "SUPER,W,exec,pkill -SIGUSR2 waybar || waybar"

        # Screenshot
        "SUPER,P,exec,hyprshot -m window -m active --clipboard-only"

        # Theme switcher
        "SUPER_SHIFT,T,exec,$HOME/Configuration/scripts/theme-switcher"

        # Workspaces (scripted)
        "SUPER,1,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 1"
        "SUPER,2,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 2"
        "SUPER,3,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 3"
        "SUPER,4,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 4"
        "SUPER,5,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 5"
        "SUPER,6,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 6"
        "SUPER,7,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 7"
        "SUPER,8,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 8"
        "SUPER,9,exec,$HOME/Configuration/scripts/hypr-keybinds.sh switch 9"

        # Move window to workspace
        "SUPER_SHIFT,1,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 1"
        "SUPER_SHIFT,2,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 2"
        "SUPER_SHIFT,3,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 3"
        "SUPER_SHIFT,4,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 4"
        "SUPER_SHIFT,5,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 5"
        "SUPER_SHIFT,6,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 6"
        "SUPER_SHIFT,7,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 7"
        "SUPER_SHIFT,8,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 8"
        "SUPER_SHIFT,9,exec,$HOME/Configuration/scripts/hypr-keybinds.sh move 9"
      ];

      ####################################
      # Startup
      ####################################
      exec-once = [
        "swww-daemon"
        "sh -c 'while [ ! -f ~/.cache/wal/colors-waybar.css ]; do sleep 0.2; done; waybar'"
        "$HOME/Configuration/scripts/setup-workspaces.sh"
      ];

      ####################################
      # Decorations (NO BLUR)
      ####################################
      decoration = {
        blur = {
          enabled = false;
        };
      };

      ####################################
      # Gaps & borders
      ####################################
      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 1;
      };

      ####################################
      # Window rules
      ####################################
      windowrulev2 = [
        # Eww window behavior
        "float, class:^(eww)$"
        "nofocus, class:^(eww)$"
        "noborder, class:^(eww)$"
        "pin, class:^(eww)$"
      ];
    };
  };
}
