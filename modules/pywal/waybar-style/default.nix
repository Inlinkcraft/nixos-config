{
  programs.waybar = {
    style = ''
      @import "/home/inlinkcraft/.cache/wal/colors-waybar.css";

      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 11px;
      }

      #waybar {
        background: @background;
        color: @foreground;
        border-bottom: 1px solid @color2;
      }

      /* Workspaces */
      #workspaces button {
        padding: 0 6px;
        background: transparent;
        color: @color4;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        color: @color1;
        border-bottom: 2px solid @color1;
        font-weight: bold;
      }

      /* Center dashboard (workspace 00) */
      #custom-dashboard {
        padding: 0 10px;
        color: @color3;
        font-weight: bold;
      }

      #custom-dashboard:hover {
        color: @color1;
      }

      /* Right side */
      #pulseaudio,
      #network,
      #clock {
        padding: 0 6px;
        color: @color6;
      }
    '';
  };
}
