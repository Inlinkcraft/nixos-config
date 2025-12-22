{
  programs.waybar = {
    style = ''
      @import "/home/inlinkcraft/.cache/wal/colors-waybar.css";

      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 11px;
      }

      window#waybar {
        background: transparent;
      }

      #waybar {
        background: transparent;
        margin: 6px 10px;
      }

      /* Floating islands */
      #workspaces,
      #custom-dashboard,
      #pulseaudio,
      #network,
      #clock {
        background: alpha(@background, 0.85);
        color: @foreground;
        padding: 4px 8px;
        margin: 0 2px;
        border: 1px solid @color2;
        border-radius: 6px;

        transition:
          background-color 150ms ease,
          color 150ms ease,
          border-color 150ms ease,
          box-shadow 150ms ease;
      }

      #workspaces:hover,
      #custom-dashboard:hover,
      #pulseaudio:hover,
      #network:hover,
      #clock:hover {
        background: @color0;
        border-color: @color1;
        box-shadow: 0 0 6px alpha(@color1, 0.35);
      }

      /* Workspace buttons */
      #workspaces button {
        background: transparent;
        color: @color4;
        padding: 0 5px;
        border: none;
      }

      #workspaces button.active {
        color: @color1;
        font-weight: bold;
      }

      /* NixOS logo dashboard button */
      #custom-dashboard {
        min-width: 22px;
        min-height: 22px;

        background-image: url("/home/inlinkcraft/Configuration/nixos.png");
        background-repeat: no-repeat;
        background-position: center;
        background-size: 14px 14px;
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
