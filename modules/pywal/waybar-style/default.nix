{
  programs.waybar = {
    style = ''
      @import "/home/inlinkcraft/.cache/wal/colors-waybar.css";

      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 11px;
      }

      /* Bar itself */
      window#waybar {
        background: transparent;
      }

      #waybar {
        background: transparent;
        margin: 6px 10px;
      }

      /* Generic module "island" */
      #workspaces,
      #custom-dashboard,
      #pulseaudio,
      #network,
      #clock {
        background: @background;
        color: @foreground;
        padding: 4px 8px;
        margin: 0 4px;
        border: 1px solid @color2;
        border-radius: 6px;

        /* GTK-safe animation */
        transition:
          background-color 150ms ease,
          color 150ms ease,
          border-color 150ms ease,
          box-shadow 150ms ease;
      }

      /* Hover effect (NO transform) */
      #workspaces:hover,
      #custom-dashboard:hover,
      #pulseaudio:hover,
      #network:hover,
      #clock:hover {
        background: @color0;
        border-color: @color1;
        box-shadow: 0 0 6px alpha(@color1, 0.35);
      }

      /* Workspaces buttons */
      #workspaces button {
        background: transparent;
        color: @color4;
        padding: 0 5px;
        border: none;
        transition: color 120ms ease;
      }

      #workspaces button.active {
        color: @color1;
        font-weight: bold;
      }

      /* Dashboard button */
      #custom-dashboard {
        font-weight: bold;
        color: @color3;
      }

      #custom-dashboard:hover {
        color: @color1;
      }

      /* Right side */
      #pulseaudio,
      #network,
      #clock {
        color: @color6;
      }
    '';
  };
}
